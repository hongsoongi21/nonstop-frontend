import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/profile_stats.dart';

part 'profile_stats_dto.freezed.dart';
part 'profile_stats_dto.g.dart';

@freezed
class ProfileStatsDto with _$ProfileStatsDto {
  const factory ProfileStatsDto({
    required String id,
    required String userId,

    // Post statistics
    @Default(0) int totalPosts,
    @Default(0) int totalLikesReceived,
    @Default(0) int totalCommentsReceived,
    @Default(0) int totalShares,

    // Board activity
    @Default(0) int postsCreated,
    @Default(0) int commentsMade,
    @Default(0) int postsLiked,
    @Default(0) int postsShared,

    // Chat activity
    @Default(0) int messagesSent,
    @Default(0) int conversationsStarted,
    @Default(0) int friendsAdded,

    // Timetable activity
    @Default(0) int eventsCreated,
    @Default(0) int eventsAttended,

    // Achievement scores
    @Default(0) int activityScore,
    @Default(0) int helpfulnessScore,
    @Default(0) int engagementScore,

    // Streaks and milestones
    @Default(0) int currentLoginStreak,
    @Default(0) int longestLoginStreak,
    @Default(0) int daysActive,

    // Timestamps
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastActivityAt,
  }) = _ProfileStatsDto;

  const ProfileStatsDto._();

  factory ProfileStatsDto.fromJson(Map<String, dynamic> json) => _$ProfileStatsDtoFromJson(json);

  static ProfileStatsDto fromDomain(ProfileStats stats) {
    return ProfileStatsDto(
      id: stats.id,
      userId: stats.userId,
      totalPosts: stats.totalPosts,
      totalLikesReceived: stats.totalLikesReceived,
      totalCommentsReceived: stats.totalCommentsReceived,
      totalShares: stats.totalShares,
      postsCreated: stats.postsCreated,
      commentsMade: stats.commentsMade,
      postsLiked: stats.postsLiked,
      postsShared: stats.postsShared,
      messagesSent: stats.messagesSent,
      conversationsStarted: stats.conversationsStarted,
      friendsAdded: stats.friendsAdded,
      eventsCreated: stats.eventsCreated,
      eventsAttended: stats.eventsAttended,
      activityScore: stats.activityScore,
      helpfulnessScore: stats.helpfulnessScore,
      engagementScore: stats.engagementScore,
      currentLoginStreak: stats.currentLoginStreak,
      longestLoginStreak: stats.longestLoginStreak,
      daysActive: stats.daysActive,
      createdAt: stats.createdAt,
      updatedAt: stats.updatedAt,
      lastActivityAt: stats.lastActivityAt,
    );
  }

  ProfileStats toDomain() {
    return ProfileStats(
      id: id,
      userId: userId,
      totalPosts: totalPosts,
      totalLikesReceived: totalLikesReceived,
      totalCommentsReceived: totalCommentsReceived,
      totalShares: totalShares,
      postsCreated: postsCreated,
      commentsMade: commentsMade,
      postsLiked: postsLiked,
      postsShared: postsShared,
      messagesSent: messagesSent,
      conversationsStarted: conversationsStarted,
      friendsAdded: friendsAdded,
      eventsCreated: eventsCreated,
      eventsAttended: eventsAttended,
      activityScore: activityScore,
      helpfulnessScore: helpfulnessScore,
      engagementScore: engagementScore,
      currentLoginStreak: currentLoginStreak,
      longestLoginStreak: longestLoginStreak,
      daysActive: daysActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
      lastActivityAt: lastActivityAt,
    );
  }
}
