import 'package:fpdart/fpdart.dart';

import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/core/usecases/usecase.dart';
import '../entities/user_settings.dart';
import '../repository/profile_repository.dart';

/// Use case for updating user settings
class UpdateUserSettingsUseCase implements UseCase<UserSettings, UpdateUserSettingsParams> {
  final ProfileRepository repository;

  UpdateUserSettingsUseCase(this.repository);

  @override
  Future<Either<Failure, UserSettings>> call(UpdateUserSettingsParams params) {
    return repository.updateUserSettings(
      userId: params.userId,
      settings: params.settings,
    );
  }
}

/// Parameters for UpdateUserSettingsUseCase
class UpdateUserSettingsParams {
  final String userId;
  final UserSettings settings;

  const UpdateUserSettingsParams({
    required this.userId,
    required this.settings,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateUserSettingsParams &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          settings == other.settings;

  @override
  int get hashCode => userId.hashCode ^ settings.hashCode;
}
