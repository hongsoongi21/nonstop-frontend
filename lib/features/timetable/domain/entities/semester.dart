import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/dto/semester_dto.dart';

part 'semester.freezed.dart';

/// Domain model for a semester
/// Represents a semester period (e.g., "Spring 2024")
@freezed
class Semester with _$Semester {
  const factory Semester({
    required int id,
    required int year,
    required SemesterType type,
    @Default(false) bool isCurrent,
  }) = _Semester;

  const Semester._();

  /// Create from DTO
  factory Semester.fromDto(SemesterDto dto) {
    return Semester(
      id: dto.id,
      year: dto.year,
      type: dto.type,
      isCurrent: dto.isCurrent,
    );
  }

  /// Get display name (e.g., "2024 Spring")
  String get displayName {
    final semesterName = type.displayName;
    return '$year $semesterName';
  }
}

/// Extension for SemesterType display names
extension SemesterTypeExtension on SemesterType {
  String get displayName {
    switch (this) {
      case SemesterType.first:
        return 'Bahor'; // Spring
      case SemesterType.second:
        return 'Kuz'; // Fall
      case SemesterType.summer:
        return 'Yoz'; // Summer
      case SemesterType.winter:
        return 'Qish'; // Winter
    }
  }
}
