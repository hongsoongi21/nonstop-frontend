import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'app_button.dart';

/// Enhanced loading indicator with different variants
class AppLoadingIndicator extends StatelessWidget {
  final String? message;
  final LoadingVariant variant;
  final double size;
  final Color? color;

  const AppLoadingIndicator({
    super.key,
    this.message,
    this.variant = LoadingVariant.spinner,
    this.size = 40,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final indicatorColor = color ?? Theme.of(context).colorScheme.primary;

    Widget indicator;
    switch (variant) {
      case LoadingVariant.spinner:
        indicator = SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
          ),
        );
        break;
      case LoadingVariant.dots:
        indicator = Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: indicatorColor.withValues(alpha: 0.6),
                shape: BoxShape.circle,
              ),
            );
          }),
        );
        break;
      case LoadingVariant.pulse:
        indicator = Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: indicatorColor.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: size * 0.6,
              height: size * 0.6,
              decoration: BoxDecoration(
                color: indicatorColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
        break;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        indicator,
        if (message != null) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            message!,
            style: AppTypography.body2.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}

/// Loading variants
enum LoadingVariant {
  spinner, // Circular progress indicator
  dots, // Three dots
  pulse, // Pulsing circle
}

/// Full screen loading overlay
class AppLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? loadingMessage;
  final Color? overlayColor;

  const AppLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.loadingMessage,
    this.overlayColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          AbsorbPointer(
            absorbing: true,
            child: Container(
              color: overlayColor ?? Colors.black.withValues(alpha: 0.5),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: AppLoadingIndicator(
                    message: loadingMessage ?? 'Loading...',
                    variant: LoadingVariant.spinner,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Empty state component for when there's no data
class AppEmptyState extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final Widget? actionButton;
  final EdgeInsetsGeometry? padding;

  const AppEmptyState({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.actionButton,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: (iconColor ?? Theme.of(context).colorScheme.primary)
                    .withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 64,
                color: iconColor ?? Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          Text(
            title,
            style: AppTypography.headline6.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              subtitle!,
              style: AppTypography.body2.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (actionButton != null) ...[
            const SizedBox(height: AppSpacing.xl),
            actionButton!,
          ],
        ],
      ),
    );
  }
}

/// Error state component for error handling
class AppErrorState extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback? onRetry;
  final String? retryText;
  final EdgeInsetsGeometry? padding;

  const AppErrorState({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.onRetry,
    this.retryText,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 64, color: AppColors.error),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          Text(
            title,
            style: AppTypography.headline6.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              subtitle!,
              style: AppTypography.body2.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (onRetry != null) ...[
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              text: retryText ?? 'Try Again',
              onPressed: onRetry,
              variant: ButtonVariant.primary,
            ),
          ],
        ],
      ),
    );
  }
}

/// Success state component for success feedback
class AppSuccessState extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback? onAction;
  final String? actionText;
  final EdgeInsetsGeometry? padding;

  const AppSuccessState({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.onAction,
    this.actionText,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 64, color: AppColors.success),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          Text(
            title,
            style: AppTypography.headline6.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              subtitle!,
              style: AppTypography.body2.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (onAction != null && actionText != null) ...[
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              text: actionText!,
              onPressed: onAction,
              variant: ButtonVariant.primary,
            ),
          ],
        ],
      ),
    );
  }
}

/// Pull to refresh wrapper
class AppRefreshIndicator extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  final Color? color;

  const AppRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color ?? Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: child,
    );
  }
}

/// Shimmer loading effect for content placeholders
class AppShimmer extends StatefulWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration duration;

  const AppShimmer({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    _animation = Tween<double>(
      begin: -1.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                widget.baseColor ?? Colors.grey[300]!,
                widget.highlightColor ?? Colors.grey[100]!,
                widget.baseColor ?? Colors.grey[300]!,
              ],
              stops: [0.0, _animation.value, 1.0],
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
      child: widget.child,
    );
  }
}
