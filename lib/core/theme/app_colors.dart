import 'package:flutter/material.dart';

/// Application color palette
/// Centralizes all colors used throughout the app
class AppColors {
  // Primary colors - University Blue
  static const Color primary = Color(0xFF2563EB); // Modern blue
  static const Color primaryLight = Color(0xFF60A5FA);
  static const Color primaryDark = Color(0xFF1D4ED8);
  static const Color primaryVariant = Color(0xFF1E40AF);

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
  static const Color surfaceSecondary = Color(0xFFF5F5F5);
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

  // University-specific colors
  static const Color universityRed = Color(0xFFE11D48); // University branding
  static const Color universityGreen = Color(0xFF059669); // Success/academics
  static const Color universityPurple = Color(0xFF7C3AED); // Premium features
  static const Color universityOrange = Color(0xFFEA580C); // Warnings/highlights

  // Course category colors
  static const List<Color> courseColors = [
    Color(0xFF3B82F6), // Blue
    Color(0xFFEF4444), // Red
    Color(0xFF10B981), // Green
    Color(0xFFF59E0B), // Yellow
    Color(0xFF8B5CF6), // Purple
    Color(0xFFF97316), // Orange
    Color(0xFF06B6D4), // Cyan
    Color(0xFFEC4899), // Pink
    Color(0xFF84CC16), // Lime
    Color(0xFFFFB300), // Amber
    Color(0xFF14B8A6), // Teal
    Color(0xFF6366F1), // Indigo
    Color(0xFFD946EF), // Fuchsia
    Color(0xFFF43F5E), // Rose
    Color(0xFF78716C), // Stone
    Color(0xFF475569), // Slate
  ];

  // Board post category colors
  static const Color boardFree = Color(0xFF06B6D4); // Erkin - Cyan (aligned with brand)
  static const Color boardSecret = Color(0xFF8B5CF6); // Sirli - Purple
  static const Color boardQuestion = Color(0xFF3B82F6); // Savol - Blue
  static const Color boardMarket = Color(0xFFF59E0B); // Bozor - Yellow

  // Timetable colors
  static const Color timetableToday = Color(0xFF2563EB);
  static const Color timetableWeekend = Color(0xFF6B7280);
  static const Color timetablePast = Color(0xFF9CA3AF);
  static const Color timetableConflict = Color(0xFFEF4444);

  // Chat colors
  static const Color chatOnline = Color(0xFF10B981);
  static const Color chatOffline = Color(0xFF6B7280);
  static const Color chatTyping = Color(0xFFF59E0B);
  static const Color messageBubbleSent = Color(0xFF2563EB);
  static const Color messageBubbleReceived = Color(0xFFF3F4F6);

  // Gradient colors
  static const Color backgroundGradientStart = Color(0xFFE0DBF8);
  static const Color backgroundGradientEnd = Color(0xFFDEF4EB);
  static const List<Color> backgroundGradient = [
    backgroundGradientStart,
    backgroundGradientEnd,
  ];

  static const List<Color> brandGradient = [
    Color(0xFF7C3BEE),
    Color(0xFFB95686),
    Color(0xFFF5711E),
  ];

  static const List<Color> primaryGradient = [primary, primaryLight];
  static const List<Color> secondaryGradient = [secondary, secondaryLight];
  static const List<Color> universityGradient = [universityRed, universityPurple];
  static const List<Color> successGradient = [universityGreen, Color(0xFF34D399)];

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
