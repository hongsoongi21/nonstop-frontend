import 'package:fpdart/fpdart.dart';

import 'package:nonstop/core/errors/exceptions.dart';
import 'package:nonstop/core/mock/mock_data.dart';
import '../dto/profile_stats_dto.dart';
import '../dto/user_profile_dto.dart';
import '../dto/user_settings_dto.dart';
import 'profile_api.dart';

/// Mock implementation of ProfileApi
/// Uses static mock data to simulate API responses
class ProfileApiMock implements ProfileApi {
  // In-memory storage for mock profile data
  final Map<String, UserProfileDto> _mockProfiles = {};
  final Map<String, UserSettingsDto> _mockSettings = {};
  final Map<String, ProfileStatsDto> _mockStats = {};

  ProfileApiMock() {
    _initializeMockData();
  }

  /// Initialize mock data from existing user data
  void _initializeMockData() {
    // Create profile data from existing users
    for (final user in MockData.users) {
      final profile = UserProfileDto(
        id: 'profile_${user.id}',
        userId: user.id,
        fullName: user.name,
        email: user.email,
        universityId: user.universityId,
        major: user.major,
        year: user.year,
        avatarUrl: user.avatarUrl,
        isPublic: true,
        showEmail: true,
        showPhone: false,
        showGpa: false,
        bio: _getMockBio(user.id),
        location: 'Tashkent, Uzbekistan',
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
        updatedAt: DateTime.now().subtract(const Duration(days: 7)),
        lastActiveAt: DateTime.now().subtract(const Duration(hours: 2)),
      );
      _mockProfiles[user.id] = profile;

      // Create default settings for each user
      final settings = UserSettingsDto(
        id: 'settings_${user.id}',
        userId: user.id,
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
        updatedAt: DateTime.now().subtract(const Duration(days: 30)),
      );
      _mockSettings[user.id] = settings;

      // Create default stats for each user
      final stats = ProfileStatsDto(
        id: 'stats_${user.id}',
        userId: user.id,
        totalPosts: (user.id.hashCode % 20) + 5, // 5-25 posts
        totalLikesReceived: (user.id.hashCode % 200) + 20, // 20-220 likes
        totalCommentsReceived: (user.id.hashCode % 80) + 10, // 10-90 comments
        totalShares: (user.id.hashCode % 30) + 2, // 2-32 shares
        postsCreated: (user.id.hashCode % 15) + 3, // 3-18 posts created
        commentsMade: (user.id.hashCode % 50) + 5, // 5-55 comments
        postsLiked: (user.id.hashCode % 100) + 10, // 10-110 likes given
        postsShared: (user.id.hashCode % 20) + 1, // 1-21 shares
        messagesSent: (user.id.hashCode % 300) + 50, // 50-350 messages
        conversationsStarted: (user.id.hashCode % 25) + 3, // 3-28 conversations
        friendsAdded: (user.id.hashCode % 15) + 2, // 2-17 friends
        eventsCreated: (user.id.hashCode % 10) + 1, // 1-11 events
        eventsAttended: (user.id.hashCode % 20) + 5, // 5-25 events attended
        activityScore: (user.id.hashCode % 800) + 200, // 200-1000 activity score
        helpfulnessScore: (user.id.hashCode % 150) + 20, // 20-170 helpfulness
        engagementScore: (user.id.hashCode % 120) + 30, // 30-150 engagement
        currentLoginStreak: (user.id.hashCode % 15) + 1, // 1-16 day streak
        longestLoginStreak: (user.id.hashCode % 30) + 5, // 5-35 longest streak
        daysActive: (user.id.hashCode % 200) + 50, // 50-250 active days
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
        lastActivityAt: DateTime.now().subtract(const Duration(hours: 2)),
      );
      _mockStats[user.id] = stats;
    }
  }

  String _getMockBio(String userId) {
    final bios = {
      '1': 'Computer Science student passionate about mobile development and AI. Always learning something new! 🚀',
      '2': 'Business Administration major with a love for entrepreneurship and digital marketing.',
      '3': 'Economics student interested in data analysis and financial modeling.',
      '4': 'Mathematics enthusiast solving complex problems and teaching others.',
    };
    return bios[userId] ?? 'Student at Tashkent universities, exploring new opportunities and learning every day.';
  }

  @override
  Future<Either<ApiException, UserProfileDto>> getUserProfile({
    required String userId,
  }) async {
    await _simulateNetworkDelay();
    final profile = _mockProfiles[userId];
    if (profile == null) {
      return Left(NotFoundException('Profile not found'));
    }
    return Right(profile);
  }

  @override
  Future<Either<ApiException, UserProfileDto>> updateUserProfile({
    required String userId,
    required UpdateUserProfileDto profile,
  }) async {
    await _simulateNetworkDelay();
    final existingProfile = _mockProfiles[userId];
    if (existingProfile == null) {
      return Left(NotFoundException('Profile not found'));
    }

    // Update the profile with new values
    final updatedProfile = existingProfile.copyWith(
      fullName: profile.fullName ?? existingProfile.fullName,
      displayName: profile.displayName ?? existingProfile.displayName,
      email: profile.email ?? existingProfile.email,
      phoneNumber: profile.phoneNumber ?? existingProfile.phoneNumber,
      bio: profile.bio ?? existingProfile.bio,
      avatarUrl: profile.avatarUrl ?? existingProfile.avatarUrl,
      coverImageUrl: profile.coverImageUrl ?? existingProfile.coverImageUrl,
      dateOfBirth: profile.dateOfBirth ?? existingProfile.dateOfBirth,
      gender: profile.gender ?? existingProfile.gender,
      location: profile.location ?? existingProfile.location,
      website: profile.website ?? existingProfile.website,
      universityId: profile.universityId ?? existingProfile.universityId,
      major: profile.major ?? existingProfile.major,
      year: profile.year ?? existingProfile.year,
      gpa: profile.gpa ?? existingProfile.gpa,
      linkedinUrl: profile.linkedinUrl ?? existingProfile.linkedinUrl,
      githubUrl: profile.githubUrl ?? existingProfile.githubUrl,
      instagramUrl: profile.instagramUrl ?? existingProfile.instagramUrl,
      isPublic: profile.isPublic ?? existingProfile.isPublic,
      showEmail: profile.showEmail ?? existingProfile.showEmail,
      showPhone: profile.showPhone ?? existingProfile.showPhone,
      showGpa: profile.showGpa ?? existingProfile.showGpa,
      updatedAt: DateTime.now(),
    );

    _mockProfiles[userId] = updatedProfile;
    return Right(updatedProfile);
  }

  @override
  Future<Either<ApiException, UserSettingsDto>> getUserSettings({
    required String userId,
  }) async {
    await _simulateNetworkDelay();
    final settings = _mockSettings[userId];
    if (settings == null) {
      return Left(NotFoundException('Settings not found'));
    }
    return Right(settings);
  }

  @override
  Future<Either<ApiException, UserSettingsDto>> updateUserSettings({
    required String userId,
    required UserSettingsDto settings,
  }) async {
    await _simulateNetworkDelay();
    final updatedSettings = settings.copyWith(
      updatedAt: DateTime.now(),
    );
    _mockSettings[userId] = updatedSettings;
    return Right(updatedSettings);
  }

  @override
  Future<Either<ApiException, String>> uploadAvatar({
    required String userId,
    required String imagePath,
  }) async {
    await _simulateNetworkDelay();

    // Simulate upload delay
    await Future.delayed(const Duration(seconds: 2));

    // Return a mock URL
    final mockUrl = 'https://api.nonstop.app/uploads/avatars/${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Update the profile with the new avatar URL
    final profile = _mockProfiles[userId];
    if (profile != null) {
      _mockProfiles[userId] = profile.copyWith(
        avatarUrl: mockUrl,
        updatedAt: DateTime.now(),
      );
    }

    return Right(mockUrl);
  }

  @override
  Future<Either<ApiException, String>> uploadCoverImage({
    required String userId,
    required String imagePath,
  }) async {
    await _simulateNetworkDelay();

    // Simulate upload delay
    await Future.delayed(const Duration(seconds: 2));

    // Return a mock URL
    final mockUrl = 'https://api.nonstop.app/uploads/covers/${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Update the profile with the new cover URL
    final profile = _mockProfiles[userId];
    if (profile != null) {
      _mockProfiles[userId] = profile.copyWith(
        coverImageUrl: mockUrl,
        updatedAt: DateTime.now(),
      );
    }

    return Right(mockUrl);
  }

  @override
  Future<Either<ApiException, Unit>> deleteAvatar({
    required String userId,
  }) async {
    await _simulateNetworkDelay();

    final profile = _mockProfiles[userId];
    if (profile != null) {
      _mockProfiles[userId] = profile.copyWith(
        avatarUrl: null,
        updatedAt: DateTime.now(),
      );
    }

    return const Right(unit);
  }

  @override
  Future<Either<ApiException, Unit>> deleteCoverImage({
    required String userId,
  }) async {
    await _simulateNetworkDelay();

    final profile = _mockProfiles[userId];
    if (profile != null) {
      _mockProfiles[userId] = profile.copyWith(
        coverImageUrl: null,
        updatedAt: DateTime.now(),
      );
    }

    return const Right(unit);
  }

  @override
  Future<Either<ApiException, Unit>> changePassword({
    required String userId,
    required String currentPassword,
    required String newPassword,
  }) async {
    await _simulateNetworkDelay();

    // Simulate password validation
    if (currentPassword.isEmpty) {
      return Left(ValidationException(
        message: 'Current password is required',
        errors: {'currentPassword': 'Required field'},
      ));
    }

    if (newPassword.length < 6) {
      return Left(ValidationException(
        message: 'New password must be at least 6 characters',
        errors: {'newPassword': 'Minimum 6 characters'},
      ));
    }

    // Simulate successful password change
    return const Right(unit);
  }

  @override
  Future<Either<ApiException, Unit>> deleteAccount({
    required String userId,
  }) async {
    await _simulateNetworkDelay();

    // Remove user data
    _mockProfiles.remove(userId);
    _mockSettings.remove(userId);

    return const Right(unit);
  }

  @override
  Future<Either<ApiException, Map<String, dynamic>>> exportUserData({
    required String userId,
  }) async {
    await _simulateNetworkDelay();

    final profile = _mockProfiles[userId];
    final settings = _mockSettings[userId];

    if (profile == null) {
      return Left(NotFoundException('Profile not found'));
    }

    final exportData = {
      'profile': profile.toJson(),
      'settings': settings?.toJson(),
      'exportedAt': DateTime.now().toIso8601String(),
      'userId': userId,
    };

    return Right(exportData);
  }

  @override
  Future<Either<ApiException, ProfileStatsDto>> getProfileStats({
    required String userId,
  }) async {
    await _simulateNetworkDelay();
    final stats = _mockStats[userId];
    if (stats == null) {
      return Left(NotFoundException('Profile stats not found'));
    }
    return Right(stats);
  }

  /// Simulate network delay for realistic API behavior
  Future<void> _simulateNetworkDelay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
