import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/mock/mock_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/extensions/context_extensions.dart';

/// User profile card component
class UserProfileCard extends StatelessWidget {
  final User user;
  final VoidCallback? onTap;
  final bool showUniversity;
  final bool showStats;

  const UserProfileCard({
    super.key,
    required this.user,
    this.onTap,
    this.showUniversity = true,
    this.showStats = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              // Avatar with online indicator
              Stack(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    child: user.avatarUrl != null
                        ? ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: user.avatarUrl!,
                              fit: BoxFit.cover,
                              width: 64,
                              height: 64,
                              placeholder: (context, url) => Container(
                                color: context.surfaceVariantColor,
                                child: const Center(
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: context.surfaceVariantColor,
                                child: Icon(Icons.person, color: context.textSecondaryColor),
                              ),
                            ),
                          )
                        : Text(
                            user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                            style: AppTypography.headline5.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ],
              ),

              SizedBox(width: AppSpacing.md),

              // User info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      user.name,
                      style: AppTypography.body1.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: AppSpacing.xs),

                    // Email
                    Text(
                      user.email,
                      style: AppTypography.caption.copyWith(
                        color: context.textSecondaryColor,
                      ),
                    ),

                    if (user.major != null) ...[
                      SizedBox(height: 2),
                      Text(
                        user.major!,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],

                    if (showUniversity) ...[
                      SizedBox(height: AppSpacing.xs),
                      Row(
                        children: [
                          Icon(
                            Icons.school,
                            size: 14,
                            color: context.textHintColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            user.university.shortName,
                            style: AppTypography.caption.copyWith(
                              color: context.textHintColor,
                            ),
                          ),
                        ],
                      ),
                    ],

                    if (showStats) ...[
                      SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          _StatItem(label: 'Year', value: '${user.year ?? 1}'),
                          SizedBox(width: AppSpacing.lg),
                          _StatItem(label: 'Friends', value: '24'),
                          SizedBox(width: AppSpacing.lg),
                          _StatItem(label: 'Posts', value: '12'),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Action button
              Icon(
                Icons.chevron_right,
                color: context.textHintColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Compact user profile for lists
class UserListItem extends StatelessWidget {
  final User user;
  final VoidCallback? onTap;
  final String? subtitle;

  const UserListItem({
    super.key,
    required this.user,
    this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            child: user.avatarUrl != null
                ? ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: user.avatarUrl!,
                      fit: BoxFit.cover,
                      width: 48,
                      height: 48,
                      placeholder: (context, url) => Container(
                        color: AppColors.surfaceVariant,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.surfaceVariant,
                        child: const Icon(Icons.person, color: AppColors.textSecondary),
                      ),
                    ),
                  )
                : Text(
                    user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                    style: AppTypography.body1.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ],
      ),
      title: Text(
        user.name,
        style: AppTypography.body1.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: AppTypography.caption.copyWith(
                color: context.textSecondaryColor,
              ),
            )
          : Text(
              '${user.major ?? 'Student'} • ${user.university.shortName}',
              style: AppTypography.caption.copyWith(
                color: context.textSecondaryColor,
              ),
            ),
      trailing: Icon(
        Icons.chevron_right,
        color: context.textHintColor,
      ),
    );
  }
}

/// University selector component
class UniversitySelector extends StatelessWidget {
  final University? selectedUniversity;
  final ValueChanged<University>? onUniversitySelected;

  const UniversitySelector({
    super.key,
    this.selectedUniversity,
    this.onUniversitySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Your University',
          style: AppTypography.body1.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),

        SizedBox(height: AppSpacing.md),

        ...MockData.universities.map((university) => Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.sm),
              child: UniversityCard(
                university: university,
                isSelected: selectedUniversity?.id == university.id,
                onTap: () => onUniversitySelected?.call(university),
              ),
            )),
      ],
    );
  }
}

/// University card component
class UniversityCard extends StatelessWidget {
  final University university;
  final bool isSelected;
  final VoidCallback? onTap;

  const UniversityCard({
    super.key,
    required this.university,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        side: isSelected
            ? BorderSide(color: Color(university.color), width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              // Logo
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Color(university.color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: university.logoUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        child: CachedNetworkImage(
                          imageUrl: university.logoUrl,
                          fit: BoxFit.cover,
                          width: 48,
                          height: 48,
                          placeholder: (context, url) => Container(
                            color: context.surfaceVariantColor,
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: context.surfaceVariantColor,
                            child: Icon(Icons.image, color: context.textSecondaryColor),
                          ),
                        ),
                      )
                    : Icon(
                        Icons.school,
                        color: Color(university.color),
                        size: 24,
                      ),
              ),

              SizedBox(width: AppSpacing.md),

              // University info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      university.name,
                      style: AppTypography.body1.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      university.shortName,
                      style: AppTypography.caption.copyWith(
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Selection indicator
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: Color(university.color),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Stat item component
class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.body1.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: AppTypography.caption.copyWith(
            color: context.textSecondaryColor,
          ),
        ),
      ],
    );
  }
}

/// Achievement badge component
class AchievementBadge extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool isEarned;

  const AchievementBadge({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.isEarned = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEarned ? 1.0 : 0.5,
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isEarned ? color.withValues(alpha: 0.1) : context.surfaceColor,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: isEarned ? color : context.borderColor,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isEarned ? color : context.textHintColor,
              size: 32,
            ),

            SizedBox(height: AppSpacing.sm),

            Text(
              title,
              style: AppTypography.body2.copyWith(
                fontWeight: FontWeight.w600,
                color: isEarned ? context.textPrimaryColor : context.textHintColor,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 4),

            Text(
              description,
              style: AppTypography.caption.copyWith(
                color: isEarned ? context.textSecondaryColor : context.textHintColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
