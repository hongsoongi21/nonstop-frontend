/// User-friendly error messages
/// Centralized location for all error messages shown to users
class ErrorMessages {
  // Network errors
  static const String networkError =
      'Connection failed. Please check your internet and try again.';
  static const String timeoutError = 'Request timed out. Please try again.';
  static const String serverError =
      'Server error occurred. Please try again later.';
  static const String noInternet =
      'No internet connection. Please check your network.';

  // Authentication errors
  static const String invalidCredentials = 'Invalid email or password.';
  static const String sessionExpired =
      'Your session has expired. Please log in again.';
  static const String accountDisabled = 'Your account has been disabled.';
  static const String emailNotVerified =
      'Please verify your email before continuing.';
  static const String weakPassword =
      'Password is too weak. Please choose a stronger password.';
  static const String emailAlreadyInUse =
      'An account with this email already exists.';
  static const String userNotFound =
      'No account found with this email address.';
  static const String tooManyRequests =
      'Too many attempts. Please try again later.';

  // Authorization errors
  static const String accessDenied =
      'You do not have permission to perform this action.';
  static const String insufficientPermissions = 'Insufficient permissions.';

  // Validation errors
  static const String requiredField = 'This field is required.';
  static const String invalidEmail = 'Please enter a valid email address.';
  static const String invalidPhone = 'Please enter a valid phone number.';
  static const String passwordMismatch = 'Passwords do not match.';
  static const String minLength = 'Must be at least {count} characters.';
  static const String maxLength = 'Must be no more than {count} characters.';
  static const String invalidFormat = 'Invalid format.';

  // File upload errors
  static const String fileTooLarge = 'File size exceeds the maximum limit.';
  static const String invalidFileType = 'File type not supported.';
  static const String uploadFailed = 'Upload failed. Please try again.';

  // WebSocket errors
  static const String connectionLost = 'Connection lost. Reconnecting...';
  static const String reconnectionFailed =
      'Failed to reconnect. Please check your connection.';

  // Cache/Storage errors
  static const String cacheError = 'Failed to load cached data.';
  static const String storageError = 'Failed to save data locally.';

  // Generic errors
  static const String unknownError =
      'An unexpected error occurred. Please try again.';
  static const String tryAgain = 'Please try again.';
  static const String contactSupport =
      'If the problem persists, please contact support.';

  /// Get localized error message
  /// In a real app, this would use AppLocalizations
  static String getLocalizedMessage(String key) {
    // For now, return the key itself
    // In production, this would map to localized strings
    return key;
  }
}
