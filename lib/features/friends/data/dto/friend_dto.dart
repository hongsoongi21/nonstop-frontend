import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/friend.dart';

part 'friend_dto.freezed.dart';
part 'friend_dto.g.dart';

@freezed
class UserInfoDto with _$UserInfoDto {
  const factory UserInfoDto({
    required dynamic userId,
    required String nickname,
    String? profileImageUrl,
  }) = _UserInfoDto;

  factory UserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$UserInfoDtoFromJson(json);
}

@freezed
class FriendDto with _$FriendDto {
  const factory FriendDto({
    required dynamic friendshipId,
    required UserInfoDto friend,
    String? becameFriendAt,
  }) = _FriendDto;

  factory FriendDto.fromJson(Map<String, dynamic> json) =>
      _$FriendDtoFromJson(json);
}

@freezed
class FriendRequestDto with _$FriendRequestDto {
  const factory FriendRequestDto({
    required dynamic requestId,
    required UserInfoDto requester,
    String? requestedAt,
  }) = _FriendRequestDto;

  factory FriendRequestDto.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestDtoFromJson(json);
}

extension FriendDtoExtension on FriendDto {
  Friend toDomain() {
    return Friend(
      id: friend.userId.toString(),
      nickname: friend.nickname,
      relationshipId: friendshipId.toString(),
      profileImageUrl: friend.profileImageUrl,
      status: FriendStatus.accepted,
    );
  }
}

extension FriendRequestDtoExtension on FriendRequestDto {
  Friend toDomain() {
    return Friend(
      id: requester.userId.toString(),
      nickname: requester.nickname,
      relationshipId: requestId.toString(),
      profileImageUrl: requester.profileImageUrl,
      status: FriendStatus.pendingReceived,
    );
  }
}

extension UserInfoDtoExtension on UserInfoDto {
  Friend toDomain({FriendStatus status = FriendStatus.none}) {
    return Friend(
      id: userId.toString(),
      nickname: nickname,
      profileImageUrl: profileImageUrl,
      status: status,
    );
  }
}
