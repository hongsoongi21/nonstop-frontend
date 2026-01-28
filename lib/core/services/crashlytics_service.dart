import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final crashlyticsServiceProvider = Provider<CrashlyticsService>((ref) {
  return CrashlyticsService();
});

class CrashlyticsService {
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  // User identification
  Future<void> setUserId(String userId) async {
    await _crashlytics.setUserIdentifier(userId);
  }

  // Custom keys for debugging
  Future<void> setCustomKey(String key, Object value) async {
    await _crashlytics.setCustomKey(key, value);
  }

  // Log messages
  Future<void> log(String message) async {
    await _crashlytics.log(message);
  }

  // Record non-fatal errors
  Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    String? reason,
    bool fatal = false,
  }) async {
    if (kDebugMode) {
      // 디버그 모드에서는 콘솔에만 출력
      debugPrint('Crashlytics Error: $exception');
      if (stack != null) debugPrint('Stack: $stack');
      return;
    }
    await _crashlytics.recordError(
      exception,
      stack,
      reason: reason,
      fatal: fatal,
    );
  }

  // Force a crash (for testing only)
  void testCrash() {
    if (kDebugMode) {
      debugPrint('Test crash called - skipped in debug mode');
      return;
    }
    _crashlytics.crash();
  }

  // Enable/disable collection
  Future<void> setCrashlyticsCollectionEnabled(bool enabled) async {
    await _crashlytics.setCrashlyticsCollectionEnabled(enabled);
  }

  // Check if collection is enabled
  bool get isCrashlyticsCollectionEnabled =>
      _crashlytics.isCrashlyticsCollectionEnabled;
}
