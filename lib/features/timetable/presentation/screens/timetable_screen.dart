import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/components/glass_container.dart';
import '../../domain/entities/event.dart';
import '../providers/timetable_provider.dart';
import '../widgets/calendar_grid.dart';
import '../widgets/calendar_header.dart';
import '../widgets/event_card.dart';

/// Main timetable screen with calendar views
class TimetableScreen extends ConsumerWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(timetableProvider);
    final notifier = ref.read(timetableProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Dars jadvali'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showCreateEventDialog(context, ref),
            icon: const Icon(Icons.add),
            tooltip: 'Yangi tadbir qo\'shish',
          ),
          IconButton(
            onPressed: () => _showSearchDialog(context, ref),
            icon: const Icon(Icons.search),
            tooltip: 'Qidirish',
          ),
        ],
      ),
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
              // Calendar header with navigation
              Padding(
                padding: EdgeInsets.all(AppSpacing.md),
                child: CalendarHeader(
                  viewType: state.viewType,
                  focusedDate: state.focusedDate,
                  onPrevious: () => notifier.navigatePrevious(),
                  onNext: () => notifier.navigateNext(),
                  onToday: () => notifier.navigateToToday(),
                ),
              ),

              // View type selector
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: ViewTypeSelector(
                  selectedViewType: state.viewType,
                  onViewTypeChanged: (viewType) => notifier.changeViewType(viewType),
                ),
              ),

              SizedBox(height: AppSpacing.md),

              // Calendar content based on view type
              Expanded(
                child: _buildCalendarView(context, ref, state, notifier),
              ),

              // Selected date events (when not in schedule view)
              if (state.viewType != CalendarViewType.schedule) ...[
                SizedBox(height: AppSpacing.md),
                _buildSelectedDateEvents(context, ref, state),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarView(
    BuildContext context,
    WidgetRef ref,
    TimetableState state,
    TimetableNotifier notifier,
  ) {
    switch (state.viewType) {
      case CalendarViewType.month:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: CalendarGrid(
            focusedDate: state.focusedDate,
            selectedDate: state.selectedDate,
            events: state.eventsForFocusedMonth,
            onDateSelected: (date) => notifier.selectDate(date),
          ),
        );

      case CalendarViewType.week:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: WeekCalendarView(
            focusedDate: state.focusedDate,
            selectedDate: state.selectedDate,
            events: state.eventsForFocusedWeek,
            onDateSelected: (date) => notifier.selectDate(date),
          ),
        );

      case CalendarViewType.day:
        return _buildDayView(context, ref, state);

      case CalendarViewType.schedule:
        return _buildScheduleView(context, ref, state);
    }
  }

  Widget _buildDayView(BuildContext context, WidgetRef ref, TimetableState state) {
    final dayEvents = state.eventsForSelectedDate;

    if (dayEvents.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_note,
              size: 64,
              color: AppColors.textSecondary.withOpacity(0.5),
            ),
            SizedBox(height: AppSpacing.md),
            Text(
              'Bu kunda tadbirlar yo\'q',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(AppSpacing.md),
      itemCount: dayEvents.length,
      itemBuilder: (context, index) {
        final event = dayEvents[index];
        return EventCard(
          event: event,
          onTap: () => _showEventDetails(context, event),
          onLongPress: () => _showEventOptions(context, ref, event),
        );
      },
    );
  }

  Widget _buildScheduleView(BuildContext context, WidgetRef ref, TimetableState state) {
    final upcomingEvents = state.upcomingEvents;

    if (upcomingEvents.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.schedule,
              size: 64,
              color: AppColors.textSecondary.withOpacity(0.5),
            ),
            SizedBox(height: AppSpacing.md),
            Text(
              'Yaqin orada tadbirlar yo\'q',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    // Group events by date
    final groupedEvents = <DateTime, List<Event>>{};
    for (final event in upcomingEvents) {
      final date = DateTime(event.startTime.year, event.startTime.month, event.startTime.day);
      groupedEvents[date] = (groupedEvents[date] ?? [])..add(event);
    }

    final sortedDates = groupedEvents.keys.toList()..sort();

    return ListView.builder(
      padding: EdgeInsets.all(AppSpacing.md),
      itemCount: sortedDates.length,
      itemBuilder: (context, index) {
        final date = sortedDates[index];
        final dayEvents = groupedEvents[date]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date header
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _formatDateHeader(date),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            SizedBox(height: AppSpacing.sm),

            // Events for this date
            ...dayEvents.map((event) => Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.sm),
              child: EventCard(
                event: event,
                onTap: () => _showEventDetails(context, event),
                onLongPress: () => _showEventOptions(context, ref, event),
              ),
            )),

            if (index < sortedDates.length - 1) SizedBox(height: AppSpacing.md),
          ],
        );
      },
    );
  }

  Widget _buildSelectedDateEvents(BuildContext context, WidgetRef ref, TimetableState state) {
    final dayEvents = state.eventsForSelectedDate;

    if (dayEvents.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: GlassContainer(
        borderColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Text(
                  'Tanlangan kun tadbirlari',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${dayEvents.length} ta',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSpacing.md),

            // Events list
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dayEvents.length,
                itemBuilder: (context, index) {
                  final event = dayEvents[index];
                  return Padding(
                    padding: EdgeInsets.only(right: AppSpacing.sm),
                    child: SizedBox(
                      width: 200,
                      child: EventCard(
                        event: event,
                        compact: true,
                        onTap: () => _showEventDetails(context, event),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return 'Bugun';
    } else if (dateOnly == tomorrow) {
      return 'Ertaga';
    } else {
      return '${date.day}.${date.month}.${date.year}';
    }
  }

  void _showCreateEventDialog(BuildContext context, WidgetRef ref) {
    context.go('/timetable/create');
  }

  void _showSearchDialog(BuildContext context, WidgetRef ref) {
    // TODO: Implement search dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Qidirish - tez orada!')),
    );
  }

  void _showEventDetails(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(event.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Vaqt: ${event.timeRange}'),
            if (event.location != null) Text('Joy: ${event.location}'),
            if (event.description.isNotEmpty) ...[
              SizedBox(height: AppSpacing.sm),
              Text('Tavsif:'),
              Text(event.description),
            ],
            if (event.tags != null && event.tags!.isNotEmpty) ...[
              SizedBox(height: AppSpacing.sm),
              Text('Teglar: ${event.tags!.join(", ")}'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Yopish'),
          ),
        ],
      ),
    );
  }

  void _showEventOptions(BuildContext context, WidgetRef ref, Event event) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Tahrirlash'),
            onTap: () {
              Navigator.of(context).pop();
              // TODO: Implement edit event
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tadbir tahrirlash - tez orada!')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: AppColors.error),
            title: const Text('O\'chirish', style: TextStyle(color: AppColors.error)),
            onTap: () {
              Navigator.of(context).pop();
              _showDeleteConfirmation(context, ref, event);
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, Event event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tadbirni o\'chirish'),
        content: Text('"${event.title}" tadbirini o\'chirishni xohlaysizmi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Bekor qilish'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final success = await ref.read(timetableProvider.notifier).deleteEvent(event.id);
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tadbir o\'chirildi')),
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('O\'chirish'),
          ),
        ],
      ),
    );
  }
}
