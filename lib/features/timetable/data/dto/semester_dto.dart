import 'package:freezed_annotation/freezed_annotation.dart';

part 'semester_dto.freezed.dart';
part 'semester_dto.g.dart';

/// Semester types matching backend enum
enum SemesterType {
  @JsonValue('FIRST')
  first,
  @JsonValue('SECOND')
  second,
  @JsonValue('SUMMER')
  summer,
  @JsonValue('WINTER')
  winter,
}

/// Semester DTO from backend
/// Represents a semester period (e.g., "Fall 2024")
@freezed
class SemesterDto with _$SemesterDto {
  const factory SemesterDto({
    required int id,
    required int year,
    required SemesterType type,
    @Default(false) bool isCurrent,
  }) = _SemesterDto;

  factory SemesterDto.fromJson(Map<String, dynamic> json) =>
      _$SemesterDtoFromJson(json);
}
