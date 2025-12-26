import 'package:flutter/material.dart';

/// Application typography system
/// Centralizes all text styles used throughout the app
class AppTypography {
  // Font family
  static const String fontFamily = 'Pretendard';

  // Headline styles
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
    height: 1.25,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
    height: 1.29,
  );

  static const TextStyle headline3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.33,
  );

  static const TextStyle headline4 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.4,
  );

  static const TextStyle headline5 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.44,
  );

  static const TextStyle headline6 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.5,
  );

  // Subtitle styles
  static const TextStyle subtitle1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.57,
  );

  // Body styles
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  );

  // Button styles
  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
    height: 1.43,
  );

  // Caption styles
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );

  static const TextStyle overline = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
    height: 1.6,
  );

  // Custom utility styles
  static TextStyle get displayLarge => headline1.copyWith(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    height: 1.12,
  );

  static TextStyle get displayMedium => headline2.copyWith(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.16,
  );

  static TextStyle get displaySmall => headline3.copyWith(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.22,
  );

  // Utility methods
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

  // Responsive text scaling
  static TextStyle responsive(TextStyle style, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 375.0; // Base width for scaling
    final clampedScale = scaleFactor.clamp(0.8, 1.2);

    return style.copyWith(fontSize: (style.fontSize ?? 14) * clampedScale);
  }

  // Material 3 aliases for easier access
  static TextStyle get bodyLarge => body1;
  static TextStyle get bodyMedium => body2;
  static TextStyle get bodySmall => caption;
  static TextStyle get labelLarge => button;
  static TextStyle get labelMedium => subtitle2;
  static TextStyle get labelSmall => overline;
  static TextStyle get headlineLarge => headline1;
  static TextStyle get headlineMedium => headline2;
  static TextStyle get headlineSmall => headline3;
  static TextStyle get titleLarge => headline4;
  static TextStyle get titleMedium => headline5;
  static TextStyle get titleSmall => headline6;

  // Material 3 text theme factory
  static TextTheme material3TextTheme({
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
      labelSmall: overline.copyWith(color: labelColor),
    );
  }
}
