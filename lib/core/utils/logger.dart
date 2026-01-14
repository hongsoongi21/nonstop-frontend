import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'dart:developer';


final loggers = Logger('loggers');

void initLogger() {
  final Map<Level, String> levelStringMap = {
    Level.INFO: 'LOG',
    Level.FINE: 'RESULT',
    Level.WARNING: 'WARNING',
    Level.SEVERE: 'ERROR',
    Level.CONFIG: 'DIO',
  };
  final Map<Level, String> levelColorTagMap = {
    Level.INFO: '\x1B[32m', //녹색
    Level.FINE: '\x1B[4m', //녹색
    Level.WARNING: '\x1B[33m', // 노란색
    Level.SEVERE: '\x1B[31m', // 빨간색
    Level.CONFIG: '\x1b[36m', // 파란색
  };
  const String resetTag = '\x1B[0m'; // 재설정

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    final message = '${levelColorTagMap[record.level]!}'
        '[${levelStringMap[record.level]}] ${record.time}: ${record.message}${record.error == null ? '' : '\n: ${record.error}'}$resetTag';
    
    // debugPrint를 사용하여 터미널 로그를 더 안정적으로 출력합니다.
    debugPrint('[NONSTOP] $message');
    
    if (record.stackTrace != null && record.level >= Level.SEVERE) {
      debugPrint('[NONSTOP] --- Start of Stack Trace ---\n${record.stackTrace}\n--- End of Stack Trace ---');
    }
  });
}

void dioLog([
  String? message,
  Object? data,
]) {
  var str = message.toString();

  loggers.config(str, data);
}

void dioErrLog([
  String? message,
  Object? e,
  StackTrace? stackTrace,
]) {
  var str = message.toString();

  loggers.severe(str, e, stackTrace);
}

void infoLog(
  dynamic message, [
  res,
  String? prefix,
  dynamic stackTrace,
]) {
  var str = message.toString();

  loggers.info(
      '${prefix != null ? [prefix.toUpperCase()] : ''}$str', res, stackTrace);
}

void resultLog(
  dynamic message, [
  res,
  dynamic stackTrace,
]) {
  var str = message.toString();

  loggers.fine(str, res, stackTrace);
}

void warnLog(
  String? message, [
  Object? e,
  StackTrace? stackTrace,
]) {
  var str = message.toString();

  loggers.warning(str, e, stackTrace);
}

void errLog([
  String? message,
  Object? e,
  StackTrace? stackTrace,
]) {
  var str = '[FAIL]: $message';

  loggers.severe(str, e, stackTrace ?? StackTrace.current);
}
