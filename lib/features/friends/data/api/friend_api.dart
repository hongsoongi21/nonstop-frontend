import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/exceptions.dart';
import '../dto/friend_dto.dart';

abstract class FriendApi {
  Future<Either<ApiException, List<FriendDto>>> getFriends();
  Future<Either<ApiException, List<FriendRequestDto>>> getFriendRequests();
  Future<Either<ApiException, Unit>> requestFriend(String userId);
  Future<Either<ApiException, Unit>> acceptFriend(String requestId);
  Future<Either<ApiException, Unit>> rejectFriend(String requestId);
  Future<Either<ApiException, Unit>> cancelRequest(String requestId);
  Future<Either<ApiException, Unit>> deleteFriend(String friendId);
  Future<Either<ApiException, List<UserInfoDto>>> searchUsers(String query);
  Future<Either<ApiException, Unit>> blockUser(String userId);
  Future<Either<ApiException, Unit>> unblockUser(String blockedId);
  Future<Either<ApiException, List<BlockedUserDto>>> getBlockedUsers();
}
