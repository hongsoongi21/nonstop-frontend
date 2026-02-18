import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/friend.dart';
import '../../domain/repository/friend_repository.dart';
import '../../data/repository_impl/friend_repository_impl.dart';
import '../../../../features/auth/presentation/providers/auth_provider.dart';
import '../../../../core/utils/logger.dart';

class FriendManagementState {
  final bool isLoading;
  final String? error;
  final List<Friend> friends;
  final List<Friend> requests;
  final List<Friend> searchResults;
  final Set<String> sentRequestUserIds;

  FriendManagementState({
    this.isLoading = false,
    this.error,
    this.friends = const [],
    this.requests = const [],
    this.searchResults = const [],
    this.sentRequestUserIds = const {},
  });

  FriendManagementState copyWith({
    bool? isLoading,
    String? error,
    List<Friend>? friends,
    List<Friend>? requests,
    List<Friend>? searchResults,
    Set<String>? sentRequestUserIds,
    bool clearError = false,
  }) {
    return FriendManagementState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      friends: friends ?? this.friends,
      requests: requests ?? this.requests,
      searchResults: searchResults ?? this.searchResults,
      sentRequestUserIds: sentRequestUserIds ?? this.sentRequestUserIds,
    );
  }
}

class FriendManagementNotifier extends StateNotifier<FriendManagementState> {
  final FriendRepository _repository;
  final Ref ref;

  FriendManagementNotifier(this._repository, this.ref)
    : super(FriendManagementState());

  Future<void> loadFriends() async {
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await _repository.getFriends();
    result.fold(
      (failure) =>
          state = state.copyWith(isLoading: false, error: failure.message),
      (friends) => state = state.copyWith(isLoading: false, friends: friends),
    );
  }

  Future<void> loadRequests() async {
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await _repository.getFriendRequests();
    result.fold(
      (failure) =>
          state = state.copyWith(isLoading: false, error: failure.message),
      (requests) =>
          state = state.copyWith(isLoading: false, requests: requests),
    );
  }

  Future<void> searchUsers(String query) async {
    if (query.isEmpty) {
      state = state.copyWith(searchResults: []);
      return;
    }

    // Ensure friends and requests are loaded first
    if (state.friends.isEmpty && state.requests.isEmpty) {
      AppLogger.d('🔍 [Search] Friends/requests not loaded, loading now...');
      await loadFriends();
      await loadRequests();
    }

    state = state.copyWith(isLoading: true, clearError: true);
    final result = await _repository.searchUsers(query);
    result.fold(
      (failure) =>
          state = state.copyWith(isLoading: false, error: failure.message),
      (users) {
        final currentUserId = ref.read(currentUserProvider)?.id;
        final currentNickname = ref.read(currentUserProvider)?.nickname;

        AppLogger.d(
          '🔍 [Search] Current User ID: $currentUserId, Nickname: $currentNickname',
        );
        for (var u in users) {
          AppLogger.d(
            '🔍 [Search] Result User ID: ${u.id}, Nickname: ${u.nickname}',
          );
        }

        final friendsIds = state.friends.map((f) => f.id).toSet();
        final requestsIds = state.requests.map((r) => r.id).toSet();
        final sentRequestIds = state.sentRequestUserIds;

        AppLogger.d('🔍 [Search] Friends IDs: $friendsIds');
        AppLogger.d('🔍 [Search] Requests IDs: $requestsIds');
        AppLogger.d('🔍 [Search] Friends count: ${state.friends.length}');
        AppLogger.d('🔍 [Search] Requests count: ${state.requests.length}');

        final filteredUsers = users
            .where((user) {
              final isSelf =
                  user.id == currentUserId || user.nickname == currentNickname;
              if (isSelf) {
                AppLogger.d('🔍 [Search] Filtering out self: ${user.nickname}');
              }

              // Filter out users who are already friends
              final isAlreadyFriend = friendsIds.contains(user.id);
              if (isAlreadyFriend) {
                AppLogger.d('🔍 [Search] Filtering out existing friend: ${user.nickname}');
              }

              return !isSelf && !isAlreadyFriend;
            })
            .map((user) {
              AppLogger.d(
                '🔍 [Search] Checking user ${user.id} (${user.nickname}) - isRequest: ${requestsIds.contains(user.id)}',
              );
              if (requestsIds.contains(user.id)) {
                AppLogger.d(
                  '📨 [Search] User ${user.nickname} has pending request',
                );
                return user.copyWith(status: FriendStatus.pendingReceived);
              } else if (sentRequestIds.contains(user.id)) {
                AppLogger.d(
                  '📨 [Search] User ${user.nickname} has pending sent request',
                );
                return user.copyWith(status: FriendStatus.pendingSent);
              }
              AppLogger.d('👤 [Search] User ${user.nickname} is new');
              return user;
            })
            .toList();

        state = state.copyWith(isLoading: false, searchResults: filteredUsers);
      },
    );
  }

  Future<void> searchFriends(String query) async {
    // Ensure friends are loaded first
    if (state.friends.isEmpty) {
      AppLogger.d('🔍 [SearchFriends] Friends not loaded, loading now...');
      await loadFriends();
    }

    // If query is empty, show all friends
    if (query.isEmpty) {
      state = state.copyWith(searchResults: state.friends);
      return;
    }

    // Filter friends by nickname (case-insensitive contains)
    final queryLower = query.toLowerCase();
    final filteredFriends = state.friends
        .where((friend) => friend.nickname.toLowerCase().contains(queryLower))
        .toList();

    AppLogger.d(
      '🔍 [SearchFriends] Query: "$query", Found: ${filteredFriends.length}/${state.friends.length}',
    );

    state = state.copyWith(searchResults: filteredFriends);
  }

  Future<bool> sendRequest(String userId) async {
    final result = await _repository.requestFriend(userId);
    return result.fold((failure) {
      state = state.copyWith(error: failure.message);
      return false;
    }, (unit) {
      final updatedSentIds = {...state.sentRequestUserIds, userId};
      final updatedResults = state.searchResults
          .map(
            (u) => u.id == userId
                ? u.copyWith(status: FriendStatus.pendingSent)
                : u,
          )
          .toList();

      state = state.copyWith(
        clearError: true,
        sentRequestUserIds: updatedSentIds,
        searchResults: updatedResults,
      );
      return true;
    });
  }

  Future<bool> acceptRequest(String requestId) async {
    final result = await _repository.acceptFriend(requestId);
    return result.fold(
      (failure) {
        state = state.copyWith(error: failure.message);
        return false;
      },
      (unit) {
        loadFriends();
        loadRequests();
        return true;
      },
    );
  }

  Future<bool> rejectRequest(String requestId) async {
    final result = await _repository.rejectFriend(requestId);
    return result.fold(
      (failure) {
        state = state.copyWith(error: failure.message);
        return false;
      },
      (unit) {
        loadRequests();
        return true;
      },
    );
  }

  Future<bool> deleteFriend(String friendId) async {
    final result = await _repository.deleteFriend(friendId);
    return result.fold(
      (failure) {
        state = state.copyWith(error: failure.message);
        return false;
      },
      (unit) {
        loadFriends();
        return true;
      },
    );
  }
}

final friendManagementProvider =
    StateNotifierProvider<FriendManagementNotifier, FriendManagementState>((
      ref,
    ) {
      return FriendManagementNotifier(ref.read(friendRepositoryProvider), ref);
    });
