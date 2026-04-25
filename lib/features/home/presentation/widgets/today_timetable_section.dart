import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/today_timetable.dart';
import '../../domain/entities/home_timetable_entry.dart';

/// Renders today's classes plus a live "remaining time" / "starts in"
/// label. The whole section rebuilds once per minute via a single
/// `Timer.periodic`, so child cards don't need their own timers.
class TodayTimetableSection extends StatefulWidget {
  final TodayTimetable timetable;

  const TodayTimetableSection({super.key, required this.timetable});

  @override
  State<TodayTimetableSection> createState() => _TodayTimetableSectionState();
}

class _TodayTimetableSectionState extends State<TodayTimetableSection> {
  Timer? _ticker;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _ticker = Timer.periodic(const Duration(minutes: 1), (_) {
      if (!mounted) return;
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.homeTodayTitle,
            style: AppTypography.headline5.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (!widget.timetable.hasTimetable && widget.timetable.isEmpty) {
      return _buildNoTimetableCard(context);
    }

    if (widget.timetable.isEmpty) {
      final l10n = AppLocalizations.of(context)!;
      return Card(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Center(
            child: Text(
              l10n.homeTodayEmpty,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ),
      );
    }

    final sorted = [...widget.timetable.entries]
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sorted.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.xs),
      itemBuilder: (context, index) =>
          _EntryCard(entry: sorted[index], now: _now),
    );
  }

  Widget _buildNoTimetableCard(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Text(
              l10n.homeTodayEmptyCta,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.sm),
            ElevatedButton(
              onPressed: () => context.go(Routes.timetable),
              child: Text(l10n.homeTodayCreateTimetable),
            ),
          ],
        ),
      ),
    );
  }
}

enum _EntryStatus { upcoming, soonStart, inProgress, ended }

class _EntryCard extends StatelessWidget {
  final HomeTimetableEntry entry;
  final DateTime now;

  const _EntryCard({required this.entry, required this.now});

  Color? _parseColor(String? hexColor) {
    if (hexColor == null) return null;
    try {
      final cleaned = hexColor.replaceAll('#', '');
      final value = int.parse(
        cleaned.length == 6 ? 'FF$cleaned' : cleaned,
        radix: 16,
      );
      return Color(value);
    } catch (_) {
      return null;
    }
  }

  /// Parses an `HH:MM` server string against today's date.
  DateTime? _parseTime(String hhmm) {
    final parts = hhmm.split(':');
    if (parts.length < 2) return null;
    final h = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    if (h == null || m == null) return null;
    return DateTime(now.year, now.month, now.day, h, m);
  }

  /// Computes the entry's live status and the relevant minute count.
  ({_EntryStatus status, int minutes}) _computeStatus() {
    final start = _parseTime(entry.startTime);
    final end = _parseTime(entry.endTime);
    if (start == null || end == null) {
      return (status: _EntryStatus.upcoming, minutes: 0);
    }
    if (!now.isBefore(end)) {
      return (status: _EntryStatus.ended, minutes: 0);
    }
    if (!now.isBefore(start)) {
      final remaining = end.difference(now).inMinutes + 1;
      return (status: _EntryStatus.inProgress, minutes: remaining);
    }
    final until = start.difference(now).inMinutes;
    if (until <= 5) {
      return (status: _EntryStatus.soonStart, minutes: until);
    }
    return (status: _EntryStatus.upcoming, minutes: until);
  }

  Widget? _buildStatusBadge(BuildContext context, _EntryStatus status,
      int minutes) {
    final l10n = AppLocalizations.of(context)!;
    String label;
    Color background;
    Color foreground;
    switch (status) {
      case _EntryStatus.inProgress:
        label = '${l10n.homeTodayInProgress} · ${l10n.homeTodayMinutesLeft(minutes)}';
        background = AppColors.primary50;
        foreground = AppColors.primary;
      case _EntryStatus.soonStart:
        label = '${l10n.homeTodayUpcoming} · ${l10n.homeTodayMinutesUntil(minutes)}';
        background = AppColors.warning.withValues(alpha: 0.12);
        foreground = AppColors.warning;
      case _EntryStatus.ended:
        label = l10n.homeTodayEnded;
        background = AppColors.divider;
        foreground = AppColors.textTertiary;
      case _EntryStatus.upcoming:
        return null;
    }
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(
        label,
        style: AppTypography.caption.copyWith(
          color: foreground,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = _parseColor(entry.color) ?? AppColors.primary;
    final result = _computeStatus();
    final badge = _buildStatusBadge(context, result.status, result.minutes);
    final isEnded = result.status == _EntryStatus.ended;

    return Opacity(
      opacity: isEnded ? 0.55 : 1.0,
      child: Card(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 4,
                decoration: BoxDecoration(
                  color: borderColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppSpacing.radiusMd),
                    bottomLeft: Radius.circular(AppSpacing.radiusMd),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.sm,
                ),
                child: Text(
                  entry.startTime,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              entry.subjectName ?? '(과목명 없음)',
                              style: AppTypography.body2.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (badge != null) ...[
                            const SizedBox(width: AppSpacing.xs),
                            badge,
                          ],
                        ],
                      ),
                      if (entry.professor != null || entry.place != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          [
                            if (entry.professor != null) entry.professor!,
                            if (entry.place != null) entry.place!,
                          ].join(' · '),
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: Text(
                  entry.endTime,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
