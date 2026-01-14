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
    // 백엔드 SignUpRequestDto가 이제 universityId와 majorId를 직접 수신하므로 
    // 가입 시 한 번에 모든 정보를 전달합니다.
    return await _authRepository.signUp(
      email: params.email,
      password: params.password,
      nickname: params.nickname,
      universityId: params.universityId,
      majorId: params.majorId,
    );
  }
}

/// Parameters for sign up use case
class SignUpParams {
  final String email;
  final String password;
  final String nickname;
  final int? universityId;
  final int? majorId;

  const SignUpParams({
    required this.email,
    required this.password,
    required this.nickname,
    this.universityId,
    this.majorId,
  });
}
