import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/user_profile.dart';
import 'glass_container.dart';

/// Profile header widget with glassmorphism design
class ProfileHeader extends StatelessWidget {
  final UserProfile profile;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onSettingsPressed;

  const ProfileHeader({
    super.key,
    required this.profile,
    this.onNotificationPressed,
    this.onSettingsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      margin: EdgeInsets.all(AppSpacing.md),
      padding: EdgeInsets.all(AppSpacing.lg),
      borderRadius: 24,
      blur: 15,
      opacity: 0.15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and action icons
          Row(
            children: [
              Text(
                'Profile',
                style: AppTypography.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              // Notification Bell
              GlassContainer(
                padding: EdgeInsets.all(AppSpacing.sm),
                borderRadius: 12,
                blur: 8,
                opacity: 0.1,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      onPressed: onNotificationPressed,
                      icon: const Icon(Icons.notifications_outlined),
                      color: AppColors.textPrimary,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      iconSize: 24,
                    ),
                    // Red dot for new notifications
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: AppSpacing.sm),
              // Settings
              GlassContainer(
                padding: EdgeInsets.all(AppSpacing.sm),
                borderRadius: 12,
                blur: 8,
                opacity: 0.1,
                child: IconButton(
                  onPressed: onSettingsPressed,
                  icon: const Icon(Icons.settings_outlined),
                  color: AppColors.textPrimary,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  iconSize: 24,
                ),
              ),
            ],
          ),

          SizedBox(height: AppSpacing.lg),

          // Profile Info Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                  image: profile.avatarUrl != null
                      ? DecorationImage(
                          image: NetworkImage(profile.avatarUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: profile.avatarUrl == null
                    ? CircleAvatar(
                        radius: 43.5,
                        backgroundColor: AppColors.primary.withOpacity(0.2),
                        child: Text(
                          profile.displayNameOrFullName[0].toUpperCase(),
                          style: AppTypography.headlineLarge.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : null,
              ),

              SizedBox(width: AppSpacing.md),

              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Username
                    Text(
                      profile.displayNameOrFullName,
                      style: AppTypography.headlineSmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: AppSpacing.xxs),

                    // University and Major
                    if (profile.major != null)
                      Text(
                        '${profile.universityId != null ? 'TUIT' : ''} • ${profile.major}',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                    SizedBox(height: AppSpacing.xxs),

                    // Student ID
                    Text(
                      'Student #${profile.id}',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Bio
          if (profile.bio != null && profile.bio!.isNotEmpty) ...[
            SizedBox(height: AppSpacing.md),
            Text(
              profile.bio!,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
