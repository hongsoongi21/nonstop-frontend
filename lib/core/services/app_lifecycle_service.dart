import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/logger.dart';

/// 앱 생명주기 이벤트를 관리하는 서비스
class AppLifecycleService extends WidgetsBindingObserver {
  final List<VoidCallback> _resumeCallbacks = [];

  AppLifecycleService();

  /// 앱이 포그라운드로 돌아올 때 실행할 콜백 등록
  void addResumeCallback(VoidCallback callback) {
    _resumeCallbacks.add(callback);
  }

  /// 앱이 포그라운드로 돌아올 때 실행할 콜백 제거
  void removeResumeCallback(VoidCallback callback) {
    _resumeCallbacks.remove(callback);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      AppLogger.d('[LIFECYCLE] App resumed, executing callbacks...');
      for (final callback in _resumeCallbacks) {
        callback();
      }
    }
  }

  /// 서비스 초기화 (WidgetsBinding에 observer 등록)
  void initialize() {
    WidgetsBinding.instance.addObserver(this);
    AppLogger.d('[LIFECYCLE] Service initialized');
  }

  /// 서비스 정리
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _resumeCallbacks.clear();
    AppLogger.d('[LIFECYCLE] Service disposed');
  }
}

/// AppLifecycleService Provider
final appLifecycleServiceProvider = Provider<AppLifecycleService>((ref) {
  final service = AppLifecycleService();
  service.initialize();

  ref.onDispose(() {
    service.dispose();
  });

  return service;
});
