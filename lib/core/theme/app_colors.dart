import 'package:flutter/material.dart';

/// Application color palette - "Nonstop Modern" Design System
/// Centered around the new Brand Color (6E89F8) with expanded 12-step grayscale
class AppColors {
  // ═══════════════════════════════════════════════════════════════════════════
  // BRAND COLORS - Primary Palette (#6E89F8)
  // ═══════════════════════════════════════════════════════════════════════════

  /// Primary - New Brand Color (6E89F8)
  static const Color primary = Color(0xFF6E89F8);
  
  /// Primary Palette (50-950) - Derived from provided hex codes
  static const Color primary50 = Color(0xFFEBECFF);
  static const Color primary100 = Color(0xFFDCDDFE);
  static const Color primary200 = Color(0xFF81A9FF); // at100
  static const Color primary300 = Color(0xFF7FABE3); // sl100
  static const Color primary400 = Color(0xFF7190FF); // mlFat
  static const Color primary500 = Color(0xFF6E89F8); // Base (slMiddle)
  static const Color primary600 = Color(0xFF7C7EFC); // gl500
  static const Color primary700 = Color(0xFF6A5DFB); // gl600
  static const Color primary800 = Color(0xFF2F5BF9); // at500
  static const Color primary900 = Color(0xFF0046A5); // slHigh
  static const Color primary950 = Color(0xFF092E97); // pbf500

  // Legacy Mapping for compatibility with existing widgets
  static const Color primaryLight = primary300;
  static const Color primaryDark = primary800;
  static const Color primarySoft = primary100;

  /// Secondary - Purple Accent (#BB8FF9)
  static const Color secondary = Color(0xFFBB8FF9);
  static const Color secondaryLight = Color(0xFFDCDDFE);
  static const Color secondaryDark = Color(0xFF8A86FF);

  /// Tertiary - Soft Lavender (#8A86FF)
  static const Color tertiary = Color(0xFF8A86FF);
  static const Color tertiaryLight = Color(0xFFEBECFF);
  static const Color tertiaryDark = Color(0xFF6A5DFB);

  // ═══════════════════════════════════════════════════════════════════════════
  // NEUTRAL COLORS (Expanded 12-step Grey Scale from HealthNYou)
  // ═══════════════════════════════════════════════════════════════════════════

  static const Color white = Color(0xFFFFFFFF);
  static const Color grey05 = Color(0xFFF8F8F8);
  static const Color grey10 = Color(0xFFF3F3F7);
  static const Color grey40 = Color(0xFFECECF0);
  static const Color grey50 = Color(0xFFE5E5EA);
  static const Color grey100 = Color(0xFFD1D1D6);
  static const Color grey200 = Color(0xFFC7C7CC);
  static const Color grey300 = Color(0xFFAEAEB2);
  static const Color grey400 = Color(0xFF8E8E93);
  static const Color grey500 = Color(0xFF636366);
  static const Color grey600 = Color(0xFF49484B);
  static const Color grey700 = Color(0xFF3A3A3C);
  static const Color grey800 = Color(0xFF2C2D2E);
  static const Color grey900 = Color(0xFF1C1C1E);
  static const Color black = Color(0xFF000000);

  // Semantic Mapping for surfaces
  static const Color background = grey05;
  static const Color surface = white;
  static const Color surfaceVariant = grey10;
  static const Color surfaceElevated = white;

  // Legacy Surface Aliases
  static const Color cardBackground = white;
  static const Color cardBackgroundAlt = grey05;
  static const Color surfaceSecondary = grey10;

  // Dark mode surfaces (kept for basic compatibility)
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color surfaceVariantDark = Color(0xFF334155);
  static const Color surfaceElevatedDark = Color(0xFF1E293B);
  static const Color cardBackgroundDark = Color(0xFF1E293B);
  static const Color cardBackgroundAltDark = Color(0xFF253347);

  // ═══════════════════════════════════════════════════════════════════════════
  // TEXT COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  static const Color textPrimary = grey900;
  static const Color textSecondary = grey500;
  static const Color textTertiary = grey300;
  static const Color textHint = grey100;
  static const Color textOnPrimary = white;
  static const Color textOnSecondary = grey900;
  static const Color textOnAccent = white;

  /// Dark mode text
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFFCBD5E1);
  static const Color textTertiaryDark = Color(0xFF64748B);
  static const Color textHintDark = Color(0xFF475569);

  // ═══════════════════════════════════════════════════════════════════════════
  // STATUS & ACCENT COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  // Accent (Coral / Energy) - Re-adding for compatibility
  static const Color accent = Color(0xFFEF6461);
  static const Color accentLight = Color(0xFFFF8A87);
  static const Color accentDark = Color(0xFFCC4A47);

  // Success (Green)
  static const Color success = Color(0xFF51C639);
  static const Color successLight = Color(0xFFCEF9B2);
  static const Color successDark = Color(0xFF1E8E1C);

  // Error (Red)
  static const Color error = Color(0xFFFF334B);
  static const Color errorLight = Color(0xFFFCC5CB);
  static const Color errorDark = Color(0xFFC9162B);

  // Warning (Orange/Yellow)
  static const Color warning = Color(0xFFFF6F36);
  static const Color warningLight = Color(0xFFFFCFBF);
  static const Color warningDark = Color(0xFFC43100);

  // Info (Blue)
  static const Color info = Color(0xFF2F5BF9);
  static const Color infoLight = Color(0xFFABC3FE);
  static const Color infoDark = Color(0xFF0E2290);

  /// Dark mode status colors
  static const Color successDarkTheme = Color(0xFF35AA29);
  static const Color errorDarkTheme = Color(0xFFE5172F);
  static const Color warningDarkTheme = Color(0xFFFF5E1F);
  static const Color infoDarkTheme = Color(0xFF2245D6);

  // Legacy University Colors
  static const Color universityRed = accent;
  static const Color universityGreen = success;
  static const Color universityPurple = Color(0xFF8B5CF6);
  static const Color universityOrange = warning;

  // ═══════════════════════════════════════════════════════════════════════════
  // BORDER & DIVIDER COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  static const Color border = grey50;
  static const Color borderLight = grey40;
  static const Color borderFocused = primary;
  static const Color divider = grey40;

  // Dark mode borders
  static const Color borderDark = Color(0xFF334155);
  static const Color borderLightDark = Color(0xFF475569);
  static const Color borderFocusedDark = primary;
  static const Color dividerDark = Color(0xFF334155);

  // ═══════════════════════════════════════════════════════════════════════════
  // SHADOW & OVERLAY COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  static const Color shadow = Color(0x0A000000);
  static const Color shadowMedium = Color(0x1A000000);
  static const Color shadowStrong = Color(0x2A000000);
  static const Color shadowDark = Color(0x40000000);
  static const Color overlay = Color(0x80000000);
  static const Color ripple = Color(0x1A6E89F8);

  // ═══════════════════════════════════════════════════════════════════════════
  // GRADIENTS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Main brand gradient
  static const List<Color> primaryGradient = [
    primary,
    Color(0xFF8196F9),
  ];

  static const List<Color> brandGradient = primaryGradient;
  static const List<Color> backgroundGradient = [grey05, white];
  static const List<Color> backgroundGradientDark = [backgroundDark, surfaceDark];

  // ═══════════════════════════════════════════════════════════════════════════
  // FEATURE-SPECIFIC COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Board categories
  static const Color boardFree = primary;
  static const Color boardSecret = secondary;
  static const Color boardQuestion = info;
  static const Color boardMarket = Color(0xFF7E94E0);

  /// Timetable
  static const Color chatOnline = Color(0xFF51C639); // success
  static const Color chatOffline = grey300;
  static const Color chatTyping = Color(0xFFFFC402); // yellow500
  static const Color messageBubbleSent = primary;
  static const Color messageBubbleReceived = grey10;
  static const Color messageBubbleReceivedDark = Color(0xFF334155);

  /// Glassmorphism
  static const Color glassBackground = Color(0x33FFFFFF);
  static const Color glassBorder = Color(0x4DFFFFFF);
  static const Color glassBackgroundDark = Color(0x33000000);
  static const Color glassBorderDark = Color(0x4D000000);

  /// Auth Fields
  static const Color authFieldBackground = Color(0xFFE9F0FE);
  static const Color authFieldBackgroundDark = Color(0xFF1E293B);
  static const Color authFieldBorder = white;
  static const Color authFieldBorderDark = Color(0xFF475569);
  static const Color authFieldText = grey900;
  static const Color authFieldTextDark = white;
  static const Color authFieldHint = grey100;
  static const Color authFieldHintDark = grey300;

  /// Social
  static const Color google = Color(0xFFDB4437);
  static const Color facebook = Color(0xFF4267B2);
  static const Color apple = Color(0xFF000000);

  /// Timetable / Course Colors (Rich Palette)
  static const List<Color> courseColors = [
    primary,
    secondary,
    tertiary,
    Color(0xFF7FABE3),
    Color(0xFF7E94E0),
    Color(0xFF7C7EFC),
    Color(0xFF6A5DFB),
    Color(0xFF2F5BF9),
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // UTILITY METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  static bool isDark(Color color) {
    return color.computeLuminance() < 0.5;
  }

  static Color getContrastingTextColor(Color backgroundColor) {
    return isDark(backgroundColor) ? Colors.white : textPrimary;
  }
}
