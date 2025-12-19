/// String utility extensions
import 'dart:convert';

extension StringExtensions on String {
  /// Capitalize first letter
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalize first letter of each word
  String get capitalizeWords {
    if (isEmpty) return this;
    return split(
      ' ',
    ).map((word) => word.isNotEmpty ? word.capitalize : word).join(' ');
  }

  /// Check if string is a valid email
  bool get isValidEmail {
    final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegex.hasMatch(this);
  }

  /// Check if string is a valid phone number (basic validation)
  bool get isValidPhone {
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{10,}$');
    return phoneRegex.hasMatch(this);
  }

  /// Check if string is a valid URL
  bool get isValidUrl {
    final urlRegex = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
    );
    return urlRegex.hasMatch(this);
  }

  /// Check if string contains only digits
  bool get isNumeric => RegExp(r'^\d+$').hasMatch(this);

  /// Check if string contains only letters
  bool get isAlphabetic => RegExp(r'^[a-zA-Z]+$').hasMatch(this);

  /// Check if string contains only letters and numbers
  bool get isAlphanumeric => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);

  /// Remove all whitespace
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  /// Remove extra whitespace (multiple spaces become single)
  String get normalizeWhitespace => replaceAll(RegExp(r'\s+'), ' ').trim();

  /// Extract numbers from string
  String get extractNumbers => replaceAll(RegExp(r'[^0-9]'), '');

  /// Extract letters from string
  String get extractLetters => replaceAll(RegExp(r'[^a-zA-Z]'), '');

  /// Check if string is null or empty
  bool get isNullOrEmpty => this == null || isEmpty;

  /// Check if string is null or contains only whitespace
  bool get isNullOrBlank => this == null || trim().isEmpty;

  /// Safe substring with bounds checking
  String safeSubstring(int start, [int? end]) {
    if (start < 0) start = 0;
    if (start >= length) return '';
    if (end != null && end > length) end = length;
    if (end != null && end <= start) return '';
    return end != null ? substring(start, end) : substring(start);
  }

  /// Truncate string with ellipsis
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${safeSubstring(0, maxLength - suffix.length)}$suffix';
  }

  /// Convert to slug (URL-friendly format)
  String get toSlug {
    return toLowerCase()
        .replaceAll(RegExp(r'[^\w\s-]'), '') // Remove special chars
        .replaceAll(RegExp(r'\s+'), '-') // Replace spaces with hyphens
        .replaceAll(RegExp(r'-+'), '-') // Replace multiple hyphens
        .trim();
  }

  /// Convert snake_case to camelCase
  String get snakeToCamel {
    final parts = split('_');
    if (parts.isEmpty) return this;

    final camelCase =
        parts.first.toLowerCase() +
        parts.skip(1).map((part) => part.capitalize).join('');

    return camelCase;
  }

  /// Convert camelCase to snake_case
  String get camelToSnake {
    final snakeCase = replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (match) => '${match.group(1)}_${match.group(2)}',
    );
    return snakeCase.toLowerCase();
  }

  /// Parse as int safely
  int? get toIntSafe {
    return int.tryParse(this);
  }

  /// Parse as double safely
  double? get toDoubleSafe {
    return double.tryParse(this);
  }

  /// Parse as bool safely
  bool? get toBoolSafe {
    switch (toLowerCase()) {
      case 'true':
      case '1':
      case 'yes':
      case 'on':
        return true;
      case 'false':
      case '0':
      case 'no':
      case 'off':
        return false;
      default:
        return null;
    }
  }

  /// Get file extension
  String get fileExtension {
    final lastDot = lastIndexOf('.');
    return lastDot != -1 ? substring(lastDot + 1) : '';
  }

  /// Get file name without extension
  String get fileNameWithoutExtension {
    final lastDot = lastIndexOf('.');
    return lastDot != -1 ? substring(0, lastDot) : this;
  }

  /// Check if string is a valid JSON
  bool get isValidJson {
    try {
      jsonDecode(this);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Reverse string
  String get reverse {
    return split('').reversed.join();
  }

  /// Count words in string
  int get wordCount {
    if (isEmpty) return 0;
    return trim().split(RegExp(r'\s+')).length;
  }

  /// Get initials from name
  String get initials {
    final words = trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return '';

    final firstLetters = words
        .where((word) => word.isNotEmpty)
        .take(2) // Take first 2 words max
        .map((word) => word[0].toUpperCase())
        .join();

    return firstLetters;
  }

  /// Format as credit card number (XXXX XXXX XXXX XXXX)
  String get formatAsCardNumber {
    final cleaned = replaceAll(RegExp(r'[^0-9]'), '');
    final buffer = StringBuffer();

    for (var i = 0; i < cleaned.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(cleaned[i]);
    }

    return buffer.toString();
  }

  /// Format as phone number (basic US format)
  String get formatAsPhoneNumber {
    final cleaned = replaceAll(RegExp(r'[^0-9]'), '');

    if (cleaned.length == 10) {
      return '(${cleaned.substring(0, 3)}) ${cleaned.substring(3, 6)}-${cleaned.substring(6)}';
    } else if (cleaned.length == 11 && cleaned.startsWith('1')) {
      return '+1 (${cleaned.substring(1, 4)}) ${cleaned.substring(4, 7)}-${cleaned.substring(7)}';
    }

    return this; // Return original if format doesn't match
  }
}
