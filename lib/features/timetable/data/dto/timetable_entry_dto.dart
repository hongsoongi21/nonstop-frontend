import 'package:freezed_annotation/freezed_annotation.dart';

part 'timetable_entry_dto.freezed.dart';
part 'timetable_entry_dto.g.dart';

/// Day of week enum matching backend
enum DayOfWeek {
  @JsonValue('MONDAY')
  monday,
  @JsonValue('TUESDAY')
  tuesday,
  @JsonValue('WEDNESDAY')
  wednesday,
  @JsonValue('THURSDAY')
  thursday,
  @JsonValue('FRIDAY')
  friday,
  @JsonValue('SATURDAY')
  saturday,
  @JsonValue('SUNDAY')
  sunday,
}

/// Extension for DayOfWeek to get weekday number (1=Monday, 7=Sunday)
extension DayOfWeekExtension on DayOfWeek {
  int get weekdayNumber {
    switch (this) {
      case DayOfWeek.monday:
        return 1;
      case DayOfWeek.tuesday:
        return 2;
      case DayOfWeek.wednesday:
        return 3;
      case DayOfWeek.thursday:
        return 4;
      case DayOfWeek.friday:
        return 5;
      case DayOfWeek.saturday:
        return 6;
      case DayOfWeek.sunday:
        return 7;
    }
  }

  String get displayName {
    switch (this) {
      case DayOfWeek.monday:
        return 'Dushanba';
      case DayOfWeek.tuesday:
        return 'Seshanba';
      case DayOfWeek.wednesday:
        return 'Chorshanba';
      case DayOfWeek.thursday:
        return 'Payshanba';
      case DayOfWeek.friday:
        return 'Juma';
      case DayOfWeek.saturday:
        return 'Shanba';
      case DayOfWeek.sunday:
        return 'Yakshanba';
    }
  }
}

/// Timetable Entry DTO from backend
/// Represents a single class/course in the timetable
@freezed
class TimetableEntryDto with _$TimetableEntryDto {
  const factory TimetableEntryDto({
    required int id,
    required int timetableId,
    required String subjectName,
    String? professor,
    required DayOfWeek dayOfWeek,
    required String startTime, // Format: "HH:mm" (e.g., "09:00")
    required String endTime, // Format: "HH:mm" (e.g., "10:30")
    String? place,
    String? color,
  }) = _TimetableEntryDto;

  factory TimetableEntryDto.fromJson(Map<String, dynamic> json) =>
      _$TimetableEntryDtoFromJson(json);
}

/// Request DTO for creating/updating a timetable entry
@freezed
class TimetableEntryRequestDto with _$TimetableEntryRequestDto {
  const factory TimetableEntryRequestDto({
    required String subjectName,
    String? professor,
    required DayOfWeek dayOfWeek,
    required String startTime, // Format: "HH:mm"
    required String endTime, // Format: "HH:mm"
    String? place,
    String? color,
  }) = _TimetableEntryRequestDto;

  factory TimetableEntryRequestDto.fromJson(Map<String, dynamic> json) =>
      _$TimetableEntryRequestDtoFromJson(json);
}
