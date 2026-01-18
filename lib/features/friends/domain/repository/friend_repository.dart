import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/friend.dart';

abstract class FriendRepository {
  Future<Either<Failure, List<Friend>>> getFriends();
  Future<Either<Failure, List<Friend>>> getFriendRequests();
  Future<Either<Failure, Unit>> requestFriend(String userId);
  Future<Either<Failure, Unit>> acceptFriend(String userId);
  Future<Either<Failure, Unit>> deleteFriend(String userId);
  Future<Either<Failure, List<Friend>>> searchUsers(String query);
}
