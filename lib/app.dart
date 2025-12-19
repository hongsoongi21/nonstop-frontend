import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/l10n/app_localizations.dart';

import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

/// Root application widget
/// Configures the app with routing, theming, and state management
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Nonstop',

      // Localization
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      // Theming
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,

      // Routing
      routerConfig: router,

      // Debug configuration
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,

      // Error handling
      builder: (context, child) {
        // Add global error handling here if needed
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
