/// Utility class for validating various input types
class Validators {
  static const int _minPasswordLength = 8;
  static const int _maxPasswordLength = 128;

  /// Validates email format
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

    if (!emailRegex.hasMatch(email.trim())) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// Validates password strength
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < _minPasswordLength) {
      return 'Password must be at least $_minPasswordLength characters long';
    }

    if (password.length > _maxPasswordLength) {
      return 'Password must be less than $_maxPasswordLength characters long';
    }

    // Check for at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    return null;
  }

  /// Validates password confirmation matches original password
  static String? validatePasswordConfirmation(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Validates required text field is not empty
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validates text length is within specified range
  static String? validateLength(
    String? value,
    String fieldName, {
    int? minLength,
    int? maxLength,
  }) {
    if (value == null || value.isEmpty) {
      return null; // Let validateRequired handle empty values
    }

    if (minLength != null && value.length < minLength) {
      return '$fieldName must be at least $minLength characters long';
    }

    if (maxLength != null && value.length > maxLength) {
      return '$fieldName must be less than $maxLength characters long';
    }

    return null;
  }

  /// Validates phone number format (basic validation)
  static String? validatePhoneNumber(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Phone number is required';
    }

    // Remove all non-digit characters for validation
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanPhone.length < 10 || cleanPhone.length > 15) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  /// Validates URL format
  static String? validateUrl(String? url) {
    if (url == null || url.isEmpty) {
      return null; // Optional field
    }

    final urlRegex = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
    );

    if (!urlRegex.hasMatch(url)) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  /// Validates numeric input
  static String? validateNumeric(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return null; // Let validateRequired handle empty values
    }

    final number = double.tryParse(value);
    if (number == null) {
      return '$fieldName must be a valid number';
    }

    return null;
  }

  /// Validates integer input
  static String? validateInteger(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return null; // Let validateRequired handle empty values
    }

    final number = int.tryParse(value);
    if (number == null) {
      return '$fieldName must be a valid whole number';
    }

    return null;
  }

  /// Validates value is within a range
  static String? validateRange(
    num? value,
    String fieldName, {
    num? min,
    num? max,
  }) {
    if (value == null) return null;

    if (min != null && value < min) {
      return '$fieldName must be at least $min';
    }

    if (max != null && value > max) {
      return '$fieldName must be less than or equal to $max';
    }

    return null;
  }
}
