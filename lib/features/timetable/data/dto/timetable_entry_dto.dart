import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/day_of_week.dart';

part 'timetable_entry_dto.freezed.dart';
part 'timetable_entry_dto.g.dart';

/// Day of week enum JSON mapping for backend
extension DayOfWeekJson on DayOfWeek {
  String toJson() {
    switch (this) {
      case DayOfWeek.monday:
        return 'MONDAY';
      case DayOfWeek.tuesday:
        return 'TUESDAY';
      case DayOfWeek.wednesday:
        return 'WEDNESDAY';
      case DayOfWeek.thursday:
        return 'THURSDAY';
      case DayOfWeek.friday:
        return 'FRIDAY';
      case DayOfWeek.saturday:
        return 'SATURDAY';
      case DayOfWeek.sunday:
        return 'SUNDAY';
    }
  }

  static DayOfWeek fromJson(String value) {
    switch (value.toUpperCase()) {
      case 'MONDAY':
        return DayOfWeek.monday;
      case 'TUESDAY':
        return DayOfWeek.tuesday;
      case 'WEDNESDAY':
        return DayOfWeek.wednesday;
      case 'THURSDAY':
        return DayOfWeek.thursday;
      case 'FRIDAY':
        return DayOfWeek.friday;
      case 'SATURDAY':
        return DayOfWeek.saturday;
      case 'SUNDAY':
        return DayOfWeek.sunday;
      default:
        return DayOfWeek.monday;
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
    @JsonKey(fromJson: _dayOfWeekFromJson, toJson: _dayOfWeekToJson)
    required DayOfWeek dayOfWeek,
    required String startTime, // Format: "HH:mm" (e.g., "09:00")
    required String endTime, // Format: "HH:mm" (e.g., "10:30")
    String? place,
    String? color,
  }) = _TimetableEntryDto;

  factory TimetableEntryDto.fromJson(Map<String, dynamic> json) =>
      _$TimetableEntryDtoFromJson(json);
}

DayOfWeek _dayOfWeekFromJson(String value) => DayOfWeekJson.fromJson(value);
String _dayOfWeekToJson(DayOfWeek value) => value.toJson();

/// Request DTO for creating/updating a timetable entry
@freezed
class TimetableEntryRequestDto with _$TimetableEntryRequestDto {
  const factory TimetableEntryRequestDto({
    required String subjectName,
    String? professor,
    @JsonKey(fromJson: _dayOfWeekFromJson, toJson: _dayOfWeekToJson)
    required DayOfWeek dayOfWeek,
    required String startTime, // Format: "HH:mm"
    required String endTime, // Format: "HH:mm"
    String? place,
    String? color,
  }) = _TimetableEntryRequestDto;

  factory TimetableEntryRequestDto.fromJson(Map<String, dynamic> json) =>
      _$TimetableEntryRequestDtoFromJson(json);
}
