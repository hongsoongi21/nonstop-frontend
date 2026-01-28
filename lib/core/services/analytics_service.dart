import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return AnalyticsService();
});

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  // Screen tracking
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
    );
  }

  // User properties
  Future<void> setUserId(String? userId) async {
    await _analytics.setUserId(id: userId);
  }

  Future<void> setUserProperty({
    required String name,
    required String? value,
  }) async {
    await _analytics.setUserProperty(name: name, value: value);
  }

  // Auth events
  Future<void> logLogin({String? loginMethod}) async {
    await _analytics.logLogin(loginMethod: loginMethod);
  }

  Future<void> logSignUp({String? signUpMethod}) async {
    await _analytics.logSignUp(signUpMethod: signUpMethod ?? 'email');
  }

  Future<void> logLogout() async {
    await _analytics.logEvent(name: 'logout');
  }

  // Custom events
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  // Chat events
  Future<void> logChatRoomCreated({String? roomType}) async {
    await _analytics.logEvent(
      name: 'chat_room_created',
      parameters: {'room_type': roomType ?? 'unknown'},
    );
  }

  Future<void> logMessageSent({String? messageType}) async {
    await _analytics.logEvent(
      name: 'message_sent',
      parameters: {'message_type': messageType ?? 'text'},
    );
  }

  // Board events
  Future<void> logPostCreated({String? category}) async {
    await _analytics.logEvent(
      name: 'post_created',
      parameters: {'category': category ?? 'general'},
    );
  }

  Future<void> logPostLiked() async {
    await _analytics.logEvent(name: 'post_liked');
  }

  Future<void> logCommentCreated() async {
    await _analytics.logEvent(name: 'comment_created');
  }

  // Timetable events
  Future<void> logTimetableEntryAdded() async {
    await _analytics.logEvent(name: 'timetable_entry_added');
  }

  // Friend events
  Future<void> logFriendRequestSent() async {
    await _analytics.logEvent(name: 'friend_request_sent');
  }

  Future<void> logFriendRequestAccepted() async {
    await _analytics.logEvent(name: 'friend_request_accepted');
  }
}
