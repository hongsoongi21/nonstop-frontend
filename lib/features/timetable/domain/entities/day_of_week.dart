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
