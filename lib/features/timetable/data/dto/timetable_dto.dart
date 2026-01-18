import 'package:freezed_annotation/freezed_annotation.dart';

import 'semester_dto.dart';
import 'timetable_entry_dto.dart';

part 'timetable_dto.freezed.dart';
part 'timetable_dto.g.dart';

/// Timetable DTO from backend (list response)
/// Represents a single timetable container (e.g., "My Spring 2024 Schedule")
@freezed
class TimetableDto with _$TimetableDto {
  const factory TimetableDto({
    required int id,
    required int semesterId,
    required int year,
    required SemesterType semesterType,
    String? title,
    required bool isPublic,
  }) = _TimetableDto;

  factory TimetableDto.fromJson(Map<String, dynamic> json) =>
      _$TimetableDtoFromJson(json);
}

/// Timetable Detail DTO (includes entries)
/// Used when fetching a specific timetable with all its classes
@freezed
class TimetableDetailDto with _$TimetableDetailDto {
  const factory TimetableDetailDto({
    required int id,
    required int semesterId,
    required int year,
    required SemesterType semesterType,
    String? title,
    required bool isPublic,
    required List<TimetableEntryDto> entries,
  }) = _TimetableDetailDto;

  factory TimetableDetailDto.fromJson(Map<String, dynamic> json) =>
      _$TimetableDetailDtoFromJson(json);
}

/// Request DTO for creating/updating a timetable
@freezed
class TimetableRequestDto with _$TimetableRequestDto {
  const factory TimetableRequestDto({
    int? semesterId, // Required for create, ignored for update
    String? title,
    bool? isPublic,
  }) = _TimetableRequestDto;

  factory TimetableRequestDto.fromJson(Map<String, dynamic> json) =>
      _$TimetableRequestDtoFromJson(json);
}
