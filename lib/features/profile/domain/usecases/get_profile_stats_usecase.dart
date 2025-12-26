import 'package:fpdart/fpdart.dart';
import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/core/usecases/usecase.dart';
import '../entities/profile_stats.dart';
import '../repository/profile_repository.dart';

class GetProfileStatsUseCase implements UseCase<ProfileStats, GetProfileStatsParams> {
  final ProfileRepository repository;

  GetProfileStatsUseCase(this.repository);

  @override
  Future<Either<Failure, ProfileStats>> call(GetProfileStatsParams params) {
    return repository.getUserStats(userId: params.userId);
  }
}

class GetProfileStatsParams {
  final String userId;

  GetProfileStatsParams({required this.userId});
}
