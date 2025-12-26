import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repository/auth_repository.dart';

/// Use case for signing out the current user
class SignOutUseCase implements UseCase<Unit, NoParams> {
  final AuthRepository _authRepository;

  SignOutUseCase(this._authRepository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return _authRepository.signOut();
  }
}
