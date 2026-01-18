import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/friend.dart';

part 'friend_dto.freezed.dart';
part 'friend_dto.g.dart';

@freezed
class FriendDto with _$FriendDto {
  const factory FriendDto({
    required String id,
    required String nickname,
    String? profileImageUrl,
    String? universityName,
    String? majorName,
    String? status,
  }) = _FriendDto;

  factory FriendDto.fromJson(Map<String, dynamic> json) =>
      _$FriendDtoFromJson(json);
}

extension FriendDtoExtension on FriendDto {
  Friend toDomain() {
    return Friend(
      id: id,
      nickname: nickname,
      profileImageUrl: profileImageUrl,
      universityName: universityName,
      majorName: majorName,
      status: _parseStatus(status),
    );
  }

  FriendStatus _parseStatus(String? status) {
    switch (status?.toUpperCase()) {
      case 'ACCEPTED':
        return FriendStatus.accepted;
      case 'PENDING_RECEIVED':
        return FriendStatus.pendingReceived;
      case 'PENDING_SENT':
        return FriendStatus.pendingSent;
      case 'BLOCKED':
        return FriendStatus.blocked;
      default:
        return FriendStatus.none;
    }
  }
}
