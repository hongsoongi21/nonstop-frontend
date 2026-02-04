import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/core/network/stomp_service.dart';
import 'package:nonstop/features/auth/domain/repository/auth_repository.dart';
import 'package:nonstop/features/chat/data/api/chat_api.dart';
import 'package:nonstop/features/chat/domain/entities/chat_message.dart';
import 'package:nonstop/features/chat/domain/entities/chat_room.dart';
import 'package:nonstop/features/chat/domain/entities/read_receipt.dart';
import 'package:nonstop/features/chat/domain/repository/chat_repository.dart';
import 'package:uuid/uuid.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatApi _api;
  final StompService _stompService;
  final AuthRepository _authRepository; // To get current access token

  // Cache subscriptions to unsubscribe later if needed
  final Map<int, Function()> _subscriptions = {};

  // Stream controllers for active rooms
  final Map<int, StreamController<ChatMessage>> _roomStreams = {};

  // Read receipt subscriptions and streams
  final Map<int, Function()> _readReceiptSubscriptions = {};
  final Map<int, StreamController<ReadReceipt>> _readReceiptStreams = {};

  ChatRepositoryImpl(this._api, this._stompService, this._authRepository);

  @override
  Future<void> connect() async {
    final tokenResult = await _authRepository.getAccessToken();
    tokenResult.fold(
      (failure) => null, // Handle error?
      (token) {
        if (token != null) {
          _stompService.connect(accessToken: token);
        }
      },
    );
  }

  @override
  Future<void> disconnect() async {
    // Unsubscribe all message subscriptions
    for (final unsubscribe in _subscriptions.values) {
      unsubscribe();
    }
    _subscriptions.clear();

    // Close message streams
    for (final controller in _roomStreams.values) {
      controller.close();
    }
    _roomStreams.clear();

    // Unsubscribe all read receipt subscriptions
    for (final unsubscribe in _readReceiptSubscriptions.values) {
      unsubscribe();
    }
    _readReceiptSubscriptions.clear();

    // Close read receipt streams
    for (final controller in _readReceiptStreams.values) {
      controller.close();
    }
    _readReceiptStreams.clear();

    _stompService.disconnect();
  }

  @override
  Stream<ChatMessage> subscribeToRoom(int roomId) {
    if (_roomStreams.containsKey(roomId)) {
      return _roomStreams[roomId]!.stream;
    }

    final controller = StreamController<ChatMessage>.broadcast();
    _roomStreams[roomId] = controller;

    final unsubscribe = _stompService.subscribe(
      destination: '/sub/chat/room/$roomId',
      callback: (data) {
        try {
          final message = ChatMessage.fromJson(data);
          controller.add(message);
        } catch (e) {
          debugPrint('Error parsing chat message: $e');
        }
      },
    );

    _subscriptions[roomId] = unsubscribe;
    
    return controller.stream;
  }

  @override
  Future<Either<Failure, void>> sendMessage({
    required int roomId,
    required String content,
    required MessageType type,
  }) async {
    try {
      final payload = {
        'roomId': roomId,
        'content': content,
        'type': type.name.toUpperCase(), // Match backend ENUM TEXT, IMAGE
        'clientMessageId': const Uuid().v4(),
      };

      _stompService.send(
        destination: '/pub/chat/message',
        body: payload,
      );
      
      return const Right(null);
    } catch (e) {
      return Left(Failure.network(message: e.toString()));
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
  Future<Either<Failure, ChatRoom>> createOneToOneRoom(int targetUserId) async {
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

    final unsubscribe = _stompService.subscribe(
      destination: '/sub/chat/room/$roomId/read',
      callback: (data) {
        try {
          final receipt = ReadReceipt.fromJson(data);
          controller.add(receipt);
        } catch (e) {
          // Log error but don't crash
          debugPrint('Error parsing read receipt: $e');
        }
      },
    );

    _readReceiptSubscriptions[roomId] = unsubscribe;

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
  Future<Either<Failure, String>> uploadChatImage(int roomId, String localFilePath) async {
    try {
      final imageUrl = await _api.uploadChatImage(roomId, localFilePath);
      return Right(imageUrl);
    } catch (e) {
      return Left(Failure.server(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, void>> leaveRoom(int roomId) async {
    try {
      // Unsubscribe from room messages
      if (_subscriptions.containsKey(roomId)) {
        _subscriptions[roomId]!();
        _subscriptions.remove(roomId);
      }
      if (_roomStreams.containsKey(roomId)) {
        _roomStreams[roomId]!.close();
        _roomStreams.remove(roomId);
      }

      // Unsubscribe from read receipts
      if (_readReceiptSubscriptions.containsKey(roomId)) {
        _readReceiptSubscriptions[roomId]!();
        _readReceiptSubscriptions.remove(roomId);
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