import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/components/glass_container.dart';
import '../../../../shared/components/main_scaffold.dart';
import '../../domain/entities/day_of_week.dart';
import '../providers/timetable_management_provider.dart';

class AddTimetableEntryScreen extends ConsumerStatefulWidget {
  const AddTimetableEntryScreen({super.key});

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

  DayOfWeek _selectedDay = DayOfWeek.monday;
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 30);
  Color _selectedColor = AppColors.courseColors[0];

  bool _isSubmitting = false;

  @override
  void dispose() {
    _subjectController.dispose();
    _professorController.dispose();
    _placeController.dispose();
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
              onSurface: AppColors.textPrimary,
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
      final success = await ref
          .read(timetableManagementProvider.notifier)
          .addEntry(
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
          );

      if (success && mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Dars muvaffaqiyatli qo\'shildi'),
            backgroundColor: AppColors.success,
          ),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              ref.read(timetableManagementProvider).error ??
                  'Xatolik yuz berdi',
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
    return AppScaffold(
      title: 'Yangi dars qo\'shish',
      showBackButton: true,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Info Card
              GlassContainer(
                padding: const EdgeInsets.all(AppSpacing.md),
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Asosiy ma\'lumotlar'),
                    const SizedBox(height: AppSpacing.md),
                    _buildTextField(
                      controller: _subjectController,
                      label: 'Fan nomi',
                      hint: 'Masalan: Dasturlash asoslari',
                      icon: Icons.book_outlined,
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Fan nomini kiriting' : null,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildTextField(
                      controller: _professorController,
                      label: 'O\'qituvchi',
                      hint: 'Masalan: Prof. Kim',
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildTextField(
                      controller: _placeController,
                      label: 'Xona / Joy',
                      hint: 'Masalan: 301-xona',
                      icon: Icons.location_on_outlined,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // Time & Day Card
              GlassContainer(
                padding: const EdgeInsets.all(AppSpacing.md),
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Vaqt va Kun'),
                    const SizedBox(height: AppSpacing.md),

                    // Day Selector
                    DropdownButtonFormField<DayOfWeek>(
                      value: _selectedDay,
                      decoration: InputDecoration(
                        labelText: 'Hafta kuni',
                        prefixIcon: const Icon(Icons.calendar_today_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.5),
                      ),
                      items: DayOfWeek.values.map((day) {
                        return DropdownMenuItem(
                          value: day,
                          child: Text(day.displayName),
                        );
                      }).toList(),
                      onChanged: (v) {
                        if (v != null) setState(() => _selectedDay = v);
                      },
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Time Range
                    Row(
                      children: [
                        Expanded(
                          child: _buildTimePicker(
                            label: 'Boshlanish',
                            time: _startTime,
                            onTap: () => _selectTime(context, true),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: _buildTimePicker(
                            label: 'Tugash',
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

              // Color Picker Card
              GlassContainer(
                padding: const EdgeInsets.all(AppSpacing.md),
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Rang'),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: AppColors.courseColors.map((color) {
                        final isSelected = _selectedColor == color;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedColor = color),
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: isSelected
                                  ? Border.all(color: Colors.white, width: 4)
                                  : null,
                              boxShadow: [
                                BoxShadow(
                                  color: color.withValues(alpha: 0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: isSelected
                                ? const Icon(Icons.check, color: Colors.white)
                                : null,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  child: _isSubmitting
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Saqlash',
                          style: AppTypography.button.copyWith(fontSize: 18),
                        ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTypography.subtitle1.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.7),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.access_time, size: 20, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  _formatTimeOfDay(time),
                  style: AppTypography.subtitle1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
