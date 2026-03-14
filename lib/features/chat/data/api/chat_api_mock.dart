import 'package:nonstop/features/chat/domain/entities/chat_room.dart';
import 'package:nonstop/features/chat/domain/entities/chat_message.dart';
import 'chat_api.dart';

class ChatApiMock implements ChatApi {
  @override
  Future<List<ChatRoom>> getMyChatRooms() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      ChatRoom(
        id: 1,
        type: ChatRoomType.oneToOne,
        name: 'John Doe',
        unreadCount: 2,
        lastMessage: ChatMessage(
          id: 101,
          roomId: 1,
          senderId: 2,
          content: 'Hey, are you coming to the study session?',
          sentAt: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
      ),
      ChatRoom(
        id: 2,
        type: ChatRoomType.group,
        name: 'CS Study Group',
        unreadCount: 0,
        lastMessage: ChatMessage(
          id: 102,
          roomId: 2,
          senderId: 3,
          content: 'I uploaded the notes for Chapter 3.',
          sentAt: DateTime.now().subtract(const Duration(hours: 1)),
        ),
      ),
      ChatRoom(
        id: 3,
        type: ChatRoomType.oneToOne,
        name: 'Alice Smith',
        unreadCount: 0,
        lastMessage: ChatMessage(
          id: 103,
          roomId: 3,
          senderId: 0,
          content: 'See you tomorrow!',
          sentAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ),
    ];
  }

  @override
  Future<List<ChatMessage>> getMessages(int roomId, int limit, int offset) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      ChatMessage(
        id: 201,
        roomId: roomId,
        senderId: 2,
        content: 'Hey!',
        sentAt: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      ChatMessage(
        id: 202,
        roomId: roomId,
        senderId: 0,
        content: 'Hello, how are you?',
        sentAt: DateTime.now().subtract(const Duration(minutes: 8)),
      ),
      ChatMessage(
        id: 203,
        roomId: roomId,
        senderId: 2,
        content: 'I am good, thanks!',
        sentAt: DateTime.now().subtract(const Duration(minutes: 7)),
      ),
    ];
  }

  @override
  Future<ChatRoom> createOneToOneRoom(int targetUserId, {String? roomName}) async {
    await Future.delayed(const Duration(seconds: 1));
    return ChatRoom(
      id: 99,
      type: ChatRoomType.oneToOne,
      name: 'New Friend',
      unreadCount: 0,
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<ChatRoom> createGroupRoom(String name, List<int> userIds) async {
    await Future.delayed(const Duration(seconds: 1));
    return ChatRoom(
      id: 100,
      type: ChatRoomType.group,
      name: name,
      unreadCount: 0,
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<void> leaveRoom(int roomId) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> inviteToGroup(int roomId, List<int> userIds) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> kickFromGroup(int roomId, int userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<List<int>> getGroupMembers(int roomId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [1, 2, 3]; // Mock member IDs
  }

  @override
  Future<void> markAsRead(int roomId, int messageId) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<Map<int, int>> getReadStatuses(int roomId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return {};
  }

  @override
  Future<String> uploadChatImage(int roomId, String localFilePath) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return 'https://example.com/mock-image.jpg';
  }

  @override
  Future<ChatMessage> sendMessage({
    required int roomId,
    required String content,
    required String type,
    required int clientMessageId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch,
      roomId: roomId,
      senderId: 0,
      content: content,
      sentAt: DateTime.now(),
      clientMessageId: clientMessageId.toString(),
    );
  }
}
