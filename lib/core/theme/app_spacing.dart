import 'package:flutter/material.dart';

/// Application spacing system
/// Centralizes all spacing values used throughout the app

class AppSpacing {
  // Base spacing units (4px grid system)
  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  // Semantic spacing (context-specific)
  static const double cardPadding = md;
  static const double screenPadding = lg;
  static const double dialogPadding = xl;
  static const double buttonPadding = md;
  static const double inputPadding = md;
  static const double listItemSpacing = sm;
  static const double sectionSpacing = xl;
  static const double iconSpacing = sm;

  // Border radius
  static const double radiusXs = 2.0;
  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radiusXxl = 24.0;
  static const double radiusFull = 999.0; // For pills/circles

  // Border widths
  static const double borderWidthThin = 0.5;
  static const double borderWidth = 1.0;
  static const double borderWidthThick = 2.0;

  // Shadows/Elevations
  static const double elevationXs = 1.0;
  static const double elevationSm = 2.0;
  static const double elevationMd = 4.0;
  static const double elevationLg = 6.0;
  static const double elevationXl = 8.0;
  static const double elevationXxl = 12.0;

  // Icon sizes
  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconMd = 20.0;
  static const double iconLg = 24.0;
  static const double iconXl = 32.0;
  static const double iconXxl = 48.0;

  // Utility methods
  static double responsiveSpacing(BuildContext context, double baseSpacing) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 375.0; // Base width for scaling
    final clampedScale = scaleFactor.clamp(0.9, 1.1);
    return baseSpacing * clampedScale;
  }

  // Spacing multipliers
  static double multiply(double base, double multiplier) => base * multiplier;
  static double divide(double base, double divisor) => base / divisor;

  // EdgeInsets helpers
  static EdgeInsets all(double value) => EdgeInsets.all(value);
  static EdgeInsets symmetric({
    double horizontal = 0.0,
    double vertical = 0.0,
  }) => EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  static EdgeInsets only({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) => EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);
  static EdgeInsets fromLTRB(
    double left,
    double top,
    double right,
    double bottom,
  ) => EdgeInsets.fromLTRB(left, top, right, bottom);
}

extension SpacingExtension on num {
  // Convert numbers to spacing values
  double get xxs => this * AppSpacing.xxs;
  double get xs => this * AppSpacing.xs;
  double get sm => this * AppSpacing.sm;
  double get md => this * AppSpacing.md;
  double get lg => this * AppSpacing.lg;
  double get xl => this * AppSpacing.xl;
  double get xxl => this * AppSpacing.xxl;

  // EdgeInsets shortcuts
  EdgeInsets get all => EdgeInsets.all(toDouble());
  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: toDouble());
}
