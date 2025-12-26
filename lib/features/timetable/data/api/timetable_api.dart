import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../dto/event_dto.dart';

/// API interface for timetable operations
/// Defines methods for communicating with the backend
abstract class TimetableApi {
  /// Get all events for a specific user
  Future<Either<ApiException, List<EventDto>>> getEvents({
    required String userId,
  });

  /// Get events for a specific date
  Future<Either<ApiException, List<EventDto>>> getEventsForDate({
    required String userId,
    required DateTime date,
  });

  /// Get events for a specific week
  Future<Either<ApiException, List<EventDto>>> getEventsForWeek({
    required String userId,
    required DateTime weekStart,
  });

  /// Get events for a specific month
  Future<Either<ApiException, List<EventDto>>> getEventsForMonth({
    required String userId,
    required int year,
    required int month,
  });

  /// Get events by type
  Future<Either<ApiException, List<EventDto>>> getEventsByType({
    required String userId,
    required String eventType,
  });

  /// Get a single event by ID
  Future<Either<ApiException, EventDto>> getEvent({
    required String eventId,
  });

  /// Create a new event
  Future<Either<ApiException, EventDto>> createEvent({
    required CreateEventDto event,
  });

  /// Update an existing event
  Future<Either<ApiException, EventDto>> updateEvent({
    required String eventId,
    required UpdateEventDto event,
  });

  /// Delete an event
  Future<Either<ApiException, Unit>> deleteEvent({
    required String eventId,
  });

  /// Check for time conflicts
  Future<Either<ApiException, List<EventDto>>> checkConflicts({
    required String userId,
    required DateTime startTime,
    required DateTime endTime,
    String? excludeEventId,
  });

  /// Get upcoming events
  Future<Either<ApiException, List<EventDto>>> getUpcomingEvents({
    required String userId,
    int days = 7,
  });

  /// Search events
  Future<Either<ApiException, List<EventDto>>> searchEvents({
    required String userId,
    required String query,
  });
}
