import 'package:fpdart/fpdart.dart';

import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/core/usecases/usecase.dart';
import '../entities/event.dart';
import '../repository/timetable_repository.dart';

/// Use case for getting all events for a user
class GetEventsUseCase implements UseCase<List<Event>, GetEventsParams> {
  final TimetableRepository repository;

  GetEventsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Event>>> call(GetEventsParams params) {
    return repository.getEvents(userId: params.userId);
  }
}

/// Parameters for GetEventsUseCase
class GetEventsParams {
  final String userId;

  const GetEventsParams({required this.userId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetEventsParams && runtimeType == other.runtimeType && userId == other.userId;

  @override
  int get hashCode => userId.hashCode;
}
