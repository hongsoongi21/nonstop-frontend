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
    // 1단계: 회원가입 시도 (AuthApiImpl 내부에서 가입 성공 시 자동으로 로그인을 시도하여 토큰을 획득합니다)
    final signUpResult = await _authRepository.signUp(
      email: params.email,
      password: params.password,
      nickname: params.nickname,
    );

    return signUpResult.fold(
      (failure) => Left(failure), // 가입 실패 시 즉시 중단
      (user) async {
        // 2단계: 가입 및 로그인 성공 후, 선택한 대학교 정보를 프로필에 업데이트
        // 백엔드 signup API가 universityId를 직접 받지 않기 때문에 별도의 PATCH 요청이 필요합니다.
        if (params.universityId != null || params.majorId != null) {
          final updateResult = await _authRepository.updateProfile(
            universityId: params.universityId,
            majorId: params.majorId,
          );
          
          return updateResult.fold(
            // 프로필 업데이트(대학교 설정)에 실패하더라도 이미 계정 생성과 로그인은 완료된 상태이므로
            // 우선 가입된 사용자 정보를 반환하여 메인 화면으로 진입할 수 있게 합니다.
            (failure) => Right(user), 
            (updatedUser) => Right(updatedUser),
          );
        }
        return Right(user);
      },
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
