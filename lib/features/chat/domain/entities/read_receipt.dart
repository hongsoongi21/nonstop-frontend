/// Represents a read status event from the server
class ReadReceipt {
  final int roomId;
  final int userId;
  final int lastReadMessageId;
  final DateTime readAt;

  const ReadReceipt({
    required this.roomId,
    required this.userId,
    required this.lastReadMessageId,
    required this.readAt,
  });

  factory ReadReceipt.fromJson(Map<String, dynamic> json) {
    return ReadReceipt(
      roomId: json['roomId'] as int,
      userId: json['userId'] as int,
      lastReadMessageId: json['lastReadMessageId'] as int,
      readAt: DateTime.parse(json['readAt'] as String),
    );
  }
}
