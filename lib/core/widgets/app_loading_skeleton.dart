import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../extensions/context_extensions.dart';

/// Skeleton loading components with shimmer effect
/// Provides visual feedback during content loading with "Samarkand Modern" aesthetic
class AppLoadingSkeleton extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;
  final SkeletonShape shape;

  const AppLoadingSkeleton({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius,
    this.margin,
    this.shape = SkeletonShape.rectangle,
  });

  /// Circle skeleton (for avatars)
  const AppLoadingSkeleton.circle({
    super.key,
    required double size,
    this.margin,
  })  : width = size,
        height = size,
        shape = SkeletonShape.circle,
        borderRadius = null;

  /// Text line skeleton
  const AppLoadingSkeleton.text({
    super.key,
    this.width = double.infinity,
    double fontSize = 14,
    this.margin,
  })  : height = fontSize * 1.2,
        shape = SkeletonShape.rectangle,
        borderRadius = const BorderRadius.all(Radius.circular(4));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: shape == SkeletonShape.circle
            ? null
            : (borderRadius ?? BorderRadius.circular(AppSpacing.radiusMd)),
        shape: shape == SkeletonShape.circle
            ? BoxShape.circle
            : BoxShape.rectangle,
      ),
      child: _ShimmerEffect(
        baseColor: context.surfaceVariantColor,
        highlightColor: context.surfaceColor,
        child: Container(
          decoration: BoxDecoration(
            color: context.surfaceVariantColor,
            borderRadius: shape == SkeletonShape.circle
                ? null
                : (borderRadius ?? BorderRadius.circular(AppSpacing.radiusMd)),
            shape: shape == SkeletonShape.circle
                ? BoxShape.circle
                : BoxShape.rectangle,
          ),
        ),
      ),
    );
  }
}

/// Pre-built skeleton layouts for common use cases
class SkeletonLayouts {
  /// List item skeleton with avatar and text
  static Widget listItem({
    bool hasAvatar = true,
    bool hasSubtitle = true,
    EdgeInsetsGeometry? padding,
  }) {
    return Padding(
      padding: padding ?? EdgeInsets.all(AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasAvatar) ...[
            const AppLoadingSkeleton.circle(size: 48),
            SizedBox(width: AppSpacing.md),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppLoadingSkeleton.text(width: 200, fontSize: 16),
                if (hasSubtitle) ...[
                  SizedBox(height: AppSpacing.sm),
                  const AppLoadingSkeleton.text(width: 150, fontSize: 14),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Card skeleton with image and content
  static Widget card({
    double imageHeight = 160,
    bool hasTitle = true,
    bool hasSubtitle = true,
    bool hasFooter = true,
    EdgeInsetsGeometry? padding,
  }) {
    return Builder(
      builder: (context) => Container(
        margin: padding ?? EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(color: context.borderColor),
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          AppLoadingSkeleton(
            height: imageHeight,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSpacing.radiusLg),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hasTitle) ...[
                  const AppLoadingSkeleton.text(width: 180, fontSize: 18),
                  SizedBox(height: AppSpacing.sm),
                ],
                if (hasSubtitle) ...[
                  const AppLoadingSkeleton.text(fontSize: 14),
                  SizedBox(height: AppSpacing.xs),
                  const AppLoadingSkeleton.text(width: 240, fontSize: 14),
                ],
                if (hasFooter) ...[
                  SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      const AppLoadingSkeleton.circle(size: 24),
                      SizedBox(width: AppSpacing.sm),
                      const AppLoadingSkeleton.text(width: 100, fontSize: 12),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  /// Post skeleton (for social feeds)
  static Widget post({EdgeInsetsGeometry? padding}) {
    return Builder(
      builder: (context) => Container(
        margin: padding ?? EdgeInsets.all(AppSpacing.md),
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(color: context.borderColor),
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header (avatar + name)
          Row(
            children: [
              const AppLoadingSkeleton.circle(size: 40),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppLoadingSkeleton.text(width: 120, fontSize: 16),
                    SizedBox(height: AppSpacing.xs),
                    const AppLoadingSkeleton.text(width: 80, fontSize: 12),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: AppSpacing.md),

          // Content lines
          const AppLoadingSkeleton.text(fontSize: 14),
          SizedBox(height: AppSpacing.sm),
          const AppLoadingSkeleton.text(width: 280, fontSize: 14),
          SizedBox(height: AppSpacing.sm),
          const AppLoadingSkeleton.text(width: 200, fontSize: 14),

          SizedBox(height: AppSpacing.md),

          // Action buttons
          Row(
            children: [
              const AppLoadingSkeleton(width: 80, height: 32),
              SizedBox(width: AppSpacing.md),
              const AppLoadingSkeleton(width: 80, height: 32),
              SizedBox(width: AppSpacing.md),
              const AppLoadingSkeleton(width: 80, height: 32),
            ],
          ),
        ],
      ),
      ),
    );
  }

  /// Profile skeleton
  static Widget profile({EdgeInsetsGeometry? padding}) {
    return Padding(
      padding: padding ?? EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          // Avatar
          const AppLoadingSkeleton.circle(size: 96),

          SizedBox(height: AppSpacing.lg),

          // Name
          const AppLoadingSkeleton.text(width: 160, fontSize: 20),

          SizedBox(height: AppSpacing.sm),

          // Bio
          const AppLoadingSkeleton.text(width: 200, fontSize: 14),

          SizedBox(height: AppSpacing.xl),

          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatSkeleton(),
              _buildStatSkeleton(),
              _buildStatSkeleton(),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildStatSkeleton() {
    return Column(
      children: [
        const AppLoadingSkeleton.text(width: 60, fontSize: 18),
        SizedBox(height: AppSpacing.xs),
        const AppLoadingSkeleton.text(width: 80, fontSize: 12),
      ],
    );
  }

  /// Grid skeleton (for image galleries)
  static Widget grid({
    int crossAxisCount = 2,
    double aspectRatio = 1.0,
    int itemCount = 6,
    EdgeInsetsGeometry? padding,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: padding ?? EdgeInsets.all(AppSpacing.md),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: aspectRatio,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return AppLoadingSkeleton(
          height: 200,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        );
      },
    );
  }
}

/// Skeleton shape types
enum SkeletonShape {
  rectangle,
  circle,
}

/// Shimmer effect for skeleton loaders
/// Creates smooth, wave-like animation
class _ShimmerEffect extends StatefulWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;

  const _ShimmerEffect({
    required this.child,
    required this.baseColor,
    required this.highlightColor,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<_ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<_ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    _animation = Tween<double>(begin: -2.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.baseColor,
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
                widget.baseColor,
              ],
              stops: [
                0.0,
                0.35 + _animation.value * 0.15,
                0.5 + _animation.value * 0.15,
                0.65 + _animation.value * 0.15,
                1.0,
              ],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
