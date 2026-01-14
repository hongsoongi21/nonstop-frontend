import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/event.dart';
import '../../domain/repository/timetable_repository.dart';
import '../api/timetable_api.dart';
import '../dto/event_dto.dart';

/// Implementation of TimetableRepository
/// Uses mock data for now, can be easily replaced with real API calls
class TimetableRepositoryImpl implements TimetableRepository {
  final TimetableApi api;

  TimetableRepositoryImpl(this.api);

  @override
  Future<Either<Failure, List<Event>>> getEvents({
    required String userId,
  }) async {
    try {
      final result = await api.getEvents(userId: userId);
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (eventDtos) => Right(eventDtos.map((dto) => dto.toDomain()).toList()),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getEventsForDate({
    required String userId,
    required DateTime date,
  }) async {
    try {
      final result = await api.getEventsForDate(userId: userId, date: date);
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (eventDtos) => Right(eventDtos.map((dto) => dto.toDomain()).toList()),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getEventsForWeek({
    required String userId,
    required DateTime weekStart,
  }) async {
    try {
      final result = await api.getEventsForWeek(
        userId: userId,
        weekStart: weekStart,
      );
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (eventDtos) => Right(eventDtos.map((dto) => dto.toDomain()).toList()),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getEventsForMonth({
    required String userId,
    required int year,
    required int month,
  }) async {
    try {
      final result = await api.getEventsForMonth(
        userId: userId,
        year: year,
        month: month,
      );
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (eventDtos) => Right(eventDtos.map((dto) => dto.toDomain()).toList()),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getEventsByType({
    required String userId,
    required EventType type,
  }) async {
    try {
      final result = await api.getEventsByType(
        userId: userId,
        eventType: type.name,
      );
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (eventDtos) => Right(eventDtos.map((dto) => dto.toDomain()).toList()),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Event>> getEvent({required String eventId}) async {
    try {
      final result = await api.getEvent(eventId: eventId);
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (eventDto) => Right(eventDto.toDomain()),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Event>> createEvent({required Event event}) async {
    try {
      final createDto = CreateEventDto.fromDomain(event);
      final result = await api.createEvent(event: createDto);
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (eventDto) => Right(eventDto.toDomain()),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Event>> updateEvent({
    required String eventId,
    required Event event,
  }) async {
    try {
      final updateDto = UpdateEventDto.fromDomain(event);
      final result = await api.updateEvent(eventId: eventId, event: updateDto);
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (eventDto) => Right(eventDto.toDomain()),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteEvent({required String eventId}) async {
    try {
      final result = await api.deleteEvent(eventId: eventId);
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (_) => const Right(unit),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> checkConflicts({
    required String userId,
    required DateTime startTime,
    required DateTime endTime,
    String? excludeEventId,
  }) async {
    try {
      final result = await api.checkConflicts(
        userId: userId,
        startTime: startTime,
        endTime: endTime,
        excludeEventId: excludeEventId,
      );
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (eventDtos) => Right(eventDtos.map((dto) => dto.toDomain()).toList()),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getUpcomingEvents({
    required String userId,
    int days = 7,
  }) async {
    try {
      final result = await api.getUpcomingEvents(userId: userId, days: days);
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (eventDtos) => Right(eventDtos.map((dto) => dto.toDomain()).toList()),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> searchEvents({
    required String userId,
    required String query,
  }) async {
    try {
      final result = await api.searchEvents(userId: userId, query: query);
      return result.fold(
        (exception) => Left(_mapExceptionToFailure(exception)),
        (eventDtos) => Right(eventDtos.map((dto) => dto.toDomain()).toList()),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  /// Map API exceptions to domain failures
  Failure _mapExceptionToFailure(ApiException exception) {
    switch (exception.runtimeType) {
      case NetworkException:
        return NetworkFailure(message: exception.message);
      case ServerException:
        final serverEx = exception as ServerException;
        return ServerFailure(
          message: serverEx.message,
          statusCode: serverEx.statusCode,
        );
      case ValidationException:
        final validationEx = exception as ValidationException;
        return ValidationFailure(
          message: validationEx.message,
          errors: validationEx.errors,
        );
      case AuthenticationException:
        return AuthenticationFailure(message: exception.message);
      case AuthorizationException:
        return AuthorizationFailure(message: exception.message);
      case TimeoutException:
        return TimeoutFailure(message: exception.message);
      default:
        return UnknownFailure(message: exception.message);
    }
  }
}
