import 'package:fpdart/fpdart.dart';

import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/core/usecases/usecase.dart';
import '../entities/event.dart';
import '../repository/timetable_repository.dart';

/// Use case for getting events for a specific date
class GetEventsForDateUseCase implements UseCase<List<Event>, GetEventsForDateParams> {
  final TimetableRepository repository;

  GetEventsForDateUseCase(this.repository);

  @override
  Future<Either<Failure, List<Event>>> call(GetEventsForDateParams params) {
    return repository.getEventsForDate(
      userId: params.userId,
      date: params.date,
    );
  }
}

/// Parameters for GetEventsForDateUseCase
class GetEventsForDateParams {
  final String userId;
  final DateTime date;

  const GetEventsForDateParams({
    required this.userId,
    required this.date,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetEventsForDateParams &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          date == other.date;

  @override
  int get hashCode => userId.hashCode ^ date.hashCode;
}
