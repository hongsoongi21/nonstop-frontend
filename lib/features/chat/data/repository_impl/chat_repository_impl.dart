import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/core/utils/date_utils.dart';
import 'package:nonstop/features/chat/data/api/chat_api.dart';
import 'package:nonstop/features/chat/domain/entities/chat_message.dart';
import 'package:nonstop/features/chat/domain/entities/chat_room.dart';
import 'package:nonstop/features/chat/domain/entities/read_receipt.dart';
import 'package:nonstop/features/chat/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatApi _api;
  final SupabaseClient _supabase;

  // Supabase Realtime channels
  final Map<int, RealtimeChannel> _messageChannels = {};
  final Map<int, RealtimeChannel> _readReceiptChannels = {};

  // Stream controllers for active rooms
  final Map<int, StreamController<ChatMessage>> _roomStreams = {};
  final Map<int, StreamController<ReadReceipt>> _readReceiptStreams = {};

  ChatRepositoryImpl(this._api, this._supabase);

  @override
  Future<void> connect() async {
    // Supabase Realtime connects automatically per-channel on subscribe
  }

  @override
  Future<void> disconnect() async {
    // Remove all message channels
    for (final channel in _messageChannels.values) {
      _supabase.removeChannel(channel);
    }
    _messageChannels.clear();

    // Close message streams
    for (final controller in _roomStreams.values) {
      controller.close();
    }
    _roomStreams.clear();

    // Remove all read receipt channels
    for (final channel in _readReceiptChannels.values) {
      _supabase.removeChannel(channel);
    }
    _readReceiptChannels.clear();

    // Close read receipt streams
    for (final controller in _readReceiptStreams.values) {
      controller.close();
    }
    _readReceiptStreams.clear();
  }

  @override
  Stream<ChatMessage> subscribeToRoom(int roomId) {
    if (_roomStreams.containsKey(roomId)) {
      return _roomStreams[roomId]!.stream;
    }

    final controller = StreamController<ChatMessage>.broadcast();
    _roomStreams[roomId] = controller;

    // Subscribe to Supabase Realtime for new messages in this room
    final channel = _supabase
        .channel('messages-room-$roomId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'messages',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'chat_room_id',
            value: roomId,
          ),
          callback: (payload) {
            try {
              final newRecord = payload.newRecord;
              final message = _mapRealtimeToMessage(newRecord, roomId);
              controller.add(message);
            } catch (e) {
              debugPrint('Error parsing realtime chat message: $e');
            }
          },
        )
        .subscribe();

    _messageChannels[roomId] = channel;
    return controller.stream;
  }

  ChatMessage _mapRealtimeToMessage(
      Map<String, dynamic> data, int roomId) {
    final typeStr = (data['type'] as String? ?? 'TEXT').toLowerCase();
    MessageType type;
    switch (typeStr) {
      case 'image':
        type = MessageType.image;
        break;
      case 'system_invite':
        type = MessageType.systemInvite;
        break;
      case 'system_leave':
        type = MessageType.systemLeave;
        break;
      case 'system_kick':
        type = MessageType.systemKick;
        break;
      default:
        type = MessageType.text;
    }

    return ChatMessage(
      id: data['id'] as int,
      roomId: data['chat_room_id'] as int? ?? roomId,
      senderId: data['sender_id'] as int? ?? 0,
      content: data['content'] as String? ?? '',
      type: type,
      sentAt: data['sent_at'] != null
          ? parseUtcDateTime(data['sent_at'] as String)
          : DateTime.now(),
      clientMessageId: data['client_message_id']?.toString(),
    );
  }

  @override
  Future<Either<Failure, void>> sendMessage({
    required int roomId,
    required String content,
    required MessageType type,
    int? clientMessageId,
  }) async {
    try {
      final effectiveClientMessageId =
          clientMessageId ?? DateTime.now().microsecondsSinceEpoch;

      await _api.sendMessage(
        roomId: roomId,
        content: content,
        type: type.name.toUpperCase(),
        clientMessageId: effectiveClientMessageId,
      );

      return const Right(null);
    } catch (e) {
      return Left(Failure.server(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<ChatRoom>>> getMyChatRooms() async {
    try {
      final result = await _api.getMyChatRooms();
      return Right(result);
    } catch (e) {
      return Left(Failure.server(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<ChatMessage>>> getMessages({
    required int roomId,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final result = await _api.getMessages(roomId, limit, offset);
      return Right(result);
    } catch (e) {
      return Left(Failure.server(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, ChatRoom>> createOneToOneRoom(
      int targetUserId) async {
    try {
      final result = await _api.createOneToOneRoom(targetUserId);
      return Right(result);
    } catch (e) {
      return Left(Failure.server(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, ChatRoom>> createGroupRoom({
    required String name,
    required List<int> userIds,
  }) async {
    try {
      final result = await _api.createGroupRoom(name, userIds);
      return Right(result);
    } catch (e) {
      return Left(Failure.server(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Stream<ReadReceipt> subscribeToReadReceipts(int roomId) {
    if (_readReceiptStreams.containsKey(roomId)) {
      return _readReceiptStreams[roomId]!.stream;
    }

    final controller = StreamController<ReadReceipt>.broadcast();
    _readReceiptStreams[roomId] = controller;

    // Subscribe to updates on chat_room_members for this room
    final channel = _supabase
        .channel('read-receipts-room-$roomId')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'chat_room_members',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'room_id',
            value: roomId,
          ),
          callback: (payload) {
            try {
              final newRecord = payload.newRecord;
              final lastReadId = newRecord['last_read_message_id'];
              if (lastReadId != null) {
                controller.add(ReadReceipt(
                  roomId: roomId,
                  userId: newRecord['user_id'] as int,
                  lastReadMessageId: lastReadId as int,
                  readAt: DateTime.now(),
                ));
              }
            } catch (e) {
              debugPrint('Error parsing read receipt: $e');
            }
          },
        )
        .subscribe();

    _readReceiptChannels[roomId] = channel;
    return controller.stream;
  }

  @override
  Future<Either<Failure, void>> markAsRead({
    required int roomId,
    required int messageId,
  }) async {
    try {
      await _api.markAsRead(roomId, messageId);
      return const Right(null);
    } catch (e) {
      return Left(Failure.server(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, String>> uploadChatImage(
      int roomId, String localFilePath) async {
    try {
      final imageUrl =
          await _api.uploadChatImage(roomId, localFilePath);
      return Right(imageUrl);
    } catch (e) {
      return Left(Failure.server(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, void>> leaveRoom(int roomId) async {
    try {
      // Unsubscribe from room messages
      if (_messageChannels.containsKey(roomId)) {
        _supabase.removeChannel(_messageChannels[roomId]!);
        _messageChannels.remove(roomId);
      }
      if (_roomStreams.containsKey(roomId)) {
        _roomStreams[roomId]!.close();
        _roomStreams.remove(roomId);
      }

      // Unsubscribe from read receipts
      if (_readReceiptChannels.containsKey(roomId)) {
        _supabase.removeChannel(_readReceiptChannels[roomId]!);
        _readReceiptChannels.remove(roomId);
      }
      if (_readReceiptStreams.containsKey(roomId)) {
        _readReceiptStreams[roomId]!.close();
        _readReceiptStreams.remove(roomId);
      }

      // Call API to leave room
      await _api.leaveRoom(roomId);
      return const Right(null);
    } catch (e) {
      return Left(Failure.server(message: e.toString(), statusCode: 500));
    }
  }
}
