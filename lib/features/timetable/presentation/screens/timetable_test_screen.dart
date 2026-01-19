import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nonstop/core/constants/routes.dart';
import 'package:nonstop/core/theme/app_colors.dart';
import 'package:nonstop/core/theme/app_spacing.dart';
import 'package:nonstop/core/theme/app_typography.dart';
import 'package:nonstop/shared/components/glass_container.dart';

import '../../domain/entities/day_of_week.dart';
import '../providers/timetable_management_provider.dart';

/// Simple test screen for the new Timetable API integration
/// This demonstrates the backend connection is working correctly
class TimetableTestScreen extends ConsumerStatefulWidget {
  const TimetableTestScreen({super.key});

  @override
  ConsumerState<TimetableTestScreen> createState() =>
      _TimetableTestScreenState();
}

class _TimetableTestScreenState extends ConsumerState<TimetableTestScreen> {
  @override
  void initState() {
    super.initState();
    // Load initial data with "Smart Defaults"
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(timetableManagementProvider.notifier).initializeTimetable();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(timetableManagementProvider);
    final notifier = ref.read(timetableManagementProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timetable (Backend Connected)'),
        backgroundColor: AppColors.primary,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.error}',
                    style: AppTypography.bodyMedium.copyWith(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => notifier.loadMyTimetables(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Timetable selector
                _buildTimetableSelector(state, notifier),

                // Entries list
                Expanded(
                  child: state.selectedTimetable == null
                      ? const Center(
                          child: Text('Select a timetable to view classes'),
                        )
                      : _buildEntriesList(state, notifier),
                ),
              ],
            ),
      floatingActionButton: state.selectedTimetableId == null
          ? null
          : FloatingActionButton(
              onPressed: () => _showAddEntryDialog(context, notifier),
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add),
            ),
    );
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Widget _buildTimetableSelector(
    TimetableManagementState state,
    TimetableManagementNotifier notifier,
  ) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      color: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Timetables',
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                onPressed: () => _showCreateTimetableDialog(context, notifier),
                icon: const Icon(Icons.add),
                label: const Text('Create'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (state.myTimetables.isEmpty)
            const Text('No timetables yet. Create one to get started.')
          else
            Wrap(
              spacing: 8,
              children: state.myTimetables.map((timetable) {
                final isSelected = state.selectedTimetableId == timetable.id;
                return ChoiceChip(
                  label: Text(timetable.displayTitle),
                  selected: isSelected,
                  onSelected: (_) => notifier.selectTimetable(timetable.id),
                  selectedColor: AppColors.primary,
                  labelStyle: isSelected
                      ? const TextStyle(color: Colors.white)
                      : null,
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildEntriesList(
    TimetableManagementState state,
    TimetableManagementNotifier notifier,
  ) {
    final entries = state.selectedTimetable!.entries;

    if (entries.isEmpty) {
      return const Center(
        child: Text('No classes yet. Tap + to add your first class.'),
      );
    }

    // Group by day
    final byDay = <DayOfWeek, List>{};
    for (final entry in entries) {
      byDay.putIfAbsent(entry.dayOfWeek, () => []).add(entry);
    }

    return ListView(
      padding: EdgeInsets.all(AppSpacing.md),
      children: DayOfWeek.values.map((day) {
        final dayEntries = byDay[day] ?? [];
        if (dayEntries.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              day.displayName,
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...dayEntries.map(
              (entry) => Card(
                child: ListTile(
                  title: Text(entry.subjectName),
                  subtitle: Text(
                    '${entry.timeRange}${entry.professor != null ? ' • ${entry.professor}' : ''}${entry.place != null ? ' • ${entry.place}' : ''}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _confirmDelete(context, notifier, entry),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }

  Future<void> _showCreateTimetableDialog(
    BuildContext context,
    TimetableManagementNotifier notifier,
  ) async {
    final titleController = TextEditingController();
    int? selectedSemesterId;

    final semesters = ref.read(semestersProvider);
    if (semesters.isEmpty) {
      await notifier.loadSemesters();
    }

    // Auto-select current semester if available
    final currentSemester =
        semesters.where((s) => s.isCurrent).firstOrNull ??
        semesters.firstOrNull;
    selectedSemesterId = currentSemester?.id;

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Timetable'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title (optional)',
                hintText: 'e.g., My Spring Schedule',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'Semester'),
              initialValue: selectedSemesterId,
              items: ref
                  .read(semestersProvider)
                  .map(
                    (s) => DropdownMenuItem(
                      value: s.id,
                      child: Text(
                        '${s.displayName}${s.isCurrent ? " (Current)" : ""}',
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) => selectedSemesterId = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (selectedSemesterId != null) {
                final success = await notifier.createTimetable(
                  semesterId: selectedSemesterId!,
                  title: titleController.text.isEmpty
                      ? null
                      : titleController.text,
                );
                if (success && context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddEntryDialog(
    BuildContext context,
    TimetableManagementNotifier notifier,
  ) async {
    final subjectController = TextEditingController();
    final professorController = TextEditingController();
    final placeController = TextEditingController();
    DayOfWeek? selectedDay;
    TimeOfDay? startTime;
    TimeOfDay? endTime;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add Class'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: subjectController,
                  decoration: const InputDecoration(labelText: 'Subject Name'),
                ),
                TextField(
                  controller: professorController,
                  decoration: const InputDecoration(
                    labelText: 'Professor (optional)',
                  ),
                ),
                TextField(
                  controller: placeController,
                  decoration: const InputDecoration(
                    labelText: 'Place (optional)',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<DayOfWeek>(
                  decoration: const InputDecoration(labelText: 'Day'),
                  initialValue: selectedDay,
                  items: DayOfWeek.values
                      .map(
                        (d) => DropdownMenuItem(
                          value: d,
                          child: Text(d.displayName),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(() => selectedDay = value),
                ),
                const SizedBox(height: 8),
                ListTile(
                  title: const Text('Start Time'),
                  subtitle: Text(startTime?.format(context) ?? 'Select'),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() => startTime = time);
                    }
                  },
                ),
                ListTile(
                  title: const Text('End Time'),
                  subtitle: Text(endTime?.format(context) ?? 'Select'),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() => endTime = time);
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (subjectController.text.isNotEmpty &&
                    selectedDay != null &&
                    startTime != null &&
                    endTime != null) {
                  final success = await notifier.addEntry(
                    subjectName: subjectController.text,
                    professor: professorController.text.isEmpty
                        ? null
                        : professorController.text,
                    dayOfWeek: selectedDay!,
                    startTime:
                        '${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}',
                    endTime:
                        '${endTime!.hour.toString().padLeft(2, '0')}:${endTime!.minute.toString().padLeft(2, '0')}',
                    place: placeController.text.isEmpty
                        ? null
                        : placeController.text,
                  );
                  if (success && context.mounted) {
                    Navigator.pop(context);
                  } else if (!success && context.mounted) {
                    _showErrorSnackBar(
                      ref.read(timetableErrorProvider) ?? 'Failed to add class',
                    );
                  }
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    TimetableManagementNotifier notifier,
    entry,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Class'),
        content: Text('Delete "${entry.subjectName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await notifier.deleteEntry(entry.id);
    }
  }
}
