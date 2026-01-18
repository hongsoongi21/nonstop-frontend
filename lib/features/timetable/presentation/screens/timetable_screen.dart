import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nonstop/core/constants/routes.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/components/glass_container.dart';
import '../providers/timetable_management_provider.dart';
import '../providers/gpa_provider.dart';
import '../widgets/weekly_time_grid.dart';

/// Main timetable screen with calendar views
class TimetableScreen extends ConsumerStatefulWidget {
  const TimetableScreen({super.key});

  @override
  ConsumerState<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends ConsumerState<TimetableScreen> {
  @override
  void initState() {
    super.initState();
    // Auto-load timetable on screen init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(timetableManagementProvider.notifier).initializeTimetable();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(timetableManagementProvider);
    final notifier = ref.read(timetableManagementProvider.notifier);
    final currentTimetable = state.selectedTimetable;
    final entries = currentTimetable?.entries ?? [];

    // Find current semester name (if any) or generic date
    final semesterName =
        state.semesters
            .where((s) => s.id == currentTimetable?.semesterId)
            .firstOrNull
            ?.displayName ??
        '2026-Winter';

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.backgroundGradient,
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
                          semesterName,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            // TODO: Show timetable switcher
                          },
                          child: Row(
                            children: [
                              Text(
                                currentTimetable?.title ?? 'Dars jadvali',
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
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () => _showCreateEventDialog(context, ref),
                      icon: Icon(Icons.add, color: AppColors.textPrimary),
                      tooltip: 'Yangi dars qo\'shish',
                    ),
                    IconButton(
                      onPressed: () => _showSettings(context, ref),
                      icon: Icon(
                        Icons.settings_outlined,
                        color: AppColors.textPrimary,
                      ),
                      tooltip: 'Sozlamalar',
                    ),
                    IconButton(
                      onPressed: () => notifier.initializeTimetable(),
                      icon: Icon(Icons.refresh, color: AppColors.textPrimary),
                      tooltip: 'Yangilash',
                    ),
                  ],
                ),
              ),

              if (state.isLoading)
                LinearProgressIndicator(color: AppColors.primary),

              // Weekly time grid
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: WeeklyTimeGrid(entries: entries),
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
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateEventDialog(BuildContext context, WidgetRef ref) {
    context.go(Routes.timetableCreate);
  }

  void _showSettings(BuildContext context, WidgetRef ref) {
    context.go(Routes.settings);
  }
}
