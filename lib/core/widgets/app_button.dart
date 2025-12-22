import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// App button widget with consistent styling and states
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.iconPosition = IconPosition.start,
    this.variant = ButtonVariant.filled,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.fullWidth = false,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.elevation,
    this.padding,
  }) : assert(
         !(icon != null && iconPosition == IconPosition.center),
         'Icon cannot be centered when text is present',
       );

  final VoidCallback? onPressed;
  final String text;
  final IconData? icon;
  final IconPosition iconPosition;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final bool fullWidth;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double? elevation;
  final EdgeInsetsGeometry? padding;

  bool get _isDisabled => isDisabled || isLoading || onPressed == null;

  @override
  Widget build(BuildContext context) {
    final button = _buildButton(context);

    if (fullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }

  Widget _buildButton(BuildContext context) {
    final style = _getButtonStyle(context);

    switch (variant) {
      case ButtonVariant.filled:
        return ElevatedButton(
          onPressed: _isDisabled ? null : onPressed,
          style: style,
          child: _buildChild(),
        );

      case ButtonVariant.outlined:
        return OutlinedButton(
          onPressed: _isDisabled ? null : onPressed,
          style: style,
          child: _buildChild(),
        );

      case ButtonVariant.text:
        return TextButton(
          onPressed: _isDisabled ? null : onPressed,
          style: style,
          child: _buildChild(),
        );

      case ButtonVariant.icon:
        return IconButton(
          onPressed: _isDisabled ? null : onPressed,
          icon: _buildIcon(),
          style: style,
          tooltip: text,
        );
    }
  }

  Widget _buildChild() {
    if (variant == ButtonVariant.icon) {
      return _buildIcon();
    }

    if (isLoading) {
      return _buildLoadingChild();
    }

    return _buildNormalChild();
  }

  Widget _buildNormalChild() {
    final children = <Widget>[];

    if (icon != null && iconPosition == IconPosition.start) {
      children.add(_buildIcon());
      children.add(const SizedBox(width: AppSpacing.sm));
    }

    children.add(Text(text));

    if (icon != null && iconPosition == IconPosition.end) {
      children.add(const SizedBox(width: AppSpacing.sm));
      children.add(_buildIcon());
    }

    if (iconPosition == IconPosition.center) {
      return _buildIcon();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildLoadingChild() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size.iconSize * 0.6,
          height: size.iconSize * 0.6,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              foregroundColor ?? AppColors.textOnPrimary,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(text),
      ],
    );
  }

  Widget _buildIcon() {
    return Icon(icon, size: size.iconSize, color: foregroundColor);
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    final baseStyle = _getBaseStyle();

    // Apply size-specific styles
    final sizeStyle = _getSizeStyle();

    // Apply variant-specific styles
    final variantStyle = _getVariantStyle();

    // Merge all styles
    return baseStyle
        .merge(sizeStyle)
        .merge(variantStyle)
        .copyWith(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.border;
            }
            return backgroundColor ?? _getDefaultBackgroundColor();
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.textHint;
            }
            return foregroundColor ?? _getDefaultForegroundColor();
          }),
          side: variant == ButtonVariant.outlined
              ? WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.disabled)) {
                    return const BorderSide(color: AppColors.border);
                  }
                  return BorderSide(
                    color: borderColor ?? _getDefaultBorderColor(),
                  );
                })
              : null,
          elevation: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled) ||
                states.contains(WidgetState.pressed)) {
              return 0;
            }
            if (states.contains(WidgetState.hovered)) {
              return (elevation ?? _getDefaultElevation()) * 1.5;
            }
            return elevation ?? _getDefaultElevation();
          }),
        );
  }

  ButtonStyle _getBaseStyle() {
    return ButtonStyle(
      padding: WidgetStateProperty.all(
        padding ??
            const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppSpacing.radiusMd,
          ),
        ),
      ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      animationDuration: const Duration(milliseconds: 200),
    );
  }

  ButtonStyle _getSizeStyle() {
    return ButtonStyle(
      padding: WidgetStateProperty.all(size.padding),
      textStyle: WidgetStateProperty.all(size.textStyle),
      minimumSize: WidgetStateProperty.all(size.minimumSize),
      tapTargetSize: size.tapTargetSize,
    );
  }

  ButtonStyle _getVariantStyle() {
    switch (variant) {
      case ButtonVariant.filled:
        return ElevatedButton.styleFrom(elevation: _getDefaultElevation());

      case ButtonVariant.outlined:
        return OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor ?? _getDefaultBorderColor()),
        );

      case ButtonVariant.text:
        return TextButton.styleFrom(padding: size.padding);

      case ButtonVariant.icon:
        return IconButton.styleFrom(
          padding: size.padding,
          minimumSize: size.minimumSize,
        );
    }
  }

  Color _getDefaultBackgroundColor() {
    switch (variant) {
      case ButtonVariant.filled:
        return AppColors.primary;
      case ButtonVariant.outlined:
      case ButtonVariant.text:
        return Colors.transparent;
      case ButtonVariant.icon:
        return Colors.transparent;
    }
  }

  Color _getDefaultForegroundColor() {
    switch (variant) {
      case ButtonVariant.filled:
        return AppColors.textOnPrimary;
      case ButtonVariant.outlined:
      case ButtonVariant.text:
      case ButtonVariant.icon:
        return AppColors.primary;
    }
  }

  Color _getDefaultBorderColor() {
    return AppColors.primary;
  }

  double _getDefaultElevation() {
    switch (variant) {
      case ButtonVariant.filled:
        return AppSpacing.elevationSm;
      case ButtonVariant.outlined:
      case ButtonVariant.text:
      case ButtonVariant.icon:
        return 0;
    }
  }
}

/// Button variants
enum ButtonVariant { filled, outlined, text, icon }

/// Button sizes
enum ButtonSize {
  small,
  medium,
  large;

  double get iconSize {
    switch (this) {
      case ButtonSize.small:
        return AppSpacing.iconSm;
      case ButtonSize.medium:
        return AppSpacing.iconMd;
      case ButtonSize.large:
        return AppSpacing.iconLg;
    }
  }

  EdgeInsetsGeometry get padding {
    switch (this) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        );
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        );
      case ButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.lg,
        );
    }
  }

  TextStyle get textStyle {
    switch (this) {
      case ButtonSize.small:
        return AppTypography.button.copyWith(fontSize: 12);
      case ButtonSize.medium:
        return AppTypography.button;
      case ButtonSize.large:
        return AppTypography.button.copyWith(fontSize: 16);
    }
  }

  Size get minimumSize {
    switch (this) {
      case ButtonSize.small:
        return const Size(64, 32);
      case ButtonSize.medium:
        return const Size(80, 40);
      case ButtonSize.large:
        return const Size(96, 48);
    }
  }

  MaterialTapTargetSize get tapTargetSize => MaterialTapTargetSize.shrinkWrap;
}

/// Icon positions
enum IconPosition { start, center, end }

/// Convenience constructors for common button types
class AppButtons {
  /// Primary action button (filled)
  static AppButton primary({
    required VoidCallback? onPressed,
    required String text,
    IconData? icon,
    IconPosition iconPosition = IconPosition.start,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool fullWidth = false,
  }) {
    return AppButton(
      onPressed: onPressed,
      text: text,
      icon: icon,
      iconPosition: iconPosition,
      variant: ButtonVariant.filled,
      size: size,
      isLoading: isLoading,
      fullWidth: fullWidth,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimary,
    );
  }

  /// Secondary action button (outlined)
  static AppButton secondary({
    required VoidCallback? onPressed,
    required String text,
    IconData? icon,
    IconPosition iconPosition = IconPosition.start,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool fullWidth = false,
  }) {
    return AppButton(
      onPressed: onPressed,
      text: text,
      icon: icon,
      iconPosition: iconPosition,
      variant: ButtonVariant.outlined,
      size: size,
      isLoading: isLoading,
      fullWidth: fullWidth,
      foregroundColor: AppColors.primary,
      borderColor: AppColors.primary,
    );
  }

  /// Danger/error button (red filled)
  static AppButton danger({
    required VoidCallback? onPressed,
    required String text,
    IconData? icon,
    IconPosition iconPosition = IconPosition.start,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool fullWidth = false,
  }) {
    return AppButton(
      onPressed: onPressed,
      text: text,
      icon: icon,
      iconPosition: iconPosition,
      variant: ButtonVariant.filled,
      size: size,
      isLoading: isLoading,
      fullWidth: fullWidth,
      backgroundColor: AppColors.error,
      foregroundColor: AppColors.textOnPrimary,
    );
  }

  /// Success button (green filled)
  static AppButton success({
    required VoidCallback? onPressed,
    required String text,
    IconData? icon,
    IconPosition iconPosition = IconPosition.start,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool fullWidth = false,
  }) {
    return AppButton(
      onPressed: onPressed,
      text: text,
      icon: icon,
      iconPosition: iconPosition,
      variant: ButtonVariant.filled,
      size: size,
      isLoading: isLoading,
      fullWidth: fullWidth,
      backgroundColor: AppColors.success,
      foregroundColor: AppColors.textOnPrimary,
    );
  }

  /// Icon-only button
  static AppButton icon({
    required VoidCallback? onPressed,
    required IconData icon,
    required String tooltip,
    ButtonSize size = ButtonSize.medium,
    Color? color,
  }) {
    return AppButton(
      onPressed: onPressed,
      text: tooltip,
      icon: icon,
      variant: ButtonVariant.icon,
      size: size,
      foregroundColor: color,
    );
  }
}
