import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 275.w,
      height: 55.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.3942, 0.75, 1.0],
          colors: [
            Color(0xFF7C3BEE), // #7C3BEE at 39.42%
            Color(0xFFB95686), // #B95686 at 75%
            Color(0xFFF5711E), // #F5711E at 100%
          ],
        ),
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C3BEE).withValues(alpha: 0.2), // #7C3BEE33
            offset: Offset(0, 8.h),
            blurRadius: 10.r,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(15.r),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    text,
                    style: AppTypography.body1.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
