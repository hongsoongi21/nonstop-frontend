import 'package:flutter/material.dart';

/// Application color palette - "Samarkand Modern" Design System
/// Inspired by Uzbekistan's iconic blue tiles mixed with modern university energy
class AppColors {
  // ═══════════════════════════════════════════════════════════════════════════
  // BRAND COLORS - Samarkand Blue Spectrum
  // ═══════════════════════════════════════════════════════════════════════════

  /// Primary - Deep Samarkand Blue (main brand color)
  static const Color primary = Color(0xFF1E4D7B);

  /// Primary variants
  static const Color primaryLight = Color(0xFF3A7CA5);
  static const Color primaryDark = Color(0xFF0D2E4D);
  static const Color primarySoft = Color(0xFF5C99C5);

  /// Secondary - Warm Gold (Uzbek textile accent)
  static const Color secondary = Color(0xFFD4A853);
  static const Color secondaryLight = Color(0xFFE8C97D);
  static const Color secondaryDark = Color(0xFFB08A3A);

  /// Tertiary - Turquoise Tile (classic Uzbek architecture)
  static const Color tertiary = Color(0xFF0891B2);
  static const Color tertiaryLight = Color(0xFF22D3EE);
  static const Color tertiaryDark = Color(0xFF0E7490);

  /// Accent - Coral Energy (youth & vibrancy)
  static const Color accent = Color(0xFFEF6461);
  static const Color accentLight = Color(0xFFFF8A87);
  static const Color accentDark = Color(0xFFCC4A47);

  // ═══════════════════════════════════════════════════════════════════════════
  // SURFACE COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Light mode surfaces
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);
  static const Color surfaceElevated = Color(0xFFFFFFFF);

  /// Card & container backgrounds
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardBackgroundAlt = Color(0xFFFCFDFE);

  /// Dark mode surfaces
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color surfaceVariantDark = Color(0xFF334155);
  static const Color surfaceElevatedDark = Color(0xFF1E293B);

  // ═══════════════════════════════════════════════════════════════════════════
  // TEXT COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Light mode text
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textHint = Color(0xFFCBD5E1);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xFF0F172A);
  static const Color textOnAccent = Color(0xFFFFFFFF);

  /// Dark mode text
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFFCBD5E1);
  static const Color textTertiaryDark = Color(0xFF64748B);

  // ═══════════════════════════════════════════════════════════════════════════
  // STATUS COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color successDark = Color(0xFF059669);

  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color errorDark = Color(0xFFDC2626);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color warningDark = Color(0xFFD97706);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);
  static const Color infoDark = Color(0xFF2563EB);

  // ═══════════════════════════════════════════════════════════════════════════
  // BORDER & DIVIDER COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFF1F5F9);
  static const Color borderFocused = Color(0xFF1E4D7B);
  static const Color divider = Color(0xFFE2E8F0);

  static const Color borderDark = Color(0xFF334155);
  static const Color borderLightDark = Color(0xFF475569);

  // ═══════════════════════════════════════════════════════════════════════════
  // SHADOW & OVERLAY COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  static const Color shadow = Color(0x0A0F172A);
  static const Color shadowMedium = Color(0x1A0F172A);
  static const Color shadowStrong = Color(0x2A0F172A);
  static const Color overlay = Color(0x800F172A);
  static const Color ripple = Color(0x1A1E4D7B);

  // ═══════════════════════════════════════════════════════════════════════════
  // GRADIENTS - Samarkand Inspired
  // ═══════════════════════════════════════════════════════════════════════════

  /// Main brand gradient (Samarkand sky to sea)
  static const List<Color> primaryGradient = [
    Color(0xFF1E4D7B),
    Color(0xFF0891B2),
  ];

  /// Warm sunset gradient (Uzbek desert)
  static const List<Color> sunsetGradient = [
    Color(0xFFD4A853),
    Color(0xFFEF6461),
  ];

  /// Cool sky gradient (Central Asian sky)
  static const List<Color> skyGradient = [
    Color(0xFF3A7CA5),
    Color(0xFF22D3EE),
  ];

  /// Background gradient (subtle)
  static const List<Color> backgroundGradient = [
    Color(0xFFF8FAFC),
    Color(0xFFF1F5F9),
  ];

  /// Premium/accent gradient
  static const List<Color> accentGradient = [
    Color(0xFFEF6461),
    Color(0xFFD4A853),
  ];

  /// Legacy support
  static const List<Color> brandGradient = primaryGradient;

  // ═══════════════════════════════════════════════════════════════════════════
  // LEGACY ALIASES (for backward compatibility)
  // ═══════════════════════════════════════════════════════════════════════════

  /// Legacy university colors - now mapped to new palette
  static const Color universityRed = accent;
  static const Color universityGreen = success;
  static const Color universityPurple = Color(0xFF8B5CF6);
  static const Color universityOrange = warning;

  /// Legacy surface colors
  static const Color surfaceSecondary = surfaceVariant;
  static const Color backgroundGradientStart = Color(0xFFF8FAFC);
  static const Color backgroundGradientEnd = Color(0xFFF1F5F9);

  /// Legacy gradient
  static const List<Color> universityGradient = accentGradient;
  static const List<Color> successGradient = [success, Color(0xFF34D399)];

  // ═══════════════════════════════════════════════════════════════════════════
  // FEATURE-SPECIFIC COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Board categories
  static const Color boardFree = Color(0xFF0891B2); // Turquoise
  static const Color boardSecret = Color(0xFF8B5CF6); // Purple
  static const Color boardQuestion = Color(0xFF3B82F6); // Blue
  static const Color boardMarket = Color(0xFFD4A853); // Gold

  /// Timetable
  static const Color timetableToday = Color(0xFF1E4D7B);
  static const Color timetableWeekend = Color(0xFF94A3B8);
  static const Color timetablePast = Color(0xFFCBD5E1);
  static const Color timetableConflict = Color(0xFFEF4444);

  /// Chat
  static const Color chatOnline = Color(0xFF10B981);
  static const Color chatOffline = Color(0xFF94A3B8);
  static const Color chatTyping = Color(0xFFD4A853);
  static const Color messageBubbleSent = Color(0xFF1E4D7B);
  static const Color messageBubbleReceived = Color(0xFFF1F5F9);

  /// Social
  static const Color google = Color(0xFFDB4437);
  static const Color facebook = Color(0xFF4267B2);
  static const Color twitter = Color(0xFF1DA1F2);
  static const Color github = Color(0xFF333333);

  // ═══════════════════════════════════════════════════════════════════════════
  // COURSE/CATEGORY COLORS (Vibrant palette for timetable)
  // ═══════════════════════════════════════════════════════════════════════════

  static const List<Color> courseColors = [
    Color(0xFF1E4D7B), // Samarkand Blue
    Color(0xFF0891B2), // Turquoise
    Color(0xFFD4A853), // Gold
    Color(0xFFEF6461), // Coral
    Color(0xFF8B5CF6), // Purple
    Color(0xFF10B981), // Emerald
    Color(0xFFF59E0B), // Amber
    Color(0xFFEC4899), // Pink
    Color(0xFF3B82F6), // Sky Blue
    Color(0xFF14B8A6), // Teal
    Color(0xFF6366F1), // Indigo
    Color(0xFFF97316), // Orange
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // UTILITY METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Get color by string name
  static Color fromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'primary':
        return primary;
      case 'secondary':
        return secondary;
      case 'tertiary':
        return tertiary;
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

  /// Get color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }
}
