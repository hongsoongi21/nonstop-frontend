import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_typography.dart';
import 'app_spacing.dart';

/// Application Theme - "Samarkand Modern" Design System
/// Clean, professional, and culturally inspired design for Uzbek university students
class AppTheme {
  // ═══════════════════════════════════════════════════════════════════════════
  // LIGHT THEME
  // ═══════════════════════════════════════════════════════════════════════════

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // ─────────────────────────────────────────────────────────────────────────
      // COLOR SCHEME
      // ─────────────────────────────────────────────────────────────────────────
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.textOnPrimary,
        primaryContainer: AppColors.primaryLight,
        onPrimaryContainer: AppColors.primaryDark,

        secondary: AppColors.secondary,
        onSecondary: AppColors.textOnSecondary,
        secondaryContainer: AppColors.secondaryLight,
        onSecondaryContainer: AppColors.secondaryDark,

        tertiary: AppColors.tertiary,
        onTertiary: Colors.white,
        tertiaryContainer: AppColors.tertiaryLight,
        onTertiaryContainer: AppColors.tertiaryDark,

        error: AppColors.error,
        onError: Colors.white,
        errorContainer: AppColors.errorLight,
        onErrorContainer: AppColors.errorDark,

        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        surfaceContainerHighest: AppColors.surfaceVariant,
        onSurfaceVariant: AppColors.textSecondary,

        outline: AppColors.border,
        outlineVariant: AppColors.borderLight,

        shadow: AppColors.shadow,
        scrim: AppColors.overlay,

        inverseSurface: AppColors.backgroundDark,
        onInverseSurface: AppColors.textPrimaryDark,
        inversePrimary: AppColors.primaryLight,

        surfaceTint: AppColors.primary,
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // TYPOGRAPHY
      // ─────────────────────────────────────────────────────────────────────────
      fontFamily: AppTypography.fontFamily,
      textTheme: AppTypography.createTextTheme(
        displayColor: AppColors.textPrimary,
        headlineColor: AppColors.textPrimary,
        titleColor: AppColors.textPrimary,
        bodyColor: AppColors.textPrimary,
        labelColor: AppColors.textSecondary,
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // APP BAR
      // ─────────────────────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: AppColors.shadow,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: AppTypography.headline4.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.textPrimary,
          size: 24,
        ),
        actionsIconTheme: const IconThemeData(
          color: AppColors.textSecondary,
          size: 24,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // SCAFFOLD
      // ─────────────────────────────────────────────────────────────────────────
      scaffoldBackgroundColor: AppColors.background,

      // ─────────────────────────────────────────────────────────────────────────
      // CARD
      // ─────────────────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: AppColors.cardBackground,
        shadowColor: AppColors.shadowMedium,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // BUTTONS
      // ─────────────────────────────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          disabledBackgroundColor: AppColors.border,
          disabledForegroundColor: AppColors.textTertiary,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          minimumSize: const Size(64, 48),
          textStyle: AppTypography.button,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.textTertiary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          minimumSize: const Size(64, 48),
          textStyle: AppTypography.button,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.textTertiary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          minimumSize: const Size(48, 40),
          textStyle: AppTypography.button,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          disabledBackgroundColor: AppColors.border,
          disabledForegroundColor: AppColors.textTertiary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          minimumSize: const Size(64, 48),
          textStyle: AppTypography.button,
        ),
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // INPUT DECORATION
      // ─────────────────────────────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        hoverColor: AppColors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        hintStyle: AppTypography.body2.copyWith(color: AppColors.textHint),
        labelStyle: AppTypography.body2.copyWith(color: AppColors.textSecondary),
        floatingLabelStyle: AppTypography.caption.copyWith(color: AppColors.primary),
        errorStyle: AppTypography.caption.copyWith(color: AppColors.error),
        helperStyle: AppTypography.caption.copyWith(color: AppColors.textTertiary),
        prefixIconColor: AppColors.textSecondary,
        suffixIconColor: AppColors.textSecondary,
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // BOTTOM NAVIGATION BAR
      // ─────────────────────────────────────────────────────────────────────────
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: AppTypography.captionSmall.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: AppTypography.captionSmall,
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // NAVIGATION BAR (Material 3)
      // ─────────────────────────────────────────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primary.withValues(alpha: 0.12),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: 72,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTypography.captionSmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            );
          }
          return AppTypography.captionSmall.copyWith(color: AppColors.textTertiary);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primary, size: 24);
          }
          return const IconThemeData(color: AppColors.textTertiary, size: 24);
        }),
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // TAB BAR
      // ─────────────────────────────────────────────────────────────────────────
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorColor: AppColors.primary,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: AppTypography.button.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: AppTypography.button,
        dividerColor: AppColors.border,
        overlayColor: WidgetStateProperty.all(AppColors.ripple),
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // FLOATING ACTION BUTTON
      // ─────────────────────────────────────────────────────────────────────────
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 4,
        focusElevation: 6,
        hoverElevation: 8,
        highlightElevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // DIALOG
      // ─────────────────────────────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        elevation: 8,
        shadowColor: AppColors.shadowStrong,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        ),
        titleTextStyle: AppTypography.headline4.copyWith(color: AppColors.textPrimary),
        contentTextStyle: AppTypography.body2.copyWith(color: AppColors.textSecondary),
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // BOTTOM SHEET
      // ─────────────────────────────────────────────────────────────────────────
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        modalBackgroundColor: AppColors.surface,
        elevation: 8,
        shadowColor: AppColors.shadowStrong,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
        ),
        showDragHandle: true,
        dragHandleColor: AppColors.border,
        dragHandleSize: const Size(40, 4),
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // SNACK BAR
      // ─────────────────────────────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.backgroundDark,
        contentTextStyle: AppTypography.body2.copyWith(color: AppColors.textPrimaryDark),
        actionTextColor: AppColors.tertiaryLight,
        elevation: 4,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // CHIP
      // ─────────────────────────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceVariant,
        selectedColor: AppColors.primary.withValues(alpha: 0.15),
        secondarySelectedColor: AppColors.secondary.withValues(alpha: 0.15),
        checkmarkColor: AppColors.primary,
        deleteIconColor: AppColors.textSecondary,
        labelStyle: AppTypography.label.copyWith(color: AppColors.textPrimary),
        secondaryLabelStyle: AppTypography.label.copyWith(color: AppColors.textOnPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // LIST TILE
      // ─────────────────────────────────────────────────────────────────────────
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        tileColor: Colors.transparent,
        selectedTileColor: AppColors.primary.withValues(alpha: 0.08),
        iconColor: AppColors.textSecondary,
        textColor: AppColors.textPrimary,
        titleTextStyle: AppTypography.body1.copyWith(color: AppColors.textPrimary),
        subtitleTextStyle: AppTypography.body2.copyWith(color: AppColors.textSecondary),
        leadingAndTrailingTextStyle: AppTypography.caption.copyWith(color: AppColors.textTertiary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // DIVIDER
      // ─────────────────────────────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // SWITCH / CHECKBOX / RADIO
      // ─────────────────────────────────────────────────────────────────────────
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return AppColors.textTertiary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary.withValues(alpha: 0.5);
          return AppColors.border;
        }),
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColors.textOnPrimary),
        side: const BorderSide(color: AppColors.border, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
      ),

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return AppColors.border;
        }),
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // PROGRESS INDICATORS
      // ─────────────────────────────────────────────────────────────────────────
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.borderLight,
        circularTrackColor: AppColors.borderLight,
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // ICON
      // ─────────────────────────────────────────────────────────────────────────
      iconTheme: const IconThemeData(
        color: AppColors.textSecondary,
        size: 24,
      ),

      primaryIconTheme: const IconThemeData(
        color: AppColors.textOnPrimary,
        size: 24,
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // TOOLTIP
      // ─────────────────────────────────────────────────────────────────────────
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.backgroundDark,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        textStyle: AppTypography.caption.copyWith(color: AppColors.textPrimaryDark),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // PAGE TRANSITIONS
      // ─────────────────────────────────────────────────────────────────────────
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DARK THEME
  // ═══════════════════════════════════════════════════════════════════════════

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight,
        onPrimary: AppColors.primaryDark,
        primaryContainer: AppColors.primary,
        onPrimaryContainer: AppColors.textOnPrimary,

        secondary: AppColors.secondary,
        onSecondary: AppColors.textOnSecondary,
        secondaryContainer: AppColors.secondaryDark,
        onSecondaryContainer: AppColors.secondaryLight,

        tertiary: AppColors.tertiaryLight,
        onTertiary: AppColors.tertiaryDark,
        tertiaryContainer: AppColors.tertiary,
        onTertiaryContainer: Colors.white,

        error: AppColors.error,
        onError: Colors.white,
        errorContainer: AppColors.errorDark,
        onErrorContainer: AppColors.errorLight,

        surface: AppColors.surfaceDark,
        onSurface: AppColors.textPrimaryDark,
        surfaceContainerHighest: AppColors.surfaceVariantDark,
        onSurfaceVariant: AppColors.textSecondaryDark,

        outline: AppColors.borderDark,
        outlineVariant: AppColors.borderLightDark,

        shadow: Color(0xFF000000),
        scrim: Color(0xFF000000),

        inverseSurface: AppColors.surface,
        onInverseSurface: AppColors.textPrimary,
        inversePrimary: AppColors.primary,

        surfaceTint: AppColors.primaryLight,
      ),

      fontFamily: AppTypography.fontFamily,
      textTheme: AppTypography.createTextTheme(
        displayColor: AppColors.textPrimaryDark,
        headlineColor: AppColors.textPrimaryDark,
        titleColor: AppColors.textPrimaryDark,
        bodyColor: AppColors.textPrimaryDark,
        labelColor: AppColors.textSecondaryDark,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: AppColors.textPrimaryDark,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: const Color(0xFF000000),
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: AppTypography.headline4.copyWith(
          color: AppColors.textPrimaryDark,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimaryDark, size: 24),
        actionsIconTheme: const IconThemeData(color: AppColors.textSecondaryDark, size: 24),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      scaffoldBackgroundColor: AppColors.backgroundDark,

      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        shadowColor: const Color(0xFF000000),
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          side: const BorderSide(color: AppColors.borderDark, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceVariantDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        hintStyle: AppTypography.body2.copyWith(color: AppColors.textTertiaryDark),
        labelStyle: AppTypography.body2.copyWith(color: AppColors.textSecondaryDark),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.textTertiaryDark,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: AppTypography.captionSmall.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: AppTypography.captionSmall,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceDark,
        elevation: 8,
        shadowColor: const Color(0xFF000000),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceVariantDark,
        selectedColor: AppColors.primaryLight.withValues(alpha: 0.2),
        checkmarkColor: AppColors.primaryLight,
        labelStyle: AppTypography.label.copyWith(color: AppColors.textPrimaryDark),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        ),
        side: BorderSide.none,
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.borderDark,
        thickness: 1,
        space: 1,
      ),

      iconTheme: const IconThemeData(
        color: AppColors.textSecondaryDark,
        size: 24,
      ),

      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // UTILITY
  // ═══════════════════════════════════════════════════════════════════════════

  static ThemeData getTheme({Brightness brightness = Brightness.light}) {
    return brightness == Brightness.dark ? darkTheme : lightTheme;
  }
}
