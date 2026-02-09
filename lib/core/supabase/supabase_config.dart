import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase configuration and initialization
class SupabaseConfig {
  static const String _supabaseUrlKey = 'SUPABASE_URL';
  static const String _supabaseAnonKeyKey = 'SUPABASE_ANON_KEY';

  static const String _defaultUrl = 'https://skmferffwiyphqvjjfrb.supabase.co';
  static const String _defaultAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNrbWZlcmZmd2l5cGhxdmpqZnJiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA2NDE1NzcsImV4cCI6MjA4NjIxNzU3N30.0FM3kXRE_w7ptZ_ubna66DMnMijJo66QyqtSHF8-BlY';

  static String get supabaseUrl {
    return const String.fromEnvironment(
      _supabaseUrlKey,
      defaultValue: _defaultUrl,
    );
  }

  static String get supabaseAnonKey {
    return const String.fromEnvironment(
      _supabaseAnonKeyKey,
      defaultValue: _defaultAnonKey,
    );
  }

  /// Initialize Supabase - call this in main() before runApp()
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      debug: kDebugMode,
    );
  }

  /// Get the Supabase client instance
  static SupabaseClient get client => Supabase.instance.client;
}
