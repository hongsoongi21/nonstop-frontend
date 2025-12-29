import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/profile_stats.dart' as domain;
import '../../domain/entities/user_profile.dart';

/// Profile statistics widget showing user activity and achievements
class ProfileStats extends StatelessWidget {
  final UserProfile profile;
  final domain.ProfileStats stats;

  const ProfileStats({super.key, required this.profile, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(AppSpacing.md),
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.bar_chart, color: AppColors.primary, size: 24),
                SizedBox(width: AppSpacing.sm),
                Text(
                  'Statistika',
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xxs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Faol foydalanuvchi',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSpacing.md),

            // Activity Level Progress
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Faollik darajasi',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      '${stats.overallScore}/${stats.activityLevel.minScore + 100}',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.xxs),
                LinearProgressIndicator(
                  value:
                      stats.overallScore /
                      (stats.activityLevel.minScore + 100).clamp(
                        1,
                        double.infinity,
                      ),
                  backgroundColor: AppColors.surfaceSecondary,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.primary,
                  ),
                ),
                SizedBox(height: AppSpacing.xxs),
                Text(
                  stats.activityLevel.description,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSpacing.lg),

            // Stats Grid
            Row(
              children: [
                Expanded(
                  child: _StatItem(
                    icon: Icons.post_add,
                    value: '${stats.totalPosts}',
                    label: 'Postlar',
                    color: AppColors.primary,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    icon: Icons.thumb_up,
                    value: '${stats.totalLikesReceived}',
                    label: 'Layklar',
                    color: AppColors.success,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    icon: Icons.comment,
                    value: '${stats.totalCommentsReceived}',
                    label: 'Izohlar',
                    color: AppColors.warning,
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSpacing.md),

            // Additional Stats
            Row(
              children: [
                Expanded(
                  child: _StatItem(
                    icon: Icons.calendar_today,
                    value: '${stats.daysActive}',
                    label: 'Faol kunlar',
                    color: AppColors.info,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    icon: Icons.trending_up,
                    value: '${stats.longestLoginStreak}',
                    label: 'Eng uzun ketma-ket',
                    color: AppColors.secondary,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    icon: Icons.access_time,
                    value: '${stats.postsPerDay.toStringAsFixed(1)}x',
                    label: 'O\'rtacha',
                    color: AppColors.universityRed,
                  ),
                ),
              ],
            ),

            // Activity Status
            Container(
              margin: EdgeInsets.only(top: AppSpacing.md),
              padding: EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: stats.isActiveRecently
                    ? AppColors.success.withOpacity(0.1)
                    : AppColors.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: stats.isActiveRecently
                      ? AppColors.success.withOpacity(0.3)
                      : AppColors.warning.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    stats.isActiveRecently
                        ? Icons.check_circle
                        : Icons.schedule,
                    color: stats.isActiveRecently
                        ? AppColors.success
                        : AppColors.warning,
                    size: 20,
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      stats.isActiveRecently
                          ? 'Siz faol foydalanuvchisiz! Davom eting!'
                          : 'Oxirgi haftada faol emassiz. Qaytib keling!',
                      style: AppTypography.bodySmall.copyWith(
                        color: stats.isActiveRecently
                            ? AppColors.success
                            : AppColors.warning,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual stat item widget
class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(height: AppSpacing.xxs),
        Text(
          value,
          style: AppTypography.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppSpacing.xxs),
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ],
    );
  }
}
