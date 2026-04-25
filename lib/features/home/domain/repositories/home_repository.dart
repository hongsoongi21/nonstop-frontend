import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/home_dashboard.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeDashboard>> getDashboard({
    String? weekday,
    int noticeLimit = 5,
    int popularLimit = 5,
  });
}
