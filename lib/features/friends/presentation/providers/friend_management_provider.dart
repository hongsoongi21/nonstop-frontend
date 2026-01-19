import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/friend.dart';
import '../../domain/repository/friend_repository.dart';
import '../../data/repository_impl/friend_repository_impl.dart';

class FriendManagementState {
  final bool isLoading;
  final String? error;
  final List<Friend> friends;
  final List<Friend> requests;
  final List<Friend> searchResults;

  FriendManagementState({
    this.isLoading = false,
    this.error,
    this.friends = const [],
    this.requests = const [],
    this.searchResults = const [],
  });

  FriendManagementState copyWith({
    bool? isLoading,
    String? error,
    List<Friend>? friends,
    List<Friend>? requests,
    List<Friend>? searchResults,
    bool clearError = false,
  }) {
    return FriendManagementState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      friends: friends ?? this.friends,
      requests: requests ?? this.requests,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}

class FriendManagementNotifier extends StateNotifier<FriendManagementState> {
  final FriendRepository _repository;

  FriendManagementNotifier(this._repository) : super(FriendManagementState());

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
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await _repository.searchUsers(query);
    result.fold(
      (failure) =>
          state = state.copyWith(isLoading: false, error: failure.message),
      (users) => state = state.copyWith(isLoading: false, searchResults: users),
    );
  }

  Future<bool> sendRequest(String userId) async {
    final result = await _repository.requestFriend(userId);
    return result.fold((failure) {
      state = state.copyWith(error: failure.message);
      return false;
    }, (unit) => true);
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
      return FriendManagementNotifier(ref.read(friendRepositoryProvider));
    });
