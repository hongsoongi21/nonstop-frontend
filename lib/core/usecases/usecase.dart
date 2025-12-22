import 'package:fpdart/fpdart.dart';
import 'package:nonstop/core/errors/failures.dart';

/// Base class for all use cases
/// [T] is the return type of the use case
/// [Params] is the parameter type for the use case
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Parameter class for use cases that don't need parameters
class NoParams {
  const NoParams();
}
