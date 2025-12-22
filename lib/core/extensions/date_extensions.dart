/// Date and time utility extensions
extension DateTimeExtensions on DateTime {
  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if date is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Check if date is in the past
  bool get isPast => isBefore(DateTime.now());

  /// Check if date is in the future
  bool get isFuture => isAfter(DateTime.now());

  /// Check if date is within the last N days
  bool isWithinLast(int days) {
    final now = DateTime.now();
    final difference = now.difference(this);
    return difference.inDays <= days && difference.inDays >= 0;
  }

  /// Check if date is within the next N days
  bool isWithinNext(int days) {
    final now = DateTime.now();
    final difference = this.difference(now);
    return difference.inDays <= days && difference.inDays >= 0;
  }

  /// Get the start of the day (00:00:00)
  DateTime get startOfDay => DateTime(year, month, day);

  /// Get the end of the day (23:59:59.999)
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Get the start of the week (Monday)
  DateTime get startOfWeek {
    final monday = subtract(Duration(days: weekday - 1));
    return DateTime(monday.year, monday.month, monday.day);
  }

  /// Get the end of the week (Sunday)
  DateTime get endOfWeek {
    final sunday = add(Duration(days: 7 - weekday));
    return DateTime(sunday.year, sunday.month, sunday.day, 23, 59, 59, 999);
  }

  /// Get the start of the month
  DateTime get startOfMonth => DateTime(year, month, 1);

  /// Get the end of the month
  DateTime get endOfMonth {
    final nextMonth = month == 12
        ? DateTime(year + 1, 1, 1)
        : DateTime(year, month + 1, 1);
    return nextMonth.subtract(const Duration(days: 1)).endOfDay;
  }

  /// Get the start of the year
  DateTime get startOfYear => DateTime(year, 1, 1);

  /// Get the end of the year
  DateTime get endOfYear => DateTime(year, 12, 31, 23, 59, 59, 999);

  /// Add business days (excluding weekends)
  DateTime addBusinessDays(int days) {
    DateTime result = this;
    int added = 0;

    while (added < days) {
      result = result.add(const Duration(days: 1));
      if (result.weekday != DateTime.saturday &&
          result.weekday != DateTime.sunday) {
        added++;
      }
    }

    return result;
  }

  /// Check if date is a weekend
  bool get isWeekend =>
      weekday == DateTime.saturday || weekday == DateTime.sunday;

  /// Check if date is a weekday
  bool get isWeekday => !isWeekend;

  /// Get age from date (assuming birth date)
  int get age {
    final now = DateTime.now();
    int age = now.year - year;

    if (now.month < month || (now.month == month && now.day < day)) {
      age--;
    }

    return age;
  }

  /// Format as relative time (e.g., "2 hours ago", "in 3 days")
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months == 1 ? '' : 's'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }

  /// Format as relative time in future (e.g., "in 2 hours", "in 3 days")
  String get timeUntil {
    final now = DateTime.now();
    final difference = this.difference(now);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return 'in $years year${years == 1 ? '' : 's'}';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return 'in $months month${months == 1 ? '' : 's'}';
    } else if (difference.inDays > 0) {
      return 'in ${difference.inDays} day${difference.inDays == 1 ? '' : 's'}';
    } else if (difference.inHours > 0) {
      return 'in ${difference.inHours} hour${difference.inHours == 1 ? '' : 's'}';
    } else if (difference.inMinutes > 0) {
      return 'in ${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'}';
    } else {
      return 'Now';
    }
  }

  /// Format as human readable date (e.g., "Today", "Yesterday", "Dec 25, 2023")
  String get humanReadableDate {
    if (isToday) return 'Today';
    if (isYesterday) return 'Yesterday';
    if (isTomorrow) return 'Tomorrow';

    final now = DateTime.now();
    if (year == now.year) {
      // Same year, show month and day
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${months[month - 1]} $day';
    } else {
      // Different year, show full date
      return '$month/$day/$year';
    }
  }

  /// Get week number of the year (ISO 8601)
  int get weekNumber {
    final firstDayOfYear = DateTime(year, 1, 1);
    final firstMonday = firstDayOfYear.add(
      Duration(days: (8 - firstDayOfYear.weekday) % 7),
    );
    final daysSinceFirstMonday = difference(firstMonday).inDays;

    return (daysSinceFirstMonday / 7).floor() + 1;
  }

  /// Get quarter of the year (1-4)
  int get quarter => ((month - 1) ~/ 3) + 1;

  /// Check if date is in a leap year
  bool get isLeapYear {
    return (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
  }

  /// Get number of days in the month
  int get daysInMonth {
    final nextMonth = month == 12
        ? DateTime(year + 1, 1, 1)
        : DateTime(year, month + 1, 1);
    return nextMonth.subtract(const Duration(days: 1)).day;
  }

  /// Copy with specific time
  DateTime copyWithTime({
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year,
      month,
      day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  /// Get the next occurrence of a specific weekday
  DateTime next(int weekday) {
    final daysUntilNext = (weekday - this.weekday + 7) % 7;
    return daysUntilNext == 0
        ? add(const Duration(days: 7))
        : add(Duration(days: daysUntilNext));
  }

  /// Get the previous occurrence of a specific weekday
  DateTime previous(int weekday) {
    final daysSincePrevious = (this.weekday - weekday + 7) % 7;
    return daysSincePrevious == 0
        ? subtract(const Duration(days: 7))
        : subtract(Duration(days: daysSincePrevious));
  }
}
