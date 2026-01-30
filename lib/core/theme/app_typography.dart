import 'package:flutter/material.dart';

/// Application typography system - "Samarkand Modern" Design System
/// Clean, readable typography optimized for university students
class AppTypography {
  // ═══════════════════════════════════════════════════════════════════════════
  // FONT FAMILY
  // ═══════════════════════════════════════════════════════════════════════════

  /// Primary font - Pretendard (Korean/English optimized, included in assets)
  static const String fontFamily = 'Pretendard';

  /// Display/headline font - Same for consistency
  static const String displayFontFamily = 'Pretendard';

  // ═══════════════════════════════════════════════════════════════════════════
  // DISPLAY STYLES - For hero sections, splash screens
  // ═══════════════════════════════════════════════════════════════════════════

  static const TextStyle displayLarge = TextStyle(
    fontFamily: displayFontFamily,
    fontSize: 48,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.5,
    height: 1.15,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: displayFontFamily,
    fontSize: 40,
    fontWeight: FontWeight.w600,
    letterSpacing: -1.0,
    height: 1.2,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: displayFontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    height: 1.25,
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // HEADLINE STYLES - For section headers, card titles
  // ═══════════════════════════════════════════════════════════════════════════

  static const TextStyle headline1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.3,
  );

  static const TextStyle headline2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    height: 1.3,
  );

  static const TextStyle headline3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.35,
  );

  static const TextStyle headline4 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
  );

  static const TextStyle headline5 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.45,
  );

  static const TextStyle headline6 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.5,
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // BODY STYLES - For content, descriptions
  // ═══════════════════════════════════════════════════════════════════════════

  static const TextStyle body1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    height: 1.6,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
    height: 1.55,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
    height: 1.5,
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SUBTITLE STYLES - For secondary information
  // ═══════════════════════════════════════════════════════════════════════════

  static const TextStyle subtitle1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.5,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.45,
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // BUTTON & LABEL STYLES
  // ═══════════════════════════════════════════════════════════════════════════

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
    height: 1.4,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    height: 1.35,
  );

  static const TextStyle label = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.4,
    height: 1.4,
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // CAPTION & OVERLINE STYLES
  // ═══════════════════════════════════════════════════════════════════════════

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.3,
    height: 1.4,
  );

  static const TextStyle captionSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
    height: 1.35,
  );

  static const TextStyle overline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
    height: 1.6,
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SPECIAL STYLES
  // ═══════════════════════════════════════════════════════════════════════════

  /// For numeric displays (stats, counters)
  static const TextStyle numeric = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.2,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// For code/monospace text
  static const TextStyle code = TextStyle(
    fontFamily: 'monospace',
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.5,
  );

  /// For links
  static const TextStyle link = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.45,
    decoration: TextDecoration.underline,
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // MATERIAL 3 ALIASES
  // ═══════════════════════════════════════════════════════════════════════════

  static TextStyle get bodyLarge => body1;
  static TextStyle get bodyMedium => body2;
  static TextStyle get labelLarge => button;
  static TextStyle get labelMedium => subtitle2;
  static TextStyle get labelSmall => label;
  static TextStyle get headlineLarge => headline1;
  static TextStyle get headlineMedium => headline2;
  static TextStyle get headlineSmall => headline3;
  static TextStyle get titleLarge => headline4;
  static TextStyle get titleMedium => headline5;
  static TextStyle get titleSmall => headline6;

  // ═══════════════════════════════════════════════════════════════════════════
  // UTILITY METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }

  static TextStyle withLetterSpacing(TextStyle style, double spacing) {
    return style.copyWith(letterSpacing: spacing);
  }

  static TextStyle withHeight(TextStyle style, double height) {
    return style.copyWith(height: height);
  }

  /// Responsive text scaling based on screen width
  static TextStyle responsive(TextStyle style, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 375.0;
    final clampedScale = scaleFactor.clamp(0.85, 1.15);
    return style.copyWith(fontSize: (style.fontSize ?? 14) * clampedScale);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // TEXT THEME FACTORY
  // ═══════════════════════════════════════════════════════════════════════════

  static TextTheme createTextTheme({
    Color? displayColor,
    Color? headlineColor,
    Color? titleColor,
    Color? bodyColor,
    Color? labelColor,
  }) {
    return TextTheme(
      displayLarge: displayLarge.copyWith(color: displayColor),
      displayMedium: displayMedium.copyWith(color: displayColor),
      displaySmall: displaySmall.copyWith(color: displayColor),
      headlineLarge: headline1.copyWith(color: headlineColor),
      headlineMedium: headline2.copyWith(color: headlineColor),
      headlineSmall: headline3.copyWith(color: headlineColor),
      titleLarge: headline4.copyWith(color: titleColor),
      titleMedium: headline5.copyWith(color: titleColor),
      titleSmall: headline6.copyWith(color: titleColor),
      bodyLarge: body1.copyWith(color: bodyColor),
      bodyMedium: body2.copyWith(color: bodyColor),
      bodySmall: caption.copyWith(color: bodyColor),
      labelLarge: button.copyWith(color: labelColor),
      labelMedium: subtitle2.copyWith(color: labelColor),
      labelSmall: label.copyWith(color: labelColor),
    );
  }

  /// Legacy alias
  static TextTheme material3TextTheme({
    Color? displayColor,
    Color? headlineColor,
    Color? titleColor,
    Color? bodyColor,
    Color? labelColor,
  }) {
    return createTextTheme(
      displayColor: displayColor,
      headlineColor: headlineColor,
      titleColor: titleColor,
      bodyColor: bodyColor,
      labelColor: labelColor,
    );
  }
}
