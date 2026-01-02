import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nonstop/core/constants/routes.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/components/glass_container.dart';
import '../providers/timetable_provider.dart';
import '../providers/gpa_provider.dart';
import '../widgets/weekly_time_grid.dart';

/// Main timetable screen with calendar views
class TimetableScreen extends ConsumerWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(timetableProvider);
    final notifier = ref.read(timetableProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.background,
              AppColors.primary.withValues(alpha: 0.05),
              AppColors.secondary.withValues(alpha: 0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Simplified header like everytime app
              Padding(
                padding: EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '2026-겨울',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              'Dars jadvali',
                              style: AppTypography.headlineSmall.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.textPrimary,
                              size: 24,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () => _showCreateEventDialog(context, ref),
                      icon: Icon(Icons.add, color: AppColors.textPrimary),
                      tooltip: 'Yangi tadbir qo\'shish',
                    ),
                    IconButton(
                      onPressed: () => _showSearchDialog(context, ref),
                      icon: Icon(Icons.settings_outlined, color: AppColors.textPrimary),
                      tooltip: 'Sozlamalar',
                    ),
                    IconButton(
                      onPressed: () => notifier.navigateToToday(),
                      icon: Icon(Icons.refresh, color: AppColors.textPrimary),
                      tooltip: 'Yangilash',
                    ),
                  ],
                ),
              ),

              // Weekly time grid
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: WeeklyTimeGrid(
                    focusedDate: state.focusedDate,
                    selectedDate: state.selectedDate,
                    events: state.eventsForFocusedWeek,
                  ),
                ),
              ),

              SizedBox(height: AppSpacing.md),

              // GPA Calculator section (like everytime app)
              _buildGPACalculator(context, ref),

              SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGPACalculator(BuildContext context, WidgetRef ref) {
    final gpaState = ref.watch(gpaProvider);
    final hasCourses = gpaState.courses.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: GestureDetector(
        onTap: () => context.go(Routes.gpaCalculator),
        child: GlassContainer(
          borderColor: Colors.transparent,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Grade Calculator',
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    hasCourses 
                      ? 'Current GPA: ${gpaState.totalGpa.toStringAsFixed(2)} (${gpaState.totalCredits.toStringAsFixed(0)} credits)'
                      : 'Calculate your GPA',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Spacer(),
              if (hasCourses)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    gpaState.totalGpa.toStringAsFixed(2),
                    style: AppTypography.titleSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              else
                Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateEventDialog(BuildContext context, WidgetRef ref) {
    context.go('/timetable/create');
  }

  void _showSearchDialog(BuildContext context, WidgetRef ref) {
    // TODO: Implement settings
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sozlamalar - tez orada!')),
    );
  }
}
