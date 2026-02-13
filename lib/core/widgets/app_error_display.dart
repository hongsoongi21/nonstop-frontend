import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../extensions/context_extensions.dart';
import 'app_animations.dart';

/// Error display widget with "Samarkand Modern" aesthetic
/// Provides clear error feedback with recovery actions
class AppErrorDisplay extends StatelessWidget {
  final String title;
  final String? message;
  final IconData? icon;
  final ErrorSeverity severity;
  final String? actionText;
  final VoidCallback? onAction;
  final String? secondaryActionText;
  final VoidCallback? onSecondaryAction;
  final EdgeInsetsGeometry? padding;
  final bool animate;
  final bool showDetails;
  final String? technicalDetails;

  const AppErrorDisplay({
    super.key,
    required this.title,
    this.message,
    this.icon,
    this.severity = ErrorSeverity.error,
    this.actionText,
    this.onAction,
    this.secondaryActionText,
    this.onSecondaryAction,
    this.padding,
    this.animate = true,
    this.showDetails = false,
    this.technicalDetails,
  });

  /// Named constructor for network errors
  const AppErrorDisplay.network({
    super.key,
    this.title = 'Connection Error',
    this.message = 'Unable to connect to the server. Please check your internet connection.',
    this.actionText = 'Retry',
    this.onAction,
    this.padding,
  })  : icon = Icons.wifi_off_rounded,
        severity = ErrorSeverity.error,
        secondaryActionText = null,
        onSecondaryAction = null,
        animate = true,
        showDetails = false,
        technicalDetails = null;

  /// Named constructor for not found errors
  const AppErrorDisplay.notFound({
    super.key,
    this.title = 'Not Found',
    this.message = 'The content you\'re looking for could not be found.',
    this.actionText = 'Go Back',
    this.onAction,
    this.padding,
  })  : icon = Icons.search_off_rounded,
        severity = ErrorSeverity.warning,
        secondaryActionText = null,
        onSecondaryAction = null,
        animate = true,
        showDetails = false,
        technicalDetails = null;

  /// Named constructor for permission errors
  const AppErrorDisplay.permission({
    super.key,
    this.title = 'Access Denied',
    this.message = 'You don\'t have permission to access this content.',
    this.actionText = 'Contact Support',
    this.onAction,
    this.padding,
  })  : icon = Icons.lock_outline_rounded,
        severity = ErrorSeverity.error,
        secondaryActionText = null,
        onSecondaryAction = null,
        animate = true,
        showDetails = false,
        technicalDetails = null;

  /// Named constructor for server errors
  const AppErrorDisplay.server({
    super.key,
    this.title = 'Server Error',
    this.message = 'Something went wrong on our end. Please try again later.',
    this.actionText = 'Retry',
    this.onAction,
    this.technicalDetails,
    this.padding,
  })  : icon = Icons.cloud_off_rounded,
        severity = ErrorSeverity.critical,
        secondaryActionText = null,
        onSecondaryAction = null,
        animate = true,
        showDetails = false;

  Color _getSeverityColor() {
    switch (severity) {
      case ErrorSeverity.info:
        return AppColors.info;
      case ErrorSeverity.warning:
        return AppColors.warning;
      case ErrorSeverity.error:
        return AppColors.error;
      case ErrorSeverity.critical:
        return AppColors.errorDark;
    }
  }

  IconData _getDefaultIcon() {
    switch (severity) {
      case ErrorSeverity.info:
        return Icons.info_outline_rounded;
      case ErrorSeverity.warning:
        return Icons.warning_amber_rounded;
      case ErrorSeverity.error:
        return Icons.error_outline_rounded;
      case ErrorSeverity.critical:
        return Icons.dangerous_outlined;
    }
  }

  Widget _buildContent(BuildContext context) {
    final severityColor = _getSeverityColor();
    final displayIcon = icon ?? _getDefaultIcon();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Error icon with dramatic circular background
        _buildErrorIcon(context, displayIcon, severityColor),

        SizedBox(height: AppSpacing.xl),

        // Title with emphasis
        Text(
          title,
          style: AppTypography.headline3.copyWith(
            color: severityColor,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),

        // Message
        if (message != null) ...[
          SizedBox(height: AppSpacing.md),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Text(
              message!,
              style: AppTypography.body1.copyWith(
                color: context.textSecondaryColor,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],

        // Technical details (expandable)
        if (showDetails && technicalDetails != null) ...[
          SizedBox(height: AppSpacing.lg),
          _buildTechnicalDetails(context),
        ],

        // Action buttons
        if (actionText != null && onAction != null) ...[
          SizedBox(height: AppSpacing.xl),
          _buildActionButtons(context, severityColor),
        ],
      ],
    );
  }

  Widget _buildErrorIcon(BuildContext context, IconData displayIcon, Color severityColor) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        // Dramatic radial gradient
        gradient: RadialGradient(
          colors: [
            severityColor.withValues(alpha: 0.2),
            severityColor.withValues(alpha: 0.05),
            Colors.transparent,
          ],
          stops: const [0.3, 0.7, 1.0],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer ring with pulse effect
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: severityColor.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
          ),
          // Inner circle
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: severityColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              displayIcon,
              size: 44,
              color: severityColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicalDetails(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.surfaceVariantColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.code_rounded,
                size: 16,
                color: context.textTertiaryColor,
              ),
              SizedBox(width: AppSpacing.xs),
              Text(
                'Technical Details',
                style: AppTypography.caption.copyWith(
                  color: context.textTertiaryColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            technicalDetails!,
            style: AppTypography.code.copyWith(
              color: context.textSecondaryColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, Color severityColor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        children: [
          // Primary action button
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [severityColor, severityColor.withValues(alpha: 0.85)],
              ),
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              boxShadow: [
                BoxShadow(
                  color: severityColor.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onAction,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.refresh_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                      SizedBox(width: AppSpacing.sm),
                      Text(
                        actionText!,
                        style: AppTypography.button.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Secondary action button
          if (secondaryActionText != null && onSecondaryAction != null) ...[
            SizedBox(height: AppSpacing.md),
            TextButton(
              onPressed: onSecondaryAction,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
              ),
              child: Text(
                secondaryActionText!,
                style: AppTypography.button.copyWith(
                  color: severityColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = _buildContent(context);

    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.all(AppSpacing.xxl),
      child: animate
          ? AppAnimations.fadeSlideIn(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              startOffset: 40,
              child: content,
            )
          : content,
    );
  }
}

/// Error severity levels
enum ErrorSeverity {
  info,
  warning,
  error,
  critical,
}

/// Inline error banner for form validation and contextual errors
class AppErrorBanner extends StatelessWidget {
  final String message;
  final ErrorSeverity severity;
  final VoidCallback? onDismiss;
  final IconData? icon;
  final EdgeInsetsGeometry? margin;

  const AppErrorBanner({
    super.key,
    required this.message,
    this.severity = ErrorSeverity.error,
    this.onDismiss,
    this.icon,
    this.margin,
  });

  Color _getSeverityColor() {
    switch (severity) {
      case ErrorSeverity.info:
        return AppColors.info;
      case ErrorSeverity.warning:
        return AppColors.warning;
      case ErrorSeverity.error:
        return AppColors.error;
      case ErrorSeverity.critical:
        return AppColors.errorDark;
    }
  }

  @override
  Widget build(BuildContext context) {
    final severityColor = _getSeverityColor();

    return Container(
      margin: margin ?? EdgeInsets.all(AppSpacing.md),
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: severityColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: severityColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon ?? Icons.error_outline_rounded,
            color: severityColor,
            size: 20,
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              message,
              style: AppTypography.body2.copyWith(
                color: severityColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (onDismiss != null) ...[
            SizedBox(width: AppSpacing.sm),
            IconButton(
              icon: Icon(Icons.close_rounded, size: 18),
              color: severityColor,
              onPressed: onDismiss,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ],
      ),
    );
  }
}
