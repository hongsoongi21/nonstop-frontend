import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/profile_stats.dart' as domain;
import '../../domain/entities/user_profile.dart';

/// Profile statistics widget - Clean numeric styling with bold edit button
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.md)
          .copyWith(top: AppSpacing.md),
      child: Column(
        children: [
          // Stats Row - Clean card design
          Container(
            padding: EdgeInsets.symmetric(
              vertical: AppSpacing.xl,
              horizontal: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.border,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.04),
                  blurRadius: 24,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(
                  value: '24',
                  label: 'Posts',
                  color: AppColors.primary,
                ),
                Container(
                  width: 1,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.border,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                _StatItem(
                  value: '156',
                  label: 'Comments',
                  color: AppColors.tertiary,
                ),
                Container(
                  width: 1,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.border,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                _StatItem(
                  value: '48',
                  label: 'Friends',
                  color: AppColors.secondary,
                ),
              ],
            ),
          ),

          SizedBox(height: AppSpacing.md),

          // Edit Profile Button - Bold and prominent
          InkWell(
            onTap: onEditProfilePressed,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: AppSpacing.md + 2),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppColors.primary,
                    AppColors.primaryDark,
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 16,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Text(
                    'Edit Profile',
                    style: AppTypography.button.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Individual stat item widget with numeric typography
class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Number with accent color
        Container(
          padding: EdgeInsets.all(AppSpacing.xs),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            value,
            style: AppTypography.numeric.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 28,
              height: 1,
            ),
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        // Label
        Text(
          label,
          style: AppTypography.caption.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
