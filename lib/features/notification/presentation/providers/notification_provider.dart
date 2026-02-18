import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/supabase/supabase_provider.dart';
import '../../data/api/notification_api.dart';
import '../../data/api/notification_api_impl.dart';
import '../../data/repository/notification_repository.dart';
import '../../domain/entities/app_notification.dart';

// API Provider
final notificationApiProvider = Provider<NotificationApi>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return NotificationApiImpl(supabaseClient);
});

// Repository Provider
final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final api = ref.watch(notificationApiProvider);
  return NotificationRepository(api);
});

// Notifications State
class NotificationState {
  final List<AppNotification> notifications;
  final bool isLoading;
  final String? error;

  const NotificationState({
    this.notifications = const [],
    this.isLoading = false,
    this.error,
  });

  NotificationState copyWith({
    List<AppNotification>? notifications,
    bool? isLoading,
    String? error,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  int get unreadCount => notifications.where((n) => !n.isRead).length;
}

// Notifications Notifier
class NotificationNotifier extends StateNotifier<NotificationState> {
  final NotificationRepository _repository;

  NotificationNotifier(this._repository) : super(const NotificationState());

  Future<void> loadNotifications() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getNotifications();
    result.fold(
      (error) => state = state.copyWith(
        isLoading: false,
        error: error.message,
      ),
      (notifications) => state = state.copyWith(
        isLoading: false,
        notifications: notifications,
      ),
    );
  }

  Future<void> markAsRead(int notificationId) async {
    // Optimistic update
    final previousNotifications = state.notifications;
    final updatedNotifications = state.notifications.map((n) {
      if (n.id == notificationId) {
        return AppNotification(
          id: n.id,
          actorId: n.actorId,
          actorNickname: n.actorNickname,
          type: n.type,
          postId: n.postId,
          commentId: n.commentId,
          chatRoomId: n.chatRoomId,
          message: n.message,
          isRead: true,
          createdAt: n.createdAt,
        );
      }
      return n;
    }).toList();
    state = state.copyWith(notifications: updatedNotifications);

    // Sync with server
    final result = await _repository.markAsRead(notificationId);
    result.fold(
      (error) {
        // Revert on failure
        state = state.copyWith(notifications: previousNotifications);
      },
      (_) => null,
    );
  }

  Future<void> markAllAsRead() async {
    // Optimistic update - immediately mark all as read in UI
    final previousNotifications = state.notifications;
    final updatedNotifications = state.notifications.map((n) {
      return AppNotification(
        id: n.id,
        actorId: n.actorId,
        actorNickname: n.actorNickname,
        type: n.type,
        postId: n.postId,
        commentId: n.commentId,
        chatRoomId: n.chatRoomId,
        message: n.message,
        isRead: true,
        createdAt: n.createdAt,
      );
    }).toList();
    state = state.copyWith(notifications: updatedNotifications);

    // Then sync with server
    final result = await _repository.markAllAsRead();
    result.fold(
      (error) {
        // Revert on failure
        state = state.copyWith(notifications: previousNotifications);
      },
      (_) => null, // Already updated
    );
  }

  void addNotification(AppNotification notification) {
    state = state.copyWith(
      notifications: [notification, ...state.notifications],
    );
  }
}

// Notification Provider
final notificationProvider =
    StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
  final repository = ref.watch(notificationRepositoryProvider);
  return NotificationNotifier(repository);
});

// Unread count provider
final unreadNotificationCountProvider = Provider<int>((ref) {
  return ref.watch(notificationProvider).unreadCount;
});
