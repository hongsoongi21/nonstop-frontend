import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Samarkand Modern gradient background
/// Rich multi-stop gradient with atmospheric depth
class AppBackground extends StatelessWidget {
  final Widget child;
  final bool usePrimaryGradient;

  const AppBackground({
    super.key,
    required this.child,
    this.usePrimaryGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: usePrimaryGradient
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.0, 0.5, 1.0],
                colors: [
                  AppColors.primary.withValues(alpha: 0.05),
                  AppColors.background,
                  AppColors.tertiary.withValues(alpha: 0.03),
                ],
              )
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.4, 0.7, 1.0],
                colors: [
                  AppColors.backgroundGradientStart,
                  AppColors.background,
                  AppColors.surfaceVariant.withValues(alpha: 0.5),
                  AppColors.backgroundGradientEnd,
                ],
              ),
      ),
      child: Stack(
        children: [
          // Subtle noise texture overlay
          Positioned.fill(
            child: Opacity(
              opacity: 0.02,
              child: CustomPaint(
                painter: _NoisePainter(),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

/// Subtle noise texture painter for atmospheric depth
class _NoisePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.textPrimary;

    for (var i = 0; i < 500; i++) {
      final x = (i * 37) % size.width;
      final y = (i * 79) % size.height;
      canvas.drawCircle(Offset(x, y), 0.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
