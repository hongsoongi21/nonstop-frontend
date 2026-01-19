// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserInfoDtoImpl _$$UserInfoDtoImplFromJson(Map<String, dynamic> json) =>
    _$UserInfoDtoImpl(
      userId: json['userId'],
      nickname: json['nickname'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
    );

Map<String, dynamic> _$$UserInfoDtoImplToJson(_$UserInfoDtoImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'nickname': instance.nickname,
      'profileImageUrl': instance.profileImageUrl,
    };

_$FriendDtoImpl _$$FriendDtoImplFromJson(Map<String, dynamic> json) =>
    _$FriendDtoImpl(
      friendshipId: json['friendshipId'],
      friend: UserInfoDto.fromJson(json['friend'] as Map<String, dynamic>),
      becameFriendAt: json['becameFriendAt'] as String?,
    );

Map<String, dynamic> _$$FriendDtoImplToJson(_$FriendDtoImpl instance) =>
    <String, dynamic>{
      'friendshipId': instance.friendshipId,
      'friend': instance.friend,
      'becameFriendAt': instance.becameFriendAt,
    };

_$FriendRequestDtoImpl _$$FriendRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$FriendRequestDtoImpl(
  requestId: json['requestId'],
  requester: UserInfoDto.fromJson(json['requester'] as Map<String, dynamic>),
  requestedAt: json['requestedAt'] as String?,
);

Map<String, dynamic> _$$FriendRequestDtoImplToJson(
  _$FriendRequestDtoImpl instance,
) => <String, dynamic>{
  'requestId': instance.requestId,
  'requester': instance.requester,
  'requestedAt': instance.requestedAt,
};
