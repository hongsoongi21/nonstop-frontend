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
import '../../data/dto/semester_dto.dart';
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
    final notifier = ref.read(timetableManagementProvider.notifier);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Consumer(
        builder: (context, ref, _) {
          final l10n = AppLocalizations.of(context)!;
          final currentState = ref.watch(timetableManagementProvider);
          final timetables = currentState.myTimetables;
          final selectedId = currentState.selectedTimetableId;

          // Group timetables by semester (year-type)
          final grouped = <String, List<dynamic>>{};
          for (final tt in timetables) {
            final key = '${tt.year}-${tt.semesterType.name}';
            grouped.putIfAbsent(key, () => []).add(tt);
          }

          return GlassContainer(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.3,
              maxChildSize: 0.8,
              expand: false,
              builder: (context, scrollController) => Column(
                children: [
                  // Handle bar
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 8),
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: context.textTertiaryColor.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  // Title row
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Text(
                          l10n.myTimetables,
                          style: AppTypography.titleLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${timetables.length}개',
                          style: AppTypography.caption.copyWith(
                            color: context.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  // Timetable list
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      children: [
                        for (final entry in grouped.entries) ...[
                          // Semester header
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              AppSpacing.md,
                              12,
                              AppSpacing.md,
                              4,
                            ),
                            child: Text(
                              _formatSemesterKey(context, entry.key),
                              style: AppTypography.overline.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          // Timetables in this semester
                          ...entry.value.map((tt) {
                            final isSelected = tt.id == selectedId;
                            return ListTile(
                              leading: Icon(
                                isSelected
                                    ? Icons.check_circle
                                    : Icons.calendar_today_outlined,
                                color: isSelected
                                    ? AppColors.primary
                                    : context.textSecondaryColor,
                                size: 22,
                              ),
                              title: Text(
                                tt.title ?? l10n.untitledTimetable,
                                style: AppTypography.body1.copyWith(
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? AppColors.primary
                                      : context.textPrimaryColor,
                                ),
                              ),
                              trailing: !isSelected
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.delete_outline,
                                        size: 20,
                                        color: AppColors.error.withValues(alpha: 0.6),
                                      ),
                                      onPressed: () async {
                                        final confirm = await showDialog<bool>(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: const Text('시간표 삭제'),
                                            content: Text(
                                              '"${tt.title ?? l10n.untitledTimetable}"을(를) 삭제하시겠습니까?',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(ctx, false),
                                                child: Text(l10n.cancel),
                                              ),
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(ctx, true),
                                                child: Text(
                                                  l10n.delete,
                                                  style: const TextStyle(
                                                    color: AppColors.error,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                        if (confirm == true) {
                                          await notifier.deleteTimetable(tt.id);
                                        }
                                      },
                                    )
                                  : null,
                              onTap: () {
                                notifier.selectTimetable(tt.id);
                                Navigator.pop(context);
                              },
                            );
                          }),
                        ],
                      ],
                    ),
                  ),
                  // Create new timetable button
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showCreateTimetableDialog(context, ref);
                        },
                        icon: const Icon(Icons.add_rounded, size: 20),
                        label: const Text('새 시간표 만들기'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatSemesterKey(BuildContext context, String key) {
    final parts = key.split('-');
    if (parts.length != 2) return key;
    final year = parts[0];
    final type = parts[1];
    final l10n = AppLocalizations.of(context)!;
    final String typeName;
    switch (type) {
      case 'first':
        typeName = l10n.semesterSpring;
        break;
      case 'second':
        typeName = l10n.semesterFall;
        break;
      case 'summer':
        typeName = l10n.semesterSummer;
        break;
      case 'winter':
        typeName = l10n.semesterWinter;
        break;
      default:
        typeName = type;
    }
    return '$year $typeName';
  }

  void _showCreateTimetableDialog(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.read(timetableManagementProvider);
    final notifier = ref.read(timetableManagementProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Determine current semester defaults
    final now = DateTime.now();
    int selectedYear = now.month >= 9 ? now.year : now.year - 1;
    SemesterType selectedType =
        (now.month >= 9 || now.month <= 1)
            ? SemesterType.first
            : (now.month >= 2 && now.month <= 6)
                ? SemesterType.second
                : SemesterType.summer;

    // Count existing preliminary timetables for auto-numbering
    final existingTimetables = state.myTimetables
        .where((tt) => tt.year == selectedYear && tt.semesterType == selectedType)
        .toList();
    final prelimCount = existingTimetables
        .where((tt) => tt.title?.startsWith('예비') == true)
        .length;

    // Default title
    final hasMain =
        existingTimetables.any((tt) => tt.title == 'Asosiy jadval');
    String selectedTitle =
        hasMain ? '예비${prelimCount + 1}' : 'Asosiy jadval';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            // Recalculate when semester changes
            final semTimetables = state.myTimetables
                .where(
                  (tt) =>
                      tt.year == selectedYear &&
                      tt.semesterType == selectedType,
                )
                .toList();
            final semHasMain =
                semTimetables.any((tt) => tt.title == 'Asosiy jadval');
            final semPrelimCount = semTimetables
                .where((tt) => tt.title?.startsWith('예비') == true)
                .length;

            final titleOptions = <String>[
              if (!semHasMain) 'Asosiy jadval',
              '예비${semPrelimCount + 1}',
            ];

            // Ensure selected title is valid
            if (!titleOptions.contains(selectedTitle)) {
              selectedTitle = titleOptions.first;
            }

            return AlertDialog(
              backgroundColor:
                  isDark ? AppColors.surfaceDark : AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                '새 시간표 만들기',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Year selector
                  Text(
                    '학년도',
                    style: AppTypography.caption.copyWith(
                      color: isDark ? Colors.white60 : AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () =>
                            setDialogState(() => selectedYear--),
                        icon: const Icon(Icons.chevron_left),
                      ),
                      Expanded(
                        child: Text(
                          '$selectedYear',
                          textAlign: TextAlign.center,
                          style: AppTypography.headline5.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            setDialogState(() => selectedYear++),
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Semester type selector
                  Text(
                    '학기',
                    style: AppTypography.caption.copyWith(
                      color: isDark ? Colors.white60 : AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: SemesterType.values.map((type) {
                      final isSelected = type == selectedType;
                      return ChoiceChip(
                        label: Text(type.displayName(context)),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            setDialogState(() => selectedType = type);
                          }
                        },
                        selectedColor:
                            AppColors.primary.withValues(alpha: 0.2),
                        labelStyle: TextStyle(
                          color: isSelected ? AppColors.primary : null,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  // Title selector
                  Text(
                    '시간표 이름',
                    style: AppTypography.caption.copyWith(
                      color: isDark ? Colors.white60 : AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...titleOptions.map(
                    (title) => InkWell(
                      onTap: () => setDialogState(() => selectedTitle = title),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Radio<String>(
                              value: title,
                              groupValue: selectedTitle,
                              onChanged: (v) =>
                                  setDialogState(() => selectedTitle = v!),
                              activeColor: AppColors.primary,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                            Text(title, style: AppTypography.body1),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.cancel),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    final success = await notifier.createTimetable(
                      year: selectedYear,
                      semesterType: selectedType,
                      title: selectedTitle,
                    );
                    if (success && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('"$selectedTitle" 시간표가 생성되었습니다'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('만들기'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
