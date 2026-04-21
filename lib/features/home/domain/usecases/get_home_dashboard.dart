import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/home_dashboard.dart';
import '../repositories/home_repository.dart';

class GetHomeDashboard {
  final HomeRepository _repository;

  GetHomeDashboard(this._repository);

  Future<Either<Failure, HomeDashboard>> call({
    String? weekday,
    int noticeLimit = 5,
    int popularLimit = 5,
  }) {
    return _repository.getDashboard(
      weekday: weekday,
      noticeLimit: noticeLimit,
      popularLimit: popularLimit,
    );
  }
}
