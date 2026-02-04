import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/api/auth_api.dart';
import '../repository/auth_repository.dart';

/// Use case for signing in a user with Google
/// Returns OAuthLoginResult - either OAuthExistingUser or OAuthNewUser
class GoogleSignInUseCase implements UseCase<OAuthLoginResult, GoogleSignInParams> {
  final AuthRepository _authRepository;

  GoogleSignInUseCase(this._authRepository);

  @override
  Future<Either<Failure, OAuthLoginResult>> call(GoogleSignInParams params) {
    return _authRepository.signInWithGoogle(idToken: params.idToken);
  }
}

/// Parameters for Google sign in use case
class GoogleSignInParams {
  final String idToken;

  const GoogleSignInParams({
    required this.idToken,
  });
}
