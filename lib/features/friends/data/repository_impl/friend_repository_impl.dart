import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/friend.dart';
import '../../domain/repository/friend_repository.dart';
import '../api/friend_api.dart';
import '../api/friend_api_impl.dart';
import '../dto/friend_dto.dart';

final friendRepositoryProvider = Provider<FriendRepository>((ref) {
  return FriendRepositoryImpl(ref.read(friendApiProvider));
});

class FriendRepositoryImpl implements FriendRepository {
  final FriendApi _api;

  FriendRepositoryImpl(this._api);

  @override
  Future<Either<Failure, List<Friend>>> getFriends() async {
    final result = await _api.getFriends();
    return result.match(
      (error) => Left(ServerFailure(message: error.message, statusCode: 500)),
      (dtos) => Right(dtos.map((dto) => dto.toDomain()).toList()),
    );
  }

  @override
  Future<Either<Failure, List<Friend>>> getFriendRequests() async {
    final result = await _api.getFriendRequests();
    return result.match(
      (error) => Left(ServerFailure(message: error.message, statusCode: 500)),
      (dtos) => Right(dtos.map((dto) => dto.toDomain()).toList()),
    );
  }

  @override
  Future<Either<Failure, List<Friend>>> getSentRequests() async {
    final result = await _api.getSentRequests();
    return result.match(
      (error) => Left(ServerFailure(message: error.message, statusCode: 500)),
      (dtos) => Right(
        dtos
            .map((dto) =>
                dto.toDomain().copyWith(status: FriendStatus.pendingSent))
            .toList(),
      ),
    );
  }

  @override
  Future<Either<Failure, Unit>> requestFriend(String userId) async {
    final result = await _api.requestFriend(userId);
    return result.match(
      (error) => Left(ServerFailure(message: error.message, statusCode: 500)),
      (unit) => Right(unit),
    );
  }

  @override
  Future<Either<Failure, Unit>> acceptFriend(String requestId) async {
    final result = await _api.acceptFriend(requestId);
    return result.match(
      (error) => Left(ServerFailure(message: error.message, statusCode: 500)),
      (unit) => Right(unit),
    );
  }

  @override
  Future<Either<Failure, Unit>> rejectFriend(String requestId) async {
    final result = await _api.rejectFriend(requestId);
    return result.match(
      (error) => Left(ServerFailure(message: error.message, statusCode: 500)),
      (unit) => Right(unit),
    );
  }

  @override
  Future<Either<Failure, Unit>> cancelRequest(String requestId) async {
    final result = await _api.cancelRequest(requestId);
    return result.match(
      (error) => Left(ServerFailure(message: error.message, statusCode: 500)),
      (unit) => Right(unit),
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteFriend(String friendId) async {
    final result = await _api.deleteFriend(friendId);
    return result.match(
      (error) => Left(ServerFailure(message: error.message, statusCode: 500)),
      (unit) => Right(unit),
    );
  }

  @override
  Future<Either<Failure, List<Friend>>> searchUsers(String query) async {
    final result = await _api.searchUsers(query);
    return result.match(
      (error) => Left(ServerFailure(message: error.message, statusCode: 500)),
      (dtos) => Right(dtos.map((dto) => dto.toDomain()).toList()),
    );
  }
}
