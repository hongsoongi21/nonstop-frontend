import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/routes.dart';
import '../../../../../core/mock/mock_data.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../shared/components/course_card.dart';
import '../../../../../shared/components/post_card.dart';
import '../../../../../shared/components/main_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Home',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome section
            _buildWelcomeSection(),

            SizedBox(height: AppSpacing.lg),

            // Quick actions
            _buildQuickActions(context),

            SizedBox(height: AppSpacing.xl),

            // Today's courses
            _buildTodaysCourses(),

            SizedBox(height: AppSpacing.xl),

            // Recent board posts
            _buildRecentPosts(),

            SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    final user = MockData.users[0]; // Current user
    final now = DateTime.now();
    final hour = now.hour;

    String greeting;
    if (hour < 12) {
      greeting = 'Good morning';
    } else if (hour < 17) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
    }

    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 32,
            backgroundImage: user.avatarUrl != null
                ? NetworkImage(user.avatarUrl!)
                : null,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            child: user.avatarUrl == null
                ? Text(
                    user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                    style: AppTypography.headline4.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : null,
          ),

          SizedBox(width: AppSpacing.md),

          // Welcome text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$greeting, ${user.name.split(' ').first}!',
                  style: AppTypography.headline6.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '${user.university.shortName} • ${user.major ?? 'Student'}',
                  style: AppTypography.body2.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),

          // Notification bell
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
            color: Colors.white,
            style: IconButton.styleFrom(
              backgroundColor: Colors.white.withValues(alpha: 0.2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: AppTypography.body1.copyWith(fontWeight: FontWeight.w600),
        ),

        SizedBox(height: AppSpacing.md),

        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                title: 'Board',
                subtitle: 'Latest posts',
                icon: Icons.forum,
                color: AppColors.boardFree,
                onTap: () => context.go(Routes.board),
              ),
            ),

            SizedBox(width: AppSpacing.md),

            Expanded(
              child: _QuickActionCard(
                title: 'Timetable',
                subtitle: 'Today\'s schedule',
                icon: Icons.schedule,
                color: AppColors.primary,
                onTap: () => context.go(Routes.timetable),
              ),
            ),
          ],
        ),

        SizedBox(height: AppSpacing.md),

        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                title: 'Chat',
                subtitle: 'Messages',
                icon: Icons.chat,
                color: AppColors.universityPurple,
                onTap: () => context.go(Routes.chat),
              ),
            ),

            SizedBox(width: AppSpacing.md),

            Expanded(
              child: _QuickActionCard(
                title: 'Cafeteria',
                subtitle: 'Order food',
                icon: Icons.restaurant,
                color: AppColors.universityGreen,
                onTap: () {}, // TODO: Navigate to cafeteria
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTodaysCourses() {
    final today = DateTime.now().weekday;
    final todaysCourses = MockData.getCoursesByDay(today);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Today\'s Classes',
              style: AppTypography.body1.copyWith(fontWeight: FontWeight.w600),
            ),

            TextButton(
              onPressed: () {}, // TODO: Navigate to full timetable
              child: Text(
                'View All',
                style: AppTypography.button.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),

        SizedBox(height: AppSpacing.md),

        if (todaysCourses.isEmpty)
          Container(
            padding: EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.event_available,
                    size: 48,
                    color: AppColors.textHint,
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Text(
                    'No classes today',
                    style: AppTypography.body2.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ...todaysCourses
              .take(2)
              .map(
                (course) => Padding(
                  padding: EdgeInsets.only(bottom: AppSpacing.sm),
                  child: CourseListCard(
                    course: course,
                    onTap: () {}, // TODO: Navigate to course details
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildRecentPosts() {
    final recentPosts = MockData.posts.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Posts',
              style: AppTypography.body1.copyWith(fontWeight: FontWeight.w600),
            ),

            TextButton(
              onPressed: () {}, // TODO: Navigate to full board
              child: Text(
                'View All',
                style: AppTypography.button.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),

        SizedBox(height: AppSpacing.md),

        ...recentPosts.map(
          (post) => Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.md),
            child: PostListCard(
              post: post,
              onTap: () {}, // TODO: Navigate to post details
            ),
          ),
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _QuickActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),

              SizedBox(height: AppSpacing.sm),

              Text(
                title,
                style: AppTypography.body2.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 2),

              Text(
                subtitle,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
