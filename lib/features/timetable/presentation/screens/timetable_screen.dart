import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nonstop/core/constants/routes.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/components/glass_container.dart';
import '../providers/timetable_management_provider.dart';
import '../providers/gpa_provider.dart';
import '../widgets/weekly_time_grid.dart';
import '../../domain/entities/semester.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(timetableManagementProvider);
    final notifier = ref.read(timetableManagementProvider.notifier);
    final currentTimetable = state.selectedTimetable;
    final entries = currentTimetable?.entries ?? [];

    // Find current semester name (if any) or generic date
    final semesterName = currentTimetable != null
        ? '${currentTimetable.year} - ${currentTimetable.semesterType.displayName(context)}'
        : '';

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
            colors: context.backgroundGradientColors,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Clean modern header
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.md,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                semesterName.toUpperCase(),
                                style: AppTypography.overline.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              SizedBox(height: 6),
                              GestureDetector(
                                onTap: () => _showTimetableSwitcher(context, ref),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        currentTimetable?.title ?? l10n.timetable,
                                        style: AppTypography.headline2.copyWith(
                                          color: context.textPrimaryColor,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: -0.5,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.unfold_more,
                                        color: AppColors.primary,
                                        size: 22,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Action buttons with refined styling
                        Container(
                          decoration: BoxDecoration(
                            color: context.surfaceColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: context.borderColor,
                              width: 1,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () => notifier.initializeTimetable(),
                            icon: Icon(
                              Icons.refresh_rounded,
                              color: AppColors.primary,
                            ),
                            tooltip: l10n.refresh,
                          ),
                        ),
                      ],
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
                  child: Stack(
                    children: [
                      WeeklyTimeGrid(
                        entries: entries,
                        onEntryTap: (entry) {
                          GoRouter.of(context).push(Routes.timetableCreate, extra: entry);
                        },
                      ),
                      if (entries.isEmpty && !state.isLoading)
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(AppSpacing.xl),
                            decoration: BoxDecoration(
                              color: context.surfaceColor,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: context.borderColor,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.calendar_month_outlined,
                                    size: 64,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(height: AppSpacing.lg),
                                Text(
                                  l10n.noCoursesAdded,
                                  style: AppTypography.headline3.copyWith(
                                    color: context.textPrimaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: AppSpacing.xs),
                                Text(
                                  l10n.noCoursesDescription,
                                  textAlign: TextAlign.center,
                                  style: AppTypography.body2.copyWith(
                                    color: AppColors.textSecondary,
                                    height: 1.6,
                                  ),
                                ),
                                SizedBox(height: AppSpacing.lg),
                                ElevatedButton(
                                  onPressed: state.isLoading
                                      ? null
                                      : () => _showCreateEventDialog(context, ref),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 32,
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.add_rounded, size: 20),
                                      SizedBox(width: 8),
                                      Text(
                                        l10n.addCourse,
                                        style: AppTypography.button.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Bottom section: Add Course button + GPA Calculator
              Padding(
                padding: EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.md),
                child: Column(
                  children: [
                    // Add course button (always visible when timetable exists)
                    if (currentTimetable != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: state.isLoading
                                ? null
                                : () => _showCreateEventDialog(context, ref),
                            icon: Icon(Icons.add_rounded, size: 20),
                            label: Text(
                              l10n.addCourse,
                              style: AppTypography.button.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                              shadowColor: AppColors.primary.withValues(alpha: 0.3),
                            ),
                          ),
                        ),
                      ),

                    // GPA Calculator card
                    _buildGPACalculator(context, ref),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGPACalculator(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final gpaState = ref.watch(gpaProvider);
    final hasCourses = gpaState.courses.isNotEmpty;

    return GestureDetector(
      onTap: () => GoRouter.of(context).go(Routes.gpaCalculator),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: context.borderColor,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calculate_outlined,
              color: AppColors.primary,
              size: 20,
            ),
            SizedBox(width: 10),
            Text(
              l10n.gpaCalculator,
              style: AppTypography.body2.copyWith(
                color: context.textSecondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            if (hasCourses) ...[
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  gpaState.totalGpa.toStringAsFixed(2),
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
            Spacer(),
            Icon(
              Icons.chevron_right_rounded,
              color: context.textSecondaryColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateEventDialog(BuildContext context, WidgetRef ref) {
    GoRouter.of(context).push(Routes.timetableCreate);
  }

  void _showTimetableSwitcher(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.read(timetableManagementProvider);
    final notifier = ref.read(timetableManagementProvider.notifier);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => GlassContainer(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.myTimetables,
                style: AppTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.myTimetables.length,
                  itemBuilder: (context, index) {
                    final tt = state.myTimetables[index];
                    final isSelected = tt.id == state.selectedTimetableId;

                    return ListTile(
                      leading: Icon(
                        isSelected ? Icons.check_circle : Icons.calendar_today,
                        color: isSelected ? AppColors.primary : AppColors.textSecondary,
                      ),
                      title: Text(
                        tt.title ?? l10n.untitledTimetable,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      subtitle: Text('${tt.year} - ${tt.semesterType.displayName(context)}'),
                      onTap: () {
                        notifier.selectTimetable(tt.id);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // TODO: Navigate to create new timetable screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(l10n.createNewTimetable),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
