import 'package:flutter/material.dart';

/// Application dimensions system
/// Centralizes screen sizes, breakpoints, and responsive values
class AppDimensions {
  // Screen breakpoints (Material Design 3)
  static const double breakpointXs = 600; // Small tablet
  static const double breakpointSm = 840; // Large tablet
  static const double breakpointMd = 1200; // Desktop
  static const double breakpointLg = 1600; // Large desktop

  // Screen size categories
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < breakpointXs;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= breakpointXs && width < breakpointMd;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= breakpointMd;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= breakpointLg;
  }

  // Standard screen sizes for design
  static const Size mobileSize = Size(375, 812); // iPhone X
  static const Size tabletSize = Size(768, 1024); // iPad
  static const Size desktopSize = Size(1440, 900); // MacBook

  // App bar heights
  static const double appBarHeight = kToolbarHeight; // 56.0
  static const double appBarHeightLarge = 64.0;
  static const double appBarHeightSmall = 48.0;

  // Bottom navigation heights
  static const double bottomNavHeight = kBottomNavigationBarHeight; // 56.0
  static const double bottomNavHeightLarge = 72.0;

  // Tab bar heights
  static const double tabBarHeight = kTextTabBarHeight; // 48.0

  // Card dimensions
  static const double cardMinHeight = 72.0;
  static const double cardMaxWidth = 400.0;

  // Dialog dimensions
  static const double dialogMinWidth = 280.0;
  static const double dialogMaxWidth = 560.0;
  static const double dialogMinHeight = 120.0;

  // Button dimensions
  static const double buttonMinHeight = 36.0;
  static const double buttonMinWidth = 64.0;
  static const double fabSize = 56.0;
  static const double fabSizeLarge = 96.0;

  // Input field dimensions
  static const double inputMinHeight = 48.0;
  static const double inputBorderRadius = 8.0;

  // List item dimensions
  static const double listItemMinHeight = 48.0;
  static const double listItemMaxWidth = 600.0;

  // Avatar sizes
  static const double avatarXs = 24.0;
  static const double avatarSm = 32.0;
  static const double avatarMd = 40.0;
  static const double avatarLg = 56.0;
  static const double avatarXl = 72.0;
  static const double avatarXxl = 96.0;

  // Image dimensions
  static const double imageThumbnailSize = 80.0;
  static const double imagePreviewSize = 200.0;
  static const double imageFullSize = 400.0;

  // Grid dimensions
  static const int gridCrossAxisCountMobile = 2;
  static const int gridCrossAxisCountTablet = 3;
  static const int gridCrossAxisCountDesktop = 4;

  static int getGridCrossAxisCount(BuildContext context) {
    if (isDesktop(context)) return gridCrossAxisCountDesktop;
    if (isTablet(context)) return gridCrossAxisCountTablet;
    return gridCrossAxisCountMobile;
  }

  // Spacing calculations based on screen size
  static double responsiveValue({
    required BuildContext context,
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    if (isDesktop(context)) return desktop ?? tablet ?? mobile;
    if (isTablet(context)) return tablet ?? mobile;
    return mobile;
  }

  // Aspect ratios
  static const double aspectRatioSquare = 1.0;
  static const double aspectRatioVideo = 16 / 9;
  static const double aspectRatioCard = 16 / 10;
  static const double aspectRatioBanner = 16 / 6;

  // Animation durations
  static const Duration durationXs = Duration(milliseconds: 150);
  static const Duration durationSm = Duration(milliseconds: 200);
  static const Duration durationMd = Duration(milliseconds: 300);
  static const Duration durationLg = Duration(milliseconds: 500);
  static const Duration durationXl = Duration(milliseconds: 700);

  // Curves
  static const Curve curveEaseInOut = Curves.easeInOut;
  static const Curve curveEaseOut = Curves.easeOut;
  static const Curve curveEaseIn = Curves.easeIn;
  static const Curve curveBounceOut = Curves.bounceOut;

  // Safe area considerations
  static EdgeInsets safeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  // Viewport calculations
  static Size viewportSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double viewportWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double viewportHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Device pixel ratio
  static double devicePixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  // Orientation detection
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }
}
