import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nonstop/app.dart';
import 'package:nonstop/core/utils/logger.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 로그 초기화
  initLogger();
  
  runApp(const ProviderScope(child: App()));
}
