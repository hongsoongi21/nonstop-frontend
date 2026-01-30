import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/app_notification.dart';
import 'notification_api.dart';

class NotificationApiImpl implements NotificationApi {
  final DioClient _dioClient;

  NotificationApiImpl(this._dioClient);

  @override
  Future<Either<ApiException, List<AppNotification>>> getNotifications() async {
    try {
      final response = await _dioClient.get('/api/v1/notifications');
      final data = response.data['data'] as List<dynamic>;
      final notifications = data.map((json) {
        final map = json as Map<String, dynamic>;
        return AppNotification(
          id: map['id'] as int,
          actorId: map['actorId'] as int?,
          actorNickname: map['actorNickname'] as String?,
          type: _parseNotificationType(map['type'] as String?),
          postId: map['postId'] as int?,
          commentId: map['commentId'] as int?,
          chatRoomId: map['chatRoomId'] as int?,
          message: map['message'] as String? ?? '',
          isRead: map['isRead'] as bool? ?? false,
          createdAt: map['createdAt'] != null
              ? DateTime.parse(map['createdAt'] as String)
              : DateTime.now(),
        );
      }).toList();
      return Right(notifications);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ApiException('Failed to get notifications: $e'));
    }
  }

  @override
  Future<Either<ApiException, void>> markAsRead(int notificationId) async {
    try {
      await _dioClient.patch('/api/v1/notifications/$notificationId/read');
      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ApiException('Failed to mark notification as read: $e'));
    }
  }

  @override
  Future<Either<ApiException, void>> markAllAsRead() async {
    try {
      await _dioClient.patch('/api/v1/notifications/read-all');
      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
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

  ApiException _handleDioError(DioException e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final data = e.response!.data;
      String message = 'Unknown error';
      if (data is Map<String, dynamic> && data['message'] != null) {
        message = data['message'] as String;
      }
      return ApiException('[$statusCode] $message');
    }
    return ApiException('Network error: ${e.message}');
  }
}
