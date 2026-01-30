import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import 'package:nonstop/core/errors/exceptions.dart';
import 'package:nonstop/core/network/dio_client.dart';
import '../dto/profile_stats_dto.dart';
import '../dto/user_profile_dto.dart';
import '../dto/user_settings_dto.dart';
import 'profile_api.dart';

/// Real implementation of ProfileApi using backend endpoints
class ProfileApiImpl implements ProfileApi {
  final DioClient _dioClient;

  ProfileApiImpl(this._dioClient);

  @override
  Future<Either<ApiException, UserProfileDto>> getUserProfile({
    required String userId,
  }) async {
    try {
      final response = await _dioClient.get('/api/v1/users/me');
      final data = response.data['data'] as Map<String, dynamic>;

      // Map backend UserResponseDto to frontend UserProfileDto
      final profileDto = UserProfileDto(
        id: data['userId']?.toString() ?? data['id']?.toString() ?? '',
        userId: data['userId']?.toString() ?? data['id']?.toString() ?? '',
        fullName: data['nickname'] ?? '',
        email: data['email'],
        bio: data['introduction'],
        avatarUrl: data['profileImageUrl'],
        universityId: data['universityId'],
        dateOfBirth: data['birthDate'] != null
            ? DateTime.tryParse(data['birthDate'])
            : null,
        isPublic: true,
        showEmail: false,
        showPhone: false,
        showGpa: false,
      );

      return Right(profileDto);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
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
      // Build request body with backend-supported fields only
      final requestBody = <String, dynamic>{};

      if (profile.fullName != null) {
        requestBody['nickname'] = profile.fullName;
      }
      if (profile.bio != null) {
        requestBody['introduction'] = profile.bio;
      }
      if (profile.avatarUrl != null) {
        requestBody['profileImageUrl'] = profile.avatarUrl;
      }
      if (profile.universityId != null) {
        requestBody['universityId'] = profile.universityId;
      }

      await _dioClient.patch('/api/v1/users/me', data: requestBody);

      // Fetch updated profile
      return getUserProfile(userId: userId);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, UserSettingsDto>> getUserSettings({
    required String userId,
  }) async {
    // Backend doesn't have dedicated settings endpoint
    // Return default settings
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
    // Backend doesn't have dedicated settings endpoint
    // Return the settings as-is (local-only for now)
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
    // Backend doesn't have profile stats endpoint yet
    // Return placeholder stats
    try {
      final stats = ProfileStatsDto(
        id: 'stats_$userId',
        userId: userId,
        totalPosts: 0,
        totalLikesReceived: 0,
        totalCommentsReceived: 0,
        totalShares: 0,
        postsCreated: 0,
        commentsMade: 0,
        postsLiked: 0,
        postsShared: 0,
        messagesSent: 0,
        conversationsStarted: 0,
        friendsAdded: 0,
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
      final file = File(imagePath);
      final fileName = file.path.split('/').last;

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imagePath, filename: fileName),
      });

      final response = await _dioClient.post(
        '/api/v1/files/upload',
        data: formData,
      );

      final imageUrl = response.data['data']['url'] as String;

      // Update profile with new avatar URL
      await _dioClient.patch('/api/v1/users/me', data: {
        'profileImageUrl': imageUrl,
      });

      return Right(imageUrl);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, String>> uploadCoverImage({
    required String userId,
    required String imagePath,
  }) async {
    // Backend doesn't support cover images yet
    // Return the local path as placeholder
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
      await _dioClient.patch('/api/v1/users/me', data: {
        'profileImageUrl': null,
      });
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Unit>> deleteCoverImage({
    required String userId,
  }) async {
    // Backend doesn't support cover images yet
    return const Right(unit);
  }

  @override
  Future<Either<ApiException, Unit>> changePassword({
    required String userId,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _dioClient.patch('/api/v1/users/me/password', data: {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      });
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Unit>> deleteAccount({
    required String userId,
  }) async {
    try {
      await _dioClient.delete('/api/v1/users/me');
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Map<String, dynamic>>> exportUserData({
    required String userId,
  }) async {
    // Backend doesn't have data export endpoint yet
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

  ApiException _handleDioError(DioException e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode ?? 500;
      final data = e.response!.data;

      String message = '서버 오류가 발생했습니다.';
      if (data is Map<String, dynamic>) {
        message = data['message'] ?? message;
      }

      if (statusCode == 401) {
        return AuthenticationException(message);
      } else if (statusCode == 403) {
        return AuthorizationException(message);
      } else if (statusCode == 404) {
        return NotFoundException(message);
      } else if (statusCode == 422 || statusCode == 400) {
        return ValidationException(message: message);
      }

      return ApiException('$message (Status: $statusCode)');
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return TimeoutException('요청 시간이 초과되었습니다.');
    }

    if (e.type == DioExceptionType.connectionError) {
      return ApiException('네트워크 연결을 확인해주세요.');
    }

    return ApiException(e.message ?? '알 수 없는 오류가 발생했습니다.');
  }
}
