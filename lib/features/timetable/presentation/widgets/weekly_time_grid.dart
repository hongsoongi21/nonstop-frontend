import 'package:flutter/material.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../domain/entities/timetable_entry.dart';
import '../../domain/entities/day_of_week.dart';

/// Weekly time grid widget showing hours and days - Everytime style
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
        color: const Color(0xFF0A0A0A), // Pure dark background
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF1A1A1A),
          width: 1,
        ),
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
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFF1A1A1A),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              // Empty space for time column
              const SizedBox(
                width: 48,
              ),

              // Day headers - minimal style
              ...weekDays.map((day) {
                final isToday = day['day'] == today;

                return Expanded(
                  child: Center(
                    child: Text(
                      day['short'] as String,
                      style: TextStyle(
                        color: isToday
                            ? const Color(0xFFFFFFFF)
                            : const Color(0xFF999999),
                        fontSize: 13,
                        fontWeight: isToday ? FontWeight.w600 : FontWeight.w500,
                        letterSpacing: 0,
                      ),
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
    // Time slots from 9 AM to 5 PM (Everytime style)
    final timeSlots = List.generate(9, (index) => 9 + index);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Time column - simple numbers
              Column(
                children: timeSlots.map((hour) {
                  // Format hour as simple number (12-hour after noon)
                  final displayHour = hour > 12 ? hour - 12 : hour;

                  return Container(
                    height: 60,
                    width: 48,
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      '$displayHour',
                      style: const TextStyle(
                        color: Color(0xFF666666),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1,
                      ),
                    ),
                  );
                }).toList(),
              ),

              // Days grid background - minimal
              Expanded(
                child: Column(
                  children: timeSlots.map((hour) {
                    return Container(
                      height: 60,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Color(0xFF1A1A1A),
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
                                      ? const BorderSide(
                                          color: Color(0xFF1A1A1A),
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

          // Events Overlay - flat Everytime style
          Positioned.fill(
            left: 48, // Skip time column
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

                        // Grid starts at 9:00. Each hour is 60px.
                        final double top =
                            ((startHour - 9) * 60) + (startMin / 60 * 60);
                        final double height =
                            (entry.durationInMinutes / 60) * 60;

                        // Muted pastel colors for Everytime style
                        final courseColor = _getMutedColor(entry.displayColor);

                        return Positioned(
                          left: dayIndex * dayWidth,
                          width: dayWidth,
                          top: top,
                          height: height,
                          child: GestureDetector(
                            onTap: () => onEntryTap?.call(entry),
                            child: Container(
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                // Flat solid color - no gradient
                                color: hasConflict
                                    ? const Color(0xFFD84545)
                                    : courseColor,
                                borderRadius: BorderRadius.circular(4),
                                // No shadows - pure flat design
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 6,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Course name
                                    Text(
                                      entry.subjectName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11,
                                        height: 1.2,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    // Location
                                    if (entry.place != null) ...[
                                      const SizedBox(height: 2),
                                      Text(
                                        entry.place!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
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

  // Convert display color to muted pastel for Everytime aesthetic
  Color _getMutedColor(int colorValue) {
    final original = Color(colorValue);
    final hsl = HSLColor.fromColor(original);

    // Create muted pastel version: reduce saturation, adjust lightness
    final muted = hsl.withSaturation((hsl.saturation * 0.5).clamp(0.3, 0.6))
        .withLightness((hsl.lightness * 0.9).clamp(0.45, 0.65));

    return muted.toColor();
  }
}
