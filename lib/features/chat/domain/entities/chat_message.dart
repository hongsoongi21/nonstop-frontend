enum MessageType {
  text,
  image,
  systemInvite,
  systemLeave,
  systemKick,
}

class ChatMessage {
  final int id;
  final int roomId;
  final int senderId;
  final String content;
  final MessageType type;
  final DateTime sentAt;
  final String? clientMessageId;
  final bool isSending;
  final bool hasError;

  const ChatMessage({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.content,
    this.type = MessageType.text,
    required this.sentAt,
    this.clientMessageId,
    this.isSending = false,
    this.hasError = false,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    // Handle both 'id' and 'messageId' field names (backend uses messageId)
    final id = (json['messageId'] ?? json['id']) as int;
    // roomId might not be present in some responses
    final roomId = json['roomId'] as int? ?? 0;

    // Handle clientMessageId as both String and int (backend sends Long)
    String? clientMessageId;
    if (json['clientMessageId'] != null) {
      clientMessageId = json['clientMessageId'].toString();
    }

    // Parse type - backend sends uppercase enum names
    final typeStr = json['type']?.toString().toLowerCase() ?? 'text';
    final type = MessageType.values.firstWhere(
      (e) => e.name.toLowerCase() == typeStr ||
             e.name == typeStr ||
             _mapBackendType(typeStr) == e,
      orElse: () => MessageType.text,
    );

    return ChatMessage(
      id: id,
      roomId: roomId,
      senderId: json['senderId'] as int,
      content: json['content'] as String,
      type: type,
      sentAt: DateTime.parse(json['sentAt'] as String),
      clientMessageId: clientMessageId,
    );
  }

  static MessageType _mapBackendType(String type) {
    switch (type.toUpperCase()) {
      case 'TEXT':
        return MessageType.text;
      case 'IMAGE':
        return MessageType.image;
      case 'SYSTEM_INVITE':
        return MessageType.systemInvite;
      case 'SYSTEM_LEAVE':
        return MessageType.systemLeave;
      case 'SYSTEM_KICK':
        return MessageType.systemKick;
      default:
        return MessageType.text;
    }
  }

  ChatMessage copyWith({
    int? id,
    int? roomId,
    int? senderId,
    String? content,
    MessageType? type,
    DateTime? sentAt,
    String? clientMessageId,
    bool? isSending,
    bool? hasError,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      type: type ?? this.type,
      sentAt: sentAt ?? this.sentAt,
      clientMessageId: clientMessageId ?? this.clientMessageId,
      isSending: isSending ?? this.isSending,
      hasError: hasError ?? this.hasError,
    );
  }
}
