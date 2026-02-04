// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokenResponseDtoImpl _$$TokenResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$TokenResponseDtoImpl(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  userId: (json['userId'] as num?)?.toInt(),
  emailVerified: json['emailVerified'] as bool? ?? false,
  hasAgreedAllMandatory: json['hasAgreedAllMandatory'] as bool? ?? false,
  hasBirthDate: json['hasBirthDate'] as bool? ?? false,
);

Map<String, dynamic> _$$TokenResponseDtoImplToJson(
  _$TokenResponseDtoImpl instance,
) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'userId': instance.userId,
  'emailVerified': instance.emailVerified,
  'hasAgreedAllMandatory': instance.hasAgreedAllMandatory,
  'hasBirthDate': instance.hasBirthDate,
};
