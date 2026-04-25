import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_loading_skeleton.dart';

/// Loading placeholder for the post-detail screen.
///
/// Approximates the real layout of `BoardDetailScreen`:
///   - body section: optional category pill, title, multi-line content,
///     view/like meta row
///   - comments section: a few comment rows (avatar + name + bubble)
///
/// Used in place of a centered spinner so the page header (AppBar)
/// settles immediately and the body fades in without a layout jump.
class PostDetailSkeleton extends StatelessWidget {
  const PostDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category pill (optional in real screen — keep here for layout fidelity)
          AppLoadingSkeleton(
            width: 56,
            height: 22,
            borderRadius: BorderRadius.circular(12),
          ),
          const SizedBox(height: AppSpacing.md),
          // Title (2 lines)
          const AppLoadingSkeleton.text(fontSize: 22),
          const SizedBox(height: 8),
          const AppLoadingSkeleton.text(width: 220, fontSize: 22),
          const SizedBox(height: AppSpacing.md),
          // Body content (4 lines, last one short)
          const AppLoadingSkeleton.text(fontSize: 14),
          const SizedBox(height: 8),
          const AppLoadingSkeleton.text(fontSize: 14),
          const SizedBox(height: 8),
          const AppLoadingSkeleton.text(fontSize: 14),
          const SizedBox(height: 8),
          const AppLoadingSkeleton.text(width: 200, fontSize: 14),
          const SizedBox(height: AppSpacing.lg),
          // Stats chips (view + like)
          Row(
            children: [
              AppLoadingSkeleton(
                width: 64,
                height: 28,
                borderRadius: BorderRadius.circular(14),
              ),
              const SizedBox(width: AppSpacing.sm),
              AppLoadingSkeleton(
                width: 64,
                height: 28,
                borderRadius: BorderRadius.circular(14),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Divider(color: context.borderColor, height: 1),
          const SizedBox(height: AppSpacing.lg),
          // Comments
          for (int i = 0; i < 3; i++) ...[
            _CommentSkeleton(bubbleWidth: i.isEven ? 240.0 : 180.0),
            if (i < 2) const SizedBox(height: AppSpacing.lg),
          ],
        ],
      ),
    );
  }
}

class _CommentSkeleton extends StatelessWidget {
  final double bubbleWidth;
  const _CommentSkeleton({required this.bubbleWidth});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppLoadingSkeleton.circle(size: 36),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppLoadingSkeleton.text(width: 90, fontSize: 13),
              const SizedBox(height: 6),
              AppLoadingSkeleton(
                width: bubbleWidth,
                height: 36,
                borderRadius: BorderRadius.circular(12),
              ),
              const SizedBox(height: 6),
              const AppLoadingSkeleton.text(width: 120, fontSize: 11),
            ],
          ),
        ),
      ],
    );
  }
}
