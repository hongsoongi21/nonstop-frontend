import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nonstop/core/config/env_config.dart';
import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/core/network/stomp_service.dart';
import 'package:nonstop/features/auth/presentation/providers/auth_provider.dart';
import 'package:nonstop/features/chat/data/api/chat_api.dart';
import 'package:nonstop/features/chat/data/api/chat_api_mock.dart';
import 'package:nonstop/features/chat/data/repository_impl/chat_repository_impl.dart';
import 'package:nonstop/features/chat/domain/entities/chat_message.dart';
import 'package:nonstop/features/chat/domain/entities/chat_room.dart';
import 'package:nonstop/features/chat/domain/entities/read_receipt.dart';
import 'package:nonstop/features/chat/domain/repository/chat_repository.dart';
import 'package:uuid/uuid.dart';

// --- Dependencies ---

final stompServiceProvider = Provider<StompService>((ref) {
  return StompService();
});

final chatApiProvider = Provider<ChatApi>((ref) {
  // Use Mock for development, Real API for production
  if (EnvConfig.isDevelopment) {
    return ChatApiMock();
  }
  final dioClient = ref.read(dioClientProvider);
  return ChatApiImpl(dioClient);
});

/// Provides the current user's ID as int for chat operations
/// User.id is String but ChatMessage.senderId requires int
final currentUserIdProvider = Provider<int?>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;
  return int.tryParse(user.id);
});

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final api = ref.watch(chatApiProvider);
  final stompService = ref.watch(stompServiceProvider);
  final authRepo = ref.watch(authRepositoryProvider);

  return ChatRepositoryImpl(api, stompService, authRepo);
});

// --- State ---

class ChatListState {
  final bool isLoading;
  final List<ChatRoom> rooms;
  final Failure? error;

  ChatListState({this.isLoading = false, this.rooms = const [], this.error});
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

  @override
  void dispose() {
    _repository.disconnect();
    super.dispose();
  }

  Future<void> loadRooms() async {
    state = ChatListState(isLoading: true, rooms: state.rooms);
    final result = await _repository.getMyChatRooms();
    result.fold(
      (failure) => state = ChatListState(
        isLoading: false,
        error: failure,
        rooms: state.rooms,
      ),
      (rooms) => state = ChatListState(isLoading: false, rooms: rooms),
    );
  }

  Future<void> createOneToOneRoom(int targetUserId) async {
    final result = await _repository.createOneToOneRoom(targetUserId);
    result.fold(
      (failure) => state = ChatListState(
        isLoading: false,
        error: failure,
        rooms: state.rooms,
      ),
      (room) => state = ChatListState(
        isLoading: false,
        rooms: [room, ...state.rooms],
      ),
    );
  }
}

final chatListProvider = StateNotifierProvider<ChatListNotifier, ChatListState>(
  (ref) {
    final repository = ref.watch(chatRepositoryProvider);
    return ChatListNotifier(repository);
  },
);

// --- Room State (Messages) ---

class ChatRoomState {
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasReachedEnd;
  final List<ChatMessage> messages;
  final Failure? error;
  final int currentOffset;
  final Map<int, int> readStatusByUser; // userId -> lastReadMessageId

  ChatRoomState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasReachedEnd = false,
    this.messages = const [],
    this.error,
    this.currentOffset = 0,
    this.readStatusByUser = const {},
  });

  ChatRoomState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasReachedEnd,
    List<ChatMessage>? messages,
    Failure? error,
    int? currentOffset,
    Map<int, int>? readStatusByUser,
  }) {
    return ChatRoomState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      messages: messages ?? this.messages,
      error: error,
      currentOffset: currentOffset ?? this.currentOffset,
      readStatusByUser: readStatusByUser ?? this.readStatusByUser,
    );
  }
}

class ChatRoomNotifier extends StateNotifier<ChatRoomState> {
  final ChatRepository _repository;
  final Ref _ref;
  final int roomId;
  StreamSubscription<ChatMessage>? _subscription;
  StreamSubscription<ReadReceipt>? _readReceiptSubscription;

  ChatRoomNotifier(this._repository, this._ref, this.roomId) : super(ChatRoomState()) {
    loadHistory();
    subscribe();
    _subscribeToReadReceipts();
    markMessagesAsRead();
  }

  Future<void> loadHistory() async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getMessages(roomId: roomId, limit: 50, offset: 0);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure,
      ),
      (history) => state = state.copyWith(
        isLoading: false,
        messages: history,
        currentOffset: history.length,
        hasReachedEnd: history.length < 50,
      ),
    );
  }

  void subscribe() {
    _subscription = _repository.subscribeToRoom(roomId).listen((message) {
      _handleIncomingMessage(message);
    });
  }

  void _subscribeToReadReceipts() {
    _readReceiptSubscription = _repository.subscribeToReadReceipts(roomId).listen((receipt) {
      // Update read status - track which message each user has read up to
      state = state.copyWith(
        readStatusByUser: {
          ...state.readStatusByUser,
          receipt.userId: receipt.lastReadMessageId,
        },
      );
    });
  }

  Future<void> markMessagesAsRead() async {
    if (state.messages.isEmpty) return;
    // Most recent message is first in the list (list is reversed for display)
    final lastMessageId = state.messages.first.id;
    await _repository.markAsRead(roomId: roomId, messageId: lastMessageId);
  }

  void _handleIncomingMessage(ChatMessage message) {
    // Check if this message matches an optimistic message by clientMessageId
    if (message.clientMessageId != null) {
      final existingIndex = state.messages.indexWhere(
        (m) => m.clientMessageId != null && m.clientMessageId == message.clientMessageId,
      );

      if (existingIndex != -1) {
        // Replace optimistic message with real message from server
        final updatedMessages = List<ChatMessage>.from(state.messages);
        updatedMessages[existingIndex] = message.copyWith(isSending: false, hasError: false);
        state = state.copyWith(messages: updatedMessages);
        return;
      }
    }

    // Check for duplicate by message ID (avoid double-adding)
    final isDuplicate = state.messages.any((m) => m.id == message.id);
    if (isDuplicate) return;

    // New message from another user - prepend to list
    state = state.copyWith(
      messages: [message, ...state.messages],
    );
  }

  Future<void> sendMessage(
    String content, {
    MessageType type = MessageType.text,
  }) async {
    // Optimistic update
    final tempId = DateTime.now().millisecondsSinceEpoch;
    final clientMessageId = const Uuid().v4();
    final optimisticMessage = ChatMessage(
      id: tempId,
      roomId: roomId,
      senderId: _ref.read(currentUserIdProvider) ?? 0,
      content: content,
      type: type,
      sentAt: DateTime.now(),
      clientMessageId: clientMessageId,
      isSending: true,
    );

    state = state.copyWith(
      messages: [optimisticMessage, ...state.messages],
    );

    final result = await _repository.sendMessage(
      roomId: roomId,
      content: content,
      type: type,
    );

    result.fold(
      (failure) {
        // Mark as error
        state = state.copyWith(
          messages: state.messages
              .map(
                (m) => m.id == tempId
                    ? m.copyWith(hasError: true, isSending: false)
                    : m,
              )
              .toList(),
        );
      },
      (_) {
        // Success - usually we wait for the real message via WS to replace this,
        // or we just mark it sent.
        state = state.copyWith(
          messages: state.messages
              .map((m) => m.id == tempId ? m.copyWith(isSending: false) : m)
              .toList(),
        );
      },
    );
  }

  Future<void> loadMore() async {
    // Prevent multiple simultaneous loads or loading when all data is fetched
    if (state.isLoadingMore || state.hasReachedEnd || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);

    final result = await _repository.getMessages(
      roomId: roomId,
      limit: 50,
      offset: state.currentOffset,
    );

    result.fold(
      (failure) => state = state.copyWith(
        isLoadingMore: false,
        error: failure,
      ),
      (moreMessages) {
        final hasReachedEnd = moreMessages.length < 50;
        state = state.copyWith(
          isLoadingMore: false,
          hasReachedEnd: hasReachedEnd,
          currentOffset: state.currentOffset + moreMessages.length,
          messages: [...state.messages, ...moreMessages], // Append older messages
        );
      },
    );
  }

  Future<void> sendImageMessage(String localFilePath) async {
    // 1. Create optimistic message with local path as content
    final tempId = DateTime.now().millisecondsSinceEpoch;
    final clientMessageId = const Uuid().v4();
    final currentUserId = _ref.read(currentUserIdProvider) ?? 0;

    final optimisticMessage = ChatMessage(
      id: tempId,
      roomId: roomId,
      senderId: currentUserId,
      content: localFilePath, // Show local preview
      type: MessageType.image,
      sentAt: DateTime.now(),
      clientMessageId: clientMessageId,
      isSending: true,
    );

    state = state.copyWith(
      messages: [optimisticMessage, ...state.messages],
    );

    try {
      // 2. Upload image and get URL
      final uploadResult = await _repository.uploadChatImage(roomId, localFilePath);

      await uploadResult.fold(
        (failure) async {
          // Mark as error if upload fails
          state = state.copyWith(
            messages: state.messages.map((m) =>
              m.id == tempId ? m.copyWith(hasError: true, isSending: false) : m
            ).toList(),
          );
        },
        (imageUrl) async {
          // 3. Send message via STOMP
          final result = await _repository.sendMessage(
            roomId: roomId,
            content: imageUrl,
            type: MessageType.image,
          );

          result.fold(
            (failure) {
              // Mark as error
              state = state.copyWith(
                messages: state.messages.map((m) =>
                  m.id == tempId ? m.copyWith(hasError: true, isSending: false) : m
                ).toList(),
              );
            },
            (_) {
              // Update optimistic message with real URL
              state = state.copyWith(
                messages: state.messages.map((m) =>
                  m.id == tempId ? m.copyWith(content: imageUrl, isSending: false) : m
                ).toList(),
              );
            },
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        messages: state.messages.map((m) =>
          m.id == tempId ? m.copyWith(hasError: true, isSending: false) : m
        ).toList(),
      );
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _readReceiptSubscription?.cancel();
    super.dispose();
  }
}

final chatRoomProvider =
    StateNotifierProvider.autoDispose.family<ChatRoomNotifier, ChatRoomState, int>((
      ref,
      roomId,
    ) {
      final repository = ref.watch(chatRepositoryProvider);
      return ChatRoomNotifier(repository, ref, roomId);
    });
