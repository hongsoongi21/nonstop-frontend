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

  const ChatRoom({
    required this.id,
    required this.type,
    this.name,
    required this.unreadCount,
    this.lastMessage,
    this.memberIds,
    this.updatedAt,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['id'] as int,
      type: json['type'] == 'GROUP' ? ChatRoomType.group : ChatRoomType.oneToOne,
      name: json['name'] as String?,
      unreadCount: json['unreadCount'] as int? ?? 0,
      lastMessage: json['lastMessage'] != null
          ? ChatMessage.fromJson(json['lastMessage'])
          : null,
      memberIds: (json['memberIds'] as List?)?.cast<int>(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }
}
