import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/profile_stats.dart' as domain;
import '../../domain/entities/user_profile.dart';
import 'glass_container.dart';

/// Profile statistics widget with glassmorphism design
class ProfileStats extends StatelessWidget {
  final UserProfile profile;
  final domain.ProfileStats stats;
  final VoidCallback? onEditProfilePressed;

  const ProfileStats({
    super.key,
    required this.profile,
    required this.stats,
    this.onEditProfilePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: EdgeInsets.all(AppSpacing.lg),
      borderRadius: 20,
      blur: 15,
      opacity: 0.15,
      child: Column(
        children: [
          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(
                value: '24',
                label: 'My Posts',
              ),
              Container(
                width: 1,
                height: 40,
                color: AppColors.textSecondary.withOpacity(0.2),
              ),
              _StatItem(
                value: '156',
                label: 'My Comments',
              ),
              Container(
                width: 1,
                height: 40,
                color: AppColors.textSecondary.withOpacity(0.2),
              ),
              _StatItem(
                value: '48',
                label: 'Friends',
              ),
            ],
          ),

          SizedBox(height: AppSpacing.lg),

          // Edit Profile Button
          InkWell(
            onTap: onEditProfilePressed,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  'Edit Profile',
                  style: AppTypography.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Individual stat item widget
class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppSpacing.xxs),
        Text(
          label,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
