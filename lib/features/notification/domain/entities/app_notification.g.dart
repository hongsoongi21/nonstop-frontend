// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppNotificationImpl _$$AppNotificationImplFromJson(
  Map<String, dynamic> json,
) => _$AppNotificationImpl(
  id: (json['id'] as num).toInt(),
  actorId: (json['actorId'] as num?)?.toInt(),
  actorNickname: json['actorNickname'] as String?,
  type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
  postId: (json['postId'] as num?)?.toInt(),
  commentId: (json['commentId'] as num?)?.toInt(),
  chatRoomId: (json['chatRoomId'] as num?)?.toInt(),
  message: json['message'] as String,
  isRead: json['isRead'] as bool? ?? false,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$AppNotificationImplToJson(
  _$AppNotificationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'actorId': instance.actorId,
  'actorNickname': instance.actorNickname,
  'type': _$NotificationTypeEnumMap[instance.type]!,
  'postId': instance.postId,
  'commentId': instance.commentId,
  'chatRoomId': instance.chatRoomId,
  'message': instance.message,
  'isRead': instance.isRead,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$NotificationTypeEnumMap = {
  NotificationType.friendRequest: 'FRIEND_REQUEST',
  NotificationType.friendAccept: 'FRIEND_ACCEPT',
  NotificationType.postLike: 'POST_LIKE',
  NotificationType.commentLike: 'COMMENT_LIKE',
  NotificationType.newComment: 'NEW_COMMENT',
  NotificationType.newReply: 'NEW_REPLY',
  NotificationType.chatMessage: 'CHAT_MESSAGE',
  NotificationType.announcement: 'ANNOUNCEMENT',
};
