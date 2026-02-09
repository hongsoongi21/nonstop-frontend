// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PolicyAgreeRequestDtoImpl _$$PolicyAgreeRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PolicyAgreeRequestDtoImpl(
  policyIds: (json['policyIds'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$$PolicyAgreeRequestDtoImplToJson(
  _$PolicyAgreeRequestDtoImpl instance,
) => <String, dynamic>{'policyIds': instance.policyIds};
