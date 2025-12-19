import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimensions.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Application theme configuration
/// Centralizes all theme-related settings and provides theme data
class AppTheme {
  // Light theme
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Colors
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryLight,
        secondary: AppColors.secondary,
        secondaryContainer: AppColors.secondaryLight,
        surface: AppColors.surface,
        background: AppColors.background,
        error: AppColors.error,
        onPrimary: AppColors.textOnPrimary,
        onSecondary: AppColors.textOnSecondary,
        onSurface: AppColors.textPrimary,
        onBackground: AppColors.textPrimary,
        onError: Colors.white,
      ),

      // Typography
      textTheme: AppTypography.material3TextTheme(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
        headlineColor: AppColors.textPrimary,
        titleColor: AppColors.textPrimary,
        labelColor: AppColors.textPrimary,
      ),

      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: AppSpacing.elevationSm,
        shadowColor: AppColors.shadow,
        surfaceTintColor: AppColors.surface,
        titleTextStyle: AppTypography.headline6.copyWith(
          color: AppColors.textPrimary,
        ),
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        elevation: AppSpacing.elevationMd,
        type: BottomNavigationBarType.fixed,
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: AppColors.cardBackground,
        shadowColor: AppColors.shadow,
        elevation: AppSpacing.elevationXs,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        margin: EdgeInsets.zero,
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(
            AppDimensions.buttonMinWidth,
            AppDimensions.buttonMinHeight,
          ),
          padding: AppSpacing.symmetric(horizontal: AppSpacing.buttonPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          elevation: AppSpacing.elevationSm,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(
            AppDimensions.buttonMinWidth,
            AppDimensions.buttonMinHeight,
          ),
          padding: AppSpacing.symmetric(horizontal: AppSpacing.buttonPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(
            AppDimensions.buttonMinWidth,
            AppDimensions.buttonMinHeight,
          ),
          padding: AppSpacing.symmetric(horizontal: AppSpacing.buttonPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          side: const BorderSide(
            color: AppColors.primary,
            width: AppSpacing.borderWidth,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(
            AppDimensions.buttonMinWidth,
            AppDimensions.buttonMinHeight,
          ),
          padding: AppSpacing.symmetric(horizontal: AppSpacing.buttonPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
        ),
      ),

      // Floating action button theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: AppSpacing.elevationMd,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: AppSpacing.all(AppSpacing.inputPadding),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputBorderRadius),
          borderSide: const BorderSide(
            color: AppColors.border,
            width: AppSpacing.borderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputBorderRadius),
          borderSide: const BorderSide(
            color: AppColors.border,
            width: AppSpacing.borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputBorderRadius),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: AppSpacing.borderWidthThick,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputBorderRadius),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: AppSpacing.borderWidth,
          ),
        ),
        labelStyle: AppTypography.body2.copyWith(
          color: AppColors.textSecondary,
        ),
        hintStyle: AppTypography.body2.copyWith(color: AppColors.textHint),
      ),

      // Dialog theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        elevation: AppSpacing.elevationLg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        titleTextStyle: AppTypography.headline6.copyWith(
          color: AppColors.textPrimary,
        ),
        contentTextStyle: AppTypography.body2.copyWith(
          color: AppColors.textPrimary,
        ),
      ),

      // SnackBar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surface,
        contentTextStyle: AppTypography.body2.copyWith(
          color: AppColors.textPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: AppSpacing.elevationMd,
      ),

      // Tab bar theme
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorColor: AppColors.primary,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: AppTypography.button,
        unselectedLabelStyle: AppTypography.button,
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: AppSpacing.borderWidthThin,
        space: AppSpacing.sm,
      ),

      // Progress indicator theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.primaryLight.withOpacity(0.3),
        circularTrackColor: AppColors.primaryLight.withOpacity(0.3),
      ),

      // Icon theme
      iconTheme: IconThemeData(
        color: AppColors.textPrimary,
        size: AppSpacing.iconMd,
      ),

      // Checkbox theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.surface;
        }),
        checkColor: WidgetStateProperty.all(AppColors.textOnPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
        ),
      ),

      // Radio theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.surface;
        }),
      ),

      // Switch theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.surface;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight;
          }
          return AppColors.borderLight;
        }),
      ),
    );
  }

  // Dark theme (can be implemented later)
  static ThemeData dark() {
    return light().copyWith(
      brightness: Brightness.dark,
      // TODO: Implement dark theme colors and overrides
    );
  }

  // Get theme based on brightness
  static ThemeData getTheme({Brightness brightness = Brightness.light}) {
    return brightness == Brightness.dark ? dark() : light();
  }

  // Utility method to get responsive theme
  static ThemeData responsive(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return getTheme(brightness: brightness);
  }
}
