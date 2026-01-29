import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Custom text field for authentication screens
///
/// Features:
/// - Fixed size: 275x55
/// - Border radius: 15px
/// - Background color: #E9F0FE
/// - White border
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
    return Container(
      width: 275.w,
      height: 55.h,
      decoration: BoxDecoration(
        color: const Color(0xFFE9F0FE),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: const Color(0xFFFFFFFF),
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
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: Colors.black.withValues(alpha: 0.5),
          ),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: const Color(0xFF7C3BEE), // #7C3BEE
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
