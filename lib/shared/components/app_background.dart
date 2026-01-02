import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Standard gradient background used throughout the app
/// Designed to work well with Glassmorphism
class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColors.backgroundGradient,
        ),
      ),
      child: child,
    );
  }
}
