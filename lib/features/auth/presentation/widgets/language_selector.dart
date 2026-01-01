import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Language selector widget for authentication screens
///
/// Displays three language options: UZ | RU | EN
/// with vertical dividers between them.
///
/// Features:
/// - Fixed size: 233x43
/// - Border radius: 12px
/// - White background with gray border
class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 233.w,
      height: 43.h,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLanguageButton('UZ', () {
            // TODO: 우즈베크어로 언어 변경
          }),
          _buildDivider(),
          _buildLanguageButton('RU', () {
            // TODO: 러시아어로 언어 변경
          }),
          _buildDivider(),
          _buildLanguageButton('EN', () {
            // TODO: 영어로 언어 변경
          }),
        ],
      ),
    );
  }

  Widget _buildLanguageButton(String label, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF111827),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1.w,
      height: 20.h,
      color: const Color(0xFFE0E0E0),
    );
  }
}
