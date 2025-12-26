import 'package:fpdart/fpdart.dart';

import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/core/usecases/usecase.dart';
import '../repository/timetable_repository.dart';

/// Use case for deleting an event
class DeleteEventUseCase implements UseCase<Unit, DeleteEventParams> {
  final TimetableRepository repository;

  DeleteEventUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(DeleteEventParams params) {
    return repository.deleteEvent(eventId: params.eventId);
  }
}

/// Parameters for DeleteEventUseCase
class DeleteEventParams {
  final String eventId;

  const DeleteEventParams({required this.eventId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeleteEventParams &&
          runtimeType == other.runtimeType &&
          eventId == other.eventId;

  @override
  int get hashCode => eventId.hashCode;
}
