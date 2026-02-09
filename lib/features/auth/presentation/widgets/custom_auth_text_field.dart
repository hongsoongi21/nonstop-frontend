import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nonstop/core/theme/app_colors.dart';

/// Custom text field for authentication screens
///
/// Features:
/// - Fixed size: 275x55
/// - Border radius: 15px
/// - Theme-aware colors for light/dark mode support
class CustomAuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool readOnly;
  final Widget? suffix;

  const CustomAuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.readOnly = false,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Theme-aware colors
    final backgroundColor = isDarkMode
        ? AppColors.authFieldBackgroundDark
        : AppColors.authFieldBackground;
    final borderColor = isDarkMode
        ? AppColors.authFieldBorderDark
        : AppColors.authFieldBorder;
    final textColor = isDarkMode
        ? AppColors.authFieldTextDark
        : AppColors.authFieldText;
    final hintColor = isDarkMode
        ? AppColors.authFieldHintDark
        : AppColors.authFieldHint;

    return Container(
      width: 275.w,
      height: 55.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: borderColor,
          width: 1.w,
        ),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        readOnly: readOnly,
        style: TextStyle(
          fontSize: 14.sp,
          color: textColor,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: hintColor,
          ),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: AppColors.primary,
                  size: 20.sp,
                )
              : null,
          suffixIcon: suffix != null
              ? Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      suffix!,
                    ],
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
        ),
        validator: validator,
      ),
    );
  }
}
