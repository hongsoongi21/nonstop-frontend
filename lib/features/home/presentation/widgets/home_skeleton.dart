import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

/// Loading-state placeholder for `HomeScreen`.
///
/// Mirrors the layout of `HomeNoticeBanner`, `TodayTimetableSection`,
/// and `PopularContentSection` so the page does not jump when real data
/// arrives. Animation is driven by a single shared `AnimationController`
/// so all shimmer boxes pulse in sync.
class HomeSkeleton extends StatefulWidget {
  const HomeSkeleton({super.key});

  @override
  State<HomeSkeleton> createState() => _HomeSkeletonState();
}

class _HomeSkeletonState extends State<HomeSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _NoticeBannerSkeleton(controller: _controller),
            const SizedBox(height: AppSpacing.lg),
            _TodayTimetableSkeleton(controller: _controller),
            const SizedBox(height: AppSpacing.lg),
            _PopularContentSkeleton(controller: _controller),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class _NoticeBannerSkeleton extends StatelessWidget {
  final AnimationController controller;
  const _NoticeBannerSkeleton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Card(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              _ShimmerBox(
                controller: controller,
                width: 56,
                height: 20,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _ShimmerBox(controller: controller, height: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TodayTimetableSkeleton extends StatelessWidget {
  final AnimationController controller;
  const _TodayTimetableSkeleton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ShimmerBox(controller: controller, width: 120, height: 18),
          const SizedBox(height: AppSpacing.sm),
          for (int i = 0; i < 3; i++) ...[
            _EntryCardSkeleton(controller: controller),
            if (i < 2) const SizedBox(height: AppSpacing.xs),
          ],
        ],
      ),
    );
  }
}

class _EntryCardSkeleton extends StatelessWidget {
  final AnimationController controller;
  const _EntryCardSkeleton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: SizedBox(
        height: 64,
        child: Row(
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppSpacing.radiusMd),
                  bottomLeft: Radius.circular(AppSpacing.radiusMd),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              child: _ShimmerBox(
                controller: controller,
                width: 36,
                height: 12,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ShimmerBox(controller: controller, width: 140, height: 14),
                    const SizedBox(height: 6),
                    _ShimmerBox(controller: controller, width: 90, height: 10),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: _ShimmerBox(controller: controller, width: 36, height: 10),
            ),
          ],
        ),
      ),
    );
  }
}

class _PopularContentSkeleton extends StatelessWidget {
  final AnimationController controller;
  const _PopularContentSkeleton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ShimmerBox(controller: controller, width: 160, height: 18),
              _ShimmerBox(controller: controller, width: 60, height: 14),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Card(
            color: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
            child: Column(
              children: [
                for (int i = 0; i < 5; i++) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ShimmerBox(
                          controller: controller,
                          width: 56,
                          height: 20,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusSm),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _ShimmerBox(
                                controller: controller,
                                height: 12,
                              ),
                              const SizedBox(height: 6),
                              _ShimmerBox(
                                controller: controller,
                                width: 80,
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (i < 4)
                    const Divider(
                      height: 1,
                      thickness: 0.5,
                      indent: AppSpacing.md,
                      endIndent: AppSpacing.md,
                      color: AppColors.divider,
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Single animated shimmer rectangle. Shares the parent `controller`
/// so multiple instances stay phase-synchronized.
class _ShimmerBox extends StatelessWidget {
  final AnimationController controller;
  final double width;
  final double height;
  final BorderRadius borderRadius;

  static const _baseColor = Color(0xFFE5E7EB);
  static const _highlightColor = Color(0xFFF3F4F6);

  const _ShimmerBox({
    required this.controller,
    this.width = double.infinity,
    this.height = 14,
    BorderRadius? borderRadius,
  }) : borderRadius = borderRadius ??
            const BorderRadius.all(Radius.circular(4));

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final t = controller.value;
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [_baseColor, _highlightColor, _baseColor],
              stops: [
                (t - 0.3).clamp(0.0, 1.0),
                t.clamp(0.0, 1.0),
                (t + 0.3).clamp(0.0, 1.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
