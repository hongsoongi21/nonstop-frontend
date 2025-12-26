import 'package:fpdart/fpdart.dart';

import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/core/usecases/usecase.dart';
import '../entities/event.dart';
import '../repository/timetable_repository.dart';

/// Use case for updating an existing event
class UpdateEventUseCase implements UseCase<Event, UpdateEventParams> {
  final TimetableRepository repository;

  UpdateEventUseCase(this.repository);

  @override
  Future<Either<Failure, Event>> call(UpdateEventParams params) async {
    // Check for conflicts (excluding the current event)
    final conflictsResult = await repository.checkConflicts(
      userId: params.event.userId,
      startTime: params.event.startTime,
      endTime: params.event.endTime,
      excludeEventId: params.eventId,
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

        // No conflicts or conflicts allowed, proceed with update
        return repository.updateEvent(
          eventId: params.eventId,
          event: params.event,
        );
      },
    );
  }
}

/// Parameters for UpdateEventUseCase
class UpdateEventParams {
  final String eventId;
  final Event event;
  final bool allowConflicts;

  const UpdateEventParams({
    required this.eventId,
    required this.event,
    this.allowConflicts = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateEventParams &&
          runtimeType == other.runtimeType &&
          eventId == other.eventId &&
          event == other.event &&
          allowConflicts == other.allowConflicts;

  @override
  int get hashCode => eventId.hashCode ^ event.hashCode ^ allowConflicts.hashCode;
}
