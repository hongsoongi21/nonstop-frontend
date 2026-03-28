import 'package:flutter/foundation.dart' show kReleaseMode;

/// Environment configuration
/// Loads environment variables via `--dart-define` (compile-time).
class EnvConfig {
  static const String _environmentKey = 'ENVIRONMENT';
  static const String _googleServerClientIdKey = 'GOOGLE_SERVER_CLIENT_ID';
  static const String _defaultEnvironment = 'development';

  /// Current environment (staging, production, development)
  static String get environment {
    return const String.fromEnvironment(
      _environmentKey,
      defaultValue: _defaultEnvironment,
    );
  }

  /// Check if running in production
  static bool get isProduction => environment == 'production' || kReleaseMode;

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
