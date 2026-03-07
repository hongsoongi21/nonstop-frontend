import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Gradient button for authentication screens
///
/// Features:
/// - Fixed size: 275x55
/// - Border radius: 15px
/// - Gradient background: #7C3BEE → #B95686 → #F5711E
/// - Box shadow with #7C3BEE color
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final String? semanticsId;

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.semanticsId,
  });

  @override
  Widget build(BuildContext context) {
    Widget button = Container(
      width: 275.w,
      height: 55.h,
      decoration: BoxDecoration(
        color: onPressed == null ? AppColors.primary.withValues(alpha: 0.5) : AppColors.primary,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            offset: Offset(0, 8.h),
            blurRadius: 10.r,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading
              ? null
              : () {
                  HapticFeedback.lightImpact();
                  onPressed?.call();
                },
          borderRadius: BorderRadius.circular(15.r),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: const CircularProgressIndicator(
                      color: AppColors.textOnPrimary,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    text,
                    style: AppTypography.body1.copyWith(
                      color: AppColors.textOnPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
          ),
        ),
      ),
    );

    if (semanticsId != null) {
      button = Semantics(
        identifier: semanticsId,
        child: button,
      );
    }

    return button;
  }
}
