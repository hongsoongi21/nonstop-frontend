import 'package:fpdart/fpdart.dart';

import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/core/usecases/usecase.dart';
import '../entities/event.dart';
import '../repository/timetable_repository.dart';

/// Use case for creating a new event
class CreateEventUseCase implements UseCase<Event, CreateEventParams> {
  final TimetableRepository repository;

  CreateEventUseCase(this.repository);

  @override
  Future<Either<Failure, Event>> call(CreateEventParams params) async {
    // First check for conflicts
    final conflictsResult = await repository.checkConflicts(
      userId: params.event.userId,
      startTime: params.event.startTime,
      endTime: params.event.endTime,
    );

    return conflictsResult.fold(
      (failure) => Left(failure),
      (conflicts) {
        if (conflicts.isNotEmpty && !params.allowConflicts) {
          return Left(Failure.validation(
            message: 'Time conflict with existing events',
            errors: {'conflicts': conflicts.map((e) => e.title).join(', ')},
          ));
        }

        // No conflicts or conflicts allowed, proceed with creation
        return repository.createEvent(event: params.event);
      },
    );
  }
}

/// Parameters for CreateEventUseCase
class CreateEventParams {
  final Event event;
  final bool allowConflicts;

  const CreateEventParams({
    required this.event,
    this.allowConflicts = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateEventParams &&
          runtimeType == other.runtimeType &&
          event == other.event &&
          allowConflicts == other.allowConflicts;

  @override
  int get hashCode => event.hashCode ^ allowConflicts.hashCode;
}
