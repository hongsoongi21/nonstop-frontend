import 'package:fpdart/fpdart.dart';

import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/core/usecases/usecase.dart';
import '../entities/event.dart';
import '../repository/timetable_repository.dart';

/// Use case for getting upcoming events
class GetUpcomingEventsUseCase implements UseCase<List<Event>, GetUpcomingEventsParams> {
  final TimetableRepository repository;

  GetUpcomingEventsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Event>>> call(GetUpcomingEventsParams params) {
    return repository.getUpcomingEvents(
      userId: params.userId,
      days: params.days,
    );
  }
}

/// Parameters for GetUpcomingEventsUseCase
class GetUpcomingEventsParams {
  final String userId;
  final int days;

  const GetUpcomingEventsParams({
    required this.userId,
    this.days = 7,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetUpcomingEventsParams &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          days == other.days;

  @override
  int get hashCode => userId.hashCode ^ days.hashCode;
}
