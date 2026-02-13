import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/providers/locale_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Language selector widget for authentication screens
///
/// Displays language options: O'zbek | Русский | English
/// with vertical dividers between them.
///
/// Features:
/// - Persists language preference
/// - Updates app locale via Riverpod provider
/// - Samarkand Modern design styling
class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);

    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        color: context.surfaceColor,
        border: Border.all(
          color: context.borderColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLanguageButton(
            context,
            ref,
            AppLocale.uzbek,
            currentLocale.languageCode == 'uz',
            isFirst: true,
          ),
          _buildDivider(),
          _buildLanguageButton(
            context,
            ref,
            AppLocale.russian,
            currentLocale.languageCode == 'ru',
          ),
          _buildDivider(),
          _buildLanguageButton(
            context,
            ref,
            AppLocale.english,
            currentLocale.languageCode == 'en',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageButton(
    BuildContext context,
    WidgetRef ref,
    Locale locale,
    bool isActive, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    return GestureDetector(
      onTap: () {
        ref.read(localeStateProvider.notifier).setLocale(locale);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        margin: EdgeInsets.symmetric(vertical: 6.h),
        decoration: isActive
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primaryLight,
                  ],
                ),
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              )
            : null,
        alignment: Alignment.center,
        child: Text(
          AppLocale.getShortName(locale),
          style: AppTypography.bodySmall.copyWith(
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            color: isActive ? Colors.white : context.textSecondaryColor,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Builder(
      builder: (context) => Container(
        width: 1,
        height: 20.h,
        color: context.borderColor,
      ),
    );
  }
}
