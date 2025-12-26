import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_stats.freezed.dart';

/// User profile statistics and activity metrics
@freezed
class ProfileStats with _$ProfileStats {
  const factory ProfileStats({
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
  }) = _ProfileStats;

  const ProfileStats._();

  /// Calculate overall engagement score
  int get overallScore => activityScore + helpfulnessScore + engagementScore;

  /// Get activity level based on score
  ActivityLevel get activityLevel {
    if (overallScore >= 1000) return ActivityLevel.expert;
    if (overallScore >= 500) return ActivityLevel.advanced;
    if (overallScore >= 200) return ActivityLevel.intermediate;
    if (overallScore >= 50) return ActivityLevel.beginner;
    return ActivityLevel.newcomer;
  }

  /// Check if user has been active recently (last 7 days)
  bool get isActiveRecently {
    if (lastActivityAt == null) return false;
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    return lastActivityAt!.isAfter(sevenDaysAgo);
  }

  /// Get posts per day average
  double get postsPerDay {
    if (daysActive == 0) return 0;
    return totalPosts / daysActive;
  }

  /// Get engagement rate (likes + comments received per post)
  double get engagementRate {
    if (totalPosts == 0) return 0;
    return (totalLikesReceived + totalCommentsReceived) / totalPosts;
  }

  /// Create stats for new user
  factory ProfileStats.newUser(String userId) {
    return ProfileStats(
      id: 'stats_$userId',
      userId: userId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastActivityAt: DateTime.now(),
    );
  }

  /// Update stats after posting
  ProfileStats afterPosting({int likes = 0, int comments = 0}) {
    return copyWith(
      totalPosts: totalPosts + 1,
      postsCreated: postsCreated + 1,
      activityScore: activityScore + 10,
      engagementScore: engagementScore + likes + (comments * 2),
      updatedAt: DateTime.now(),
      lastActivityAt: DateTime.now(),
    );
  }

  /// Update stats after receiving engagement
  ProfileStats afterReceivingEngagement({int likes = 0, int comments = 0, int shares = 0}) {
    return copyWith(
      totalLikesReceived: totalLikesReceived + likes,
      totalCommentsReceived: totalCommentsReceived + comments,
      totalShares: totalShares + shares,
      helpfulnessScore: helpfulnessScore + (likes * 2) + (comments * 3) + (shares * 5),
      updatedAt: DateTime.now(),
    );
  }

  /// Update stats after login
  ProfileStats afterLogin() {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    final isConsecutive = lastActivityAt?.isAfter(yesterday) ?? false;

    return copyWith(
      currentLoginStreak: isConsecutive ? currentLoginStreak + 1 : 1,
      longestLoginStreak: isConsecutive && currentLoginStreak + 1 > longestLoginStreak
          ? currentLoginStreak + 1
          : longestLoginStreak,
      daysActive: daysActive + 1,
      activityScore: activityScore + 1,
      lastActivityAt: now,
      updatedAt: now,
    );
  }
}

/// Activity levels based on user engagement
enum ActivityLevel {
  newcomer,
  beginner,
  intermediate,
  advanced,
  expert,
}

/// Extension for activity level utilities
extension ActivityLevelExtension on ActivityLevel {
  String get displayName {
    switch (this) {
      case ActivityLevel.newcomer:
        return 'Yangi foydalanuvchi';
      case ActivityLevel.beginner:
        return 'Boshlovchi';
      case ActivityLevel.intermediate:
        return 'O\'rtacha';
      case ActivityLevel.advanced:
        return 'Tajribali';
      case ActivityLevel.expert:
        return 'Ekspert';
    }
  }

  String get description {
    switch (this) {
      case ActivityLevel.newcomer:
        return 'Siz endigina boshladingiz!';
      case ActivityLevel.beginner:
        return 'Yaxshi boshlangan!';
      case ActivityLevel.intermediate:
        return 'Faol ishtirok etyapsiz!';
      case ActivityLevel.advanced:
        return 'Siz faol foydalanuvchisiz!';
      case ActivityLevel.expert:
        return 'Siz hamjamiyat yetakchisisiz!';
    }
  }

  int get minScore {
    switch (this) {
      case ActivityLevel.newcomer:
        return 0;
      case ActivityLevel.beginner:
        return 50;
      case ActivityLevel.intermediate:
        return 200;
      case ActivityLevel.advanced:
        return 500;
      case ActivityLevel.expert:
        return 1000;
    }
  }
}
