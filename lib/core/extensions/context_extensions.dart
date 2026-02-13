import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nonstop/core/theme/app_colors.dart';

/// BuildContext extensions for navigation, theming, and common utilities
extension ContextExtensions on BuildContext {
  // Navigation
  void goTo(String route, {Object? extra}) {
    GoRouter.of(this).go(route, extra: extra);
  }

  void goNamed(
    String name, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters,
    Object? extra,
  }) {
    GoRouter.of(this).goNamed(
      name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  void push(String route, {Object? extra}) {
    GoRouter.of(this).push(route, extra: extra);
  }

  void pushNamed(String name, {Object? extra}) {
    GoRouter.of(this).pushNamed(name, extra: extra);
  }

  void replace(String route, {Object? extra}) {
    GoRouter.of(this).replace(route, extra: extra);
  }

  void replaceNamed(String name, {Object? extra}) {
    GoRouter.of(this).replaceNamed(name, extra: extra);
  }

  void pop<T extends Object?>([T? result]) {
    GoRouter.of(this).pop(result);
  }

  // MediaQuery shortcuts
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get viewPadding => mediaQuery.viewPadding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  EdgeInsets get padding => mediaQuery.padding;
  double get devicePixelRatio => mediaQuery.devicePixelRatio;
  Orientation get orientation => mediaQuery.orientation;
  bool get isLandscape => orientation == Orientation.landscape;
  bool get isPortrait => orientation == Orientation.portrait;

  // Theme shortcuts
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  AppBarThemeData get appBarTheme => theme.appBarTheme;

  // Text styles shortcuts
  TextStyle? get headline1 => textTheme.displayLarge;
  TextStyle? get headline2 => textTheme.displayMedium;
  TextStyle? get headline3 => textTheme.displaySmall;
  TextStyle? get headline4 => textTheme.headlineLarge;
  TextStyle? get headline5 => textTheme.headlineMedium;
  TextStyle? get headline6 => textTheme.headlineSmall;
  TextStyle? get subtitle1 => textTheme.titleLarge;
  TextStyle? get subtitle2 => textTheme.titleMedium;
  TextStyle? get bodyText1 => textTheme.bodyLarge;
  TextStyle? get bodyText2 => textTheme.bodyMedium;
  TextStyle? get caption => textTheme.bodySmall;
  TextStyle? get button => textTheme.labelLarge;
  TextStyle? get overline => textTheme.labelSmall;

  // ScaffoldMessenger shortcuts
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  void showSnackBar(SnackBar snackBar) {
    scaffoldMessenger.showSnackBar(snackBar);
  }

  void hideCurrentSnackBar() {
    scaffoldMessenger.hideCurrentSnackBar();
  }

  void removeCurrentSnackBar() {
    scaffoldMessenger.removeCurrentSnackBar();
  }

  void clearSnackBars() {
    scaffoldMessenger.clearSnackBars();
  }

  // Focus shortcuts
  FocusScopeNode get focusScope => FocusScope.of(this);
  void unfocus() => focusScope.unfocus();
  bool get hasFocus => focusScope.hasFocus;

  // Modal shortcuts
  Future<T?> showBottomSheet<T>(
    Widget child, {
    bool isScrollControlled = false,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      builder: (_) => child,
    );
  }

  Future<T?> showDialog<T>(Widget child, {bool barrierDismissible = true}) {
    return showGeneralDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) => child,
    );
  }

  Future<DateTime?> showDatePicker({
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    DateTime? currentDate,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    String? cancelText,
    String? confirmText,
    String? helpText,
  }) {
    return showDatePicker(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      currentDate: currentDate,
      initialEntryMode: initialEntryMode,
      cancelText: cancelText,
      confirmText: confirmText,
      helpText: helpText,
    );
  }

  Future<TimeOfDay?> showTimePicker({
    required TimeOfDay initialTime,
    String? cancelText,
    String? confirmText,
    String? helpText,
  }) {
    return showTimePicker(
      initialTime: initialTime,
      cancelText: cancelText,
      confirmText: confirmText,
      helpText: helpText,
    );
  }

  // Responsive helpers
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;
  bool get isDesktop => screenWidth >= 1200;
  bool get isLargeScreen => screenWidth >= 1600;

  // Platform detection
  TargetPlatform get platform => theme.platform;
  bool get isAndroid => platform == TargetPlatform.android;
  bool get isIOS => platform == TargetPlatform.iOS;
  bool get isWeb =>
      platform == TargetPlatform.linux ||
      platform == TargetPlatform.windows ||
      platform == TargetPlatform.macOS;
  bool get isMacOS => platform == TargetPlatform.macOS;
  bool get isWindows => platform == TargetPlatform.windows;
  bool get isLinux => platform == TargetPlatform.linux;
  bool get isFuchsia => platform == TargetPlatform.fuchsia;

  // Locale
  Locale get locale => Localizations.localeOf(this);
  String get languageCode => locale.languageCode;
  String get countryCode => locale.countryCode ?? '';

  // Accessibility
  bool get accessibleNavigation => MediaQuery.accessibleNavigationOf(this);
  bool get invertColors => MediaQuery.invertColorsOf(this);
  bool get disableAnimations => MediaQuery.disableAnimationsOf(this);
  bool get boldText => MediaQuery.boldTextOf(this);
  double get textScaleFactor => MediaQuery.textScalerOf(this).scale(1.0);

  // Safe area
  EdgeInsets get safeAreaPadding => MediaQuery.paddingOf(this);

  // Form validation
  FormState? get form => Form.of(this);
  bool get isFormValid => form?.validate() ?? false;

  // Overlay
  OverlayState? get overlay => Overlay.of(this);
  void insertOverlay(OverlayEntry entry) => overlay?.insert(entry);

  // Animation
  TickerProvider get tickerProvider => this as TickerProvider;

  // Brightness
  Brightness get brightness => theme.brightness;
  bool get isDarkMode => brightness == Brightness.dark;
  bool get isLightMode => brightness == Brightness.light;
}

/// Theme-aware color helpers - automatically returns dark/light variant
extension ThemeAwareColors on BuildContext {
  // Surfaces
  Color get backgroundColor => isDarkMode ? AppColors.backgroundDark : AppColors.background;
  Color get surfaceColor => isDarkMode ? AppColors.surfaceDark : AppColors.surface;
  Color get surfaceVariantColor => isDarkMode ? AppColors.surfaceVariantDark : AppColors.surfaceVariant;
  Color get surfaceElevatedColor => isDarkMode ? AppColors.surfaceElevatedDark : AppColors.surfaceElevated;
  Color get cardColor => isDarkMode ? AppColors.cardBackgroundDark : AppColors.cardBackground;
  Color get cardAltColor => isDarkMode ? AppColors.cardBackgroundAltDark : AppColors.cardBackgroundAlt;

  // Text
  Color get textPrimaryColor => isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;
  Color get textSecondaryColor => isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary;
  Color get textTertiaryColor => isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiary;
  Color get textHintColor => isDarkMode ? AppColors.textHintDark : AppColors.textHint;

  // Borders
  Color get borderColor => isDarkMode ? AppColors.borderDark : AppColors.border;
  Color get borderLightColor => isDarkMode ? AppColors.borderLightDark : AppColors.borderLight;
  Color get borderFocusedColor => isDarkMode ? AppColors.borderFocusedDark : AppColors.borderFocused;
  Color get dividerColor => isDarkMode ? AppColors.dividerDark : AppColors.divider;

  // Glass
  Color get glassBackgroundColor => isDarkMode ? AppColors.glassBackgroundDark : AppColors.glassBackground;
  Color get glassBorderColor => isDarkMode ? AppColors.glassBorderDark : AppColors.glassBorder;

  // Chat
  Color get messageBubbleReceivedColor => isDarkMode ? AppColors.messageBubbleReceivedDark : AppColors.messageBubbleReceived;

  // Gradients
  List<Color> get backgroundGradientColors => isDarkMode ? AppColors.backgroundGradientDark : AppColors.backgroundGradient;
}
