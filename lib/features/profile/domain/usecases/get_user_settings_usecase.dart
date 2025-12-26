import 'package:fpdart/fpdart.dart';

import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/core/usecases/usecase.dart';
import '../entities/user_settings.dart';
import '../repository/profile_repository.dart';

/// Use case for getting user settings
class GetUserSettingsUseCase implements UseCase<UserSettings, GetUserSettingsParams> {
  final ProfileRepository repository;

  GetUserSettingsUseCase(this.repository);

  @override
  Future<Either<Failure, UserSettings>> call(GetUserSettingsParams params) {
    return repository.getUserSettings(userId: params.userId);
  }
}

/// Parameters for GetUserSettingsUseCase
class GetUserSettingsParams {
  final String userId;

  const GetUserSettingsParams({required this.userId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetUserSettingsParams && runtimeType == other.runtimeType && userId == other.userId;

  @override
  int get hashCode => userId.hashCode;
}
