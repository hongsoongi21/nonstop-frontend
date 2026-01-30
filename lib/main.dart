import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nonstop/app.dart';
import 'package:nonstop/core/services/fcm_service.dart';
import 'package:nonstop/core/utils/logger.dart';
import 'package:nonstop/firebase_options.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Firebase 초기화
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // FCM background handler 등록
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Crashlytics 설정
    if (!kDebugMode) {
      // Flutter framework 에러 핸들링
      FlutterError.onError = (FlutterErrorDetails details) {
        // fatal 여부 판단: PlatformDispatcher에서 발생한 에러는 fatal
        final isFatal = details.library == 'Flutter framework' &&
            details.silent == false;

        if (isFatal) {
          FirebaseCrashlytics.instance.recordFlutterFatalError(details);
        } else {
          // Non-fatal로 보고 (UI 관련 에러 등)
          FirebaseCrashlytics.instance.recordFlutterError(details);
        }
      };

      // PlatformDispatcher 에러 (진짜 fatal)
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }

    // 로그 초기화
    initLogger();

    runApp(const ProviderScope(child: App()));
  }, (error, stack) {
    // 비동기 에러 캐치 - 대부분 non-fatal
    if (!kDebugMode) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: false);
    }
  });
}
