import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repository/auth_repository.dart';

/// Use case for signing up a new user
class SignUpUseCase implements UseCase<User, SignUpParams> {
  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await _authRepository.signUp(
      email: params.email,
      password: params.password,
      nickname: params.nickname,
      birthDate: params.birthDate,
      universityId: params.universityId,
      majorId: params.majorId,
      agreedPolicyIds: params.agreedPolicyIds,
    );
  }
}

/// Parameters for sign up use case
class SignUpParams {
  final String email;
  final String password;
  final String nickname;
  final DateTime birthDate;
  final int? universityId;
  final int? majorId;
  final List<int>? agreedPolicyIds;

  const SignUpParams({
    required this.email,
    required this.password,
    required this.nickname,
    required this.birthDate,
    this.universityId,
    this.majorId,
    this.agreedPolicyIds,
  });
}
