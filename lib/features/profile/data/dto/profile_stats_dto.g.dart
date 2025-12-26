// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_stats_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileStatsDtoImpl _$$ProfileStatsDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ProfileStatsDtoImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  totalPosts: (json['totalPosts'] as num?)?.toInt() ?? 0,
  totalLikesReceived: (json['totalLikesReceived'] as num?)?.toInt() ?? 0,
  totalCommentsReceived: (json['totalCommentsReceived'] as num?)?.toInt() ?? 0,
  totalShares: (json['totalShares'] as num?)?.toInt() ?? 0,
  postsCreated: (json['postsCreated'] as num?)?.toInt() ?? 0,
  commentsMade: (json['commentsMade'] as num?)?.toInt() ?? 0,
  postsLiked: (json['postsLiked'] as num?)?.toInt() ?? 0,
  postsShared: (json['postsShared'] as num?)?.toInt() ?? 0,
  messagesSent: (json['messagesSent'] as num?)?.toInt() ?? 0,
  conversationsStarted: (json['conversationsStarted'] as num?)?.toInt() ?? 0,
  friendsAdded: (json['friendsAdded'] as num?)?.toInt() ?? 0,
  eventsCreated: (json['eventsCreated'] as num?)?.toInt() ?? 0,
  eventsAttended: (json['eventsAttended'] as num?)?.toInt() ?? 0,
  activityScore: (json['activityScore'] as num?)?.toInt() ?? 0,
  helpfulnessScore: (json['helpfulnessScore'] as num?)?.toInt() ?? 0,
  engagementScore: (json['engagementScore'] as num?)?.toInt() ?? 0,
  currentLoginStreak: (json['currentLoginStreak'] as num?)?.toInt() ?? 0,
  longestLoginStreak: (json['longestLoginStreak'] as num?)?.toInt() ?? 0,
  daysActive: (json['daysActive'] as num?)?.toInt() ?? 0,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  lastActivityAt: json['lastActivityAt'] == null
      ? null
      : DateTime.parse(json['lastActivityAt'] as String),
);

Map<String, dynamic> _$$ProfileStatsDtoImplToJson(
  _$ProfileStatsDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'totalPosts': instance.totalPosts,
  'totalLikesReceived': instance.totalLikesReceived,
  'totalCommentsReceived': instance.totalCommentsReceived,
  'totalShares': instance.totalShares,
  'postsCreated': instance.postsCreated,
  'commentsMade': instance.commentsMade,
  'postsLiked': instance.postsLiked,
  'postsShared': instance.postsShared,
  'messagesSent': instance.messagesSent,
  'conversationsStarted': instance.conversationsStarted,
  'friendsAdded': instance.friendsAdded,
  'eventsCreated': instance.eventsCreated,
  'eventsAttended': instance.eventsAttended,
  'activityScore': instance.activityScore,
  'helpfulnessScore': instance.helpfulnessScore,
  'engagementScore': instance.engagementScore,
  'currentLoginStreak': instance.currentLoginStreak,
  'longestLoginStreak': instance.longestLoginStreak,
  'daysActive': instance.daysActive,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'lastActivityAt': instance.lastActivityAt?.toIso8601String(),
};
