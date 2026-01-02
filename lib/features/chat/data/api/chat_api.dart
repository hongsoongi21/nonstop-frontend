import 'package:nonstop/core/network/dio_client.dart';
import 'package:nonstop/features/chat/domain/entities/chat_room.dart';
import 'package:nonstop/features/chat/domain/entities/chat_message.dart';

class ChatApi {
  final DioClient _dioClient;

  ChatApi(this._dioClient);

  Future<List<ChatRoom>> getMyChatRooms() async {
    try {
      final response = await _dioClient.get('/api/v1/chat/rooms');
      // Assuming response format: { "success": true, "data": [...] }
      final list = (response.data['data'] as List)
          .map((e) => ChatRoom.fromJson(e))
          .toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }

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

  Future<ChatRoom> createOneToOneRoom(int targetUserId) async {
    final response = await _dioClient.post(
      '/api/v1/chat/rooms',
      data: {'targetUserId': targetUserId},
    );
    return ChatRoom.fromJson(response.data['data']);
  }

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
