import 'package:fpdart/fpdart.dart';

import 'package:nonstop/core/errors/failures.dart';
import '../entities/event.dart';

/// Repository interface for timetable operations
/// Provides methods to manage scheduled events
abstract class TimetableRepository {
  /// Get all events for a specific user
  Future<Either<Failure, List<Event>>> getEvents({required String userId});

  /// Get events for a specific date
  Future<Either<Failure, List<Event>>> getEventsForDate({
    required String userId,
    required DateTime date,
  });

  /// Get events for a specific week
  Future<Either<Failure, List<Event>>> getEventsForWeek({
    required String userId,
    required DateTime weekStart,
  });

  /// Get events for a specific month
  Future<Either<Failure, List<Event>>> getEventsForMonth({
    required String userId,
    required int year,
    required int month,
  });

  /// Get events by type
  Future<Either<Failure, List<Event>>> getEventsByType({
    required String userId,
    required EventType type,
  });

  /// Get a single event by ID
  Future<Either<Failure, Event>> getEvent({required String eventId});

  /// Create a new event
  Future<Either<Failure, Event>> createEvent({required Event event});

  /// Update an existing event
  Future<Either<Failure, Event>> updateEvent({
    required String eventId,
    required Event event,
  });

  /// Delete an event
  Future<Either<Failure, Unit>> deleteEvent({required String eventId});

  /// Check for time conflicts with existing events
  Future<Either<Failure, List<Event>>> checkConflicts({
    required String userId,
    required DateTime startTime,
    required DateTime endTime,
    String? excludeEventId,
  });

  /// Get upcoming events (next 7 days)
  Future<Either<Failure, List<Event>>> getUpcomingEvents({
    required String userId,
    int days = 7,
  });

  /// Search events by title or description
  Future<Either<Failure, List<Event>>> searchEvents({
    required String userId,
    required String query,
  });
}
