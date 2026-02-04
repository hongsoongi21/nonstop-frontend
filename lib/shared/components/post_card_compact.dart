import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../features/board/domain/entities/post.entity.dart';
import '../../core/utils/date_utils.dart';
import '../../core/l10n/app_localizations.dart';

/// Compact post card for list views - shows only essential info
class PostCardCompact extends StatelessWidget {
  final PostEntity post;
  final VoidCallback? onTap;
  final VoidCallback? onLike;
  final VoidCallback? onMenuTap;

  const PostCardCompact({
    super.key,
    required this.post,
    this.onTap,
    this.onLike,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm + 2,
          ),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.surfaceVariant.withValues(alpha: 0.3)
                : AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark
                  ? AppColors.border.withValues(alpha: 0.3)
                  : AppColors.border,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Main content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      post.title,
                      style: AppTypography.body1.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : AppColors.textPrimary,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    // Meta info
                    Row(
                      children: [
                        // Author
                        Text(
                          post.isWriterAnonymous
                              ? l10n.anonymous
                              : post.writerNickname,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        _dot(),
                        // Time
                        Text(
                          timeAgo(post.createdAt),
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                        const Spacer(),
                        // Stats
                        _statIcon(Icons.favorite_border, post.likeCount),
                        const SizedBox(width: 12),
                        _statIcon(Icons.chat_bubble_outline, post.commentCount),
                      ],
                    ),
                  ],
                ),
              ),
              // Menu button
              if (onMenuTap != null) ...[
                const SizedBox(width: 4),
                IconButton(
                  onPressed: onMenuTap,
                  icon: Icon(
                    Icons.more_vert,
                    size: 18,
                    color: AppColors.textTertiary,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _dot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Text(
        '·',
        style: TextStyle(
          color: AppColors.textTertiary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _statIcon(IconData icon, int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textTertiary),
        const SizedBox(width: 3),
        Text(
          '$count',
          style: AppTypography.caption.copyWith(
            color: AppColors.textTertiary,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
