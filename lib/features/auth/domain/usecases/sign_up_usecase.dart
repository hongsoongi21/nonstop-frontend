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
  Future<Either<Failure, User>> call(SignUpParams params) {
    return _authRepository.signUp(
      email: params.email,
      password: params.password,
      fullName: params.fullName,
      university: params.university,
      major: params.major,
    );
  }
}

/// Parameters for sign up use case
class SignUpParams {
  final String email;
  final String password;
  final String fullName;
  final String? university;
  final String? major;

  const SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
    this.university,
    this.major,
  });
}
