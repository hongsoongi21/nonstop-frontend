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
    return ChatMessage(
      id: json['id'] as int,
      roomId: json['roomId'] as int,
      senderId: json['senderId'] as int,
      content: json['content'] as String,
      type: MessageType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => MessageType.text,
      ),
      sentAt: DateTime.parse(json['sentAt'] as String),
      clientMessageId: json['clientMessageId'] as String?,
    );
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
