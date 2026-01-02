import 'package:fpdart/fpdart.dart';
import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/features/chat/domain/entities/chat_message.dart';
import 'package:nonstop/features/chat/domain/entities/chat_room.dart';

abstract class ChatRepository {
  /// Connect to the real-time chat service
  Future<void> connect();
  
  /// Disconnect from the real-time chat service
  Future<void> disconnect();
  
  /// Subscribe to a specific chat room for real-time messages
  /// Returns a stream of incoming messages
  Stream<ChatMessage> subscribeToRoom(int roomId);
  
  /// Send a message to a chat room
  Future<Either<Failure, void>> sendMessage({
    required int roomId,
    required String content,
    required MessageType type,
  });

  /// Fetch list of my chat rooms
  Future<Either<Failure, List<ChatRoom>>> getMyChatRooms();
  
  /// Fetch message history for a room
  Future<Either<Failure, List<ChatMessage>>> getMessages({
    required int roomId,
    int limit = 50,
    int offset = 0,
  });
  
  /// Create a 1:1 chat room
  Future<Either<Failure, ChatRoom>> createOneToOneRoom(int targetUserId);
  
  /// Create a group chat room
  Future<Either<Failure, ChatRoom>> createGroupRoom({
    required String name,
    required List<int> userIds,
  });
}
