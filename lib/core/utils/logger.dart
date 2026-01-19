import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

/// 터미널 출력을 위한 ANSI 색상 코드
class AnsiColor {
  static const String reset = '\x1B[0m';
  static const String black = '\x1B[30m';
  static const String red = '\x1B[31m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String blue = '\x1B[34m';
  static const String magenta = '\x1B[35m';
  static const String cyan = '\x1B[36m';
  static const String white = '\x1B[37m';
}

/// 앱 전반에서 사용할 로거
/// 터미널에서 색상으로 구분된 로그를 출력합니다.
class AppLogger {
  static const int _maxLogLength = 2000; // 로그 최대 길이 제한

  /// 일반 정보 (Info) - Cyan
  static void i(String message) {
    _log('ℹ️', message, AnsiColor.cyan);
  }

  /// 성공 (Success) - Green
  static void s(String message) {
    _log('✅', message, AnsiColor.green);
  }

  /// 경고 (Warning) - Yellow
  static void w(String message) {
    _log('⚠️', message, AnsiColor.yellow);
  }

  /// 에러 (Error) - Red
  static void e(String message, [Object? error, StackTrace? stackTrace]) {
    _log('🚨', message, AnsiColor.red);
    if (error != null) {
      debugPrint('${AnsiColor.red}Error: $error${AnsiColor.reset}');
    }
    if (stackTrace != null) {
      debugPrint('${AnsiColor.red}StackTrace: $stackTrace${AnsiColor.reset}');
    }
  }

  /// 네트워크 (Network) - Blue
  static void n(String message) {
    _log('🌐', message, AnsiColor.blue);
  }

  /// 디버그 (Debug) - White
  static void d(String message) {
    if (!kReleaseMode) {
      _log('🐛', message, AnsiColor.white);
    }
  }

  static void _log(String icon, String message, String colorCode) {
    if (kReleaseMode) return;

    final now = DateTime.now();
    final timeStr = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    
    // 메시지 길이 제한 (너무 길면 자름)
    String finalMessage = message;
    if (message.length > _maxLogLength) {
      finalMessage = "${message.substring(0, _maxLogLength)}... (truncated)";
    }

    // 터미널 출력 포맷: [시간] [NONSTOP] 아이콘 메시지
    // 색상 코드는 메시지 부분에만 적용하거나 전체에 적용할 수 있음
    debugPrint('$colorCode[$timeStr] [NONSTOP] $icon $finalMessage${AnsiColor.reset}');
  }
}

// 기존 코드와의 호환성을 위한 레거시 함수들 (필요 시 유지 또는 제거)
final loggers = Logger('loggers');

void initLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (record.level == Level.SEVERE) {
      AppLogger.e(record.message, record.error, record.stackTrace);
    } else if (record.level == Level.WARNING) {
      AppLogger.w(record.message);
    } else if (record.level == Level.INFO) {
      AppLogger.i(record.message);
    } else {
      AppLogger.d(record.message);
    }
  });
}
