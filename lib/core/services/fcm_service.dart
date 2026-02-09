import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants/routes.dart';
import '../router/app_router.dart';
import '../supabase/supabase_provider.dart';

/// Background message handler - must be top-level function
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Background message received: ${message.messageId}');
}

/// FCM Service for handling push notifications
class FcmService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  final SupabaseClient _supabase;
  final ProviderContainer _container;

  String? _fcmToken;
  String get fcmToken => _fcmToken ?? '';

  FcmService(this._supabase, this._container);

  /// Initialize FCM service
  Future<void> initialize() async {
    // Request permission
    await _requestPermission();

    // Initialize local notifications
    await _initializeLocalNotifications();

    // Get FCM token
    await _getToken();

    // Listen for token refresh
    _messaging.onTokenRefresh.listen(_onTokenRefresh);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle background message tap
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // Check for initial message (app opened from terminated state)
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageOpenedApp(initialMessage);
    }
  }

  /// Request notification permission
  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint('FCM Permission status: ${settings.authorizationStatus}');
  }

  /// Initialize local notifications for foreground display
  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create Android notification channel
    if (Platform.isAndroid) {
      const channel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
      );

      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
  }

  /// Get FCM token
  Future<void> _getToken() async {
    try {
      _fcmToken = await _messaging.getToken();
      debugPrint('FCM Token: $_fcmToken');

      if (_fcmToken != null) {
        await _registerTokenWithBackend(_fcmToken!);
      }
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
    }
  }

  /// Handle token refresh
  void _onTokenRefresh(String token) {
    debugPrint('FCM Token refreshed: $token');
    _fcmToken = token;
    _registerTokenWithBackend(token);
  }

  /// Register token with backend via Supabase
  Future<void> _registerTokenWithBackend(String token) async {
    try {
      final authUser = _supabase.auth.currentUser;
      if (authUser == null) return;

      // Get user ID from users table
      final userData = await _supabase
          .from('users')
          .select('id')
          .eq('auth_id', authUser.id)
          .single();
      final userId = userData['id'] as int;

      final deviceType = Platform.isIOS ? 'IOS' : 'ANDROID';

      // Upsert device token
      await _supabase.from('device_tokens').upsert(
        {
          'user_id': userId,
          'device_type': deviceType,
          'token': token,
          'is_active': true,
        },
        onConflict: 'token',
      );
      debugPrint('FCM token registered with backend');
    } catch (e) {
      debugPrint('Error registering FCM token: $e');
    }
  }

  /// Handle foreground message
  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('Foreground message: ${message.notification?.title}');

    final notification = message.notification;
    if (notification != null) {
      _showLocalNotification(
        id: message.hashCode,
        title: notification.title ?? '',
        body: notification.body ?? '',
        payload: jsonEncode(message.data),
      );
    }
  }

  /// Show local notification
  Future<void> _showLocalNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(id, title, body, details, payload: payload);
  }

  /// Handle notification tap when app is in background
  void _handleMessageOpenedApp(RemoteMessage message) {
    debugPrint('Message opened app: ${message.data}');
    _navigateToNotification(message.data);
  }

  /// Handle local notification tap
  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('Notification tapped: ${response.payload}');
    if (response.payload == null) return;

    try {
      // Parse payload string to Map
      final data = jsonDecode(response.payload!) as Map<String, dynamic>;
      _navigateToNotification(data);
    } catch (e) {
      debugPrint('Error parsing notification payload: $e');
    }
  }

  /// Navigate based on notification data
  void _navigateToNotification(Map<String, dynamic> data) {
    try {
      final router = _container.read(routerProvider);
      final type = data['type'] as String?;
      final id = data['id'] as String?;

      if (type == null) {
        debugPrint('Notification type is null, cannot navigate');
        return;
      }

      debugPrint('Navigating: type=$type, id=$id');

      switch (type) {
        case 'chat':
          if (id != null) {
            router.push(Routes.chatRoomPath(id));
          } else {
            router.push(Routes.chat);
          }
          break;

        case 'board':
        case 'post':
          if (id != null) {
            router.push(Routes.boardDetailPath(id));
          } else {
            router.push(Routes.board);
          }
          break;

        case 'friend':
          router.push(Routes.friends);
          break;

        case 'comment':
          if (id != null) {
            router.push(Routes.boardDetailPath(id));
          } else {
            router.push(Routes.board);
          }
          break;

        default:
          router.push(Routes.notifications);
          debugPrint(
              'Unknown notification type: $type, navigating to notifications screen');
      }
    } catch (e) {
      debugPrint('Error navigating from notification: $e');
    }
  }

  /// Unregister token (call on logout)
  Future<void> unregisterToken() async {
    try {
      await _messaging.deleteToken();
      _fcmToken = null;
      debugPrint('FCM token deleted');
    } catch (e) {
      debugPrint('Error deleting FCM token: $e');
    }
  }
}

/// FCM Service Provider
final fcmServiceProvider = Provider<FcmService>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return FcmService(supabaseClient, ref.container);
});
