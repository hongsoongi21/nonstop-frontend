import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nonstop/core/theme/app_colors.dart';
import 'package:nonstop/core/theme/app_spacing.dart';
import 'package:nonstop/core/theme/app_typography.dart';
import 'package:nonstop/features/timetable/domain/entities/gpa_course.dart';
import 'package:nonstop/features/timetable/presentation/providers/gpa_provider.dart';
// import 'package:nonstop/features/timetable/presentation/providers/timetable_provider.dart';
import 'package:nonstop/features/timetable/presentation/providers/timetable_management_provider.dart';
import 'package:nonstop/shared/components/app_background.dart';
import 'package:nonstop/shared/components/glass_container.dart';

class GpaCalculatorScreen extends ConsumerStatefulWidget {
  const GpaCalculatorScreen({super.key});

  @override
  ConsumerState<GpaCalculatorScreen> createState() =>
      _GpaCalculatorScreenState();
}

class _GpaCalculatorScreenState extends ConsumerState<GpaCalculatorScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final gpaState = ref.watch(gpaProvider);
    final notifier = ref.read(gpaProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Grade Calculator',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.download_outlined, color: AppColors.textPrimary),
            tooltip: 'Import from Timetable',
            onPressed: () {
              // final events = ref.read(timetableEventsProvider);
              final entries =
                  ref
                      .read(timetableManagementProvider)
                      .selectedTimetable
                      ?.entries ??
                  [];
              notifier.importCourses(entries);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Courses imported from timetable')),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh, color: AppColors.textPrimary),
            onPressed: () {
              // Confirm reset
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Reset Calculator?'),
                  content: Text(
                    'This will remove all courses from the calculator.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        notifier.clearAll();
                        Navigator.pop(context);
                      },
                      child: Text('Reset', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: AppBackground(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              // GPA Summary Card
              _buildSummaryCard(gpaState),

              SizedBox(height: AppSpacing.lg),

              // Course List Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                child: Row(
                  children: [
                    Text(
                      'Courses',
                      style: AppTypography.titleSmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Spacer(),
                    TextButton.icon(
                      onPressed: () => _showAddCourseDialog(context, ref),
                      icon: Icon(Icons.add, size: 16),
                      label: Text('Add Course'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppSpacing.sm),

              // Course List
              if (gpaState.courses.isEmpty)
                _buildEmptyState()
              else
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: gpaState.courses.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final course = gpaState.courses[index];
                    return _buildCourseItem(context, ref, course);
                  },
                ),

              SizedBox(height: 100), // Bottom padding
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () => _showAddCourseDialog(context, ref),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: AppColors.brandGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7C3BEE).withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.add, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                'Add Course',
                style: AppTypography.button.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(GpaState state) {
    return GlassContainer(
      padding: EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem(
                'Total GPA',
                state.totalGpa.toStringAsFixed(2),
                isMain: true,
              ),
              Container(width: 1, height: 40, color: AppColors.border),
              _buildStatItem('Major GPA', state.majorGpa.toStringAsFixed(2)),
              Container(width: 1, height: 40, color: AppColors.border),
              _buildStatItem('Credits', state.totalCredits.toStringAsFixed(0)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, {bool isMain = false}) {
    return Column(
      children: [
        Text(
          label,
          style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: isMain
              ? AppTypography.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                )
              : AppTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
        ),
      ],
    );
  }

  Widget _buildCourseItem(
    BuildContext context,
    WidgetRef ref,
    GpaCourse course,
  ) {
    return Dismissible(
      key: Key(course.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        ref.read(gpaProvider.notifier).removeCourse(course.id);
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.delete, color: Colors.red),
      ),
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name,
                    style: AppTypography.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      if (course.isMajor)
                        Container(
                          margin: EdgeInsets.only(right: 8),
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Major',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      Text(
                        '${course.credits} Credits',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                course.grade,
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _getGradeColor(course.grade),
                ),
              ),
            ),
            SizedBox(width: 8),
            IconButton(
              icon: Icon(
                Icons.more_vert,
                size: 20,
                color: AppColors.textSecondary,
              ),
              onPressed: () => _showEditCourseDialog(context, ref, course),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }

  Color _getGradeColor(String grade) {
    if (grade.startsWith('A')) return AppColors.primary;
    if (grade.startsWith('B')) return Colors.blue;
    if (grade.startsWith('C')) return Colors.orange;
    if (grade.startsWith('D')) return Colors.deepOrange;
    if (grade == 'F') return Colors.red;
    return AppColors.textPrimary;
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Icon(
              Icons.calculate_outlined,
              size: 64,
              color: AppColors.textSecondary.withValues(alpha: 0.3),
            ),
            SizedBox(height: 16),
            Text(
              'No courses added yet',
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Add your courses to calculate GPA',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddCourseDialog(BuildContext context, WidgetRef ref) {
    _showCourseDialog(context, ref, null);
  }

  void _showEditCourseDialog(
    BuildContext context,
    WidgetRef ref,
    GpaCourse course,
  ) {
    _showCourseDialog(context, ref, course);
  }

  void _showCourseDialog(
    BuildContext context,
    WidgetRef ref,
    GpaCourse? course,
  ) {
    final isEditing = course != null;
    final nameController = TextEditingController(text: course?.name ?? '');
    double credits = course?.credits ?? 3.0;
    String grade = course?.grade ?? 'A+';
    bool isMajor = course?.isMajor ?? false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEditing ? 'Edit Course' : 'Add Course',
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Course Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: AppColors.surface,
                ),
                autofocus: true,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<double>(
                      initialValue: credits,
                      decoration: InputDecoration(
                        labelText: 'Credits',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items:
                          [
                                0.5,
                                1.0,
                                1.5,
                                2.0,
                                2.5,
                                3.0,
                                3.5,
                                4.0,
                                4.5,
                                5.0,
                                6.0,
                              ]
                              .map(
                                (c) => DropdownMenuItem(
                                  value: c,
                                  child: Text(c.toString()),
                                ),
                              )
                              .toList(),
                      onChanged: (v) => setState(() => credits = v!),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: grade,
                      decoration: InputDecoration(
                        labelText: 'Grade',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items:
                          [
                                'A+',
                                'A0',
                                'B+',
                                'B0',
                                'C+',
                                'C0',
                                'D+',
                                'D0',
                                'F',
                                'P',
                                'NP',
                              ]
                              .map(
                                (g) =>
                                    DropdownMenuItem(value: g, child: Text(g)),
                              )
                              .toList(),
                      onChanged: (v) => setState(() => grade = v!),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              CheckboxListTile(
                title: Text('Major Subject'),
                value: isMajor,
                onChanged: (v) => setState(() => isMajor = v!),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isEmpty) return;

                    final newCourse = isEditing
                        ? course.copyWith(
                            name: nameController.text,
                            credits: credits,
                            grade: grade,
                            isMajor: isMajor,
                          )
                        : GpaCourse.create(
                            name: nameController.text,
                            credits: credits,
                            grade: grade,
                            isMajor: isMajor,
                          );

                    if (isEditing) {
                      ref.read(gpaProvider.notifier).updateCourse(newCourse);
                    } else {
                      ref.read(gpaProvider.notifier).addCourse(newCourse);
                    }

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(isEditing ? 'Save Changes' : 'Add Course'),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
