import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;

/// Environment configuration
/// Loads environment variables via `--dart-define` (compile-time).
class EnvConfig {
  static const String _apiBaseUrlKey = 'API_BASE_URL';
  static const String _wsBaseUrlKey = 'WS_BASE_URL';
  static const String _environmentKey = 'ENVIRONMENT';
  static const String _googleServerClientIdKey = 'GOOGLE_SERVER_CLIENT_ID';

  /// When running a physical Android device over USB with `adb reverse`,
  /// use localhost from the device to reach the host machine.
  ///
  /// Run:
  /// - `adb reverse tcp:28080 tcp:28080`
  /// - `flutter run --dart-define=USE_ADB_REVERSE=true`
  static bool get _useAdbReverse =>
      const bool.fromEnvironment('USE_ADB_REVERSE', defaultValue: false);

  // Default values for development
  static const String _defaultApiBaseUrl = 'http://20.2.136.12:28080';
  static const String _defaultWsBaseUrl = 'ws://20.2.136.12:28080/ws/v1/chat';
  static const String _defaultEnvironment = 'development';

  static String get _localApiBaseUrl {
    if (kIsWeb) return 'http://20.2.136.12:28080';
    if (Platform.isAndroid) {
      // Emulator uses 10.0.2.2, physical device should use adb reverse + localhost.
      return _useAdbReverse
          ? 'http://20.2.136.12:28080'
          : 'http://20.2.136.12:28080';
    }
    return 'http://20.2.136.12:28080';
  }

  static String get _localWsBaseUrl {
    if (kIsWeb) return 'ws://20.2.136.12:28080/ws/v1/chat';
    if (Platform.isAndroid) {
      return _useAdbReverse
          ? 'ws://20.2.136.12:28080/ws/v1/chat'
          : 'ws://20.2.136.12:28080/ws/v1/chat';
    }
    return 'ws://20.2.136.12:28080/ws/v1/chat';
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

  /// Google Server Client ID for OAuth
  /// Firebase project: nonstop-c2aa4 (127473148279)
  static String get googleServerClientId {
    return const String.fromEnvironment(
      _googleServerClientIdKey,
      defaultValue:
          '127473148279-sa5hnb576mfoceltmfg0d5ih76tegi95.apps.googleusercontent.com',
    );
  }

  // Supabase
  static const String _supabaseUrlKey = 'SUPABASE_URL';
  static const String _supabaseAnonKeyKey = 'SUPABASE_ANON_KEY';

  static String get supabaseUrl {
    return const String.fromEnvironment(
      _supabaseUrlKey,
      defaultValue: 'https://skmferffwiyphqvjjfrb.supabase.co',
    );
  }

  static String get supabaseAnonKey {
    return const String.fromEnvironment(
      _supabaseAnonKeyKey,
      defaultValue:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNrbWZlcmZmd2l5cGhxdmpqZnJiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA2NDE1NzcsImV4cCI6MjA4NjIxNzU3N30.0FM3kXRE_w7ptZ_ubna66DMnMijJo66QyqtSHF8-BlY',
    );
  }
}
