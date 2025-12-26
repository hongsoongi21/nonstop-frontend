import 'package:fpdart/fpdart.dart';

import 'package:nonstop/core/errors/failures.dart';
import '../entities/profile_stats.dart';
import '../entities/user_profile.dart';
import '../entities/user_settings.dart';

/// Repository interface for profile operations
/// Provides methods to manage user profiles, settings, and statistics
abstract class ProfileRepository {
  /// Get user profile by user ID
  Future<Either<Failure, UserProfile>> getUserProfile({
    required String userId,
  });

  /// Update user profile
  Future<Either<Failure, UserProfile>> updateUserProfile({
    required String userId,
    required UserProfile profile,
  });

  /// Get user settings
  Future<Either<Failure, UserSettings>> getUserSettings({
    required String userId,
  });

  /// Update user settings
  Future<Either<Failure, UserSettings>> updateUserSettings({
    required String userId,
    required UserSettings settings,
  });

  /// Get user profile statistics
  Future<Either<Failure, ProfileStats>> getUserStats({
    required String userId,
  });

  /// Update user profile statistics
  Future<Either<Failure, ProfileStats>> updateUserStats({
    required String userId,
    required ProfileStats stats,
  });

  /// Upload profile avatar
  Future<Either<Failure, String>> uploadAvatar({
    required String userId,
    required String imagePath,
  });

  /// Upload profile cover image
  Future<Either<Failure, String>> uploadCoverImage({
    required String userId,
    required String imagePath,
  });

  /// Delete profile avatar
  Future<Either<Failure, Unit>> deleteAvatar({
    required String userId,
  });

  /// Delete profile cover image
  Future<Either<Failure, Unit>> deleteCoverImage({
    required String userId,
  });

  /// Change user password
  Future<Either<Failure, Unit>> changePassword({
    required String userId,
    required String currentPassword,
    required String newPassword,
  });

  /// Delete user account
  Future<Either<Failure, Unit>> deleteAccount({
    required String userId,
  });

  /// Export user data
  Future<Either<Failure, Map<String, dynamic>>> exportUserData({
    required String userId,
  });
}
