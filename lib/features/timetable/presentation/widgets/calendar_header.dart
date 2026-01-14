import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/components/glass_container.dart';

/// Simplified header widget for weekly calendar view
class WeekCalendarHeader extends StatelessWidget {
  final DateTime focusedDate;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onToday;

  const WeekCalendarHeader({
    super.key,
    required this.focusedDate,
    required this.onPrevious,
    required this.onNext,
    required this.onToday,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderColor: Colors.transparent,
      child: Row(
        children: [
          // Navigation buttons
          Row(
            children: [
              _NavigationButton(
                icon: Icons.chevron_left,
                onPressed: onPrevious,
              ),
              SizedBox(width: AppSpacing.sm),
              _NavigationButton(
                icon: Icons.chevron_right,
                onPressed: onNext,
              ),
            ],
          ),

          SizedBox(width: AppSpacing.md),

          // Date title
          Expanded(
            child: Text(
              _getWeekTitle(),
              style: AppTypography.headlineSmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(width: AppSpacing.md),

          // Today button
          GestureDetector(
            onTap: onToday,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: AppColors.brandGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7C3BEE).withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'Today',
                style: AppTypography.labelMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getWeekTitle() {
    final weekStart = focusedDate.subtract(Duration(days: focusedDate.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 6));
    if (weekStart.month == weekEnd.month) {
      return '${DateFormat('MMMM d').format(weekStart)} - ${DateFormat('d, yyyy').format(weekEnd)}';
    } else {
      return '${DateFormat('MMM d').format(weekStart)} - ${DateFormat('MMM d, yyyy').format(weekEnd)}';
    }
  }
}

/// Navigation button widget
class _NavigationButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _NavigationButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 22,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

