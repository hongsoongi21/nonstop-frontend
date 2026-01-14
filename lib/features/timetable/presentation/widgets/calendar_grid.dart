import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/event.dart';

/// Calendar grid widget for month view
class CalendarGrid extends StatelessWidget {
  final DateTime focusedDate;
  final DateTime? selectedDate;
  final List<Event> events;
  final ValueChanged<DateTime> onDateSelected;

  const CalendarGrid({
    super.key,
    required this.focusedDate,
    this.selectedDate,
    this.events = const [],
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _getDaysInMonth(focusedDate);
    final firstDayOfMonth = DateTime(focusedDate.year, focusedDate.month, 1);
    final firstDayWeekday = firstDayOfMonth.weekday; // 1 = Monday, 7 = Sunday
    final totalCells = daysInMonth + (firstDayWeekday - 1);

    return Column(
      children: [
        // Weekday headers
        Row(
          children: _getWeekdayHeaders(),
        ),
        SizedBox(height: AppSpacing.sm),

        // Calendar grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemCount: totalCells,
          itemBuilder: (context, index) {
            if (index < firstDayWeekday - 1) {
              // Empty cells before the first day
              return const SizedBox.shrink();
            }

            final dayNumber = index - (firstDayWeekday - 2);
            final date = DateTime(focusedDate.year, focusedDate.month, dayNumber);
            final dayEvents = events.forDate(date);
            final isSelected = selectedDate != null &&
                date.year == selectedDate!.year &&
                date.month == selectedDate!.month &&
                date.day == selectedDate!.day;
            final isToday = date.year == DateTime.now().year &&
                date.month == DateTime.now().month &&
                date.day == DateTime.now().day;

            return CalendarDayCell(
              date: date,
              events: dayEvents,
              isSelected: isSelected,
              isToday: isToday,
              onTap: () => onDateSelected(date),
            );
          },
        ),
      ],
    );
  }

  List<Widget> _getWeekdayHeaders() {
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays.map((day) => Expanded(
      child: Center(
        child: Text(
          day,
          style: AppTypography.labelMedium.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
      ),
    )).toList();
  }

  int _getDaysInMonth(DateTime date) {
    final nextMonth = DateTime(date.year, date.month + 1, 1);
    final lastDayOfMonth = nextMonth.subtract(const Duration(days: 1));
    return lastDayOfMonth.day;
  }
}

/// Individual day cell in the calendar grid
class CalendarDayCell extends StatelessWidget {
  final DateTime date;
  final List<Event> events;
  final bool isSelected;
  final bool isToday;
  final VoidCallback onTap;

  const CalendarDayCell({
    super.key,
    required this.date,
    this.events = const [],
    this.isSelected = false,
    this.isToday = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasEvents = events.isNotEmpty;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : isToday
                  ? Colors.white.withOpacity(0.6)
                  : Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: isToday && !isSelected
              ? Border.all(color: AppColors.primary, width: 2)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Day number
            Text(
              date.day.toString(),
              style: AppTypography.bodyMedium.copyWith(
                color: isSelected
                    ? Colors.white
                    : AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),

            SizedBox(height: 6),

            // Event indicators - Simple colored dots
            if (hasEvents) ...[
              Expanded(
                child: Column(
                  children: [
                    // Show up to 3 event indicators as colored bars
                    ...events.take(3).map((event) {
                      final color = Color(event.color ?? event.typeColor);
                      return Container(
                        width: double.infinity,
                        height: 4,
                        margin: EdgeInsets.only(bottom: 2),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white.withOpacity(0.9) : color,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Week view calendar widget
class WeekCalendarView extends StatelessWidget {
  final DateTime focusedDate;
  final DateTime? selectedDate;
  final List<Event> events;
  final ValueChanged<DateTime> onDateSelected;

  const WeekCalendarView({
    super.key,
    required this.focusedDate,
    this.selectedDate,
    this.events = const [],
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final weekStart = focusedDate.subtract(Duration(days: focusedDate.weekday - 1));
    final weekDays = List.generate(7, (index) => weekStart.add(Duration(days: index)));

    return Column(
      children: [
        // Time header (hours)
        Row(
          children: [
            SizedBox(width: 60), // Space for day labels
            ...List.generate(24, (hour) => Expanded(
              child: Center(
                child: Text(
                  hour == 0 ? '12 AM' : hour < 12 ? '${hour}AM' : hour == 12 ? '12 PM' : '${hour - 12}PM',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            )),
          ],
        ),
        SizedBox(height: AppSpacing.sm),

        // Days with time slots
        Expanded(
          child: ListView.builder(
            itemCount: 7,
            itemBuilder: (context, dayIndex) {
              final day = weekDays[dayIndex];
              final dayEvents = events.forDate(day);
              final isSelected = selectedDate != null &&
                  day.year == selectedDate!.year &&
                  day.month == selectedDate!.month &&
                  day.day == selectedDate!.day;
              final isToday = day.year == DateTime.now().year &&
                  day.month == DateTime.now().month &&
                  day.day == DateTime.now().day;

              return Container(
                height: 60,
                margin: EdgeInsets.only(bottom: AppSpacing.xxs),
                child: Row(
                  children: [
                    // Day label
                    SizedBox(
                      width: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('E').format(day),
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            day.day.toString(),
                            style: AppTypography.bodySmall.copyWith(
                              color: isSelected
                                  ? AppColors.primary
                                  : isToday
                                      ? AppColors.secondary
                                      : AppColors.textPrimary,
                              fontWeight: isSelected || isToday ? FontWeight.w600 : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Time slots for the day
                    Expanded(
                      child: Stack(
                        children: [
                          // Time slot grid lines
                          Row(
                            children: List.generate(24, (index) => Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: index < 23 ? 0.5 : 0),
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: index > 0 ? BorderSide(
                                      color: AppColors.surfaceSecondary,
                                      width: 0.5,
                                    ) : BorderSide.none,
                                  ),
                                ),
                              ),
                            )),
                          ),

                          // Events positioned on the timeline
                          ...dayEvents.map((event) {
                            final startHour = event.startTime.hour + event.startTime.minute / 60.0;
                            final duration = event.durationInMinutes / 60.0;
                            final left = (startHour / 24) * MediaQuery.of(context).size.width * 0.8; // Approximate width
                            final width = (duration / 24) * MediaQuery.of(context).size.width * 0.8;

                            return Positioned(
                              left: left,
                              top: 5,
                              width: width,
                              height: 50,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
                                decoration: BoxDecoration(
                                  color: Color(event.color ?? event.typeColor).withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    event.title,
                                    style: AppTypography.labelSmall.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
