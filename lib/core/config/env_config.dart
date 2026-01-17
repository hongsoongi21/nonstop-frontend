import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;

/// Environment configuration
/// Loads environment variables via `--dart-define` (compile-time).
class EnvConfig {
  static const String _apiBaseUrlKey = 'API_BASE_URL';
  static const String _wsBaseUrlKey = 'WS_BASE_URL';
  static const String _environmentKey = 'ENVIRONMENT';

  // Default values for development
  static const String _defaultApiBaseUrl = 'http://10.0.2.2:28080';
  static const String _defaultWsBaseUrl = 'ws://10.0.2.2:28080/ws';
  static const String _defaultEnvironment = 'development';

  static String get _localApiBaseUrl {
    if (kIsWeb) return 'http://localhost:28080';
    if (Platform.isAndroid) return 'http://10.0.2.2:28080';
    return 'http://localhost:28080';
  }

  static String get _localWsBaseUrl {
    if (kIsWeb) return 'ws://localhost:28080/ws';
    if (Platform.isAndroid) return 'ws://10.0.2.2:28080/ws';
    return 'ws://localhost:28080/ws';
  }

  /// API base URL
  static String get apiBaseUrl {
    final value = const String.fromEnvironment(
      _apiBaseUrlKey,
      defaultValue: _defaultApiBaseUrl,
    );
    if (!kReleaseMode && value == _defaultApiBaseUrl) {
      return _localApiBaseUrl;
    }
    return value;
  }

  /// WebSocket base URL
  static String get wsBaseUrl {
    final value = const String.fromEnvironment(
      _wsBaseUrlKey,
      defaultValue: _defaultWsBaseUrl,
    );
    if (!kReleaseMode && value == _defaultWsBaseUrl) {
      return _localWsBaseUrl;
    }
    return value;
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