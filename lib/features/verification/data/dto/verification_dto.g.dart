// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmailVerificationRequestDtoImpl _$$EmailVerificationRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$EmailVerificationRequestDtoImpl(email: json['email'] as String);

Map<String, dynamic> _$$EmailVerificationRequestDtoImplToJson(
  _$EmailVerificationRequestDtoImpl instance,
) => <String, dynamic>{'email': instance.email};

_$EmailVerificationConfirmDtoImpl _$$EmailVerificationConfirmDtoImplFromJson(
  Map<String, dynamic> json,
) => _$EmailVerificationConfirmDtoImpl(
  email: json['email'] as String,
  code: json['code'] as String,
);

Map<String, dynamic> _$$EmailVerificationConfirmDtoImplToJson(
  _$EmailVerificationConfirmDtoImpl instance,
) => <String, dynamic>{'email': instance.email, 'code': instance.code};

_$VerificationStatusDtoImpl _$$VerificationStatusDtoImplFromJson(
  Map<String, dynamic> json,
) => _$VerificationStatusDtoImpl(
  isUniversityVerified: json['isUniversityVerified'] as bool,
  verificationMethod: $enumDecodeNullable(
    _$VerificationMethodEnumMap,
    json['verificationMethod'],
  ),
);

Map<String, dynamic> _$$VerificationStatusDtoImplToJson(
  _$VerificationStatusDtoImpl instance,
) => <String, dynamic>{
  'isUniversityVerified': instance.isUniversityVerified,
  'verificationMethod':
      _$VerificationMethodEnumMap[instance.verificationMethod],
};

const _$VerificationMethodEnumMap = {
  VerificationMethod.emailDomain: 'EMAIL_DOMAIN',
  VerificationMethod.manualReview: 'MANUAL_REVIEW',
  VerificationMethod.studentIdPhoto: 'STUDENT_ID_PHOTO',
};
