import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/event.dart';

/// Weekly time grid widget showing hours and days like Korean everytime app
class WeeklyTimeGrid extends StatelessWidget {
  final DateTime focusedDate;
  final DateTime? selectedDate;
  final List<Event> events;
  final ValueChanged<DateTime>? onDateSelected;

  const WeeklyTimeGrid({
    super.key,
    required this.focusedDate,
    this.selectedDate,
    this.events = const [],
    this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Days header
          _buildDaysHeader(),

          // Time grid
          Expanded(
            child: _buildTimeGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildDaysHeader() {
    final weekStart = focusedDate.subtract(Duration(days: focusedDate.weekday - 1));
    final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Empty space for time column
          SizedBox(width: 50),

          // Day headers
          ...List.generate(5, (index) {
            final date = weekStart.add(Duration(days: index));
            final dayName = weekDays[index];
            final dayNumber = date.day;

            return Expanded(
              child: Column(
                children: [
                  Text(
                    dayName,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    dayNumber.toString(),
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTimeGrid() {
    // Time slots from 9 AM to 9 PM
    final timeSlots = List.generate(13, (index) => 9 + index);

    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time column
          Column(
            children: timeSlots.map((hour) {
              return Container(
                height: 80,
                width: 50,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  hour.toString(),
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),

          // Days grid
          Expanded(
            child: Stack(
              children: [
                // Grid lines
                Column(
                  children: timeSlots.map((hour) {
                    return Container(
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: List.generate(5, (dayIndex) {
                          return Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  left: dayIndex > 0
                                      ? BorderSide(
                                          color: Colors.white.withOpacity(0.2),
                                          width: 1,
                                        )
                                      : BorderSide.none,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  }).toList(),
                ),

                // Events/classes will be positioned here
                // TODO: Add event blocks positioned based on time and day
              ],
            ),
          ),
        ],
      ),
    );
  }
}
