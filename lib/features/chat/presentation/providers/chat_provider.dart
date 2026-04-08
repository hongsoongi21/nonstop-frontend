import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/core/supabase/supabase_provider.dart';
import 'package:nonstop/features/auth/presentation/providers/auth_provider.dart';
import 'package:nonstop/features/chat/data/api/chat_api.dart';
import 'package:nonstop/features/chat/data/repository_impl/chat_repository_impl.dart';
import 'package:nonstop/features/chat/domain/entities/chat_message.dart';
import 'package:nonstop/features/chat/domain/entities/chat_room.dart';
import 'package:nonstop/features/chat/domain/entities/read_receipt.dart';
import 'package:nonstop/features/chat/domain/repository/chat_repository.dart';

// --- Dependencies ---

final chatApiProvider = Provider<ChatApi>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return ChatApiImpl(supabaseClient);
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
  final supabaseClient = ref.watch(supabaseClientProvider);
  return ChatRepositoryImpl(api, supabaseClient);
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
    // Connect to real-time (no-op for Supabase, connects per-channel)
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

  Future<ChatRoom?> createOneToOneRoom(int targetUserId, {String? roomName}) async {
    final result = await _repository.createOneToOneRoom(targetUserId, roomName: roomName);
    ChatRoom? createdRoom;
    result.fold(
      (failure) => state = ChatListState(
        isLoading: false,
        error: failure,
        rooms: state.rooms,
      ),
      (room) {
        createdRoom = room;
        final alreadyExists = state.rooms.any((r) => r.id == room.id);
        if (alreadyExists) {
          // Room already in list - no need to add duplicate
          state = ChatListState(
            isLoading: false,
            rooms: state.rooms,
          );
        } else {
          state = ChatListState(
            isLoading: false,
            rooms: [room, ...state.rooms],
          );
        }
      },
    );
    return createdRoom;
  }

  /// 특정 채팅방의 unreadCount를 0으로 초기화 (읽음 처리 후 즉시 배지 갱신)
  void clearUnreadCount(int roomId) {
    final updatedRooms = state.rooms.map((r) {
      if (r.id == roomId && r.unreadCount != 0) {
        return r.copyWith(unreadCount: 0);
      }
      return r;
    }).toList();
    state = ChatListState(isLoading: false, rooms: updatedRooms);
  }

  /// 채팅방 목록에서 특정 방 제거 (나가기 성공 후 호출)
  void removeRoom(int roomId) {
    state = ChatListState(
      isLoading: false,
      rooms: state.rooms.where((r) => r.id != roomId).toList(),
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

  ChatRoomNotifier(this._repository, this._ref, this.roomId)
      : super(ChatRoomState()) {
    _initialize();
    subscribe();
    _subscribeToReadReceipts();
  }

  Future<void> _initialize() async {
    await loadHistory();
    await _loadInitialReadStatuses();
    await markMessagesAsRead();
  }

  Future<void> _loadInitialReadStatuses() async {
    final result = await _repository.getReadStatuses(roomId);
    result.fold(
      (_) {},
      (statuses) {
        if (statuses.isNotEmpty) {
          state = state.copyWith(
            readStatusByUser: {...state.readStatusByUser, ...statuses},
          );
        }
      },
    );
  }

  Future<void> loadHistory() async {
    state = state.copyWith(isLoading: true);
    final result =
        await _repository.getMessages(roomId: roomId, limit: 50, offset: 0);
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
    final myUserId = _ref.read(currentUserIdProvider);
    _readReceiptSubscription =
        _repository.subscribeToReadReceipts(roomId).listen((receipt) {
      // Ignore own read receipts — only track other users' read status
      if (receipt.userId == myUserId) return;
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
    // optimistic 메시지(전송 중/실패)는 DB에 없으므로 건너뛰고 실제 메시지 ID 사용
    final realMessages = state.messages.where(
      (m) => !m.isSending && !m.hasError,
    );
    if (realMessages.isEmpty) return;
    final lastMessageId = realMessages.first.id;
    final result = await _repository.markAsRead(roomId: roomId, messageId: lastMessageId);
    result.fold(
      (_) {},
      (_) {
        // 읽음 처리 성공 시 채팅 목록의 배지를 즉시 초기화
        _ref.read(chatListProvider.notifier).clearUnreadCount(roomId);
      },
    );
  }

  void _handleIncomingMessage(ChatMessage message) {
    // Check if this message matches an optimistic message by clientMessageId
    if (message.clientMessageId != null) {
      final existingIndex = state.messages.indexWhere(
        (m) =>
            m.clientMessageId != null &&
            m.clientMessageId == message.clientMessageId,
      );

      if (existingIndex != -1) {
        // Replace optimistic message with real message from server
        final updatedMessages = List<ChatMessage>.from(state.messages);
        updatedMessages[existingIndex] =
            message.copyWith(isSending: false, hasError: false);
        state = state.copyWith(messages: updatedMessages);
        return;
      }
    }

    // Check for duplicate by message ID
    final isDuplicate = state.messages.any((m) => m.id == message.id);
    if (isDuplicate) return;

    // New message - prepend to list
    state = state.copyWith(
      messages: [message, ...state.messages],
    );

    // Mark as read since user is currently viewing this room
    markMessagesAsRead();
  }

  Future<void> sendMessage(
    String content, {
    MessageType type = MessageType.text,
  }) async {
    // Generate a clientMessageId for optimistic update matching
    final clientMsgId = DateTime.now().microsecondsSinceEpoch;
    final optimisticMessage = ChatMessage(
      id: clientMsgId,
      roomId: roomId,
      senderId: _ref.read(currentUserIdProvider) ?? 0,
      content: content,
      type: type,
      sentAt: DateTime.now(),
      clientMessageId: clientMsgId.toString(),
      isSending: true,
    );

    state = state.copyWith(
      messages: [optimisticMessage, ...state.messages],
    );

    final result = await _repository.sendMessage(
      roomId: roomId,
      content: content,
      type: type,
      clientMessageId: clientMsgId,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          messages: state.messages
              .map(
                (m) => m.id == clientMsgId
                    ? m.copyWith(hasError: true, isSending: false)
                    : m,
              )
              .toList(),
        );
      },
      (_) {
        state = state.copyWith(
          messages: state.messages
              .map(
                  (m) => m.id == clientMsgId ? m.copyWith(isSending: false) : m)
              .toList(),
        );
        markMessagesAsRead();
      },
    );
  }

  Future<void> loadMore() async {
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
          messages: [...state.messages, ...moreMessages],
        );
      },
    );
  }

  Future<void> sendImageMessage(String localFilePath) async {
    final clientMsgId = DateTime.now().microsecondsSinceEpoch;
    final currentUserId = _ref.read(currentUserIdProvider) ?? 0;

    final optimisticMessage = ChatMessage(
      id: clientMsgId,
      roomId: roomId,
      senderId: currentUserId,
      content: localFilePath,
      type: MessageType.image,
      sentAt: DateTime.now(),
      clientMessageId: clientMsgId.toString(),
      isSending: true,
    );

    state = state.copyWith(
      messages: [optimisticMessage, ...state.messages],
    );

    try {
      final uploadResult =
          await _repository.uploadChatImage(roomId, localFilePath);

      await uploadResult.fold(
        (failure) async {
          state = state.copyWith(
            messages: state.messages
                .map((m) => m.id == clientMsgId
                    ? m.copyWith(hasError: true, isSending: false)
                    : m)
                .toList(),
          );
        },
        (imageUrl) async {
          final result = await _repository.sendMessage(
            roomId: roomId,
            content: imageUrl,
            type: MessageType.image,
            clientMessageId: clientMsgId,
          );

          result.fold(
            (failure) {
              state = state.copyWith(
                messages: state.messages
                    .map((m) => m.id == clientMsgId
                        ? m.copyWith(hasError: true, isSending: false)
                        : m)
                    .toList(),
              );
            },
            (_) {
              state = state.copyWith(
                messages: state.messages
                    .map((m) => m.id == clientMsgId
                        ? m.copyWith(content: imageUrl, isSending: false)
                        : m)
                    .toList(),
              );
              markMessagesAsRead();
            },
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        messages: state.messages
            .map((m) => m.id == clientMsgId
                ? m.copyWith(hasError: true, isSending: false)
                : m)
            .toList(),
      );
    }
  }

  /// 채팅방 나가기
  Future<bool> leaveRoom() async {
    final result = await _repository.leaveRoom(roomId);
    return result.fold(
      (failure) => false,
      (_) => true,
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _readReceiptSubscription?.cancel();
    // Refresh chat list to update unread counts when leaving the room
    _ref.read(chatListProvider.notifier).loadRooms();
    super.dispose();
  }
}

final chatRoomProvider = StateNotifierProvider.autoDispose
    .family<ChatRoomNotifier, ChatRoomState, int>((
  ref,
  roomId,
) {
  final repository = ref.watch(chatRepositoryProvider);
  return ChatRoomNotifier(repository, ref, roomId);
});
