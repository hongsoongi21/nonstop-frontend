import 'package:flutter/material.dart';

class AppLoadingIndicator extends StatelessWidget {
  final Color? color;
  final double? size;
  final double strokeWidth;

  const AppLoadingIndicator({
    super.key,
    this.color,
    this.size,
    this.strokeWidth = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size ?? 48,
        height: size ?? 48,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ??
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
          ),
        ),
      ),
    );
  }

  static Widget small({Color? color}) {
    return AppLoadingIndicator(color: color, size: 24, strokeWidth: 3);
  }

  static Widget medium({Color? color}) {
    return AppLoadingIndicator(color: color, size: 48, strokeWidth: 4);
  }

  static Widget large({Color? color}) {
    return AppLoadingIndicator(color: color, size: 72, strokeWidth: 5);
  }

  static Widget button({Color? color}) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? Colors.white.withValues(alpha: 0.9),
        ),
      ),
    );
  }

  static Widget overlay({Color? color, double opacity = 0.7}) {
    return Stack(
      children: [
        Container(color: Colors.black.withValues(alpha: opacity)),
        const Center(child: AppLoadingIndicator(color: Colors.white)),
      ],
    );
  }

  static Widget inline({Color? color, BuildContext? context}) {
    return SizedBox(
      width: 16,
      height: 16,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ??
              (context != null
                  ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.6)
                  : Colors.grey),
        ),
      ),
    );
  }
}
