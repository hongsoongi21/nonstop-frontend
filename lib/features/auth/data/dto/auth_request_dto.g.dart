// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRequestDtoImpl _$$LoginRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$LoginRequestDtoImpl(
  email: json['email'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$$LoginRequestDtoImplToJson(
  _$LoginRequestDtoImpl instance,
) => <String, dynamic>{'email': instance.email, 'password': instance.password};

_$SignUpRequestDtoImpl _$$SignUpRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$SignUpRequestDtoImpl(
  email: json['email'] as String,
  password: json['password'] as String,
  nickname: json['nickname'] as String,
  birthDate: json['birthDate'] as String,
  universityId: (json['universityId'] as num?)?.toInt(),
  majorId: (json['majorId'] as num?)?.toInt(),
  agreedPolicyIds: (json['agreedPolicyIds'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$$SignUpRequestDtoImplToJson(
  _$SignUpRequestDtoImpl instance,
) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
  'nickname': instance.nickname,
  'birthDate': instance.birthDate,
  'universityId': instance.universityId,
  'majorId': instance.majorId,
  'agreedPolicyIds': instance.agreedPolicyIds,
};

_$ProfileUpdateRequestDtoImpl _$$ProfileUpdateRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ProfileUpdateRequestDtoImpl(
  nickname: json['nickname'] as String?,
  universityId: (json['universityId'] as num?)?.toInt(),
  majorId: (json['majorId'] as num?)?.toInt(),
  introduction: json['introduction'] as String?,
  preferredLanguage: json['preferredLanguage'] as String?,
);

Map<String, dynamic> _$$ProfileUpdateRequestDtoImplToJson(
  _$ProfileUpdateRequestDtoImpl instance,
) => <String, dynamic>{
  'nickname': instance.nickname,
  'universityId': instance.universityId,
  'majorId': instance.majorId,
  'introduction': instance.introduction,
  'preferredLanguage': instance.preferredLanguage,
};

_$RefreshRequestDtoImpl _$$RefreshRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$RefreshRequestDtoImpl(refreshToken: json['refreshToken'] as String);

Map<String, dynamic> _$$RefreshRequestDtoImplToJson(
  _$RefreshRequestDtoImpl instance,
) => <String, dynamic>{'refreshToken': instance.refreshToken};
