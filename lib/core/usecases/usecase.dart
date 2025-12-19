import 'package:fpdart/fpdart.dart';
import 'package:nonstop/core/errors/failures.dart';

/// Base class for all use cases
/// [Type] is the return type of the use case
/// [Params] is the parameter type for the use case
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Parameter class for use cases that don't need parameters
class NoParams {
  const NoParams();
}
