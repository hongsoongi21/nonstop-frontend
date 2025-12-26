import 'package:fpdart/fpdart.dart';

import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/core/usecases/usecase.dart';
import '../entities/user_profile.dart';
import '../repository/profile_repository.dart';

/// Use case for getting user profile
class GetUserProfileUseCase implements UseCase<UserProfile, GetUserProfileParams> {
  final ProfileRepository repository;

  GetUserProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserProfile>> call(GetUserProfileParams params) {
    return repository.getUserProfile(userId: params.userId);
  }
}

/// Parameters for GetUserProfileUseCase
class GetUserProfileParams {
  final String userId;

  const GetUserProfileParams({required this.userId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetUserProfileParams && runtimeType == other.runtimeType && userId == other.userId;

  @override
  int get hashCode => userId.hashCode;
}
