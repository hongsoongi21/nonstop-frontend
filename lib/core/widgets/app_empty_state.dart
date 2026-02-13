import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../extensions/context_extensions.dart';
import 'app_animations.dart';

/// Reusable empty state widget with "Samarkand Modern" aesthetic
/// Features dramatic geometric backgrounds and meaningful illustrations
class AppEmptyState extends StatelessWidget {
  final IconData? icon;
  final Widget? illustration;
  final String title;
  final String? description;
  final String? actionText;
  final VoidCallback? onAction;
  final EmptyStateVariant variant;
  final Color? customColor;
  final EdgeInsetsGeometry? padding;
  final bool animate;

  const AppEmptyState({
    super.key,
    this.icon,
    this.illustration,
    required this.title,
    this.description,
    this.actionText,
    this.onAction,
    this.variant = EmptyStateVariant.primary,
    this.customColor,
    this.padding,
    this.animate = true,
  });

  /// Named constructor for "no content" state
  const AppEmptyState.noContent({
    super.key,
    required this.title,
    this.description,
    this.actionText,
    this.onAction,
    this.padding,
  })  : icon = Icons.inbox_outlined,
        illustration = null,
        variant = EmptyStateVariant.neutral,
        customColor = null,
        animate = true;

  /// Named constructor for "search" empty state
  const AppEmptyState.noResults({
    super.key,
    this.title = 'No results found',
    this.description = 'Try adjusting your search or filters',
    this.actionText,
    this.onAction,
    this.padding,
  })  : icon = Icons.search_off_rounded,
        illustration = null,
        variant = EmptyStateVariant.neutral,
        customColor = null,
        animate = true;

  /// Named constructor for "network" error state
  const AppEmptyState.offline({
    super.key,
    this.title = 'No internet connection',
    this.description = 'Please check your network and try again',
    this.actionText = 'Retry',
    this.onAction,
    this.padding,
  })  : icon = Icons.wifi_off_rounded,
        illustration = null,
        variant = EmptyStateVariant.error,
        customColor = null,
        animate = true;

  /// Named constructor for "coming soon" state
  const AppEmptyState.comingSoon({
    super.key,
    this.title = 'Coming Soon',
    this.description = 'This feature is under construction',
    this.actionText,
    this.onAction,
    this.padding,
  })  : icon = Icons.construction_rounded,
        illustration = null,
        variant = EmptyStateVariant.info,
        customColor = null,
        animate = true;

  Color _getVariantColor(BuildContext context) {
    if (customColor != null) return customColor!;

    switch (variant) {
      case EmptyStateVariant.primary:
        return AppColors.primary;
      case EmptyStateVariant.success:
        return AppColors.success;
      case EmptyStateVariant.error:
        return AppColors.error;
      case EmptyStateVariant.warning:
        return AppColors.warning;
      case EmptyStateVariant.info:
        return AppColors.info;
      case EmptyStateVariant.neutral:
        return context.textTertiaryColor;
    }
  }

  Widget _buildContent(BuildContext context) {
    final variantColor = _getVariantColor(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Illustration or icon with decorative background
        if (illustration != null)
          _buildIllustration(context, variantColor)
        else if (icon != null)
          _buildIcon(context, variantColor),

        SizedBox(height: AppSpacing.xl),

        // Title with bold typography
        Text(
          title,
          style: AppTypography.headline3.copyWith(
            color: context.textPrimaryColor,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),

        // Description with subtle color
        if (description != null) ...[
          SizedBox(height: AppSpacing.md),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Text(
              description!,
              style: AppTypography.body1.copyWith(
                color: context.textSecondaryColor,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],

        // Action button with gradient background
        if (actionText != null && onAction != null) ...[
          SizedBox(height: AppSpacing.xl),
          _buildActionButton(context, variantColor),
        ],
      ],
    );
  }

  Widget _buildIllustration(BuildContext context, Color variantColor) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            variantColor.withValues(alpha: 0.1),
            variantColor.withValues(alpha: 0.02),
          ],
          stops: const [0.3, 1.0],
        ),
        shape: BoxShape.circle,
      ),
      child: Center(child: illustration!),
    );
  }

  Widget _buildIcon(BuildContext context, Color variantColor) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        // Layered geometric background inspired by Uzbek tiles
        gradient: RadialGradient(
          colors: [
            variantColor.withValues(alpha: 0.15),
            variantColor.withValues(alpha: 0.05),
          ],
        ),
        shape: BoxShape.circle,
        border: Border.all(
          color: variantColor.withValues(alpha: 0.2),
          width: 2,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Decorative ring
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: variantColor.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
          ),
          // Icon
          Icon(
            icon,
            size: 52,
            color: variantColor,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, Color variantColor) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            variantColor,
            variantColor.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        boxShadow: [
          BoxShadow(
            color: variantColor.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onAction,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.md,
            ),
            child: Text(
              actionText!,
              style: AppTypography.button.copyWith(
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = _buildContent(context);

    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.all(AppSpacing.xxl),
      child: animate
          ? AppAnimations.fadeSlideIn(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              startOffset: 40,
              child: content,
            )
          : content,
    );
  }
}

/// Empty state visual variants
enum EmptyStateVariant {
  primary,
  success,
  error,
  warning,
  info,
  neutral,
}

/// Decorative background pattern for empty states
/// Creates geometric patterns inspired by Uzbek tile work
class EmptyStateBackground extends StatelessWidget {
  final Widget child;
  final Color? accentColor;

  const EmptyStateBackground({
    super.key,
    required this.child,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? AppColors.primary.withValues(alpha: 0.03);

    return Stack(
      children: [
        // Geometric pattern background
        Positioned.fill(
          child: CustomPaint(
            painter: _TilePatternPainter(color: color),
          ),
        ),
        // Content
        child,
      ],
    );
  }
}

/// Custom painter for decorative tile patterns
class _TilePatternPainter extends CustomPainter {
  final Color color;

  _TilePatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    const spacing = 40.0;

    // Draw diamond grid pattern
    for (double x = -spacing; x < size.width + spacing; x += spacing) {
      for (double y = -spacing; y < size.height + spacing; y += spacing) {
        final path = Path()
          ..moveTo(x, y - spacing / 2)
          ..lineTo(x + spacing / 2, y)
          ..lineTo(x, y + spacing / 2)
          ..lineTo(x - spacing / 2, y)
          ..close();

        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
