import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_states.dart';
import '../../../../shared/components/main_scaffold.dart';
import '../../domain/entities/user.dart';
import '../providers/auth_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return AppScaffold(
      title: 'Home',
      actions: [
        IconButton(
          onPressed: () async {
            await ref.read(authProvider.notifier).signOut();
          },
          icon: const Icon(Icons.logout),
          tooltip: 'Logout',
        ),
      ],
      body: AppRefreshIndicator(
        onRefresh: () async {
          // TODO: Implement refresh logic
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome section
                _buildWelcomeSection(authState.user!),

                const SizedBox(height: AppSpacing.xl),

                // Quick actions
                _buildQuickActions(),

                const SizedBox(height: AppSpacing.xxl),

                // Today's overview
                _buildTodaysOverview(),

                const SizedBox(height: AppSpacing.xxl),

                // Recent activity
                _buildRecentActivity(),

                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(User user) {
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

    return AppCard(
      gradient: LinearGradient(
        colors: [
          AppColors.primary.withValues(alpha: 0.1),
          AppColors.primary.withValues(alpha: 0.05),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderColor: AppColors.primary.withValues(alpha: 0.2),
      borderWidth: 1,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primaryLight,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: Text(
                user.initials,
                style: AppTypography.headline5.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          const SizedBox(width: AppSpacing.lg),

          // Welcome text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$greeting, ${user.displayName.split(' ').first}!',
                  style: AppTypography.headline6.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${user.university ?? 'Welcome to Nonstop'} • ${user.major ?? 'Your Campus Companion'}',
                  style: AppTypography.body2.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // Notification bell
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.8),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                // TODO: Navigate to notifications
              },
              icon: const Icon(Icons.notifications_outlined),
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Text(
            'Quick Actions',
            style: AppTypography.headline6.copyWith(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            children: [
              QuickActionCard(
                title: 'Board',
                subtitle: 'Latest posts',
                icon: Icons.forum,
                iconBackgroundColor: AppColors.boardFree,
                iconColor: Colors.white,
                onTap: () => context.go(Routes.board),
              ),

              const SizedBox(width: AppSpacing.md),

              QuickActionCard(
                title: 'Timetable',
                subtitle: 'Today\'s schedule',
                icon: Icons.schedule,
                iconBackgroundColor: AppColors.primary,
                iconColor: Colors.white,
                onTap: () => context.go(Routes.timetable),
              ),

              const SizedBox(width: AppSpacing.md),

              QuickActionCard(
                title: 'Chat',
                subtitle: 'Messages',
                icon: Icons.chat,
                iconBackgroundColor: AppColors.universityPurple,
                iconColor: Colors.white,
                onTap: () => context.go(Routes.chat),
              ),

              const SizedBox(width: AppSpacing.md),

              QuickActionCard(
                title: 'Cafeteria',
                subtitle: 'Order food',
                icon: Icons.restaurant,
                iconBackgroundColor: AppColors.universityGreen,
                iconColor: Colors.white,
                onTap: () {
                  // TODO: Navigate to cafeteria
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTodaysOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today\'s Overview',
                style: AppTypography.headline6.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              AppButton(
                text: 'View All',
                onPressed: () => context.go(Routes.timetable),
                variant: ButtonVariant.ghost,
                size: ButtonSize.small,
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            children: [
              Expanded(
                child: StatsCard(
                  title: 'Classes Today',
                  value: '3',
                  subtitle: '2 completed',
                  icon: Icons.school,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: StatsCard(
                  title: 'Assignments',
                  value: '2',
                  subtitle: 'Due today',
                  icon: Icons.assignment,
                  color: AppColors.warning,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: AppTypography.headline6.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              AppButton(
                text: 'View All',
                onPressed: () => context.go(Routes.board),
                variant: ButtonVariant.ghost,
                size: ButtonSize.small,
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // Recent posts placeholder
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            children: [
              InfoCard(
                title: 'New post in General Board',
                subtitle: 'Check out the latest discussion about campus events',
                icon: Icons.forum,
                iconColor: AppColors.boardFree,
                onTap: () => context.go(Routes.board),
              ),

              const SizedBox(height: AppSpacing.md),

              InfoCard(
                title: 'Timetable updated',
                subtitle: 'Your Computer Science class schedule has been updated',
                icon: Icons.schedule,
                iconColor: AppColors.primary,
                onTap: () => context.go(Routes.timetable),
              ),

              const SizedBox(height: AppSpacing.md),

              InfoCard(
                title: 'New message from Study Group',
                subtitle: 'You have 3 unread messages',
                icon: Icons.chat,
                iconColor: AppColors.universityPurple,
                trailing: Container(
                  padding: const EdgeInsets.all(AppSpacing.xs),
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '3',
                    style: AppTypography.caption.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                onTap: () => context.go(Routes.chat),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
