import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Glassmorphic container with Samarkand Modern design
/// Features refined borders, layered shadows, and subtle backdrop blur
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double blur;
  final double opacity;
  final Color color;
  final Color? borderColor;
  final VoidCallback? onTap;
  final bool showBorder;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.padding,
    this.margin,
    this.blur = 12.0,
    this.opacity = 0.85,
    this.color = Colors.white,
    this.borderColor,
    this.onTap,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderR = borderRadius ?? BorderRadius.circular(AppSpacing.radiusLg);
    final effectiveBorderColor = borderColor ??
        (isDark ? AppColors.borderDark : AppColors.border).withValues(alpha: 0.5);
    final effectiveColor = isDark && color == Colors.white
        ? AppColors.surfaceDark
        : color;

    Widget container = Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: effectiveColor.withValues(alpha: opacity),
        borderRadius: borderR,
        border: showBorder
            ? Border.all(
                color: effectiveBorderColor,
                width: AppSpacing.borderWidth,
              )
            : null,
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 16,
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: AppColors.shadowMedium,
                  blurRadius: 32,
                  offset: const Offset(0, 8),
                  spreadRadius: 0,
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: borderR,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        Colors.white.withValues(alpha: 0.03),
                        Colors.white.withValues(alpha: 0.01),
                      ]
                    : [
                        Colors.white.withValues(alpha: 0.1),
                        Colors.white.withValues(alpha: 0.05),
                      ],
              ),
            ),
            child: Padding(
              padding: padding ?? EdgeInsets.all(AppSpacing.md),
              child: child,
            ),
          ),
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: container,
      );
    }

    return container;
  }
}
