import 'package:flutter/material.dart';
import '../../../../core/l10n/app_localizations.dart';

/// Day of week enum for timetable entries
enum DayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
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

  /// Get localized display name
  String displayName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case DayOfWeek.monday:
        return l10n.dayMonday;
      case DayOfWeek.tuesday:
        return l10n.dayTuesday;
      case DayOfWeek.wednesday:
        return l10n.dayWednesday;
      case DayOfWeek.thursday:
        return l10n.dayThursday;
      case DayOfWeek.friday:
        return l10n.dayFriday;
      case DayOfWeek.saturday:
        return l10n.daySaturday;
      case DayOfWeek.sunday:
        return l10n.daySunday;
    }
  }

  /// Get localized short display name
  String displayNameShort(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case DayOfWeek.monday:
        return l10n.dayMondayShort;
      case DayOfWeek.tuesday:
        return l10n.dayTuesdayShort;
      case DayOfWeek.wednesday:
        return l10n.dayWednesdayShort;
      case DayOfWeek.thursday:
        return l10n.dayThursdayShort;
      case DayOfWeek.friday:
        return l10n.dayFridayShort;
      case DayOfWeek.saturday:
        return l10n.daySaturdayShort;
      case DayOfWeek.sunday:
        return l10n.daySundayShort;
    }
  }
}
