import 'package:flutter/material.dart';

/// Animation utilities for consistent transitions throughout the app
class AppAnimations {
  // Duration constants
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);

  // Curve constants
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve bounceOut = Curves.bounceOut;

  /// Fade in animation
  static Widget fadeIn({
    Duration duration = normal,
    Curve curve = easeOut,
    double startOpacity = 0.0,
    double endOpacity = 1.0,
    required Widget child,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: startOpacity, end: endOpacity),
      duration: duration,
      curve: curve,
      builder: (context, opacity, child) {
        return Opacity(opacity: opacity, child: child);
      },
      child: child,
    );
  }

  /// Scale animation
  static Widget scaleIn({
    Duration duration = normal,
    Curve curve = easeOut,
    double startScale = 0.8,
    double endScale = 1.0,
    required Widget child,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: startScale, end: endScale),
      duration: duration,
      curve: curve,
      builder: (context, scale, child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: child,
    );
  }

  /// Slide in from bottom animation
  static Widget slideInFromBottom({
    Duration duration = normal,
    Curve curve = easeOut,
    double startOffset = 50.0,
    required Widget child,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: startOffset, end: 0.0),
      duration: duration,
      curve: curve,
      builder: (context, offset, child) {
        return Transform.translate(offset: Offset(0, offset), child: child);
      },
      child: child,
    );
  }

  /// Slide in from right animation
  static Widget slideInFromRight({
    Duration duration = normal,
    Curve curve = easeOut,
    double startOffset = 50.0,
    required Widget child,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: startOffset, end: 0.0),
      duration: duration,
      curve: curve,
      builder: (context, offset, child) {
        return Transform.translate(offset: Offset(offset, 0), child: child);
      },
      child: child,
    );
  }

  /// Combined fade and slide animation
  static Widget fadeSlideIn({
    Duration duration = normal,
    Curve curve = easeOut,
    double startOpacity = 0.0,
    double endOpacity = 1.0,
    double startOffset = 30.0,
    required Widget child,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return Opacity(
          opacity: startOpacity + (endOpacity - startOpacity) * value,
          child: Transform.translate(
            offset: Offset(0, startOffset * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  /// Pulse animation for attention-grabbing elements
  static Widget pulse({
    Duration duration = const Duration(milliseconds: 1500),
    double startScale = 1.0,
    double endScale = 1.1,
    required Widget child,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: startScale, end: endScale),
      duration: duration,
      curve: Curves.easeInOut,
      builder: (context, scale, child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: child,
    );
  }

  /// Shimmer loading effect
  static Widget shimmer({
    Duration duration = const Duration(milliseconds: 1500),
    Color? baseColor,
    Color? highlightColor,
    required Widget child,
  }) {
    return _ShimmerAnimation(
      duration: duration,
      baseColor: baseColor ?? Colors.grey[300]!,
      highlightColor: highlightColor ?? Colors.grey[100]!,
      child: child,
    );
  }

  /// Bounce animation for playful interactions
  static Widget bounce({
    Duration duration = const Duration(milliseconds: 800),
    double bounceHeight = 20.0,
    required Widget child,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: bounceHeight, end: 0.0),
      duration: duration,
      curve: bounceOut,
      builder: (context, offset, child) {
        return Transform.translate(offset: Offset(0, offset), child: child);
      },
      child: child,
    );
  }
}

/// Shimmer animation widget
class _ShimmerAnimation extends StatefulWidget {
  final Duration duration;
  final Color baseColor;
  final Color highlightColor;
  final Widget child;

  const _ShimmerAnimation({
    required this.duration,
    required this.baseColor,
    required this.highlightColor,
    required this.child,
  });

  @override
  State<_ShimmerAnimation> createState() => _ShimmerAnimationState();
}

class _ShimmerAnimationState extends State<_ShimmerAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    _animation = Tween<double>(
      begin: -1.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: [0.0, _animation.value, 1.0],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Staggered animation for lists
class StaggeredAnimation extends StatelessWidget {
  final List<Widget> children;
  final Duration staggerDelay;
  final Duration animationDuration;
  final Curve curve;

  const StaggeredAnimation({
    super.key,
    required this.children,
    this.staggerDelay = const Duration(milliseconds: 100),
    this.animationDuration = AppAnimations.normal,
    this.curve = AppAnimations.easeOut,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(children.length, (index) {
        return AppAnimations.fadeSlideIn(
          startOffset: 20.0,
          duration: animationDuration,
          curve: curve,
          child: children[index],
        );
      }),
    );
  }
}

/// Hero transition wrapper for smooth page transitions
class AppHero extends StatelessWidget {
  final String tag;
  final Widget child;
  final bool enabled;

  const AppHero({
    super.key,
    required this.tag,
    required this.child,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return enabled ? Hero(tag: tag, child: child) : child;
  }
}

/// Page route with custom transitions
class AppPageRoute<T> extends MaterialPageRoute<T> {
  final PageTransition transition;

  AppPageRoute({
    required super.builder,
    super.settings,
    this.transition = PageTransition.fade,
    super.maintainState = true,
    super.fullscreenDialog = false,
  });

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    switch (transition) {
      case PageTransition.fade:
        return FadeTransition(opacity: animation, child: child);

      case PageTransition.slideUp:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );

      case PageTransition.slideLeft:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );

      case PageTransition.scale:
        return ScaleTransition(scale: animation, child: child);

      case PageTransition.none:
        return child;
    }
  }
}

/// Page transition types
enum PageTransition { fade, slideUp, slideLeft, scale, none }
