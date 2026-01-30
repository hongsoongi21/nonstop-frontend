import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';
part 'app_notification.g.dart';

enum NotificationType {
  @JsonValue('FRIEND_REQUEST')
  friendRequest,
  @JsonValue('FRIEND_ACCEPT')
  friendAccept,
  @JsonValue('POST_LIKE')
  postLike,
  @JsonValue('COMMENT_LIKE')
  commentLike,
  @JsonValue('NEW_COMMENT')
  newComment,
  @JsonValue('NEW_REPLY')
  newReply,
  @JsonValue('CHAT_MESSAGE')
  chatMessage,
  @JsonValue('ANNOUNCEMENT')
  announcement,
}

@freezed
class AppNotification with _$AppNotification {
  const factory AppNotification({
    required int id,
    int? actorId,
    String? actorNickname,
    required NotificationType type,
    int? postId,
    int? commentId,
    int? chatRoomId,
    required String message,
    @Default(false) bool isRead,
    required DateTime createdAt,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}
