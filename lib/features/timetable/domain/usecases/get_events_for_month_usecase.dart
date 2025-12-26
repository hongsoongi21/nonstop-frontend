import 'package:fpdart/fpdart.dart';

import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/core/usecases/usecase.dart';
import '../entities/event.dart';
import '../repository/timetable_repository.dart';

/// Use case for getting events for a specific month
class GetEventsForMonthUseCase implements UseCase<List<Event>, GetEventsForMonthParams> {
  final TimetableRepository repository;

  GetEventsForMonthUseCase(this.repository);

  @override
  Future<Either<Failure, List<Event>>> call(GetEventsForMonthParams params) {
    return repository.getEventsForMonth(
      userId: params.userId,
      year: params.year,
      month: params.month,
    );
  }
}

/// Parameters for GetEventsForMonthUseCase
class GetEventsForMonthParams {
  final String userId;
  final int year;
  final int month;

  const GetEventsForMonthParams({
    required this.userId,
    required this.year,
    required this.month,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetEventsForMonthParams &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          year == other.year &&
          month == other.month;

  @override
  int get hashCode => userId.hashCode ^ year.hashCode ^ month.hashCode;
}
