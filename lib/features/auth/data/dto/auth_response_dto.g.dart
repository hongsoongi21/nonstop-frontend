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
);

Map<String, dynamic> _$$TokenResponseDtoImplToJson(
  _$TokenResponseDtoImpl instance,
) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
};
