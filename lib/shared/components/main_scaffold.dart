import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/app_navigation.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import 'app_background.dart';

/// Main scaffold with bottom navigation for the app
class MainScaffold extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final isAdmin = user?.isAdmin ?? false;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          AppBackground(child: navigationShell),
          if (kDebugMode) const _DebugPortal(),
        ],
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        navigationShell: navigationShell,
      ),
      floatingActionButton: isAdmin
          ? AppFab(
              icon: Icons.admin_panel_settings,
              tooltip: 'Admin Menu',
              backgroundColor: AppColors.secondary,
              onPressed: () {
                // TODO: 관리자 기능 구현
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('관리자 기능은 준비 중입니다.')),
                );
              },
            )
          : null,
    );
  }
}

/// A floating debug button visible only in debug mode
class _DebugPortal extends StatelessWidget {
  const _DebugPortal();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      bottom: 100, // Above bottom nav
      child: FloatingActionButton.small(
        heroTag: 'debug_portal',
        onPressed: () => _showDebugMenu(context),
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        child: const Icon(Icons.bug_report, color: Colors.white),
      ),
    );
  }

  void _showDebugMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Developer Menu',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: const Text('Timetable Integration Test'),
              subtitle: const Text(
                'Test real backend connection for schedules',
              ),
              onTap: () {
                Navigator.pop(context);
                context.push(Routes.timetableTest);
              },
            ),
            // Add more test screens here in the future
          ],
        ),
      ),
    );
  }
}

/// App bar with consistent styling
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final Widget? leading;
  final double elevation;

  const AppAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.leading,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      elevation: elevation,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      actions: actions,
      leading:
          leading ??
          (showBackButton && Navigator.of(context).canPop()
              ? IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back),
                )
              : null),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Floating action button for primary actions
class AppFab extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const AppFab({
    super.key,
    this.onPressed,
    required this.icon,
    this.tooltip,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip,
      backgroundColor: backgroundColor ?? AppColors.primary,
      foregroundColor: foregroundColor ?? AppColors.textOnPrimary,
      elevation: 6,
      child: Icon(icon),
    );
  }
}

/// Screen scaffold with consistent padding and app bar
class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final bool showAppBar;
  final bool showBackButton;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool useGradient;
  final EdgeInsetsGeometry? padding;
  final bool extendBody;
  final bool extendBodyBehindAppBar;

  const AppScaffold({
    super.key,
    this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.showAppBar = true,
    this.showBackButton = true,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.useGradient = true,
    this.padding,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = SafeArea(
      top: !extendBodyBehindAppBar,
      bottom: !extendBody,
      child: Padding(
        padding: padding ?? EdgeInsets.all(AppSpacing.md),
        child: body,
      ),
    );

    if (useGradient && backgroundColor == null) {
      content = AppBackground(child: content);
    }

    return Scaffold(
      backgroundColor:
          backgroundColor ?? (useGradient ? Colors.transparent : null),
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: showAppBar && title != null
          ? AppAppBar(
              title: title!,
              actions: actions,
              showBackButton: showBackButton,
            )
          : null,
      body: content,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
