import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nonstop/core/network/dio_client.dart';
import 'package:nonstop/features/chat/domain/entities/chat_room.dart';
import 'package:nonstop/features/chat/domain/entities/chat_message.dart';
import 'package:path/path.dart' as path;

abstract class ChatApi {
  Future<List<ChatRoom>> getMyChatRooms();
  Future<List<ChatMessage>> getMessages(int roomId, int limit, int offset);
  Future<ChatRoom> createOneToOneRoom(int targetUserId);
  Future<ChatRoom> createGroupRoom(String name, List<int> userIds);

  // New methods for full chat functionality
  Future<void> leaveRoom(int roomId);
  Future<void> inviteToGroup(int roomId, List<int> userIds);
  Future<void> kickFromGroup(int roomId, int userId);
  Future<List<int>> getGroupMembers(int roomId);
  Future<void> markAsRead(int roomId, int messageId);
  Future<String> uploadChatImage(int roomId, String localFilePath);
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

  @override
  Future<void> leaveRoom(int roomId) async {
    await _dioClient.delete('/api/v1/chat/rooms/$roomId');
  }

  @override
  Future<void> inviteToGroup(int roomId, List<int> userIds) async {
    await _dioClient.post(
      '/api/v1/chat/group-rooms/$roomId/invite',
      data: {'userIds': userIds},
    );
  }

  @override
  Future<void> kickFromGroup(int roomId, int userId) async {
    await _dioClient.delete('/api/v1/chat/group-rooms/$roomId/members/$userId');
  }

  @override
  Future<List<int>> getGroupMembers(int roomId) async {
    final response = await _dioClient.get('/api/v1/chat/group-rooms/$roomId/members');
    final data = response.data['data'] as List;
    // Backend returns List<ChatRoomMemberResponseDto>, extract userIds
    return data.map((member) {
      if (member is int) {
        return member;
      } else if (member is Map) {
        return member['userId'] as int;
      }
      return 0;
    }).where((id) => id > 0).toList();
  }

  @override
  Future<void> markAsRead(int roomId, int messageId) async {
    // Backend expects messageId as query parameter, not request body
    await _dioClient.patch(
      '/api/v1/chat/rooms/$roomId/read',
      queryParameters: {'messageId': messageId},
    );
  }

  @override
  Future<String> uploadChatImage(int roomId, String localFilePath) async {
    final file = File(localFilePath);
    final fileName = path.basename(localFilePath);
    final extension = path.extension(localFilePath).toLowerCase();

    // Determine content type
    String contentType;
    switch (extension) {
      case '.jpg':
      case '.jpeg':
        contentType = 'image/jpeg';
        break;
      case '.png':
        contentType = 'image/png';
        break;
      case '.gif':
        contentType = 'image/gif';
        break;
      case '.webp':
        contentType = 'image/webp';
        break;
      default:
        contentType = 'image/jpeg';
    }

    // 1. Request SAS URL from backend
    final sasResponse = await _dioClient.post(
      '/api/v1/files/sas-url',
      data: {
        'fileName': fileName,
        'contentType': contentType,
        'purpose': 'CHAT_IMAGE',
        'targetId': roomId,
      },
    );
    final sasUrl = sasResponse.data['data'] as String;

    // Extract blob URL (URL without SAS token)
    final blobUrl = sasUrl.split('?').first;

    // 2. Upload file directly to Azure Blob Storage
    final fileBytes = await file.readAsBytes();
    await Dio().put(
      sasUrl,
      data: Stream.fromIterable([fileBytes]),
      options: Options(
        headers: {
          'x-ms-blob-type': 'BlockBlob',
          'Content-Type': contentType,
          'Content-Length': fileBytes.length,
        },
      ),
    );

    // 3. Notify backend upload is complete
    await _dioClient.post(
      '/api/v1/files/upload-complete',
      data: {
        'blobUrl': blobUrl,
        'originalFileName': fileName,
        'purpose': 'CHAT_IMAGE',
        'targetId': roomId,
      },
    );

    return blobUrl;
  }
}
