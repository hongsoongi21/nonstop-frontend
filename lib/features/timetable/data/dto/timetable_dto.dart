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
    @JsonKey(name: 'timetable_kind') @Default('backup') String timetableKind,
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
    @JsonKey(name: 'timetable_kind') @Default('backup') String timetableKind,
    required List<TimetableEntryDto> entries,
  }) = _TimetableDetailDto;

  factory TimetableDetailDto.fromJson(Map<String, dynamic> json) =>
      _$TimetableDetailDtoFromJson(json);
}

/// Request DTO for creating/updating a timetable
/// Backend expects: year (int) + semesterType (enum), NOT semesterId
@freezed
class TimetableRequestDto with _$TimetableRequestDto {
  const factory TimetableRequestDto({
    int? year, // Required for create
    @JsonKey(toJson: _semesterTypeToJson, fromJson: _semesterTypeFromJson)
    SemesterType? semesterType, // Required for create (FIRST, SECOND, SUMMER, WINTER)
    String? title,
    bool? isPublic,
    String? timetableKind,
  }) = _TimetableRequestDto;

  factory TimetableRequestDto.fromJson(Map<String, dynamic> json) =>
      _$TimetableRequestDtoFromJson(json);
}

String? _semesterTypeToJson(SemesterType? type) {
  if (type == null) return null;
  switch (type) {
    case SemesterType.first:
      return 'FIRST';
    case SemesterType.second:
      return 'SECOND';
    case SemesterType.summer:
      return 'SUMMER';
    case SemesterType.winter:
      return 'WINTER';
  }
}

SemesterType? _semesterTypeFromJson(String? value) {
  if (value == null) return null;
  switch (value.toUpperCase()) {
    case 'FIRST':
      return SemesterType.first;
    case 'SECOND':
      return SemesterType.second;
    case 'SUMMER':
      return SemesterType.summer;
    case 'WINTER':
      return SemesterType.winter;
    default:
      return SemesterType.first;
  }
}
