import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/app_notification.dart';
import '../providers/notification_provider.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationProvider.notifier).loadNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('알림'),
        actions: [
          if (state.notifications.isNotEmpty)
            TextButton(
              onPressed: () {
                ref.read(notificationProvider.notifier).markAllAsRead();
              },
              child: const Text('모두 읽음'),
            ),
        ],
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(NotificationState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '알림을 불러오는데 실패했습니다',
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                ref.read(notificationProvider.notifier).loadNotifications();
              },
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }

    if (state.notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 64.sp,
              color: Colors.grey,
            ),
            SizedBox(height: 16.h),
            Text(
              '알림이 없습니다',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(notificationProvider.notifier).loadNotifications();
      },
      child: ListView.separated(
        itemCount: state.notifications.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final notification = state.notifications[index];
          return _NotificationTile(
            notification: notification,
            onTap: () => _handleNotificationTap(notification),
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
          context.push('/board/post/${notification.postId}');
        }
        break;
      case NotificationType.chatMessage:
        if (notification.chatRoomId != null) {
          context.push('/chat/${notification.chatRoomId}');
        }
        break;
      case NotificationType.friendRequest:
      case NotificationType.friendAccept:
        // Navigate to friends page or user profile
        if (notification.actorId != null) {
          context.push('/profile/${notification.actorId}');
        }
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

  const _NotificationTile({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: notification.isRead ? null : Colors.blue.withOpacity(0.05),
      leading: CircleAvatar(
        backgroundColor: _getIconBackgroundColor(),
        child: Icon(
          _getNotificationIcon(),
          color: Colors.white,
          size: 20.sp,
        ),
      ),
      title: Text(
        notification.message,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: notification.isRead ? FontWeight.normal : FontWeight.w600,
        ),
      ),
      subtitle: Text(
        _formatTime(notification.createdAt),
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.grey,
        ),
      ),
      trailing: notification.isRead
          ? null
          : Container(
              width: 8.w,
              height: 8.h,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
    );
  }

  IconData _getNotificationIcon() {
    switch (notification.type) {
      case NotificationType.postLike:
      case NotificationType.commentLike:
        return Icons.favorite;
      case NotificationType.newComment:
      case NotificationType.newReply:
        return Icons.comment;
      case NotificationType.chatMessage:
        return Icons.chat_bubble;
      case NotificationType.friendRequest:
        return Icons.person_add;
      case NotificationType.friendAccept:
        return Icons.people;
      case NotificationType.announcement:
        return Icons.campaign;
    }
  }

  Color _getIconBackgroundColor() {
    switch (notification.type) {
      case NotificationType.postLike:
      case NotificationType.commentLike:
        return Colors.red;
      case NotificationType.newComment:
      case NotificationType.newReply:
        return Colors.blue;
      case NotificationType.chatMessage:
        return Colors.green;
      case NotificationType.friendRequest:
      case NotificationType.friendAccept:
        return Colors.purple;
      case NotificationType.announcement:
        return Colors.orange;
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return '방금 전';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else {
      return '${dateTime.month}/${dateTime.day}';
    }
  }
}
