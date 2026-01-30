import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/app_notification.dart';
import '../api/notification_api.dart';

class NotificationRepository {
  final NotificationApi _api;

  NotificationRepository(this._api);

  Future<Either<ApiException, List<AppNotification>>> getNotifications() {
    return _api.getNotifications();
  }

  Future<Either<ApiException, void>> markAsRead(int notificationId) {
    return _api.markAsRead(notificationId);
  }

  Future<Either<ApiException, void>> markAllAsRead() {
    return _api.markAllAsRead();
  }
}
