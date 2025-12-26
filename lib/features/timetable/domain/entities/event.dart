import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';

/// Types of events that can be scheduled in the timetable
enum EventType {
  course,      // University courses
  exam,        // Exams
  assignment,  // Assignment deadlines
  meeting,     // Study group meetings
  personal,    // Personal events
  other,       // Other events
}

/// Extension methods for EventType
extension EventTypeExtension on EventType {
  /// Get event type display name
  String get typeName {
    switch (this) {
      case EventType.course:
        return 'Dars';
      case EventType.exam:
        return 'Imtihon';
      case EventType.assignment:
        return 'Vazifa';
      case EventType.meeting:
        return 'Uchrashuv';
      case EventType.personal:
        return 'Shaxsiy';
      case EventType.other:
        return 'Boshqa';
    }
  }
}

/// Represents a scheduled event in the timetable
@freezed
class Event with _$Event {
  const factory Event({
    required String id,
    required String title,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
    required EventType type,
    required String userId,
    String? location,
    int? color,
    bool? isAllDay,
    List<String>? tags,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Event;

  const Event._();

  /// Duration of the event in minutes
  int get durationInMinutes => endTime.difference(startTime).inMinutes;

  /// Check if event is recurring (for future enhancement)
  bool get isRecurring => false; // Placeholder for future feature

  /// Get day of week (1 = Monday, 7 = Sunday)
  int get dayOfWeek => startTime.weekday;

  /// Get formatted time range
  String get timeRange {
    final start = '${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}';
    final end = '${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}';
    return '$start - $end';
  }

  /// Get event type display name
  String get typeName {
    switch (type) {
      case EventType.course:
        return 'Dars';
      case EventType.exam:
        return 'Imtihon';
      case EventType.assignment:
        return 'Vazifa';
      case EventType.meeting:
        return 'Uchrashuv';
      case EventType.personal:
        return 'Shaxsiy';
      case EventType.other:
        return 'Boshqa';
    }
  }

  /// Get event type display name (alias for backwards compatibility)
  String get eventTypeName => typeName;

  /// Get event type color (for UI theming)
  int get typeColor {
    switch (type) {
      case EventType.course:
        return 0xFF2563EB; // Blue
      case EventType.exam:
        return 0xFFDC2626; // Red
      case EventType.assignment:
        return 0xFFF59E0B; // Amber
      case EventType.meeting:
        return 0xFF059669; // Green
      case EventType.personal:
        return 0xFF7C3AED; // Purple
      case EventType.other:
        return 0xFF6B7280; // Gray
    }
  }

  /// Check if event conflicts with another event
  bool conflictsWith(Event other) {
    if (startTime.isAtSameMomentAs(other.startTime) ||
        endTime.isAtSameMomentAs(other.endTime)) {
      return true;
    }
    return startTime.isBefore(other.endTime) && endTime.isAfter(other.startTime);
  }

  /// Create a copy with new time (for drag & drop in future)
  Event copyWithTime(DateTime newStartTime, DateTime newEndTime) {
    return copyWith(
      startTime: newStartTime,
      endTime: newEndTime,
    );
  }
}

/// Extension methods for Event lists
extension EventListExtension on List<Event> {
  /// Get events for a specific date
  List<Event> forDate(DateTime date) {
    final dateOnly = DateTime(date.year, date.month, date.day);
    final nextDay = dateOnly.add(const Duration(days: 1));

    return where((event) =>
        event.startTime.isAfter(dateOnly.subtract(const Duration(seconds: 1))) &&
        event.startTime.isBefore(nextDay)).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  /// Get events for a specific week
  List<Event> forWeek(DateTime weekStart) {
    final weekEnd = weekStart.add(const Duration(days: 7));
    return where((event) =>
        event.startTime.isAfter(weekStart.subtract(const Duration(seconds: 1))) &&
        event.startTime.isBefore(weekEnd)).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  /// Get events for a specific month
  List<Event> forMonth(int year, int month) {
    return where((event) =>
        event.startTime.year == year && event.startTime.month == month).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  /// Get events by type
  List<Event> byType(EventType type) {
    return where((event) => event.type == type).toList();
  }

  /// Check for time conflicts
  List<Event> findConflicts() {
    final conflicts = <Event>[];
    for (var i = 0; i < length; i++) {
      for (var j = i + 1; j < length; j++) {
        if (this[i].conflictsWith(this[j])) {
          if (!conflicts.contains(this[i])) conflicts.add(this[i]);
          if (!conflicts.contains(this[j])) conflicts.add(this[j]);
        }
      }
    }
    return conflicts;
  }
}
