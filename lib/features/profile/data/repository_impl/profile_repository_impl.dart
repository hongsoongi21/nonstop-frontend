import 'package:fpdart/fpdart.dart';

import 'package:nonstop/core/errors/exceptions.dart';
import 'package:nonstop/core/errors/failures.dart';
import '../../domain/entities/profile_stats.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/user_settings.dart';
import '../../domain/repository/profile_repository.dart';
import '../api/profile_api.dart';
import '../dto/user_profile_dto.dart';
import '../dto/user_settings_dto.dart';

/// Implementation of ProfileRepository
/// Uses mock data for now, can be easily replaced with real API calls
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApi api;

  ProfileRepositoryImpl(this.api);

  @override
  Future<Either<Failure, UserProfile>> getUserProfile({
    required String userId,
  }) async {
    try {
      final result = await api.getUserProfile(userId: userId);
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (profileDto) => Right(profileDto.toDomain()),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> updateUserProfile({
    required String userId,
    required UserProfile profile,
  }) async {
    try {
      final updateDto = UpdateUserProfileDto.fromDomain(profile);
      final result = await api.updateUserProfile(userId: userId, profile: updateDto);
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (profileDto) => Right(profileDto.toDomain()),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserSettings>> getUserSettings({
    required String userId,
  }) async {
    try {
      final result = await api.getUserSettings(userId: userId);
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (settingsDto) => Right(settingsDto.toDomain()),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserSettings>> updateUserSettings({
    required String userId,
    required UserSettings settings,
  }) async {
    try {
      final settingsDto = UserSettingsDto.fromDomain(settings);
      final result = await api.updateUserSettings(userId: userId, settings: settingsDto);
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (settingsDto) => Right(settingsDto.toDomain()),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileStats>> getUserStats({
    required String userId,
  }) async {
    try {
      final result = await api.getProfileStats(userId: userId);
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (dto) => Right(dto.toDomain()),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileStats>> updateUserStats({
    required String userId,
    required ProfileStats stats,
  }) async {
    // For now, just return the stats - in real implementation, this would update via API
    return Right(stats);
  }

  @override
  Future<Either<Failure, String>> uploadAvatar({
    required String userId,
    required String imagePath,
  }) async {
    try {
      final result = await api.uploadAvatar(userId: userId, imagePath: imagePath);
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (url) => Right(url),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadCoverImage({
    required String userId,
    required String imagePath,
  }) async {
    try {
      final result = await api.uploadCoverImage(userId: userId, imagePath: imagePath);
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (url) => Right(url),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAvatar({
    required String userId,
  }) async {
    try {
      final result = await api.deleteAvatar(userId: userId);
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (_) => const Right(unit),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCoverImage({
    required String userId,
  }) async {
    try {
      final result = await api.deleteCoverImage(userId: userId);
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (_) => const Right(unit),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> changePassword({
    required String userId,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final result = await api.changePassword(
        userId: userId,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (_) => const Right(unit),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAccount({
    required String userId,
  }) async {
    try {
      final result = await api.deleteAccount(userId: userId);
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (_) => const Right(unit),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> exportUserData({
    required String userId,
  }) async {
    try {
      final result = await api.exportUserData(userId: userId);
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  /// Map API exceptions to domain failures
  Failure _mapExceptionToFailure(ApiException exception) {
    switch (exception.runtimeType) {
      case NetworkException:
        return NetworkFailure(message: exception.message);
      case ServerException:
        final serverEx = exception as ServerException;
        return ServerFailure(
          message: serverEx.message,
          statusCode: serverEx.statusCode,
        );
      case ValidationException:
        final validationEx = exception as ValidationException;
        return ValidationFailure(
          message: validationEx.message,
          errors: validationEx.errors,
        );
      case AuthenticationException:
        return AuthenticationFailure(message: exception.message);
      case AuthorizationException:
        return AuthorizationFailure(message: exception.message);
      case NotFoundException:
        return ServerFailure(
          message: exception.message,
          statusCode: 404,
        );
      default:
        return UnknownFailure(message: exception.message);
    }
  }
}
