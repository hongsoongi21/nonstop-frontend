import 'package:intl/intl.dart';

/// Utility class for formatting various data types
class Formatters {
  static final DateFormat _dateFormat = DateFormat('MMM dd, yyyy');
  static final DateFormat _timeFormat = DateFormat('HH:mm');
  static final DateFormat _dateTimeFormat = DateFormat('MMM dd, yyyy HH:mm');
  static final NumberFormat _currencyFormat = NumberFormat.currency(
    symbol: '\$',
  );
  static final NumberFormat _numberFormat = NumberFormat.decimalPattern();

  /// Formats a DateTime to a readable date string
  static String formatDate(DateTime date) {
    return _dateFormat.format(date);
  }

  /// Formats a DateTime to a readable time string
  static String formatTime(DateTime time) {
    return _timeFormat.format(time);
  }

  /// Formats a DateTime to a readable date and time string
  static String formatDateTime(DateTime dateTime) {
    return _dateTimeFormat.format(dateTime);
  }

  /// Formats a number as currency
  static String formatCurrency(double amount) {
    return _currencyFormat.format(amount);
  }

  /// Formats a number with commas for thousands
  static String formatNumber(int number) {
    return _numberFormat.format(number);
  }

  /// Formats a number with commas for thousands (double)
  static String formatDecimal(double number) {
    return _numberFormat.format(number);
  }

  /// Capitalizes the first letter of each word
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  /// Truncates text to a specified length with ellipsis
  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// Formats file size in human readable format
  static String formatFileSize(int bytes) {
    const units = ['B', 'KB', 'MB', 'GB', 'TB'];
    var size = bytes.toDouble();
    var unitIndex = 0;

    while (size >= 1024 && unitIndex < units.length - 1) {
      size /= 1024;
      unitIndex++;
    }

    return '${size.toStringAsFixed(size < 10 ? 1 : 0)} ${units[unitIndex]}';
  }

  /// Formats duration in human readable format
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }
}
