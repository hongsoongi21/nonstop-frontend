import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

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

/// Post card widget - Clean card with border accent
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
    return Container(
      margin: EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        bottom: AppSpacing.md,
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.border,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title with accent line
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 4,
                      height: 20,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primary,
                            AppColors.tertiary,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        post.title,
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppSpacing.sm),

                // Preview
                Padding(
                  padding: EdgeInsets.only(left: AppSpacing.sm + 4),
                  child: Text(
                    post.preview,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                SizedBox(height: AppSpacing.md),

                // Stats with colored icons
                Padding(
                  padding: EdgeInsets.only(left: AppSpacing.sm + 4),
                  child: Row(
                    children: [
                      _StatBadge(
                        icon: Icons.visibility_outlined,
                        value: post.views.toString(),
                        color: AppColors.tertiary,
                      ),
                      SizedBox(width: AppSpacing.lg),
                      _StatBadge(
                        icon: Icons.thumb_up_outlined,
                        value: post.likes.toString(),
                        color: AppColors.accent,
                      ),
                      SizedBox(width: AppSpacing.lg),
                      _StatBadge(
                        icon: Icons.chat_bubble_outline,
                        value: post.comments.toString(),
                        color: AppColors.secondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Stat badge widget with colored icon
class _StatBadge extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;

  const _StatBadge({
    required this.icon,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 14,
            color: color,
          ),
        ),
        SizedBox(width: AppSpacing.xs),
        Text(
          value,
          style: AppTypography.numeric.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            height: 1,
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
