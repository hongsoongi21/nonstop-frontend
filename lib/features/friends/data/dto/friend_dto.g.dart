// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendDtoImpl _$$FriendDtoImplFromJson(Map<String, dynamic> json) =>
    _$FriendDtoImpl(
      id: json['id'] as String,
      nickname: json['nickname'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      universityName: json['universityName'] as String?,
      majorName: json['majorName'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$FriendDtoImplToJson(_$FriendDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'profileImageUrl': instance.profileImageUrl,
      'universityName': instance.universityName,
      'majorName': instance.majorName,
      'status': instance.status,
    };
