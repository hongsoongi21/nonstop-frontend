import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/core/network/stomp_service.dart';
import 'package:nonstop/features/auth/domain/repository/auth_repository.dart';
import 'package:nonstop/features/chat/data/api/chat_api.dart';
import 'package:nonstop/features/chat/domain/entities/chat_message.dart';
import 'package:nonstop/features/chat/domain/entities/chat_room.dart';
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
    // Unsubscribe all
    for (final unsubscribe in _subscriptions.values) {
      unsubscribe();
    }
    _subscriptions.clear();
    
    // Close streams
    for (final controller in _roomStreams.values) {
      controller.close();
    }
    _roomStreams.clear();
    
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
          // controller.addError(e);
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
}