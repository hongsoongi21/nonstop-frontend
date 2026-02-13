import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_loading_skeleton.dart';
import '../../domain/entities/app_notification.dart';
import '../providers/notification_provider.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationProvider.notifier).loadNotifications();
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.surfaceColor,
        centerTitle: false,
        title: Text(
          l10n.notifications,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: context.textPrimaryColor,
          ),
        ),
        actions: [
          if (state.notifications.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: TextButton.icon(
                onPressed: () {
                  ref.read(notificationProvider.notifier).markAllAsRead();
                },
                icon: Icon(
                  Icons.done_all,
                  size: 18.sp,
                  color: AppColors.primary,
                ),
                label: Text(
                  l10n.markAllAsRead,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                ),
              ),
            ),
        ],
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(NotificationState state) {
    final l10n = AppLocalizations.of(context)!;

    if (state.isLoading) {
      return ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        itemCount: 6,
        separatorBuilder: (context, index) => Divider(
          height: 1.h,
          thickness: 1,
          color: context.dividerColor,
          indent: 80.w,
        ),
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          child: SkeletonLayouts.listItem(
            hasAvatar: true,
            hasSubtitle: true,
            padding: EdgeInsets.all(16.r),
          ),
        ),
      );
    }

    if (state.error != null) {
      return Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32.w),
          padding: EdgeInsets.all(32.r),
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: AppColors.errorLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 48.sp,
                  color: AppColors.error,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                l10n.notificationLoadError,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(notificationProvider.notifier).loadNotifications();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textOnPrimary,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    l10n.retry,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (state.notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: context.surfaceVariantColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                size: 64.sp,
                color: context.textTertiaryColor,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              l10n.noNotificationsYet,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: context.textSecondaryColor,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              l10n.noNotificationsHint,
              style: TextStyle(
                fontSize: 14.sp,
                color: context.textTertiaryColor,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(notificationProvider.notifier).loadNotifications();
        _animationController.reset();
        _animationController.forward();
      },
      color: AppColors.primary,
      backgroundColor: context.surfaceColor,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        itemCount: state.notifications.length,
        separatorBuilder: (context, index) => Divider(
          height: 1.h,
          thickness: 1,
          color: context.dividerColor,
          indent: 80.w,
        ),
        itemBuilder: (context, index) {
          final notification = state.notifications[index];
          return _NotificationTile(
            notification: notification,
            onTap: () => _handleNotificationTap(notification),
            animationController: _animationController,
            index: index,
          );
        },
      ),
    );
  }

  void _handleNotificationTap(AppNotification notification) {
    // Mark as read
    if (!notification.isRead) {
      ref.read(notificationProvider.notifier).markAsRead(notification.id);
    }

    // Navigate based on notification type
    switch (notification.type) {
      case NotificationType.postLike:
      case NotificationType.newComment:
      case NotificationType.newReply:
      case NotificationType.commentLike:
        if (notification.postId != null) {
          GoRouter.of(context).push(Routes.boardDetailPath(notification.postId.toString()));
        }
        break;
      case NotificationType.chatMessage:
        if (notification.chatRoomId != null) {
          GoRouter.of(context).push(Routes.chatRoomPath(notification.chatRoomId.toString()));
        }
        break;
      case NotificationType.friendRequest:
      case NotificationType.friendAccept:
        // Navigate to friends page for friend-related notifications
        GoRouter.of(context).push(Routes.friends);
        break;
      case NotificationType.announcement:
        // Show announcement detail or do nothing
        break;
    }
  }
}

class _NotificationTile extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onTap;
  final AnimationController animationController;
  final int index;

  const _NotificationTile({
    required this.notification,
    required this.onTap,
    required this.animationController,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          (index * 0.05).clamp(0.0, 1.0),
          ((index * 0.05) + 0.3).clamp(0.0, 1.0),
          curve: Curves.easeOutCubic,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - animation.value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: notification.isRead
              ? context.surfaceColor
              : (context.isDarkMode
                  ? const Color(0xFF1E3A5F)
                  : AppColors.infoLight),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: notification.isRead ? context.borderColor : AppColors.info.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: notification.isRead
              ? null
              : [
                  BoxShadow(
                    color: AppColors.info.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16.r),
            splashColor: AppColors.ripple,
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: _getIconBackgroundColor().withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      _getNotificationIcon(),
                      color: _getIconBackgroundColor(),
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                notification.message,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: notification.isRead
                                      ? FontWeight.w500
                                      : FontWeight.w600,
                                  color: context.textPrimaryColor,
                                  height: 1.4,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (!notification.isRead) ...[
                              SizedBox(width: 8.w),
                              Container(
                                width: 8.w,
                                height: 8.w,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 12.sp,
                              color: context.textTertiaryColor,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              _formatTime(notification.createdAt, context),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: context.textTertiaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getNotificationIcon() {
    switch (notification.type) {
      case NotificationType.postLike:
      case NotificationType.commentLike:
        return Icons.favorite_rounded;
      case NotificationType.newComment:
      case NotificationType.newReply:
        return Icons.chat_bubble_rounded;
      case NotificationType.chatMessage:
        return Icons.forum_rounded;
      case NotificationType.friendRequest:
        return Icons.person_add_alt_1_rounded;
      case NotificationType.friendAccept:
        return Icons.group_rounded;
      case NotificationType.announcement:
        return Icons.campaign_rounded;
    }
  }

  Color _getIconBackgroundColor() {
    switch (notification.type) {
      case NotificationType.postLike:
      case NotificationType.commentLike:
        return AppColors.accent;
      case NotificationType.newComment:
      case NotificationType.newReply:
        return AppColors.info;
      case NotificationType.chatMessage:
        return AppColors.success;
      case NotificationType.friendRequest:
      case NotificationType.friendAccept:
        return AppColors.universityPurple;
      case NotificationType.announcement:
        return AppColors.warning;
    }
  }

  String _formatTime(DateTime dateTime, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return l10n.justNow;
    } else if (difference.inHours < 1) {
      return l10n.minutesAgo(difference.inMinutes);
    } else if (difference.inDays < 1) {
      return l10n.hoursAgo(difference.inHours);
    } else if (difference.inDays < 7) {
      return l10n.daysAgo(difference.inDays);
    } else {
      return '${dateTime.month}/${dateTime.day}';
    }
  }
}
