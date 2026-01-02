import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/core/network/dio_client.dart';
import 'package:nonstop/core/network/stomp_service.dart';
import 'package:nonstop/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:nonstop/features/auth/data/api/auth_api_mock.dart';
import 'package:nonstop/features/chat/data/api/chat_api.dart';
import 'package:nonstop/features/chat/data/repository_impl/chat_repository_impl.dart';
import 'package:nonstop/features/chat/domain/entities/chat_message.dart';
import 'package:nonstop/features/chat/domain/entities/chat_room.dart';
import 'package:nonstop/features/chat/domain/repository/chat_repository.dart';

// --- Dependencies ---

final stompServiceProvider = Provider<StompService>((ref) {
  return StompService();
});

final chatApiProvider = Provider<ChatApi>((ref) {
  final dioClient = ref.read(dioClientProvider);
  return ChatApi(dioClient);
});

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final api = ref.read(chatApiProvider);
  final stompService = ref.read(stompServiceProvider);
  
  // In a real app, we would use the globally provided AuthRepository.
  // For integration testing/dev, we use the mock implementation.
  final authRepo = AuthRepositoryImpl(AuthApiMock()); 
  
  return ChatRepositoryImpl(api, stompService, authRepo);
});

// --- State ---

class ChatListState {
  final bool isLoading;
  final List<ChatRoom> rooms;
  final Failure? error;

  ChatListState({
    this.isLoading = false,
    this.rooms = const [],
    this.error,
  });
}

class ChatListNotifier extends StateNotifier<ChatListState> {
  final ChatRepository _repository;

  ChatListNotifier(this._repository) : super(ChatListState()) {
    _init();
  }

  Future<void> _init() async {
    // Connect to WS
    await _repository.connect();
    // Load rooms
    loadRooms();
  }

  Future<void> loadRooms() async {
    state = ChatListState(isLoading: true, rooms: state.rooms);
    final result = await _repository.getMyChatRooms();
    result.fold(
      (failure) => state = ChatListState(isLoading: false, error: failure, rooms: state.rooms),
      (rooms) => state = ChatListState(isLoading: false, rooms: rooms),
    );
  }

  Future<void> createOneToOneRoom(int targetUserId) async {
    final result = await _repository.createOneToOneRoom(targetUserId);
    result.fold(
      (failure) => state = ChatListState(isLoading: false, error: failure, rooms: state.rooms),
      (room) => state = ChatListState(isLoading: false, rooms: [room, ...state.rooms]),
    );
  }
}

final chatListProvider = StateNotifierProvider<ChatListNotifier, ChatListState>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ChatListNotifier(repository);
});


// --- Room State (Messages) ---

class ChatRoomState {
  final bool isLoading;
  final List<ChatMessage> messages;
  final Failure? error;

  ChatRoomState({
    this.isLoading = false,
    this.messages = const [],
    this.error,
  });
}

class ChatRoomNotifier extends StateNotifier<ChatRoomState> {
  final ChatRepository _repository;
  final int roomId;
  StreamSubscription? _subscription;

  ChatRoomNotifier(this._repository, this.roomId) : super(ChatRoomState()) {
    loadHistory();
    subscribe();
  }

  Future<void> loadHistory() async {
    state = ChatRoomState(isLoading: true, messages: state.messages);
    final result = await _repository.getMessages(roomId: roomId);
    result.fold(
      (failure) => state = ChatRoomState(isLoading: false, error: failure, messages: state.messages),
      (history) => state = ChatRoomState(isLoading: false, messages: history),
    );
  }

  void subscribe() {
    _subscription = _repository.subscribeToRoom(roomId).listen((message) {
      // Deduplicate if needed, or append
      // Assuming new messages come here
      state = ChatRoomState(
        isLoading: false, 
        messages: [message, ...state.messages], // Prepend if list is reversed
      );
    });
  }

  Future<void> sendMessage(String content, {MessageType type = MessageType.text}) async {
    // Optimistic update
    final tempId = DateTime.now().millisecondsSinceEpoch;
    final optimisticMessage = ChatMessage(
      id: tempId, 
      roomId: roomId,
      senderId: 0, // Current user ID (unknown here without User provider)
      content: content,
      type: type,
      sentAt: DateTime.now(),
      isSending: true,
    );
    
    state = ChatRoomState(
      isLoading: false,
      messages: [optimisticMessage, ...state.messages],
    );

    final result = await _repository.sendMessage(roomId: roomId, content: content, type: type);
    
    result.fold(
      (failure) {
        // Mark as error
        state = ChatRoomState(
          isLoading: false,
          messages: state.messages.map((m) => m.id == tempId ? m.copyWith(hasError: true, isSending: false) : m).toList(),
        );
      },
      (_) {
        // Success - usually we wait for the real message via WS to replace this, 
        // or we just mark it sent.
        state = ChatRoomState(
          isLoading: false,
          messages: state.messages.map((m) => m.id == tempId ? m.copyWith(isSending: false) : m).toList(),
        );
      }
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

final chatRoomProvider = StateNotifierProvider.family<ChatRoomNotifier, ChatRoomState, int>((ref, roomId) {
  final repository = ref.watch(chatRepositoryProvider);
  return ChatRoomNotifier(repository, roomId);
});
