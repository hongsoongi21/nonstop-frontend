import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/timetable_provider.dart';

/// Header widget for calendar views with navigation controls
class CalendarHeader extends StatelessWidget {
  final CalendarViewType viewType;
  final DateTime focusedDate;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onToday;

  const CalendarHeader({
    super.key,
    required this.viewType,
    required this.focusedDate,
    required this.onPrevious,
    required this.onNext,
    required this.onToday,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
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
              _getDateTitle(),
              style: AppTypography.headlineSmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(width: AppSpacing.md),

          // Today button
          TextButton(
            onPressed: onToday,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              backgroundColor: AppColors.primary.withOpacity(0.1),
              foregroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Today',
              style: AppTypography.labelMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getDateTitle() {
    switch (viewType) {
      case CalendarViewType.month:
        return DateFormat('MMMM yyyy').format(focusedDate);
      case CalendarViewType.week:
        final weekStart = focusedDate.subtract(Duration(days: focusedDate.weekday - 1));
        final weekEnd = weekStart.add(const Duration(days: 6));
        if (weekStart.month == weekEnd.month) {
          return '${DateFormat('MMM d').format(weekStart)} - ${DateFormat('d, yyyy').format(weekEnd)}';
        } else {
          return '${DateFormat('MMM d').format(weekStart)} - ${DateFormat('MMM d, yyyy').format(weekEnd)}';
        }
      case CalendarViewType.day:
        return DateFormat('EEEE, MMMM d, yyyy').format(focusedDate);
      case CalendarViewType.schedule:
        return DateFormat('MMMM yyyy').format(focusedDate);
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
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.surfaceSecondary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 20,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

/// View type selector widget
class ViewTypeSelector extends StatelessWidget {
  final CalendarViewType selectedViewType;
  final ValueChanged<CalendarViewType> onViewTypeChanged;

  const ViewTypeSelector({
    super.key,
    required this.selectedViewType,
    required this.onViewTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.xxs),
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: CalendarViewType.values.map((viewType) {
          final isSelected = viewType == selectedViewType;
          return InkWell(
            onTap: () => onViewTypeChanged(viewType),
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xxs,
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                _getViewTypeLabel(viewType),
                style: AppTypography.labelSmall.copyWith(
                  color: isSelected ? AppColors.surface : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _getViewTypeLabel(CalendarViewType viewType) {
    switch (viewType) {
      case CalendarViewType.month:
        return 'Month';
      case CalendarViewType.week:
        return 'Week';
      case CalendarViewType.day:
        return 'Day';
      case CalendarViewType.schedule:
        return 'Schedule';
    }
  }
}
