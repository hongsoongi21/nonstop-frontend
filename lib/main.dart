import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nonstop/app.dart';
import 'package:nonstop/core/utils/logger.dart';
import 'package:nonstop/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 로그 초기화
  initLogger();

  runApp(const ProviderScope(child: App()));
}
