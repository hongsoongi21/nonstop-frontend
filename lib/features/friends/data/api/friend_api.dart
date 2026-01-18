import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/exceptions.dart';
import '../dto/friend_dto.dart';

abstract class FriendApi {
  Future<Either<ApiException, List<FriendDto>>> getFriends();
  Future<Either<ApiException, List<FriendDto>>> getFriendRequests();
  Future<Either<ApiException, Unit>> requestFriend(String userId);
  Future<Either<ApiException, Unit>> acceptFriend(String userId);
  Future<Either<ApiException, Unit>> deleteFriend(String userId);
  Future<Either<ApiException, List<FriendDto>>> searchUsers(String query);
}
