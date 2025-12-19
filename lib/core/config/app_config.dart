/// Application configuration
/// Contains app-wide constants and settings
class AppConfig {
  // App information
  static const String appName = 'Nonstop';
  static const String appVersion = '1.0.0';
  static const int appVersionCode = 1;

  // API timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // WebSocket configuration
  static const Duration wsReconnectDelay = Duration(seconds: 5);
  static const Duration wsPingInterval = Duration(seconds: 30);
  static const int wsMaxReconnectAttempts = 5;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Cache configuration
  static const Duration defaultCacheDuration = Duration(hours: 1);
  static const int maxCacheSize = 100;

  // File upload
  static const int maxFileSizeBytes = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedImageTypes = [
    'image/jpeg',
    'image/png',
    'image/gif',
    'image/webp',
  ];

  // Local storage keys
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  static const String themeKey = 'app_theme';
  static const String localeKey = 'app_locale';

  // Feature flags (can be controlled remotely in production)
  static const bool enableWebSocket = true;
  static const bool enablePushNotifications = true;
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
}
