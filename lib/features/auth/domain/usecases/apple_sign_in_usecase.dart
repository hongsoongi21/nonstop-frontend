import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/api/auth_api.dart';
import '../repository/auth_repository.dart';

/// Use case for signing in a user with Apple
/// Returns OAuthLoginResult - either OAuthExistingUser or OAuthNewUser
class AppleSignInUseCase implements UseCase<OAuthLoginResult, AppleSignInParams> {
  final AuthRepository _authRepository;

  AppleSignInUseCase(this._authRepository);

  @override
  Future<Either<Failure, OAuthLoginResult>> call(AppleSignInParams params) {
    return _authRepository.signInWithApple(
      idToken: params.idToken,
      authorizationCode: params.authorizationCode,
      firstName: params.firstName,
      lastName: params.lastName,
    );
  }
}

/// Parameters for Apple sign in use case
class AppleSignInParams {
  final String idToken;
  final String? authorizationCode;
  final String? firstName;
  final String? lastName;

  const AppleSignInParams({
    required this.idToken,
    this.authorizationCode,
    this.firstName,
    this.lastName,
  });
}
