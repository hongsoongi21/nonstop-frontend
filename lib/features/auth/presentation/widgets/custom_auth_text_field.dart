import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nonstop/core/theme/app_colors.dart';

/// Custom text field for authentication screens
///
/// Features:
/// - Fixed size: 275x55
/// - Border radius: 15px
/// - Theme-aware colors for light/dark mode support
/// - Clear text button when field has content (non-password fields)
/// - Password visibility toggle (eye button) for password fields
class CustomAuthTextField extends StatefulWidget {
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
  State<CustomAuthTextField> createState() => _CustomAuthTextFieldState();
}

class _CustomAuthTextFieldState extends State<CustomAuthTextField> {
  late bool _obscureText;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _hasText = widget.controller.text.isNotEmpty;
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = widget.controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

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
    final iconColor = isDarkMode
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
        controller: widget.controller,
        obscureText: _obscureText,
        keyboardType: widget.keyboardType,
        readOnly: widget.readOnly,
        style: TextStyle(
          fontSize: 14.sp,
          color: textColor,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: hintColor,
          ),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  color: AppColors.primary,
                  size: 20.sp,
                )
              : null,
          suffixIcon: _buildSuffixIcon(iconColor),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
        ),
        validator: widget.validator,
      ),
    );
  }

  Widget? _buildSuffixIcon(Color iconColor) {
    // Priority 1: Custom suffix widget (e.g., timer in verification code field)
    if (widget.suffix != null) {
      // If it's a password field with custom suffix, show both toggle and suffix
      if (widget.obscureText && _hasText) {
        return Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildVisibilityToggle(iconColor),
              SizedBox(width: 4.w),
              widget.suffix!,
            ],
          ),
        );
      }
      return Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [widget.suffix!],
        ),
      );
    }

    // Priority 2: Password visibility toggle
    if (widget.obscureText && _hasText) {
      return Padding(
        padding: EdgeInsets.only(right: 4.w),
        child: _buildVisibilityToggle(iconColor),
      );
    }

    // Priority 3: Clear text button (non-password, non-readOnly fields)
    if (_hasText && !widget.obscureText && !widget.readOnly) {
      return Padding(
        padding: EdgeInsets.only(right: 4.w),
        child: GestureDetector(
          onTap: () => widget.controller.clear(),
          child: Icon(
            Icons.cancel_rounded,
            size: 18.sp,
            color: iconColor,
          ),
        ),
      );
    }

    return null;
  }

  Widget _buildVisibilityToggle(Color iconColor) {
    return GestureDetector(
      onTap: () => setState(() => _obscureText = !_obscureText),
      child: Icon(
        _obscureText ? Icons.visibility_off_rounded : Icons.visibility_rounded,
        size: 20.sp,
        color: iconColor,
      ),
    );
  }
}
