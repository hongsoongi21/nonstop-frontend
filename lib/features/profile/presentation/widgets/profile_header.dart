import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/user_profile.dart';

/// Profile header widget showing cover image, avatar, and basic info
class ProfileHeader extends StatelessWidget {
  final UserProfile profile;
  final bool isEditing;
  final VoidCallback? onEditPressed;
  final VoidCallback? onAvatarPressed;
  final VoidCallback? onCoverPressed;

  const ProfileHeader({
    super.key,
    required this.profile,
    this.isEditing = false,
    this.onEditPressed,
    this.onAvatarPressed,
    this.onCoverPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Cover Image
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            image: profile.coverImageUrl != null
                ? DecorationImage(
                    image: NetworkImage(profile.coverImageUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: profile.coverImageUrl == null
              ? Center(
                  child: Icon(
                    Icons.photo_camera,
                    size: 48,
                    color: AppColors.primary.withOpacity(0.5),
                  ),
                )
              : null,
        ),

        // Edit Cover Button (when editing)
        if (isEditing && onCoverPressed != null)
          Positioned(
            top: AppSpacing.md,
            right: AppSpacing.md,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: onCoverPressed,
                icon: const Icon(Icons.camera_alt),
                tooltip: 'Cover rasmini o\'zgartirish',
              ),
            ),
          ),

        // Profile Info Card
        Positioned(
          left: AppSpacing.md,
          right: AppSpacing.md,
          bottom: 0,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Avatar
                      Stack(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.surface,
                                width: 3,
                              ),
                              image: profile.avatarUrl != null
                                  ? DecorationImage(
                                      image: NetworkImage(profile.avatarUrl!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: profile.avatarUrl == null
                                ? CircleAvatar(
                                    radius: 37,
                                    backgroundColor: AppColors.primary.withOpacity(0.1),
                                    child: Text(
                                      profile.displayNameOrFullName[0].toUpperCase(),
                                      style: AppTypography.headlineSmall.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                : null,
                          ),

                          // Edit Avatar Button (when editing)
                          if (isEditing && onAvatarPressed != null)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(AppSpacing.xxs),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.surface,
                                    width: 2,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: onAvatarPressed,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 16,
                                    color: AppColors.surface,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),

                      SizedBox(width: AppSpacing.md),

                      // Name and Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile.displayNameOrFullName,
                              style: AppTypography.headlineSmall.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            if (profile.major != null && profile.year != null) ...[
                              SizedBox(height: AppSpacing.xxs),
                              Text(
                                '${profile.major} - ${profile.year}-kurs',
                                style: AppTypography.bodyMedium.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],

                            if (profile.universityId != null) ...[
                              SizedBox(height: AppSpacing.xxs),
                              Text(
                                'Toshkent Davlat Iqtisodiyot Universiteti', // Mock university name
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),

                      // Edit Button
                      if (onEditPressed != null)
                        IconButton(
                          onPressed: onEditPressed,
                          icon: Icon(isEditing ? Icons.close : Icons.edit),
                          tooltip: isEditing ? 'Tahrirlashni bekor qilish' : 'Profilni tahrirlash',
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
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  // Location
                  if (profile.location != null && profile.location!.isNotEmpty) ...[
                    SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: AppSpacing.xxs),
                        Text(
                          profile.location!,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],

                  // Social Links
                  if (_hasSocialLinks(profile)) ...[
                    SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        if (profile.linkedinUrl != null)
                          _SocialLinkButton(
                            icon: Icons.business,
                            url: profile.linkedinUrl!,
                            tooltip: 'LinkedIn',
                          ),
                        if (profile.githubUrl != null) ...[
                          SizedBox(width: AppSpacing.sm),
                          _SocialLinkButton(
                            icon: Icons.code,
                            url: profile.githubUrl!,
                            tooltip: 'GitHub',
                          ),
                        ],
                        if (profile.instagramUrl != null) ...[
                          SizedBox(width: AppSpacing.sm),
                          _SocialLinkButton(
                            icon: Icons.camera_alt,
                            url: profile.instagramUrl!,
                            tooltip: 'Instagram',
                          ),
                        ],
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool _hasSocialLinks(UserProfile profile) {
    return profile.linkedinUrl != null ||
           profile.githubUrl != null ||
           profile.instagramUrl != null;
  }
}

/// Social link button widget
class _SocialLinkButton extends StatelessWidget {
  final IconData icon;
  final String url;
  final String tooltip;

  const _SocialLinkButton({
    required this.icon,
    required this.url,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Open URL
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$tooltip: $url')),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(AppSpacing.xxs),
        decoration: BoxDecoration(
          color: AppColors.surfaceSecondary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 20,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
