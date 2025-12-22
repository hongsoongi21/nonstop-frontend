import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nonstop/core/router/app_router.dart';
import 'package:nonstop/core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Nonstop',
      theme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
