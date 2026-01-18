import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend.freezed.dart';

enum FriendStatus {
  accepted,
  pendingReceived, // Request received from them
  pendingSent, // Request sent to them
  blocked,
  none,
}

@freezed
class Friend with _$Friend {
  const factory Friend({
    required String id,
    required String nickname,
    String? profileImageUrl,
    String? universityName,
    String? majorName,
    @Default(FriendStatus.none) FriendStatus status,
  }) = _Friend;
}
