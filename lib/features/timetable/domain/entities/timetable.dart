import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/dto/semester_dto.dart';
import '../../data/dto/timetable_dto.dart';
import 'day_of_week.dart';
import 'semester.dart';
import 'timetable_entry.dart';

part 'timetable.freezed.dart';

/// Domain model for a timetable
/// Represents a single timetable container (e.g., "My Spring 2024 Schedule")
@freezed
class Timetable with _$Timetable {
  const factory Timetable({
    required int id,
    required int semesterId,
    required int year,
    required SemesterType semesterType,
    String? title,
    required bool isPublic,
  }) = _Timetable;

  const Timetable._();

  /// Create from DTO
  factory Timetable.fromDto(TimetableDto dto) {
    return Timetable(
      id: dto.id,
      semesterId: dto.semesterId,
      year: dto.year,
      semesterType: dto.semesterType,
      title: dto.title,
      isPublic: dto.isPublic,
    );
  }

  /// Get display title (fallback to semester name if no custom title)
  String get displayTitle {
    if (title != null && title!.isNotEmpty) {
      return title!;
    }
    final semesterName = semesterType.displayName;
    return '$year $semesterName';
  }
}

/// Domain model for timetable detail (with entries)
@freezed
class TimetableDetail with _$TimetableDetail {
  const factory TimetableDetail({
    required int id,
    required int semesterId,
    required int year,
    required SemesterType semesterType,
    String? title,
    required bool isPublic,
    required List<TimetableEntry> entries,
  }) = _TimetableDetail;

  const TimetableDetail._();

  /// Create from DTO
  factory TimetableDetail.fromDto(TimetableDetailDto dto) {
    return TimetableDetail(
      id: dto.id,
      semesterId: dto.semesterId,
      year: dto.year,
      semesterType: dto.semesterType,
      title: dto.title,
      isPublic: dto.isPublic,
      entries: dto.entries.map((e) => TimetableEntry.fromDto(e)).toList(),
    );
  }

  /// Get display title
  String get displayTitle {
    if (title != null && title!.isNotEmpty) {
      return title!;
    }
    final semesterName = semesterType.displayName;
    return '$year $semesterName';
  }

  /// Get entries for a specific day
  List<TimetableEntry> entriesForDay(int weekdayNumber) {
    return entries
        .where((entry) => entry.dayOfWeek.weekdayNumber == weekdayNumber)
        .toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  /// Check if there are any time conflicts
  bool hasConflicts() {
    for (var i = 0; i < entries.length; i++) {
      for (var j = i + 1; j < entries.length; j++) {
        if (entries[i].conflictsWith(entries[j])) {
          return true;
        }
      }
    }
    return false;
  }
}
