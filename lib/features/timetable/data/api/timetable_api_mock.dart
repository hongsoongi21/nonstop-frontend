import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import 'package:nonstop/core/errors/exceptions.dart';
import 'package:nonstop/core/mock/mock_data.dart';
import '../dto/event_dto.dart';
import 'timetable_api.dart';

/// Mock implementation of TimetableApi
/// Uses static mock data to simulate API responses
class TimetableApiMock implements TimetableApi {
  final _uuid = const Uuid();

  // In-memory storage for mock events
  final List<EventDto> _mockEvents = [];

  TimetableApiMock() {
    _initializeMockEvents();
  }

  /// Initialize mock events from existing course data and add some custom events
  void _initializeMockEvents() {
    final now = DateTime.now();

    // Convert existing courses to events
    for (final course in MockData.courses) {
      final event = EventDto(
        id: course.id,
        title: course.name,
        description: course.description,
        startTime: course.startDateTime,
        endTime: course.endDateTime,
        eventType: 'course',
        userId: '1', // Assuming current user
        location: course.location,
        color: course.color,
        tags: [course.code, course.professor],
        metadata: {
          'credits': course.credits,
          'universityId': course.universityId,
          'professor': course.professor,
        },
        createdAt: now.subtract(const Duration(days: 30)),
        updatedAt: now.subtract(const Duration(days: 30)),
      );
      _mockEvents.add(event);
    }

    // Add some additional mock events
    final additionalEvents = [
      EventDto(
        id: 'exam_1',
        title: 'Data Structures Final Exam',
        description: 'Final examination for CS201 Data Structures course',
        startTime: DateTime(now.year, now.month, now.day + 7, 10, 0),
        endTime: DateTime(now.year, now.month, now.day + 7, 12, 0),
        eventType: 'exam',
        userId: '1',
        location: 'Room 301',
        color: 0xFFDC2626,
        tags: ['exam', 'cs201', 'final'],
        metadata: {'courseId': '1', 'type': 'final'},
        createdAt: now.subtract(const Duration(days: 14)),
        updatedAt: now.subtract(const Duration(days: 14)),
      ),
      EventDto(
        id: 'assignment_1',
        title: 'Algorithm Analysis Assignment',
        description: 'Submit analysis of sorting algorithms complexity',
        startTime: DateTime(now.year, now.month, now.day + 3, 23, 59),
        endTime: DateTime(now.year, now.month, now.day + 3, 23, 59),
        eventType: 'assignment',
        userId: '1',
        location: 'Online',
        color: 0xFFF59E0B,
        isAllDay: true,
        tags: ['assignment', 'algorithms', 'deadline'],
        metadata: {'courseId': '1', 'type': 'homework'},
        createdAt: now.subtract(const Duration(days: 7)),
        updatedAt: now.subtract(const Duration(days: 7)),
      ),
      EventDto(
        id: 'meeting_1',
        title: 'Study Group Meeting',
        description: 'Group study session for upcoming midterms',
        startTime: DateTime(now.year, now.month, now.day + 2, 14, 0),
        endTime: DateTime(now.year, now.month, now.day + 2, 16, 0),
        eventType: 'meeting',
        userId: '1',
        location: 'Library Room 205',
        color: 0xFF059669,
        tags: ['study-group', 'midterms', 'algorithms'],
        metadata: {'participants': '1,2,3', 'type': 'study'},
        createdAt: now.subtract(const Duration(days: 3)),
        updatedAt: now.subtract(const Duration(days: 3)),
      ),
      EventDto(
        id: 'personal_1',
        title: 'Doctor Appointment',
        description: 'Regular health checkup',
        startTime: DateTime(now.year, now.month, now.day + 5, 9, 0),
        endTime: DateTime(now.year, now.month, now.day + 5, 10, 0),
        eventType: 'personal',
        userId: '1',
        location: 'City Hospital',
        color: 0xFF7C3AED,
        tags: ['health', 'appointment'],
        metadata: {'type': 'medical'},
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now.subtract(const Duration(days: 1)),
      ),
    ];

    _mockEvents.addAll(additionalEvents);
  }

  @override
  Future<Either<ApiException, List<EventDto>>> getEvents({
    required String userId,
  }) async {
    await _simulateNetworkDelay();
    final userEvents = _mockEvents.where((event) => event.userId == userId).toList();
    return Right(userEvents);
  }

  @override
  Future<Either<ApiException, List<EventDto>>> getEventsForDate({
    required String userId,
    required DateTime date,
  }) async {
    await _simulateNetworkDelay();
    final dateOnly = DateTime(date.year, date.month, date.day);
    final nextDay = dateOnly.add(const Duration(days: 1));

    final events = _mockEvents.where((event) =>
        event.userId == userId &&
        event.startTime.isAfter(dateOnly.subtract(const Duration(seconds: 1))) &&
        event.startTime.isBefore(nextDay)).toList();

    return Right(events);
  }

  @override
  Future<Either<ApiException, List<EventDto>>> getEventsForWeek({
    required String userId,
    required DateTime weekStart,
  }) async {
    await _simulateNetworkDelay();
    final weekEnd = weekStart.add(const Duration(days: 7));

    final events = _mockEvents.where((event) =>
        event.userId == userId &&
        event.startTime.isAfter(weekStart.subtract(const Duration(seconds: 1))) &&
        event.startTime.isBefore(weekEnd)).toList();

    return Right(events);
  }

  @override
  Future<Either<ApiException, List<EventDto>>> getEventsForMonth({
    required String userId,
    required int year,
    required int month,
  }) async {
    await _simulateNetworkDelay();

    final events = _mockEvents.where((event) =>
        event.userId == userId &&
        event.startTime.year == year &&
        event.startTime.month == month).toList();

    return Right(events);
  }

  @override
  Future<Either<ApiException, List<EventDto>>> getEventsByType({
    required String userId,
    required String eventType,
  }) async {
    await _simulateNetworkDelay();

    final events = _mockEvents.where((event) =>
        event.userId == userId &&
        event.eventType == eventType).toList();

    return Right(events);
  }

  @override
  Future<Either<ApiException, EventDto>> getEvent({
    required String eventId,
  }) async {
    await _simulateNetworkDelay();

    final event = _mockEvents.firstWhere(
      (event) => event.id == eventId,
      orElse: () => throw NotFoundException('Event not found'),
    );

    return Right(event);
  }

  @override
  Future<Either<ApiException, EventDto>> createEvent({
    required CreateEventDto event,
  }) async {
    await _simulateNetworkDelay();

    // Check for conflicts - for now, assume current user
    final currentUserId = '1'; // Mock current user
    final conflicts = _mockEvents.where((existingEvent) =>
        existingEvent.userId == currentUserId &&
        existingEvent.startTime.isBefore(event.endTime) &&
        existingEvent.endTime.isAfter(event.startTime)).toList();

    if (conflicts.isNotEmpty) {
      return Left(ValidationException(
        message: 'Time conflict with existing events',
        errors: {'conflicts': conflicts.map((e) => e.title).join(', ')},
      ));
    }

    final newEvent = EventDto(
      id: _uuid.v4(),
      title: event.title,
      description: event.description,
      startTime: event.startTime,
      endTime: event.endTime,
      eventType: event.eventType,
      userId: event.userId,
      location: event.location,
      color: event.color,
      isAllDay: event.isAllDay,
      tags: event.tags,
      metadata: event.metadata,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _mockEvents.add(newEvent);
    return Right(newEvent);
  }

  @override
  Future<Either<ApiException, EventDto>> updateEvent({
    required String eventId,
    required UpdateEventDto event,
  }) async {
    await _simulateNetworkDelay();

    final index = _mockEvents.indexWhere((e) => e.id == eventId);
    if (index == -1) {
      return Left(NotFoundException('Event not found'));
    }

    // Check for conflicts (excluding current event)
    final conflicts = _mockEvents.where((existingEvent) =>
        existingEvent.id != eventId &&
        existingEvent.userId == _mockEvents[index].userId &&
        existingEvent.startTime.isBefore(event.endTime) &&
        existingEvent.endTime.isAfter(event.startTime)).toList();

    if (conflicts.isNotEmpty) {
      return Left(ValidationException(
        message: 'Time conflict with existing events',
        errors: {'conflicts': conflicts.map((e) => e.title).join(', ')},
      ));
    }

    final updatedEvent = _mockEvents[index].copyWith(
      title: event.title,
      description: event.description,
      startTime: event.startTime,
      endTime: event.endTime,
      eventType: event.eventType,
      location: event.location,
      color: event.color,
      isAllDay: event.isAllDay,
      tags: event.tags,
      metadata: event.metadata,
      updatedAt: DateTime.now(),
    );

    _mockEvents[index] = updatedEvent;
    return Right(updatedEvent);
  }

  @override
  Future<Either<ApiException, Unit>> deleteEvent({
    required String eventId,
  }) async {
    await _simulateNetworkDelay();

    final index = _mockEvents.indexWhere((e) => e.id == eventId);
    if (index == -1) {
      return Left(NotFoundException('Event not found'));
    }

    _mockEvents.removeAt(index);
    return const Right(unit);
  }

  @override
  Future<Either<ApiException, List<EventDto>>> checkConflicts({
    required String userId,
    required DateTime startTime,
    required DateTime endTime,
    String? excludeEventId,
  }) async {
    await _simulateNetworkDelay();

    final conflicts = _mockEvents.where((event) =>
        event.userId == userId &&
        event.id != excludeEventId &&
        event.startTime.isBefore(endTime) &&
        event.endTime.isAfter(startTime)).toList();

    return Right(conflicts);
  }

  @override
  Future<Either<ApiException, List<EventDto>>> getUpcomingEvents({
    required String userId,
    int days = 7,
  }) async {
    await _simulateNetworkDelay();

    final now = DateTime.now();
    final futureDate = now.add(Duration(days: days));

    final events = _mockEvents.where((event) =>
        event.userId == userId &&
        event.startTime.isAfter(now.subtract(const Duration(seconds: 1))) &&
        event.startTime.isBefore(futureDate)).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    return Right(events);
  }

  @override
  Future<Either<ApiException, List<EventDto>>> searchEvents({
    required String userId,
    required String query,
  }) async {
    await _simulateNetworkDelay();

    final lowerQuery = query.toLowerCase();
    final events = _mockEvents.where((event) =>
        event.userId == userId &&
        (event.title.toLowerCase().contains(lowerQuery) ||
         event.description.toLowerCase().contains(lowerQuery) ||
         event.tags?.any((tag) => tag.toLowerCase().contains(lowerQuery)) == true)).toList();

    return Right(events);
  }

  /// Simulate network delay for realistic API behavior
  Future<void> _simulateNetworkDelay() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
