import 'package:fpdart/fpdart.dart';
import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/core/usecases/usecase.dart';
import 'package:nonstop/features/timetable/domain/entities/event.dart';
import 'package:nonstop/features/timetable/domain/repository/timetable_repository.dart';

class GetEventsForWeekUseCase
    implements UseCase<List<Event>, GetEventsForWeekParams> {
  final TimetableRepository repository;

  GetEventsForWeekUseCase(this.repository);

  @override
  Future<Either<Failure, List<Event>>> call(GetEventsForWeekParams params) {
    return repository.getEventsForWeek(
      userId: params.userId,
      weekStart: params.weekStart,
    );
  }
}

class GetEventsForWeekParams {
  final String userId;
  final DateTime weekStart;

  GetEventsForWeekParams({required this.userId, required this.weekStart});
}
