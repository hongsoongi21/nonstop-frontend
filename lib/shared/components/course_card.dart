import 'package:flutter/material.dart';

import '../../core/mock/mock_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// Course card component for displaying course information in timetable
class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback? onTap;
  final bool isCompact;
  final bool showProfessor;
  final bool showLocation;

  const CourseCard({
    super.key,
    required this.course,
    this.onTap,
    this.isCompact = false,
    this.showProfessor = true,
    this.showLocation = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Color(course.color),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Padding(
          padding: EdgeInsets.all(isCompact ? AppSpacing.sm : AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course name and code
              Text(
                course.name,
                style: (isCompact ? AppTypography.caption : AppTypography.body2)
                    .copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
                maxLines: isCompact ? 1 : 2,
                overflow: TextOverflow.ellipsis,
              ),

              if (!isCompact) ...[
                SizedBox(height: AppSpacing.xs),

                // Course code
                Text(
                  course.code,
                  style: AppTypography.caption.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],

              if (showProfessor && !isCompact) ...[
                SizedBox(height: AppSpacing.sm),

                // Professor
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 14,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                    SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        course.professor,
                        style: AppTypography.caption.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],

              if (showLocation && !isCompact) ...[
                SizedBox(height: AppSpacing.xs),

                // Location
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                    SizedBox(width: AppSpacing.xs),
                    Text(
                      course.location,
                      style: AppTypography.caption.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ],

              if (!isCompact) ...[
                SizedBox(height: AppSpacing.sm),

                // Time and credits
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                    SizedBox(width: AppSpacing.xs),
                    Text(
                      course.timeRange,
                      style: AppTypography.caption.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                      ),
                      child: Text(
                        '${course.credits} credits',
                        style: AppTypography.caption.copyWith(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Compact course card for list views
class CourseListCard extends StatelessWidget {
  final Course course;
  final VoidCallback? onTap;

  const CourseListCard({
    super.key,
    required this.course,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: AppSpacing.sm),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              // Color indicator
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(course.color),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              SizedBox(width: AppSpacing.md),

              // Course info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.name,
                      style: AppTypography.body2.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${course.code} • ${course.professor}',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              SizedBox(width: AppSpacing.md),

              // Time and location
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    course.timeRange,
                    style: AppTypography.body2.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    course.location,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
