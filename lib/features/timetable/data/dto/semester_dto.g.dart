// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semester_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SemesterDtoImpl _$$SemesterDtoImplFromJson(Map<String, dynamic> json) =>
    _$SemesterDtoImpl(
      id: (json['id'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      type: $enumDecode(_$SemesterTypeEnumMap, json['type']),
      isCurrent: json['isCurrent'] as bool? ?? false,
    );

Map<String, dynamic> _$$SemesterDtoImplToJson(_$SemesterDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'type': _$SemesterTypeEnumMap[instance.type]!,
      'isCurrent': instance.isCurrent,
    };

const _$SemesterTypeEnumMap = {
  SemesterType.first: 'FIRST',
  SemesterType.second: 'SECOND',
  SemesterType.summer: 'SUMMER',
  SemesterType.winter: 'WINTER',
};
