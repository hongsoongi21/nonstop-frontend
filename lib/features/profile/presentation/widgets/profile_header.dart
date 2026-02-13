import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/user_profile.dart';

/// Profile header widget - Hero section with dramatic gradient and elevated avatar
class ProfileHeader extends StatelessWidget {
  final UserProfile profile;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onSettingsPressed;

  const ProfileHeader({
    super.key,
    required this.profile,
    this.onNotificationPressed,
    this.onSettingsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Dramatic gradient background with geometric pattern
        Container(
          width: double.infinity,
          height: 320,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                AppColors.primaryDark,
                AppColors.tertiary.withValues(alpha:0.8),
              ],
              stops: const [0.0, 0.6, 1.0],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: CustomPaint(
            painter: _GeometricPatternPainter(),
          ),
        ),

        // Content overlay
        Positioned.fill(
          child: SafeArea(
            bottom: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top bar with actions
                Padding(
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.profile,
                        style: AppTypography.headlineMedium.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Row(
                        children: [
                          // Notification with badge
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha:0.15),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha:0.3),
                                    width: 1,
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: onNotificationPressed,
                                  icon: const Icon(Icons.notifications_outlined),
                                  color: Colors.white,
                                  iconSize: 22,
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(),
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: AppColors.accent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.primary,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: AppSpacing.sm),
                          // Settings
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha:0.15),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withValues(alpha:0.3),
                                width: 1,
                              ),
                            ),
                            child: IconButton(
                              onPressed: onSettingsPressed,
                              icon: const Icon(Icons.settings_outlined),
                              color: Colors.white,
                              iconSize: 22,
                              padding: const EdgeInsets.all(8),
                              constraints: const BoxConstraints(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: AppSpacing.md),

                // Avatar - dramatically elevated
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha:0.3),
                        blurRadius: 24,
                        spreadRadius: 0,
                        offset: const Offset(0, 12),
                      ),
                      BoxShadow(
                        color: AppColors.tertiary.withValues(alpha:0.4),
                        blurRadius: 32,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: profile.avatarUrl != null
                        ? CachedNetworkImage(
                            imageUrl: profile.avatarUrl!,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                            placeholder: (context, url) => Container(
                              color: context.surfaceVariantColor,
                              child: const Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: context.surfaceVariantColor,
                              child: Icon(Icons.person, color: context.textSecondaryColor, size: 40),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColors.secondary,
                                  AppColors.secondaryDark,
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                profile.displayNameOrFullName[0].toUpperCase(),
                                style: AppTypography.displayMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),

                SizedBox(height: AppSpacing.md),

                // Name with bold presence
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Text(
                    profile.displayNameOrFullName,
                    style: AppTypography.headline1.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.8,
                      height: 1.1,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: AppSpacing.xs),

                // University badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha:0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha:0.4),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (profile.universityId != null) ...[
                        const Icon(
                          Icons.school_outlined,
                          color: Colors.white,
                          size: 14,
                        ),
                        SizedBox(width: AppSpacing.xxs),
                        Text(
                          'TUIT',
                          style: AppTypography.bodySmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                      if (profile.major != null) ...[
                        if (profile.universityId != null)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                            child: Container(
                              width: 3,
                              height: 3,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        Text(
                          profile.major!,
                          style: AppTypography.bodySmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Bio with subtle styling
                if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                  SizedBox(height: AppSpacing.sm),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                    child: Text(
                      profile.bio!,
                      style: AppTypography.bodyMedium.copyWith(
                        color: Colors.white.withValues(alpha:0.9),
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Custom painter for geometric pattern overlay
class _GeometricPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha:0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Diagonal lines pattern
    for (double i = -size.height; i < size.width; i += 60) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }

    // Subtle circles in corners
    final circlePaint = Paint()
      ..color = Colors.white.withValues(alpha:0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.3),
      40,
      circlePaint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.7),
      60,
      circlePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
