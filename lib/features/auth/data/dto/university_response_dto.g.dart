// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UniversityResponseDtoImpl _$$UniversityResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$UniversityResponseDtoImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  region: json['region'] as String?,
  logoImageUrl: json['logoImageUrl'] as String?,
);

Map<String, dynamic> _$$UniversityResponseDtoImplToJson(
  _$UniversityResponseDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'region': instance.region,
  'logoImageUrl': instance.logoImageUrl,
};
