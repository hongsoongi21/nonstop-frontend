import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Custom snackbar helper with "Samarkand Modern" aesthetic
/// Provides consistent feedback across the app
class AppSnackbar {
  /// Show success snackbar
  static void showSuccess(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    _show(
      context,
      message: message,
      title: title,
      icon: Icons.check_circle_rounded,
      backgroundColor: AppColors.success,
      duration: duration,
      action: action,
    );
  }

  /// Show error snackbar
  static void showError(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
  }) {
    _show(
      context,
      message: message,
      title: title,
      icon: Icons.error_rounded,
      backgroundColor: AppColors.error,
      duration: duration,
      action: action,
    );
  }

  /// Show warning snackbar
  static void showWarning(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    _show(
      context,
      message: message,
      title: title,
      icon: Icons.warning_amber_rounded,
      backgroundColor: AppColors.warning,
      duration: duration,
      action: action,
    );
  }

  /// Show info snackbar
  static void showInfo(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    _show(
      context,
      message: message,
      title: title,
      icon: Icons.info_rounded,
      backgroundColor: AppColors.info,
      duration: duration,
      action: action,
    );
  }

  /// Show custom snackbar
  static void showCustom(
    BuildContext context, {
    required String message,
    String? title,
    IconData? icon,
    Color? backgroundColor,
    Color? textColor,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    _show(
      context,
      message: message,
      title: title,
      icon: icon,
      backgroundColor: backgroundColor ?? AppColors.primary,
      textColor: textColor,
      duration: duration,
      action: action,
    );
  }

  /// Internal method to show snackbar
  static void _show(
    BuildContext context, {
    required String message,
    String? title,
    IconData? icon,
    required Color backgroundColor,
    Color? textColor,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    final messenger = ScaffoldMessenger.of(context);

    // Remove any existing snackbars
    messenger.clearSnackBars();

    final snackBar = SnackBar(
      content: _SnackbarContent(
        message: message,
        title: title,
        icon: icon,
        textColor: textColor ?? Colors.white,
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(AppSpacing.md),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      elevation: 4,
      action: action != null
          ? SnackBarAction(
              label: action.label,
              onPressed: action.onPressed,
              textColor: textColor ?? Colors.white,
            )
          : null,
    );

    messenger.showSnackBar(snackBar);
  }

  /// Show loading snackbar (persistent until dismissed)
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showLoading(
    BuildContext context, {
    String message = 'Loading...',
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();

    return messenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Text(
              message,
              style: AppTypography.body2.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
        duration: const Duration(days: 1), // Long duration, manually dismiss
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(AppSpacing.md),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
      ),
    );
  }

  /// Dismiss any showing snackbar
  static void dismiss(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }
}

/// Custom snackbar content widget
class _SnackbarContent extends StatelessWidget {
  final String message;
  final String? title;
  final IconData? icon;
  final Color textColor;

  const _SnackbarContent({
    required this.message,
    this.title,
    this.icon,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          // Icon
          if (icon != null) ...[
            Container(
              padding: EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 24,
                color: textColor,
              ),
            ),
            SizedBox(width: AppSpacing.md),
          ],

          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: AppTypography.subtitle2.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xxs),
                ],
                Text(
                  message,
                  style: AppTypography.body2.copyWith(
                    color: textColor.withValues(alpha: 0.95),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Toast-style notification (alternative to snackbar)
/// Shows at the top of the screen with auto-dismiss
class AppToast {
  static OverlayEntry? _currentToast;

  /// Show success toast
  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    _show(
      context,
      message: message,
      icon: Icons.check_circle_rounded,
      backgroundColor: AppColors.success,
      duration: duration,
    );
  }

  /// Show error toast
  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      context,
      message: message,
      icon: Icons.error_rounded,
      backgroundColor: AppColors.error,
      duration: duration,
    );
  }

  /// Show info toast
  static void showInfo(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    _show(
      context,
      message: message,
      icon: Icons.info_rounded,
      backgroundColor: AppColors.info,
      duration: duration,
    );
  }

  /// Internal method to show toast
  static void _show(
    BuildContext context, {
    required String message,
    required IconData icon,
    required Color backgroundColor,
    Duration duration = const Duration(seconds: 2),
  }) {
    _currentToast?.remove();

    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        icon: icon,
        backgroundColor: backgroundColor,
        onDismiss: () {
          _currentToast?.remove();
          _currentToast = null;
        },
      ),
    );

    _currentToast = overlayEntry;
    overlay.insert(overlayEntry);

    // Auto dismiss
    Future.delayed(duration, () {
      overlayEntry.remove();
      if (_currentToast == overlayEntry) {
        _currentToast = null;
      }
    });
  }
}

/// Toast widget implementation
class _ToastWidget extends StatefulWidget {
  final String message;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onDismiss;

  const _ToastWidget({
    required this.message,
    required this.icon,
    required this.backgroundColor,
    required this.onDismiss,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + AppSpacing.md,
      left: AppSpacing.md,
      right: AppSpacing.md,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowStrong,
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    widget.icon,
                    color: Colors.white,
                    size: 24,
                  ),
                  SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: AppTypography.body2.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
