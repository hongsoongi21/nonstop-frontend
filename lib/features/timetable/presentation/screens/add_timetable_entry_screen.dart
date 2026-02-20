import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/components/main_scaffold.dart';
import '../../domain/entities/day_of_week.dart';
import '../../domain/entities/timetable_entry.dart';
import '../providers/timetable_management_provider.dart';

class AddTimetableEntryScreen extends ConsumerStatefulWidget {
  final TimetableEntry? initialEntry;

  const AddTimetableEntryScreen({super.key, this.initialEntry});

  @override
  ConsumerState<AddTimetableEntryScreen> createState() =>
      _AddTimetableEntryScreenState();
}

class _AddTimetableEntryScreenState
    extends ConsumerState<AddTimetableEntryScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form Fields
  final _subjectController = TextEditingController();
  final _professorController = TextEditingController();
  final _placeController = TextEditingController();
  final _creditController = TextEditingController();

  DayOfWeek _selectedDay = DayOfWeek.monday;
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 30);
  Color _selectedColor = AppColors.courseColors[0];

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialEntry != null) {
      final entry = widget.initialEntry!;
      _subjectController.text = entry.subjectName;
      _professorController.text = entry.professor ?? '';
      _placeController.text = entry.place ?? '';
      _creditController.text = entry.credit?.toString() ?? '';
      _selectedDay = entry.dayOfWeek;

      final startParts = entry.startTime.split(':');
      _startTime = TimeOfDay(
        hour: int.parse(startParts[0]),
        minute: int.parse(startParts[1]),
      );

      final endParts = entry.endTime.split(':');
      _endTime = TimeOfDay(
        hour: int.parse(endParts[0]),
        minute: int.parse(endParts[1]),
      );

      if (entry.color != null) {
        try {
          final colorValue = int.parse(
            entry.color!.replaceAll('#', 'FF'),
            radix: 16,
          );
          _selectedColor = Color(colorValue);
        } catch (_) {}
      }
    }
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _professorController.dispose();
    _placeController.dispose();
    _creditController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context, bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: context.textPrimaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
          // Auto-adjust end time to be 1.5 hours later by default
          final startMinutes = picked.hour * 60 + picked.minute;
          final endMinutes = startMinutes + 90; // 1.5 hours
          _endTime = TimeOfDay(
            hour: (endMinutes ~/ 60) % 24,
            minute: endMinutes % 60,
          );
        } else {
          _endTime = picked;
        }
      });
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm').format(dt);
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final notifier = ref.read(timetableManagementProvider.notifier);
      final bool success;

      if (widget.initialEntry != null) {
        success = await notifier.updateEntry(
          entryId: widget.initialEntry!.id,
          subjectName: _subjectController.text.trim(),
          professor: _professorController.text.trim().isEmpty
              ? null
              : _professorController.text.trim(),
          dayOfWeek: _selectedDay,
          startTime: _formatTimeOfDay(_startTime),
          endTime: _formatTimeOfDay(_endTime),
          place: _placeController.text.trim().isEmpty
              ? null
              : _placeController.text.trim(),
          color: '#${_selectedColor.value.toRadixString(16).substring(2)}',
          credit: _creditController.text.trim().isEmpty
              ? null
              : int.tryParse(_creditController.text.trim()),
        );
      } else {
        success = await notifier.addEntry(
          subjectName: _subjectController.text.trim(),
          professor: _professorController.text.trim().isEmpty
              ? null
              : _professorController.text.trim(),
          dayOfWeek: _selectedDay,
          startTime: _formatTimeOfDay(_startTime),
          endTime: _formatTimeOfDay(_endTime),
          place: _placeController.text.trim().isEmpty
              ? null
              : _placeController.text.trim(),
          color: '#${_selectedColor.value.toRadixString(16).substring(2)}',
          credit: _creditController.text.trim().isEmpty
              ? null
              : int.tryParse(_creditController.text.trim()),
        );
      }

      if (success && mounted) {
        GoRouter.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.initialEntry != null
                  ? AppLocalizations.of(context)!.courseUpdated
                  : AppLocalizations.of(context)!.courseAdded,
            ),
            backgroundColor: AppColors.success,
          ),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              ref.read(timetableManagementProvider).error ??
                  AppLocalizations.of(context)!.errorOccurred,
            ),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEditing = widget.initialEntry != null;

    return AppScaffold(
      title: isEditing ? l10n.editCourse : l10n.addCourse,
      showBackButton: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEditing ? l10n.editCourseTitle : l10n.newCourse,
                      style: AppTypography.overline.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isEditing
                          ? l10n.updateCourseInfo
                          : l10n.createNewCourse,
                      style: AppTypography.body2.copyWith(
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // Basic Info Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: context.surfaceColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: context.borderColor,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowMedium,
                      offset: const Offset(0, 2),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(l10n.basicInfo, Icons.book),
                    const SizedBox(height: AppSpacing.lg),
                    _buildTextField(
                      controller: _subjectController,
                      label: l10n.courseName,
                      hint: l10n.courseNameHint,
                      icon: Icons.school_outlined,
                      validator: (v) =>
                          v == null || v.isEmpty ? l10n.courseNameRequired : null,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildTextField(
                      controller: _professorController,
                      label: l10n.professor,
                      hint: l10n.professorHint,
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildTextField(
                      controller: _placeController,
                      label: l10n.room,
                      hint: l10n.roomHint,
                      icon: Icons.location_on_outlined,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildTextField(
                      controller: _creditController,
                      label: 'Credits',
                      hint: '3',
                      icon: Icons.school_outlined,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // Time & Day Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: context.surfaceColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: context.borderColor,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowMedium,
                      offset: const Offset(0, 2),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(l10n.timeAndDay, Icons.schedule),
                    const SizedBox(height: AppSpacing.lg),

                    // Day Selector with clean design
                    Container(
                      decoration: BoxDecoration(
                        color: context.surfaceVariantColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: context.borderColor,
                          width: 1,
                        ),
                      ),
                      child: DropdownButtonFormField<DayOfWeek>(
                        value: _selectedDay,
                        decoration: InputDecoration(
                          labelText: l10n.dayOfWeek,
                          labelStyle: AppTypography.labelSmall.copyWith(
                            color: context.textSecondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          prefixIcon: Icon(
                            Icons.calendar_today_rounded,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        items: DayOfWeek.values.map((day) {
                          return DropdownMenuItem(
                            value: day,
                            child: Text(
                              day.displayName(context),
                              style: AppTypography.body2.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (v) {
                          if (v != null) setState(() => _selectedDay = v);
                        },
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Time Range with enhanced design
                    Row(
                      children: [
                        Expanded(
                          child: _buildTimePicker(
                            label: l10n.startTime,
                            time: _startTime,
                            onTap: () => _selectTime(context, true),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(
                            Icons.arrow_forward,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                        Expanded(
                          child: _buildTimePicker(
                            label: l10n.endTime,
                            time: _endTime,
                            onTap: () => _selectTime(context, false),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // Color Picker Card with better UX
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: context.surfaceColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: context.borderColor,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowMedium,
                      offset: const Offset(0, 2),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(l10n.color, Icons.palette_outlined),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n.colorDescription,
                      style: AppTypography.caption.copyWith(
                        color: context.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Wrap(
                      spacing: 14,
                      runSpacing: 14,
                      children: AppColors.courseColors.map((color) {
                        final isSelected = _selectedColor == color;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedColor = color),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: isSelected ? 56 : 52,
                            height: isSelected ? 56 : 52,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  color.withValues(alpha: 0.9),
                                  color,
                                ],
                              ),
                              shape: BoxShape.circle,
                              border: isSelected
                                  ? Border.all(
                                      color: AppColors.primary,
                                      width: 3,
                                    )
                                  : Border.all(
                                      color: context.borderColor,
                                      width: 1,
                                    ),
                              boxShadow: [
                                BoxShadow(
                                  color: isSelected
                                      ? color.withValues(alpha: 0.4)
                                      : color.withValues(alpha: 0.2),
                                  blurRadius: isSelected ? 12 : 6,
                                  offset: Offset(0, isSelected ? 4 : 2),
                                ),
                              ],
                            ),
                            child: isSelected
                                ? Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withValues(alpha: 0.15),
                                    ),
                                    child: const Icon(
                                      Icons.check_rounded,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  )
                                : null,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Save Button with modern design
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                      shadowColor: AppColors.primary.withValues(alpha: 0.3),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isEditing ? Icons.save_rounded : Icons.add_rounded,
                                size: 22,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                isEditing ? l10n.saveChanges : l10n.save,
                                style: AppTypography.button.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),

              if (isEditing) ...[
                const SizedBox(height: AppSpacing.md),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: OutlinedButton(
                      onPressed: _isSubmitting ? null : _deleteEntry,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(
                          color: AppColors.error,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.delete_outline, size: 22),
                          const SizedBox(width: 10),
                          Text(
                            l10n.deleteCourse,
                            style: AppTypography.button.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteEntry() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteCourse),
        content: Text(l10n.confirmDeleteCourse),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _isSubmitting = true);

    try {
      final success = await ref
          .read(timetableManagementProvider.notifier)
          .deleteEntry(widget.initialEntry!.id);

      if (success && mounted) {
        GoRouter.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.courseDeleted),
            backgroundColor: AppColors.success,
          ),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              ref.read(timetableManagementProvider).error ??
                  l10n.errorOccurred,
            ),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w800,
            color: context.textPrimaryColor,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceVariantColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.borderColor,
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        style: AppTypography.body1.copyWith(
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: AppTypography.labelSmall.copyWith(
            color: context.textSecondaryColor,
            fontWeight: FontWeight.w600,
          ),
          hintText: hint,
          hintStyle: AppTypography.body2.copyWith(
            color: context.textTertiaryColor,
          ),
          prefixIcon: Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.error,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildTimePicker({
    required String label,
    required TimeOfDay time,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.surfaceVariantColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: context.borderColor,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: AppTypography.labelSmall.copyWith(
                    color: context.textSecondaryColor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _formatTimeOfDay(time),
              style: AppTypography.headline4.copyWith(
                fontWeight: FontWeight.w800,
                color: context.textPrimaryColor,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
