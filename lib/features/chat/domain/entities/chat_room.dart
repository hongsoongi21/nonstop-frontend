import 'package:nonstop/features/chat/domain/entities/chat_message.dart';

enum ChatRoomType {
  oneToOne,
  group,
}

class ChatRoom {
  final int id;
  final ChatRoomType type;
  final String? name;
  final int unreadCount;
  final ChatMessage? lastMessage;
  final List<int>? memberIds;
  final DateTime? updatedAt;
  final String? imageUrl;

  const ChatRoom({
    required this.id,
    required this.type,
    this.name,
    required this.unreadCount,
    this.lastMessage,
    this.memberIds,
    this.updatedAt,
    this.imageUrl,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    // Handle lastMessage - backend sends flat fields instead of nested object
    ChatMessage? lastMessage;
    if (json['lastMessage'] != null) {
      // Nested object case (for future compatibility)
      lastMessage = ChatMessage.fromJson(json['lastMessage']);
    } else if (json['lastMessageContent'] != null) {
      // Flat fields case (current backend)
      lastMessage = ChatMessage(
        id: 0, // Backend doesn't send message ID in room list
        roomId: (json['roomId'] ?? json['id']) as int,
        senderId: 0, // Backend doesn't send sender ID in room list
        content: json['lastMessageContent'] as String,
        sentAt: json['lastMessageSentAt'] != null
            ? DateTime.parse(json['lastMessageSentAt'] as String)
            : DateTime.now(),
      );
    }

    return ChatRoom(
      id: (json['roomId'] ?? json['id']) as int,
      type: json['type'] == 'GROUP' ? ChatRoomType.group : ChatRoomType.oneToOne,
      name: json['name'] as String?,
      unreadCount: json['unreadCount'] as int? ?? 0,
      lastMessage: lastMessage,
      memberIds: (json['memberIds'] as List?)?.cast<int>(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : (json['lastMessageSentAt'] != null
              ? DateTime.parse(json['lastMessageSentAt'] as String)
              : null),
      imageUrl: json['imageUrl'] as String?,
    );
  }
}
