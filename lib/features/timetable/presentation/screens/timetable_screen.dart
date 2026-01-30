import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nonstop/core/constants/routes.dart';

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
        : l10n.loading;

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: entries.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () => _showCreateEventDialog(context, ref),
              backgroundColor: AppColors.primary,
              elevation: 8,
              icon: Icon(Icons.add_rounded, color: Colors.white),
              label: Text(
                l10n.addCourse,
                style: AppTypography.button.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : null,
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
              // Clean modern header
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
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
                                          color: AppColors.textPrimary,
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
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.border,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () => notifier.initializeTimetable(),
                                icon: Icon(
                                  Icons.refresh_rounded,
                                  color: AppColors.primary,
                                ),
                                tooltip: l10n.refresh,
                              ),
                              Container(
                                width: 1,
                                height: 24,
                                color: AppColors.border,
                              ),
                              IconButton(
                                onPressed: () => _showSettings(context, ref),
                                icon: Icon(
                                  Icons.settings_outlined,
                                  color: AppColors.primary,
                                ),
                                tooltip: l10n.settings,
                              ),
                            ],
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
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Stack(
                    children: [
                      WeeklyTimeGrid(
                        entries: entries,
                        onEntryTap: (entry) {
                          context.push(Routes.timetableCreate, extra: entry);
                        },
                      ),
                      if (entries.isEmpty && !state.isLoading)
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(AppSpacing.xl),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: AppColors.border,
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
                                    color: AppColors.textPrimary,
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
                                  onPressed:
                                      () => _showCreateEventDialog(context, ref),
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
    final l10n = AppLocalizations.of(context)!;
    final gpaState = ref.watch(gpaProvider);
    final hasCourses = gpaState.courses.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: GestureDetector(
        onTap: () => context.go(Routes.gpaCalculator),
        child: Container(
          padding: EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                AppColors.primaryDark,
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                offset: Offset(0, 4),
                blurRadius: 16,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.calculate_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.gpaCalculator,
                      style: AppTypography.titleMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      hasCourses
                          ? '${gpaState.totalGpa.toStringAsFixed(2)} • ${gpaState.totalCredits.toStringAsFixed(0)} ${l10n.credits}'
                          : l10n.calculateAndTrack,
                      style: AppTypography.caption.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (hasCourses)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    gpaState.totalGpa.toStringAsFixed(2),
                    style: AppTypography.headline3.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                )
              else
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateEventDialog(BuildContext context, WidgetRef ref) {
    context.push(Routes.timetableCreate);
  }

  void _showSettings(BuildContext context, WidgetRef ref) {
    context.go(Routes.settings);
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
