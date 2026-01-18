import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/dto/timetable_entry_dto.dart';

part 'timetable_entry.freezed.dart';

/// Domain model for a timetable entry
/// Represents a single class/course in the timetable
@freezed
class TimetableEntry with _$TimetableEntry {
  const factory TimetableEntry({
    required int id,
    required int timetableId,
    required String subjectName,
    String? professor,
    required DayOfWeek dayOfWeek,
    required String startTime, // Format: "HH:mm"
    required String endTime, // Format: "HH:mm"
    String? place,
    String? color,
  }) = _TimetableEntry;

  const TimetableEntry._();

  /// Create from DTO
  factory TimetableEntry.fromDto(TimetableEntryDto dto) {
    return TimetableEntry(
      id: dto.id,
      timetableId: dto.timetableId,
      subjectName: dto.subjectName,
      professor: dto.professor,
      dayOfWeek: dto.dayOfWeek,
      startTime: dto.startTime,
      endTime: dto.endTime,
      place: dto.place,
      color: dto.color,
    );
  }

  /// Get formatted time range (e.g., "09:00 - 10:30")
  String get timeRange => '$startTime - $endTime';

  /// Get duration in minutes
  int get durationInMinutes {
    final start = _parseTime(startTime);
    final end = _parseTime(endTime);
    return end.difference(start).inMinutes;
  }

  /// Parse time string to DateTime (using today as date)
  DateTime _parseTime(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  /// Check if this entry conflicts with another entry
  bool conflictsWith(TimetableEntry other) {
    // Only check conflict if same day
    if (dayOfWeek != other.dayOfWeek) return false;

    final thisStart = _parseTime(startTime);
    final thisEnd = _parseTime(endTime);
    final otherStart = _parseTime(other.startTime);
    final otherEnd = _parseTime(other.endTime);

    // Check if times overlap
    return thisStart.isBefore(otherEnd) && thisEnd.isAfter(otherStart);
  }

  /// Get display color (hex string to int, or default blue)
  int get displayColor {
    if (color != null && color!.isNotEmpty) {
      try {
        // Remove '#' if present and parse as hex
        final hexColor = color!.replaceAll('#', '');
        return int.parse('FF$hexColor', radix: 16);
      } catch (e) {
        return 0xFF2563EB; // Default blue
      }
    }
    return 0xFF2563EB; // Default blue
  }
}
