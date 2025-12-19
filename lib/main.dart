import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/utils/logger.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logger
  initLogger();

  // TODO: Initialize Firebase here when needed
  // await Firebase.initializeApp();

  // TODO: Initialize other services here
  // - Secure storage
  // - Local database
  // - Push notifications

  runApp(const ProviderScope(child: App()));
}
