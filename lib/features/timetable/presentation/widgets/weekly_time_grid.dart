import 'package:flutter/material.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
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
    // Get current day to highlight today column
    final today = DateTime.now().weekday;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,
            offset: const Offset(0, 4),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        children: [
          // Days header
          _buildDaysHeader(today),

          // Time grid
          Expanded(child: _buildTimeGrid()),
        ],
      ),
    );
  }

  Widget _buildDaysHeader(int today) {
    return Builder(
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        final weekDays = [
          {'short': l10n.dayMondayShort, 'full': l10n.dayMonday, 'day': 1},
          {'short': l10n.dayTuesdayShort, 'full': l10n.dayTuesday, 'day': 2},
          {'short': l10n.dayWednesdayShort, 'full': l10n.dayWednesday, 'day': 3},
          {'short': l10n.dayThursdayShort, 'full': l10n.dayThursday, 'day': 4},
          {'short': l10n.dayFridayShort, 'full': l10n.dayFriday, 'day': 5},
        ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.border,
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          // Empty space for time column with clean styling
          Container(
            width: 64,
            alignment: Alignment.center,
            child: Icon(
              Icons.schedule,
              size: 20,
              color: AppColors.primary.withValues(alpha: 0.6),
            ),
          ),

          // Day headers with today highlight
          ...weekDays.map((day) {
            final isToday = day['day'] == today;

            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isToday
                      ? AppColors.timetableToday.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: isToday
                      ? Border.all(
                          color: AppColors.timetableToday,
                          width: 2,
                        )
                      : null,
                ),
                child: Column(
                  children: [
                    Text(
                      day['short'] as String,
                      style: AppTypography.labelSmall.copyWith(
                        color: isToday
                            ? AppColors.timetableToday
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                    if (isToday) ...[
                      const SizedBox(height: 2),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: AppColors.timetableToday,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
      },
    );
  }

  Widget _buildTimeGrid() {
    // Get current day to highlight today column
    final today = DateTime.now().weekday;

    // Time slots from 8 AM to 9 PM (extended for flexibility)
    final timeSlots = List.generate(14, (index) => 8 + index);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Time column with refined typography
              Column(
                children: timeSlots.map((hour) {
                  // Highlight current hour
                  final now = DateTime.now();
                  final isCurrentHour = now.hour == hour;

                  return Container(
                    height: 88,
                    width: 64,
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isCurrentHour
                            ? AppColors.primary.withValues(alpha: 0.08)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        hour < 10 ? '0$hour:00' : '$hour:00',
                        style: AppTypography.caption.copyWith(
                          color: isCurrentHour
                              ? AppColors.primary
                              : AppColors.textTertiary,
                          fontWeight: isCurrentHour
                              ? FontWeight.w700
                              : FontWeight.w500,
                          letterSpacing: 0.5,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              // Days grid background with today column highlight
              Expanded(
                child: Column(
                  children: timeSlots.map((hour) {
                    final isCurrentHour = DateTime.now().hour == hour;

                    return Container(
                      height: 88,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: isCurrentHour
                                ? AppColors.primary.withValues(alpha: 0.15)
                                : AppColors.borderLight,
                            width: isCurrentHour ? 2 : 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: List.generate(5, (dayIndex) {
                          final dayNumber = dayIndex + 1;
                          final isToday = dayNumber == today;

                          return Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: isToday
                                    ? AppColors.timetableToday
                                        .withValues(alpha: 0.02)
                                    : Colors.transparent,
                                border: Border(
                                  left: dayIndex > 0
                                      ? BorderSide(
                                          color: isToday || (dayIndex == today)
                                              ? AppColors.border
                                              : AppColors.borderLight,
                                          width: isToday ? 1.5 : 1,
                                        )
                                      : BorderSide.none,
                                  right: isToday
                                      ? const BorderSide(
                                          color: AppColors.border,
                                          width: 1.5,
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

          // Events Overlay with enhanced styling
          Positioned.fill(
            left: 64, // Skip time column
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

                        // Grid starts at 8:00. Each hour is 88px.
                        final double top =
                            ((startHour - 8) * 88) + (startMin / 60 * 88);
                        final double height =
                            (entry.durationInMinutes / 60) * 88;

                        final courseColor = Color(entry.displayColor);

                        return Positioned(
                          left: dayIndex * dayWidth,
                          width: dayWidth,
                          top: top,
                          height: height,
                          child: GestureDetector(
                            onTap: () => onEntryTap?.call(entry),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: hasConflict
                                      ? [
                                          AppColors.timetableConflict
                                              .withValues(alpha: 0.85),
                                          AppColors.timetableConflict
                                              .withValues(alpha: 0.95),
                                        ]
                                      : [
                                          courseColor.withValues(alpha: 0.92),
                                          courseColor,
                                        ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: hasConflict
                                      ? AppColors.timetableConflict
                                      : courseColor.withValues(alpha: 0.3),
                                  width: hasConflict ? 2.5 : 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: hasConflict
                                        ? AppColors.timetableConflict
                                            .withValues(alpha: 0.25)
                                        : courseColor.withValues(alpha: 0.2),
                                    offset: const Offset(0, 3),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(11),
                                child: Stack(
                                  children: [
                                    // Subtle pattern overlay
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.white
                                                  .withValues(alpha: 0.1),
                                              Colors.transparent,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Content
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 8,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (hasConflict)
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 6,
                                                vertical: 2,
                                              ),
                                              margin: const EdgeInsets.only(
                                                bottom: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                    Icons.warning_rounded,
                                                    size: 10,
                                                    color: AppColors
                                                        .timetableConflict,
                                                  ),
                                                  const SizedBox(width: 3),
                                                  Text(
                                                    AppLocalizations.of(context)!.conflict,
                                                    style: AppTypography
                                                        .overline
                                                        .copyWith(
                                                      color: AppColors
                                                          .timetableConflict,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          Text(
                                            entry.subjectName,
                                            style: AppTypography.labelSmall
                                                .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 11,
                                              height: 1.3,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          if (entry.place != null) ...[
                                            const SizedBox(height: 3),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  size: 10,
                                                  color: Colors.white
                                                      .withValues(alpha: 0.9),
                                                ),
                                                const SizedBox(width: 3),
                                                Expanded(
                                                  child: Text(
                                                    entry.place!,
                                                    style: AppTypography.caption
                                                        .copyWith(
                                                      color: Colors.white
                                                          .withValues(
                                                              alpha: 0.95),
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                          if (height > 55 &&
                                              entry.professor != null) ...[
                                            const SizedBox(height: 3),
                                            Text(
                                              entry.professor!,
                                              style: AppTypography.caption
                                                  .copyWith(
                                                color: Colors.white
                                                    .withValues(alpha: 0.85),
                                                fontSize: 9,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.italic,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
