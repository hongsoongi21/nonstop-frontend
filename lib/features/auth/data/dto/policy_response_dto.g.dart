// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PolicyResponseDtoImpl _$$PolicyResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PolicyResponseDtoImpl(
  id: (json['id'] as num).toInt(),
  type: json['type'] as String,
  title: json['title'] as String,
  url: json['url'] as String,
  isMandatory: json['is_mandatory'] as bool,
);

Map<String, dynamic> _$$PolicyResponseDtoImplToJson(
  _$PolicyResponseDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'title': instance.title,
  'url': instance.url,
  'is_mandatory': instance.isMandatory,
};
