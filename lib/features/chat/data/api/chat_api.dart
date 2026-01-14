import 'package:nonstop/core/network/dio_client.dart';
import 'package:nonstop/features/chat/domain/entities/chat_room.dart';
import 'package:nonstop/features/chat/domain/entities/chat_message.dart';

abstract class ChatApi {
  Future<List<ChatRoom>> getMyChatRooms();
  Future<List<ChatMessage>> getMessages(int roomId, int limit, int offset);
  Future<ChatRoom> createOneToOneRoom(int targetUserId);
  Future<ChatRoom> createGroupRoom(String name, List<int> userIds);
}

class ChatApiImpl implements ChatApi {
  final DioClient _dioClient;

  ChatApiImpl(this._dioClient);

  @override
  Future<List<ChatRoom>> getMyChatRooms() async {
    try {
      final response = await _dioClient.get('/api/v1/chat/rooms');
      final list = (response.data['data'] as List)
          .map((e) => ChatRoom.fromJson(e))
          .toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ChatMessage>> getMessages(int roomId, int limit, int offset) async {
    final response = await _dioClient.get(
      '/api/v1/chat/rooms/$roomId/messages',
      queryParameters: {
        'limit': limit,
        'offset': offset,
      },
    );
    final list = (response.data['data'] as List)
        .map((e) => ChatMessage.fromJson(e))
        .toList();
    return list;
  }

  @override
  Future<ChatRoom> createOneToOneRoom(int targetUserId) async {
    final response = await _dioClient.post(
      '/api/v1/chat/rooms',
      data: {'targetUserId': targetUserId},
    );
    return ChatRoom.fromJson(response.data['data']);
  }

  @override
  Future<ChatRoom> createGroupRoom(String name, List<int> userIds) async {
    final response = await _dioClient.post(
      '/api/v1/chat/group-rooms',
      data: {
        'roomName': name,
        'userIds': userIds,
      },
    );
    return ChatRoom.fromJson(response.data['data']);
  }
}
