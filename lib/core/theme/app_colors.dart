import 'package:flutter/material.dart';

/// Application color palette
/// Centralizes all colors used throughout the app
class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF42A5F5);
  static const Color primaryDark = Color(0xFF1565C0);
  static const Color primaryVariant = Color(0xFF0D47A1);

  // Secondary colors
  static const Color secondary = Color(0xFFDCEDC8);
  static const Color secondaryLight = Color(0xFFFFFFF8);
  static const Color secondaryDark = Color(0xFFC5E1A5);
  static const Color secondaryVariant = Color(0xFF689F38);

  // Accent colors
  static const Color accent = Color(0xFFFFC107);
  static const Color accentLight = Color(0xFFFFF350);
  static const Color accentDark = Color(0xFFFF8F00);

  // Background colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Colors.white;
  static const Color cardBackground = Colors.white;

  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Colors.white;
  static const Color textOnSecondary = Color(0xFF212121);

  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Border colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderLight = Color(0xFFF5F5F5);
  static const Color divider = Color(0xFFBDBDBD);

  // Special colors
  static const Color shadow = Color(0x1F000000); // 12% black
  static const Color overlay = Color(0x80000000); // 50% black
  static const Color ripple = Color(0x1F1976D2); // Primary with 12% opacity

  // Social colors (for OAuth buttons, etc.)
  static const Color google = Color(0xFFDB4437);
  static const Color facebook = Color(0xFF4267B2);
  static const Color twitter = Color(0xFF1DA1F2);
  static const Color github = Color(0xFF333333);

  // Gradient colors
  static const List<Color> primaryGradient = [primary, primaryLight];

  static const List<Color> secondaryGradient = [secondary, secondaryLight];

  /// Get color by string name (useful for dynamic theming)
  static Color fromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'primary':
        return primary;
      case 'secondary':
        return secondary;
      case 'accent':
        return accent;
      case 'success':
        return success;
      case 'error':
        return error;
      case 'warning':
        return warning;
      case 'info':
        return info;
      default:
        return primary;
    }
  }

  /// Check if color is dark (for text contrast)
  static bool isDark(Color color) {
    return color.computeLuminance() < 0.5;
  }

  /// Get contrasting text color for background
  static Color getContrastingTextColor(Color backgroundColor) {
    return isDark(backgroundColor) ? Colors.white : textPrimary;
  }
}
