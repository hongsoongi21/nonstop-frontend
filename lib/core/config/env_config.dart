/// Environment configuration
/// Loads environment variables from .env file or system environment
class EnvConfig {
  static const String _apiBaseUrlKey = 'API_BASE_URL';
  static const String _wsBaseUrlKey = 'WS_BASE_URL';
  static const String _environmentKey = 'ENVIRONMENT';

  // Default values for development
  static const String _defaultApiBaseUrl = 'https://api-staging.nonstop.app';
  static const String _defaultWsBaseUrl = 'wss://api-staging.nonstop.app/ws';
  static const String _defaultEnvironment = 'staging';

  /// API base URL
  static String get apiBaseUrl {
    return const String.fromEnvironment(
      _apiBaseUrlKey,
      defaultValue: _defaultApiBaseUrl,
    );
  }

  /// WebSocket base URL
  static String get wsBaseUrl {
    return const String.fromEnvironment(
      _wsBaseUrlKey,
      defaultValue: _defaultWsBaseUrl,
    );
  }

  /// Current environment (staging, production, development)
  static String get environment {
    return const String.fromEnvironment(
      _environmentKey,
      defaultValue: _defaultEnvironment,
    );
  }

  /// Check if running in production
  static bool get isProduction => environment == 'production';

  /// Check if running in staging
  static bool get isStaging => environment == 'staging';

  /// Check if running in development
  static bool get isDevelopment => environment == 'development';
}
