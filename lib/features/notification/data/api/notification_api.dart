import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/app_notification.dart';

abstract class NotificationApi {
  Future<Either<ApiException, List<AppNotification>>> getNotifications();
  Future<Either<ApiException, void>> markAsRead(int notificationId);
  Future<Either<ApiException, void>> markAllAsRead();
}
