import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import 'glass_container.dart';

/// Mock post model for profile display
class ProfilePost {
  final String title;
  final String preview;
  final int views;
  final int likes;
  final int comments;

  const ProfilePost({
    required this.title,
    required this.preview,
    required this.views,
    required this.likes,
    required this.comments,
  });
}

/// Post card widget with glassmorphism design
class ProfilePostCard extends StatelessWidget {
  final ProfilePost post;
  final VoidCallback? onTap;

  const ProfilePostCard({
    super.key,
    required this.post,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      margin: EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        bottom: AppSpacing.md,
      ),
      padding: EdgeInsets.all(AppSpacing.lg),
      borderRadius: 20,
      blur: 15,
      opacity: 0.15,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              post.title,
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            SizedBox(height: AppSpacing.sm),

            // Preview
            Text(
              post.preview,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: AppSpacing.md),

            // Stats
            Row(
              children: [
                _StatBadge(
                  icon: Icons.visibility_outlined,
                  value: '${post.views} views',
                ),
                SizedBox(width: AppSpacing.md),
                _StatBadge(
                  icon: Icons.thumb_up_outlined,
                  value: '${post.likes} likes',
                ),
                SizedBox(width: AppSpacing.md),
                _StatBadge(
                  icon: Icons.chat_bubble_outline,
                  value: '${post.comments} comments',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Stat badge widget
class _StatBadge extends StatelessWidget {
  final IconData icon;
  final String value;

  const _StatBadge({
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.textSecondary,
        ),
        SizedBox(width: AppSpacing.xxs),
        Text(
          value,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

/// Mock data for posts
class MockPosts {
  static final List<ProfilePost> posts = [
    const ProfilePost(
      title: 'Best cafes near TUIT campus?',
      preview: 'Looking for recommendations for good study cafes with wifi near the university. Any...',
      views: 245,
      likes: 32,
      comments: 18,
    ),
    const ProfilePost(
      title: 'Data Structures midterm - what to expect?',
      preview: 'Has anyone taken Prof. Karimov\'s midterm before? What topics should I focus on?',
      views: 189,
      likes: 45,
      comments: 27,
    ),
  ];
}
