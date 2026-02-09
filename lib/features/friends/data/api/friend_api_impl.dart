import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/supabase/supabase_provider.dart';
import '../dto/friend_dto.dart';
import 'friend_api.dart';

final friendApiProvider = Provider<FriendApi>((ref) {
  return FriendApiImpl(ref.read(supabaseClientProvider));
});

class FriendApiImpl implements FriendApi {
  final SupabaseClient _supabase;

  FriendApiImpl(this._supabase);

  // ---------------------------------------------------------------------------
  // Helper: get current user's BIGSERIAL id from auth UUID
  // ---------------------------------------------------------------------------
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

  // ---------------------------------------------------------------------------
  // Friends List
  // ---------------------------------------------------------------------------
  @override
  Future<Either<ApiException, List<FriendDto>>> getFriends() async {
    try {
      final currentUserId = await _getCurrentUserId();

      // Get accepted friendships where current user is sender or receiver
      final data = await _supabase
          .from('friends')
          .select(
              '*, sender:users!friends_sender_id_fkey(id, nickname, profile_image_url), receiver:users!friends_receiver_id_fkey(id, nickname, profile_image_url)')
          .or('sender_id.eq.$currentUserId,receiver_id.eq.$currentUserId')
          .eq('status', 'ACCEPTED')
          .isFilter('deleted_at', null);

      final list = (data as List).map((json) {
        final senderId = json['sender_id'] as int;
        final isSender = senderId == currentUserId;
        final friendUser = (isSender
            ? json['receiver']
            : json['sender']) as Map<String, dynamic>;

        return FriendDto(
          friendshipId: json['id'],
          friend: UserInfoDto(
            userId: friendUser['id'],
            nickname: friendUser['nickname'] as String? ?? '',
            profileImageUrl: friendUser['profile_image_url'] as String?,
          ),
          becameFriendAt: json['updated_at'] as String?,
        );
      }).toList();

      return right(list);
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Friend Requests
  // ---------------------------------------------------------------------------
  @override
  Future<Either<ApiException, List<FriendRequestDto>>>
      getFriendRequests() async {
    try {
      final currentUserId = await _getCurrentUserId();

      // Get WAITING requests where I'm the receiver
      final data = await _supabase
          .from('friends')
          .select(
              '*, sender:users!friends_sender_id_fkey(id, nickname, profile_image_url)')
          .eq('receiver_id', currentUserId)
          .eq('status', 'WAITING')
          .isFilter('deleted_at', null)
          .order('created_at', ascending: false);

      final list = (data as List).map((json) {
        final senderData = json['sender'] as Map<String, dynamic>;
        return FriendRequestDto(
          requestId: json['id'],
          requester: UserInfoDto(
            userId: senderData['id'],
            nickname: senderData['nickname'] as String? ?? '',
            profileImageUrl: senderData['profile_image_url'] as String?,
          ),
          requestedAt: json['created_at'] as String?,
        );
      }).toList();

      return right(list);
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Friend Actions
  // ---------------------------------------------------------------------------
  @override
  Future<Either<ApiException, Unit>> requestFriend(String userId) async {
    try {
      final currentUserId = await _getCurrentUserId();
      final targetUserId = int.parse(userId);

      await _supabase.from('friends').insert({
        'sender_id': currentUserId,
        'receiver_id': targetUserId,
        'status': 'WAITING',
      });

      return right(unit);
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Unit>> acceptFriend(String requestId) async {
    try {
      await _supabase.from('friends').update({
        'status': 'ACCEPTED',
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', int.parse(requestId));

      return right(unit);
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Unit>> rejectFriend(String requestId) async {
    try {
      await _supabase.from('friends').update({
        'status': 'REJECTED',
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', int.parse(requestId));

      return right(unit);
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Unit>> cancelRequest(String requestId) async {
    try {
      await _supabase.from('friends').delete().eq('id', int.parse(requestId));

      return right(unit);
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Unit>> deleteFriend(String friendId) async {
    try {
      await _supabase.from('friends').update({
        'deleted_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', int.parse(friendId));

      return right(unit);
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // User Search
  // ---------------------------------------------------------------------------
  @override
  Future<Either<ApiException, List<UserInfoDto>>> searchUsers(
    String query,
  ) async {
    try {
      final data = await _supabase
          .from('users')
          .select('id, nickname, profile_image_url')
          .ilike('nickname', '%$query%')
          .isFilter('deleted_at', null)
          .limit(20);

      final list = (data as List)
          .map((json) => UserInfoDto(
                userId: json['id'],
                nickname: json['nickname'] as String? ?? '',
                profileImageUrl: json['profile_image_url'] as String?,
              ))
          .toList();

      return right(list);
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Block
  // ---------------------------------------------------------------------------
  @override
  Future<Either<ApiException, Unit>> blockUser(String userId) async {
    try {
      final currentUserId = await _getCurrentUserId();

      await _supabase.from('user_blocks').insert({
        'blocker_id': currentUserId,
        'blocked_id': int.parse(userId),
      });

      return right(unit);
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Unit>> unblockUser(String blockedId) async {
    try {
      final currentUserId = await _getCurrentUserId();

      await _supabase
          .from('user_blocks')
          .delete()
          .eq('blocker_id', currentUserId)
          .eq('blocked_id', int.parse(blockedId));

      return right(unit);
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, List<BlockedUserDto>>> getBlockedUsers() async {
    try {
      final currentUserId = await _getCurrentUserId();

      final data = await _supabase
          .from('user_blocks')
          .select(
              '*, blocked:users!user_blocks_blocked_id_fkey(id, nickname, profile_image_url)')
          .eq('blocker_id', currentUserId);

      final list = (data as List).map((json) {
        final blockedData = json['blocked'] as Map<String, dynamic>;
        return BlockedUserDto(
          blockedUser: UserInfoDto(
            userId: blockedData['id'],
            nickname: blockedData['nickname'] as String? ?? '',
            profileImageUrl: blockedData['profile_image_url'] as String?,
          ),
          blockedAt: json['created_at'] as String?,
        );
      }).toList();

      return right(list);
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }
}
