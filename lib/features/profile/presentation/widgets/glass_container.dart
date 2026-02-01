import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nonstop/core/theme/app_colors.dart';

/// A glassmorphism container widget with blur and transparency effects
/// Supports both light and dark theme with appropriate colors
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final Color? backgroundColor;
  final double blur;
  final Border? border;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double opacity;

  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 16,
    this.backgroundColor,
    this.blur = 10,
    this.border,
    this.padding,
    this.margin,
    this.opacity = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Theme-aware glass colors
    final glassColor = backgroundColor ??
        (isDarkMode
            ? AppColors.glassBackgroundDark.withValues(alpha: opacity * 3)
            : AppColors.glassBackground.withValues(alpha: opacity));

    final glassBorderColor = isDarkMode
        ? AppColors.glassBorderDark.withValues(alpha: 0.3)
        : AppColors.glassBorder.withValues(alpha: 0.2);

    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: glassColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: border ??
                  Border.all(
                    color: glassBorderColor,
                    width: 1.5,
                  ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
