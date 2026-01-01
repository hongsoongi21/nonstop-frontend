import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../domain/entities/event.dart';
import '../providers/timetable_provider.dart';

/// Screen for creating new events
class CreateEventScreen extends ConsumerStatefulWidget {
  const CreateEventScreen({super.key});

  @override
  ConsumerState<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends ConsumerState<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _tagsController = TextEditingController();

  EventType _selectedType = EventType.personal;
  DateTime _startDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  DateTime _endDate = DateTime.now();
  TimeOfDay _endTime = TimeOfDay.now().replacing(
    hour: TimeOfDay.now().hour + 1,
  );
  bool _isAllDay = false;
  final List<String> _tags = [];
  int? _selectedColor;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(timetableLoadingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yangi tadbir'),
        actions: [
          TextButton(
            onPressed: isLoading ? null : _saveEvent,
            child: Text(
              'Saqlash',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(AppSpacing.md),
          children: [
            // Event type selector
            _buildSectionTitle('Tadbir turi'),
            _buildEventTypeSelector(),

            SizedBox(height: AppSpacing.lg),

            // Title field
            _buildSectionTitle('Sarlavha'),
            AppTextField(
              controller: _titleController,
              hintText: 'Tadbir nomini kiriting',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Sarlavha majburiy';
                }
                return null;
              },
            ),

            SizedBox(height: AppSpacing.lg),

            // Description field
            _buildSectionTitle('Tavsif'),
            AppTextField(
              controller: _descriptionController,
              hintText: 'Tadbir haqida batafsil ma\'lumot',
              maxLines: 3,
            ),

            SizedBox(height: AppSpacing.lg),

            // All day toggle
            SwitchListTile(
              title: Text(
                'Kun bo\'yi davom etadi',
                style: AppTypography.bodyMedium,
              ),
              value: _isAllDay,
              onChanged: (value) {
                setState(() {
                  _isAllDay = value;
                });
              },
              activeThumbColor: AppColors.primary,
            ),

            if (!_isAllDay) ...[
              SizedBox(height: AppSpacing.lg),

              // Start date and time
              _buildSectionTitle('Boshlanish vaqti'),
              Row(
                children: [
                  Expanded(
                    child: _buildDatePicker(
                      label: 'Sana',
                      selectedDate: _startDate,
                      onDateSelected: (date) {
                        setState(() {
                          _startDate = date;
                          // If end date is before start date, update it
                          if (_endDate.isBefore(date)) {
                            _endDate = date;
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _buildTimePicker(
                      label: 'Vaqt',
                      selectedTime: _startTime,
                      onTimeSelected: (time) {
                        setState(() {
                          _startTime = time;
                        });
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSpacing.lg),

              // End date and time
              _buildSectionTitle('Tugash vaqti'),
              Row(
                children: [
                  Expanded(
                    child: _buildDatePicker(
                      label: 'Sana',
                      selectedDate: _endDate,
                      onDateSelected: (date) {
                        setState(() {
                          _endDate = date;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _buildTimePicker(
                      label: 'Vaqt',
                      selectedTime: _endTime,
                      onTimeSelected: (time) {
                        setState(() {
                          _endTime = time;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ] else ...[
              SizedBox(height: AppSpacing.lg),

              // All day date picker
              _buildSectionTitle('Sana'),
              _buildDatePicker(
                label: 'Kunni tanlang',
                selectedDate: _startDate,
                onDateSelected: (date) {
                  setState(() {
                    _startDate = date;
                    _endDate = date;
                  });
                },
              ),
            ],

            SizedBox(height: AppSpacing.lg),

            // Location field
            _buildSectionTitle('Joylashuv'),
            AppTextField(
              controller: _locationController,
              hintText: 'Tadbir joyini kiriting (ixtiyoriy)',
              prefixIcon: const Icon(Icons.location_on),
            ),

            SizedBox(height: AppSpacing.lg),

            // Color picker
            _buildSectionTitle('Rang'),
            _buildColorPicker(),

            SizedBox(height: AppSpacing.lg),

            // Tags
            _buildSectionTitle('Teglar'),
            _buildTagsSection(),

            SizedBox(height: AppSpacing.xl),

            // Save button
            AppButton(
              text: 'Tadbirni saqlash',
              onPressed: isLoading ? null : _saveEvent,
              isLoading: isLoading,
              width: double.infinity,
            ),

            SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(
        title,
        style: AppTypography.bodyLarge.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildEventTypeSelector() {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: EventType.values.map((type) {
        final isSelected = type == _selectedType;
        return ChoiceChip(
          label: Text(type.typeName),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) {
              setState(() {
                _selectedType = type;
              });
            }
          },
          selectedColor: AppColors.primary.withOpacity(0.1),
          checkmarkColor: AppColors.primary,
          labelStyle: AppTypography.bodyMedium.copyWith(
            color: isSelected ? AppColors.primary : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDatePicker({
    required String label,
    required DateTime selectedDate,
    required ValueChanged<DateTime> onDateSelected,
  }) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (date != null) {
          onDateSelected(date);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        child: Text(
          DateFormat('dd/MM/yyyy').format(selectedDate),
          style: AppTypography.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildTimePicker({
    required String label,
    required TimeOfDay selectedTime,
    required ValueChanged<TimeOfDay> onTimeSelected,
  }) {
    return InkWell(
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: selectedTime,
        );
        if (time != null) {
          onTimeSelected(time);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          suffixIcon: const Icon(Icons.access_time),
        ),
        child: Text(
          selectedTime.format(context),
          style: AppTypography.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildColorPicker() {
    final colors = [
      0xFF2563EB, // Blue
      0xFFDC2626, // Red
      0xFFF59E0B, // Amber
      0xFF059669, // Green
      0xFF7C3AED, // Purple
      0xFF0891B2, // Cyan
      0xFFEA580C, // Orange
      0xFFBE185D, // Pink
    ];

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: colors.map((color) {
        final isSelected = _selectedColor == color;
        return InkWell(
          onTap: () {
            setState(() {
              _selectedColor = color;
            });
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(color),
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(color: AppColors.primary, width: 3)
                  : null,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Color(color).withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: isSelected
                ? const Icon(Icons.check, color: Colors.white, size: 20)
                : null,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTagsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: AppTextField(
                controller: _tagsController,
                hintText: 'Teg qo\'shish',
                onSubmitted: _addTag,
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            IconButton(
              onPressed: () => _addTag(_tagsController.text),
              icon: const Icon(Icons.add),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),

        if (_tags.isNotEmpty) ...[
          SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xxs,
            runSpacing: AppSpacing.xxs,
            children: _tags.map((tag) {
              return Chip(
                label: Text(tag),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () {
                  setState(() {
                    _tags.remove(tag);
                  });
                },
                backgroundColor: AppColors.primary.withOpacity(0.1),
                labelStyle: AppTypography.bodySmall.copyWith(
                  color: AppColors.primary,
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  void _addTag(String tagText) {
    final tag = tagText.trim();
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
        _tagsController.clear();
      });
    }
  }

  void _saveEvent() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Calculate start and end DateTime
    DateTime startDateTime;
    DateTime endDateTime;

    if (_isAllDay) {
      startDateTime = DateTime(
        _startDate.year,
        _startDate.month,
        _startDate.day,
      );
      endDateTime = DateTime(
        _startDate.year,
        _startDate.month,
        _startDate.day,
        23,
        59,
        59,
      );
    } else {
      startDateTime = DateTime(
        _startDate.year,
        _startDate.month,
        _startDate.day,
        _startTime.hour,
        _startTime.minute,
      );
      endDateTime = DateTime(
        _endDate.year,
        _endDate.month,
        _endDate.day,
        _endTime.hour,
        _endTime.minute,
      );
    }

    // Validate that end time is after start time
    if (endDateTime.isBefore(startDateTime) ||
        endDateTime.isAtSameMomentAs(startDateTime)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Tugash vaqti boshlanish vaqtidan keyin bo\'lishi kerak',
          ),
        ),
      );
      return;
    }

    final event = Event(
      id: const Uuid().v4(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      startTime: startDateTime,
      endTime: endDateTime,
      type: _selectedType,
      userId: '1', // Current user ID
      location: _locationController.text.trim().isEmpty
          ? null
          : _locationController.text.trim(),
      color: _selectedColor,
      isAllDay: _isAllDay,
      tags: _tags.isEmpty ? null : List.from(_tags),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Save the event
    ref.read(timetableProvider.notifier).createEvent(event).then((success) {
      if (success) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tadbir muvaffaqiyatli saqlandi')),
        );
      }
    });
  }
}
