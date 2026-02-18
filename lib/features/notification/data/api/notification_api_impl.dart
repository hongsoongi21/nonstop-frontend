import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/date_utils.dart';
import '../../domain/entities/app_notification.dart';
import 'notification_api.dart';

class NotificationApiImpl implements NotificationApi {
  final SupabaseClient _supabase;

  NotificationApiImpl(this._supabase);

  Future<int> _getCurrentUserId() async {
    final authUser = _supabase.auth.currentUser;
    if (authUser == null) throw const ApiException('Not authenticated');
    final data = await _supabase
        .from('users')
        .select('id')
        .eq('auth_id', authUser.id)
        .single();
    return data['id'] as int;
  }

  @override
  Future<Either<ApiException, List<AppNotification>>>
      getNotifications() async {
    try {
      final currentUserId = await _getCurrentUserId();

      final data = await _supabase
          .from('notifications')
          .select()
          .eq('user_id', currentUserId)
          .order('created_at', ascending: false);

      final notifications = (data as List).map((map) {
        return AppNotification(
          id: map['id'] as int,
          actorId: map['actor_id'] as int?,
          actorNickname: map['actor_nickname'] as String?,
          type: _parseNotificationType(map['type'] as String?),
          postId: map['post_id'] as int?,
          commentId: map['comment_id'] as int?,
          chatRoomId: map['chat_room_id'] as int?,
          message: map['message'] as String? ?? '',
          isRead: map['is_read'] as bool? ?? false,
          createdAt: map['created_at'] != null
              ? parseUtcDateTime(map['created_at'] as String)
              : DateTime.now(),
        );
      }).toList();

      return Right(notifications);
    } catch (e) {
      return Left(ApiException('Failed to get notifications: $e'));
    }
  }

  @override
  Future<Either<ApiException, void>> markAsRead(int notificationId) async {
    try {
      await _supabase
          .from('notifications')
          .update({'is_read': true})
          .eq('id', notificationId);
      return const Right(null);
    } catch (e) {
      return Left(ApiException('Failed to mark notification as read: $e'));
    }
  }

  @override
  Future<Either<ApiException, void>> markAllAsRead() async {
    try {
      final currentUserId = await _getCurrentUserId();
      await _supabase
          .from('notifications')
          .update({'is_read': true})
          .eq('user_id', currentUserId)
          .eq('is_read', false);
      return const Right(null);
    } catch (e) {
      return Left(ApiException('Failed to mark all notifications as read: $e'));
    }
  }

  NotificationType _parseNotificationType(String? type) {
    switch (type) {
      case 'FRIEND_REQUEST':
        return NotificationType.friendRequest;
      case 'FRIEND_ACCEPT':
        return NotificationType.friendAccept;
      case 'POST_LIKE':
        return NotificationType.postLike;
      case 'COMMENT_LIKE':
        return NotificationType.commentLike;
      case 'NEW_COMMENT':
        return NotificationType.newComment;
      case 'NEW_REPLY':
        return NotificationType.newReply;
      case 'CHAT_MESSAGE':
        return NotificationType.chatMessage;
      case 'ANNOUNCEMENT':
        return NotificationType.announcement;
      default:
        return NotificationType.announcement;
    }
  }
}
