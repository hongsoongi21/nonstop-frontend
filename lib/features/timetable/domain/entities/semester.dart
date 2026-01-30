import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/l10n/app_localizations.dart';
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
  /// Get localized display name
  String displayName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case SemesterType.first:
        return l10n.semesterSpring; // Spring
      case SemesterType.second:
        return l10n.semesterFall; // Fall
      case SemesterType.summer:
        return l10n.semesterSummer; // Summer
      case SemesterType.winter:
        return l10n.semesterWinter; // Winter
    }
  }
}
