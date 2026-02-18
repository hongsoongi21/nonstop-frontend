import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:nonstop/core/errors/exceptions.dart';
import 'package:nonstop/core/utils/date_utils.dart';
import '../dto/profile_stats_dto.dart';
import '../dto/user_profile_dto.dart';
import '../dto/user_settings_dto.dart';
import 'profile_api.dart';

/// Real implementation of ProfileApi using Supabase
class ProfileApiImpl implements ProfileApi {
  final SupabaseClient _supabase;

  ProfileApiImpl(this._supabase);

  Future<int> _getCurrentUserId() async {
    final authUser = _supabase.auth.currentUser;
    if (authUser == null) throw const AuthenticationException('Not authenticated');
    final data = await _supabase
        .from('users')
        .select('id')
        .eq('auth_id', authUser.id)
        .single();
    return data['id'] as int;
  }

  @override
  Future<Either<ApiException, UserProfileDto>> getUserProfile({
    required String userId,
  }) async {
    try {
      final authUser = _supabase.auth.currentUser;
      if (authUser == null) {
        return Left(const AuthenticationException('Not authenticated'));
      }

      final data = await _supabase
          .from('users')
          .select('*, universities(name), majors(name)')
          .eq('auth_id', authUser.id)
          .single();

      final profileDto = UserProfileDto(
        id: data['id']?.toString() ?? '',
        userId: data['id']?.toString() ?? '',
        fullName: data['nickname'] ?? '',
        email: data['email'] as String?,
        bio: data['introduction'] as String?,
        avatarUrl: data['profile_image_url'] as String?,
        universityId: data['university_id'],
        major: data['majors'] != null
            ? (data['majors'] as Map<String, dynamic>)['name'] as String?
            : null,
        dateOfBirth: data['birth_date'] != null
            ? DateTime.tryParse(data['birth_date'] as String)
            : null,
        isPublic: true,
        showEmail: false,
        showPhone: false,
        showGpa: false,
        createdAt: data['created_at'] != null
            ? parseUtcDateTime(data['created_at'] as String)
            : null,
        updatedAt: data['updated_at'] != null
            ? parseUtcDateTime(data['updated_at'] as String)
            : null,
      );

      return Right(profileDto);
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, UserProfileDto>> updateUserProfile({
    required String userId,
    required UpdateUserProfileDto profile,
  }) async {
    try {
      final authUser = _supabase.auth.currentUser;
      if (authUser == null) {
        return Left(const AuthenticationException('Not authenticated'));
      }

      final updateData = <String, dynamic>{};
      if (profile.fullName != null) updateData['nickname'] = profile.fullName;
      if (profile.bio != null) updateData['introduction'] = profile.bio;
      if (profile.avatarUrl != null) {
        updateData['profile_image_url'] = profile.avatarUrl;
      }
      if (profile.universityId != null) {
        updateData['university_id'] = profile.universityId;
      }

      if (updateData.isNotEmpty) {
        updateData['updated_at'] = DateTime.now().toIso8601String();
        await _supabase
            .from('users')
            .update(updateData)
            .eq('auth_id', authUser.id);
      }

      return getUserProfile(userId: userId);
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, UserSettingsDto>> getUserSettings({
    required String userId,
  }) async {
    try {
      final settings = UserSettingsDto(
        id: 'settings_$userId',
        userId: userId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      return Right(settings);
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, UserSettingsDto>> updateUserSettings({
    required String userId,
    required UserSettingsDto settings,
  }) async {
    try {
      final updatedSettings = settings.copyWith(updatedAt: DateTime.now());
      return Right(updatedSettings);
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, ProfileStatsDto>> getProfileStats({
    required String userId,
  }) async {
    try {
      final currentUserId = await _getCurrentUserId();

      // Get real counts from Supabase
      final posts = await _supabase
          .from('posts')
          .select('id')
          .eq('user_id', currentUserId)
          .isFilter('deleted_at', null);

      final comments = await _supabase
          .from('comments')
          .select('id')
          .eq('user_id', currentUserId)
          .isFilter('deleted_at', null);

      final friends = await _supabase
          .from('friends')
          .select('id')
          .or('sender_id.eq.$currentUserId,receiver_id.eq.$currentUserId')
          .eq('status', 'ACCEPTED')
          .isFilter('deleted_at', null);

      final stats = ProfileStatsDto(
        id: 'stats_$userId',
        userId: userId,
        totalPosts: (posts as List).length,
        totalLikesReceived: 0,
        totalCommentsReceived: 0,
        totalShares: 0,
        postsCreated: (posts).length,
        commentsMade: (comments as List).length,
        postsLiked: 0,
        postsShared: 0,
        messagesSent: 0,
        conversationsStarted: 0,
        friendsAdded: (friends as List).length,
        eventsCreated: 0,
        eventsAttended: 0,
        activityScore: 0,
        helpfulnessScore: 0,
        engagementScore: 0,
        currentLoginStreak: 0,
        longestLoginStreak: 0,
        daysActive: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        lastActivityAt: DateTime.now(),
      );
      return Right(stats);
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, String>> uploadAvatar({
    required String userId,
    required String imagePath,
  }) async {
    try {
      final authUser = _supabase.auth.currentUser;
      if (authUser == null) {
        return Left(const AuthenticationException('Not authenticated'));
      }

      final file = File(imagePath);
      final fileName =
          '${authUser.id}/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';

      await _supabase.storage.from('avatars').upload(fileName, file);

      final imageUrl =
          _supabase.storage.from('avatars').getPublicUrl(fileName);

      // Update profile with new avatar URL
      await _supabase.from('users').update({
        'profile_image_url': imageUrl,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('auth_id', authUser.id);

      return Right(imageUrl);
    } on StorageException catch (e) {
      return Left(ApiException('아바타 업로드 실패: ${e.message}'));
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, String>> uploadCoverImage({
    required String userId,
    required String imagePath,
  }) async {
    try {
      return Right(imagePath);
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Unit>> deleteAvatar({
    required String userId,
  }) async {
    try {
      final authUser = _supabase.auth.currentUser;
      if (authUser == null) {
        return Left(const AuthenticationException('Not authenticated'));
      }

      await _supabase.from('users').update({
        'profile_image_url': null,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('auth_id', authUser.id);

      return const Right(unit);
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Unit>> deleteCoverImage({
    required String userId,
  }) async {
    return const Right(unit);
  }

  @override
  Future<Either<ApiException, Unit>> changePassword({
    required String userId,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
      return const Right(unit);
    } on AuthException catch (e) {
      return Left(ApiException(e.message));
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Unit>> deleteAccount({
    required String userId,
  }) async {
    try {
      final authUser = _supabase.auth.currentUser;
      if (authUser == null) {
        return Left(const AuthenticationException('Not authenticated'));
      }

      // Soft delete
      await _supabase.from('users').update({
        'deleted_at': DateTime.now().toIso8601String(),
        'is_active': false,
      }).eq('auth_id', authUser.id);

      await _supabase.auth.signOut();
      return const Right(unit);
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Map<String, dynamic>>> exportUserData({
    required String userId,
  }) async {
    try {
      final profileResult = await getUserProfile(userId: userId);
      return profileResult.fold(
        (failure) => Left(failure),
        (profile) => Right({
          'profile': profile.toJson(),
          'exportedAt': DateTime.now().toIso8601String(),
          'userId': userId,
        }),
      );
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }
}
