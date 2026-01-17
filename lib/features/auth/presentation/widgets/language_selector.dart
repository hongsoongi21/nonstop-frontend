import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Language selector widget for authentication screens
///
/// Displays three language options: O'zbek | Pyccknn | English
/// with vertical dividers between them.
///
/// Features:
/// - Fixed size: 233x43
/// - Border radius: 12px
/// - White background with gray border
class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String _selectedLanguage = 'O\'zbek'; // Initial active language

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
          _buildLanguageButton('O\'zbek'),
          _buildDivider(),
          _buildLanguageButton('Pyccknn'),
          _buildDivider(),
          _buildLanguageButton('English'),
        ],
      ),
    );
  }

  Widget _buildLanguageButton(String language) {
    final bool isActive = _selectedLanguage == language;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = language;
          // TODO: 실제 언어 변경 로직 추가
        });
      },
      child: Container(
        width: 65.w,
        height: 28.h,
        alignment: Alignment.center,
        decoration: isActive
            ? BoxDecoration(
                color: const Color(0xFF7C39ED),
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF000000).withOpacity(0.25),
                    blurRadius: 4.r,
                    offset: Offset(0, 1.h),
                  ),
                ],
              )
            : null,
        child: Text(
          language,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: isActive ? Colors.white : const Color(0xFF111827),
          ),
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
