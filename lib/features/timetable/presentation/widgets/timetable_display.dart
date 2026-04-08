import '../../../../core/l10n/app_localizations.dart';
import '../../domain/entities/timetable.dart';

/// Display helpers that derive a localized label for a timetable when the
/// user hasn't set a custom title. Lives in the presentation layer so the
/// domain layer stays Flutter-free.
extension TimetableDisplay on Timetable {
  String displayLabel(AppLocalizations l10n, {int? backupNumber}) {
    if (title != null && title!.isNotEmpty) return title!;
    switch (kind) {
      case TimetableKind.main:
        return l10n.mainTimetable;
      case TimetableKind.backup:
        return backupNumber != null
            ? l10n.backupTimetableWithNumber(backupNumber)
            : l10n.backupTimetable;
    }
  }
}

extension TimetableDetailDisplay on TimetableDetail {
  String displayLabel(AppLocalizations l10n, {int? backupNumber}) {
    if (title != null && title!.isNotEmpty) return title!;
    switch (kind) {
      case TimetableKind.main:
        return l10n.mainTimetable;
      case TimetableKind.backup:
        return backupNumber != null
            ? l10n.backupTimetableWithNumber(backupNumber)
            : l10n.backupTimetable;
    }
  }
}
