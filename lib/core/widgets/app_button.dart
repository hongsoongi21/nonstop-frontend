import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Enhanced button component with multiple variants and states
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.leadingIcon,
    this.trailingIcon,
    this.width,
    this.padding,
  });

  bool get _isDisabled => isDisabled || isLoading || onPressed == null;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _getButtonStyle(context);

    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: _isDisabled ? null : onPressed,
        style: buttonStyle,
        child: _buildContent(),
      ),
    );
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    final baseStyle = ElevatedButton.styleFrom(
      padding: padding ?? _getPadding(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      elevation: 0,
      shadowColor: Colors.transparent,
      textStyle: _getTextStyle(),
    );

    switch (variant) {
      case ButtonVariant.primary:
        return baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (_isDisabled) return AppColors.primary.withValues(alpha: 0.5);
            if (states.contains(WidgetState.pressed))
              return AppColors.primaryDark;
            return AppColors.primary;
          }),
          foregroundColor: WidgetStateProperty.all(AppColors.textOnPrimary),
        );

      case ButtonVariant.secondary:
        return baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (_isDisabled) return AppColors.surface.withValues(alpha: 0.5);
            return AppColors.surface;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (_isDisabled)
              return AppColors.textSecondary.withValues(alpha: 0.5);
            return AppColors.textPrimary;
          }),
          side: WidgetStateProperty.all(
            const BorderSide(color: AppColors.border, width: 1.5),
          ),
        );

      case ButtonVariant.outline:
        return baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (_isDisabled) return AppColors.primary.withValues(alpha: 0.5);
            return AppColors.primary;
          }),
          side: WidgetStateProperty.all(
            BorderSide(
              color: _isDisabled
                  ? AppColors.primary.withValues(alpha: 0.5)
                  : AppColors.primary,
              width: 1.5,
            ),
          ),
        );

      case ButtonVariant.ghost:
        return baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (_isDisabled)
              return AppColors.textSecondary.withValues(alpha: 0.5);
            return AppColors.textSecondary;
          }),
          elevation: WidgetStateProperty.all(0),
        );

      case ButtonVariant.danger:
        return baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (_isDisabled) return AppColors.error.withValues(alpha: 0.5);
            if (states.contains(WidgetState.pressed))
              return AppColors.error.withValues(alpha: 0.8);
            return AppColors.error;
          }),
          foregroundColor: WidgetStateProperty.all(Colors.white),
        );
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (size) {
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

  TextStyle _getTextStyle() {
    switch (size) {
      case ButtonSize.small:
        return AppTypography.button.copyWith(fontSize: 14);
      case ButtonSize.medium:
        return AppTypography.button;
      case ButtonSize.large:
        return AppTypography.button.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        );
    }
  }

  Widget _buildContent() {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            variant == ButtonVariant.primary || variant == ButtonVariant.danger
                ? AppColors.textOnPrimary
                : AppColors.primary,
          ),
        ),
      );
    }

    final children = <Widget>[];

    if (leadingIcon != null) {
      children.add(Icon(leadingIcon, size: _getIconSize()));
      children.add(const SizedBox(width: AppSpacing.sm));
    }

    children.add(Flexible(child: Text(text)));

    if (trailingIcon != null) {
      children.add(const SizedBox(width: AppSpacing.sm));
      children.add(Icon(trailingIcon, size: _getIconSize()));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  double _getIconSize() {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 18;
      case ButtonSize.large:
        return 20;
    }
  }
}

/// Button variants
enum ButtonVariant { primary, secondary, outline, ghost, danger }

/// Button sizes
enum ButtonSize { small, medium, large }

/// Social login button for OAuth providers
class SocialButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback? onPressed;
  final bool isLoading;

  const SocialButton({
    super.key,
    required this.text,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 20),
                  const SizedBox(width: AppSpacing.sm),
                  Text(text, style: AppTypography.button),
                ],
              ),
      ),
    );
  }
}

/// Icon button with better styling
class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool isLoading;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.size = 24,
    this.backgroundColor,
    this.iconColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Theme.of(context).colorScheme.surface;
    final icColor = iconColor ?? Theme.of(context).colorScheme.onSurface;

    return Container(
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: IconButton(
        onPressed: isLoading ? null : onPressed,
        tooltip: tooltip,
        iconSize: size,
        padding: const EdgeInsets.all(AppSpacing.sm),
        icon: isLoading
            ? SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(icColor),
                ),
              )
            : Icon(icon, color: icColor),
      ),
    );
  }
}
