import 'package:flutter/material.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/timetable_entry.dart';
import '../../domain/entities/day_of_week.dart';

/// Weekly time grid widget showing hours and days - Everytime style
/// Supports both light and dark themes
class WeeklyTimeGrid extends StatelessWidget {
  final List<TimetableEntry> entries;
  final Function(TimetableEntry)? onEntryTap;

  const WeeklyTimeGrid({super.key, this.entries = const [], this.onEntryTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final today = DateTime.now().weekday;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0A0A0A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xFF1A1A1A) : AppColors.border,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildDaysHeader(context, today, isDark),
          Expanded(child: _buildTimeGrid(context, isDark)),
        ],
      ),
    );
  }

  Widget _buildDaysHeader(BuildContext context, int today, bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    final weekDays = [
      {'short': l10n.dayMondayShort, 'day': 1},
      {'short': l10n.dayTuesdayShort, 'day': 2},
      {'short': l10n.dayWednesdayShort, 'day': 3},
      {'short': l10n.dayThursdayShort, 'day': 4},
      {'short': l10n.dayFridayShort, 'day': 5},
    ];

    final borderColor = isDark ? const Color(0xFF1A1A1A) : AppColors.border;
    final defaultTextColor = isDark ? const Color(0xFF999999) : AppColors.textSecondary;
    final todayTextColor = isDark ? Colors.white : AppColors.primary;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: borderColor, width: 1),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 48),
          ...weekDays.map((day) {
            final isToday = day['day'] == today;
            return Expanded(
              child: Center(
                child: Text(
                  day['short'] as String,
                  style: TextStyle(
                    color: isToday ? todayTextColor : defaultTextColor,
                    fontSize: 13,
                    fontWeight: isToday ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTimeGrid(BuildContext context, bool isDark) {
    // Time slots from 9 AM to 9 PM
    final timeSlots = List.generate(13, (index) => 9 + index);

    final borderColor = isDark ? const Color(0xFF1A1A1A) : AppColors.borderLight;
    final hourTextColor = isDark ? const Color(0xFF666666) : AppColors.textTertiary;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Time column
              Column(
                children: timeSlots.map((hour) {
                  final displayHour = hour > 12 ? hour - 12 : hour;
                  return Container(
                    height: 60,
                    width: 48,
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      '$displayHour',
                      style: TextStyle(
                        color: hourTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
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
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: borderColor, width: 1),
                        ),
                      ),
                      child: Row(
                        children: List.generate(5, (dayIndex) {
                          return Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  left: dayIndex > 0
                                      ? BorderSide(color: borderColor, width: 1)
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

          // Course entries overlay
          Positioned.fill(
            left: 48,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final dayWidth = constraints.maxWidth / 5;

                return Stack(
                  children: entries
                      .where((e) {
                        final dayNum = e.dayOfWeek.weekdayNumber;
                        return dayNum >= 1 && dayNum <= 5;
                      })
                      .map((entry) {
                        final hasConflict = entries.any(
                          (other) => other.id != entry.id && entry.conflictsWith(other),
                        );

                        final dayIndex = entry.dayOfWeek.weekdayNumber - 1;

                        final startParts = entry.startTime.split(':');
                        final startHour = int.parse(startParts[0]);
                        final startMin = int.parse(startParts[1]);

                        final double top = ((startHour - 9) * 60) + (startMin / 60 * 60);
                        final double height = (entry.durationInMinutes / 60) * 60;

                        final courseColor = _getMutedColor(entry.displayColor, isDark);

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
                                color: hasConflict
                                    ? const Color(0xFFD84545)
                                    : courseColor,
                                borderRadius: BorderRadius.circular(4),
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

  /// Convert display color to muted pastel for Everytime aesthetic
  Color _getMutedColor(int colorValue, bool isDark) {
    final original = Color(colorValue);
    final hsl = HSLColor.fromColor(original);

    if (isDark) {
      // Dark mode: muted, slightly darker pastels
      final muted = hsl
          .withSaturation((hsl.saturation * 0.5).clamp(0.3, 0.6))
          .withLightness((hsl.lightness * 0.9).clamp(0.45, 0.65));
      return muted.toColor();
    } else {
      // Light mode: brighter, more vibrant pastels
      final muted = hsl
          .withSaturation((hsl.saturation * 0.7).clamp(0.4, 0.7))
          .withLightness((hsl.lightness).clamp(0.5, 0.7));
      return muted.toColor();
    }
  }
}
