import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/timetable_entry.dart';
import '../../domain/entities/day_of_week.dart';

/// Weekly time grid widget showing hours and days
class WeeklyTimeGrid extends StatelessWidget {
  final List<TimetableEntry> entries;
  final Function(TimetableEntry)? onEntryTap;

  const WeeklyTimeGrid({super.key, this.entries = const [], this.onEntryTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Days header
          _buildDaysHeader(),

          // Time grid
          Expanded(child: _buildTimeGrid()),
        ],
      ),
    );
  }

  Widget _buildDaysHeader() {
    final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.3),
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
            final dayName = weekDays[index];

            return Expanded(
              child: Center(
                child: Text(
                  dayName,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
      child: Stack(
        children: [
          Row(
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

              // Days grid background
              Expanded(
                child: Column(
                  children: timeSlots.map((hour) {
                    return Container(
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withValues(alpha: 0.2),
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
                                          color: Colors.white.withValues(
                                            alpha: 0.2,
                                          ),
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
              ),
            ],
          ),

          // Events Overlay
          Positioned.fill(
            left: 50, // Skip time column
            child: LayoutBuilder(
              builder: (context, constraints) {
                final dayWidth = constraints.maxWidth / 5;

                return Stack(
                  children: entries
                      .where((e) {
                        // Only show Mon(1) to Fri(5)
                        final dayNum = e.dayOfWeek.weekdayNumber;
                        return dayNum >= 1 && dayNum <= 5;
                      })
                      .map((entry) {
                        // Check for conflicts
                        final hasConflict = entries.any(
                          (other) =>
                              other.id != entry.id && entry.conflictsWith(other),
                        );

                        // Calculate position
                        final dayIndex = entry.dayOfWeek.weekdayNumber - 1;

                        final startParts = entry.startTime.split(':');
                        final startHour = int.parse(startParts[0]);
                        final startMin = int.parse(startParts[1]);

                        // Grid starts at 9:00. Each hour is 80px.
                        final double top =
                            ((startHour - 9) * 80) + (startMin / 60 * 80);
                        final double height =
                            (entry.durationInMinutes / 60) * 80;

                        return Positioned(
                          left: dayIndex * dayWidth,
                          width: dayWidth,
                          top: top,
                          height: height,
                          child: GestureDetector(
                            onTap: () => onEntryTap?.call(entry),
                            child: Container(
                              margin: EdgeInsets.all(2),
                              padding: EdgeInsets.all(4),
                                                          decoration: BoxDecoration(
                                                            color: Color(
                                                              entry.displayColor,
                                                            ).withValues(alpha: hasConflict ? 0.6 : 0.8),
                                                            borderRadius: BorderRadius.circular(4),
                                                            border: hasConflict
                                                                ? Border.all(color: Colors.red, width: 2)
                                                                : null,
                                                          ),
                              
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    entry.subjectName,
                                    style: AppTypography.caption.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (entry.place != null)
                                    Text(
                                      entry.place!,
                                      style: AppTypography.caption.copyWith(
                                        color: Colors.white.withValues(
                                          alpha: 0.9,
                                        ),
                                        fontSize: 9,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  if (height > 40 && entry.professor != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        entry.professor!,
                                        style: AppTypography.caption.copyWith(
                                          color: Colors.white.withValues(
                                            alpha: 0.8,
                                          ),
                                          fontSize: 8,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
