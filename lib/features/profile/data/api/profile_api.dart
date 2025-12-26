import 'package:fpdart/fpdart.dart';

import 'package:nonstop/core/errors/exceptions.dart';
import '../dto/profile_stats_dto.dart';
import '../dto/user_profile_dto.dart';
import '../dto/user_settings_dto.dart';

/// API interface for profile operations
/// Defines methods for communicating with the backend
abstract class ProfileApi {
  /// Get user profile by user ID
  Future<Either<ApiException, UserProfileDto>> getUserProfile({
    required String userId,
  });

  /// Update user profile
  Future<Either<ApiException, UserProfileDto>> updateUserProfile({
    required String userId,
    required UpdateUserProfileDto profile,
  });

  /// Get user settings
  Future<Either<ApiException, UserSettingsDto>> getUserSettings({
    required String userId,
  });

  /// Update user settings
  Future<Either<ApiException, UserSettingsDto>> updateUserSettings({
    required String userId,
    required UserSettingsDto settings,
  });

  /// Get user profile statistics
  Future<Either<ApiException, ProfileStatsDto>> getProfileStats({
    required String userId,
  });

  /// Upload profile avatar
  Future<Either<ApiException, String>> uploadAvatar({
    required String userId,
    required String imagePath,
  });

  /// Upload profile cover image
  Future<Either<ApiException, String>> uploadCoverImage({
    required String userId,
    required String imagePath,
  });

  /// Delete profile avatar
  Future<Either<ApiException, Unit>> deleteAvatar({
    required String userId,
  });

  /// Delete profile cover image
  Future<Either<ApiException, Unit>> deleteCoverImage({
    required String userId,
  });

  /// Change user password
  Future<Either<ApiException, Unit>> changePassword({
    required String userId,
    required String currentPassword,
    required String newPassword,
  });

  /// Delete user account
  Future<Either<ApiException, Unit>> deleteAccount({
    required String userId,
  });

  /// Export user data
  Future<Either<ApiException, Map<String, dynamic>>> exportUserData({
    required String userId,
  });
}
