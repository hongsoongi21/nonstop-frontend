import 'package:fpdart/fpdart.dart';

import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/core/usecases/usecase.dart';
import '../entities/user_profile.dart';
import '../repository/profile_repository.dart';

/// Use case for updating user profile
class UpdateUserProfileUseCase implements UseCase<UserProfile, UpdateUserProfileParams> {
  final ProfileRepository repository;

  UpdateUserProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserProfile>> call(UpdateUserProfileParams params) {
    return repository.updateUserProfile(
      userId: params.userId,
      profile: params.profile,
    );
  }
}

/// Parameters for UpdateUserProfileUseCase
class UpdateUserProfileParams {
  final String userId;
  final UserProfile profile;

  const UpdateUserProfileParams({
    required this.userId,
    required this.profile,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateUserProfileParams &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          profile == other.profile;

  @override
  int get hashCode => userId.hashCode ^ profile.hashCode;
}
