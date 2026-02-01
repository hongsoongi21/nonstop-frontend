// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apple_login_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppleLoginRequestDtoImpl _$$AppleLoginRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$AppleLoginRequestDtoImpl(
  idToken: json['idToken'] as String,
  authorizationCode: json['authorizationCode'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
);

Map<String, dynamic> _$$AppleLoginRequestDtoImplToJson(
  _$AppleLoginRequestDtoImpl instance,
) => <String, dynamic>{
  'idToken': instance.idToken,
  'authorizationCode': instance.authorizationCode,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
};
