import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // Dismiss keyboard when tapping outside of input fields (iOS fix)
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        extendBody: true,
        body: AppBackground(child: navigationShell),
        bottomNavigationBar: AppBottomNavigationBar(
          navigationShell: navigationShell,
        ),
        floatingActionButton: isAdmin
            ? AppFab(
                icon: Icons.admin_panel_settings,
                tooltip: 'Admin Menu',
                backgroundColor: AppColors.secondary,
                onPressed: () {
                  HapticFeedback.lightImpact();
                  // TODO: 관리자 기능 구현
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('관리자 기능은 준비 중입니다.')),
                  );
                },
              )
            : null,
        floatingActionButtonLocation: isAdmin
            ? FloatingActionButtonLocation.startFloat
            : null,
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
    // Use GoRouter's canPop() for consistency with context.pop()
    final canPop = showBackButton && GoRouter.of(context).canPop();

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
          (canPop
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
      onPressed: onPressed != null
          ? () {
              HapticFeedback.lightImpact();
              onPressed!();
            }
          : null,
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
  final bool dismissKeyboardOnTap;

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
    this.dismissKeyboardOnTap = true,
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

    // Wrap with keyboard dismiss functionality for iOS
    if (dismissKeyboardOnTap) {
      content = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          final currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            currentFocus.unfocus();
          }
        },
        child: content,
      );
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
