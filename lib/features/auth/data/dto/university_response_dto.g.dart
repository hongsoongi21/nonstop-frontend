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

_$UniversityListResponseDtoImpl _$$UniversityListResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$UniversityListResponseDtoImpl(
  items: (json['items'] as List<dynamic>)
      .map((e) => UniversityResponseDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalCount: (json['totalCount'] as num).toInt(),
  hasMore: json['hasMore'] as bool,
  limit: (json['limit'] as num?)?.toInt(),
  offset: (json['offset'] as num?)?.toInt(),
);

Map<String, dynamic> _$$UniversityListResponseDtoImplToJson(
  _$UniversityListResponseDtoImpl instance,
) => <String, dynamic>{
  'items': instance.items,
  'totalCount': instance.totalCount,
  'hasMore': instance.hasMore,
  'limit': instance.limit,
  'offset': instance.offset,
};
