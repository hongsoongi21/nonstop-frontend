// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimetableDtoImpl _$$TimetableDtoImplFromJson(Map<String, dynamic> json) =>
    _$TimetableDtoImpl(
      id: (json['id'] as num).toInt(),
      semesterId: (json['semesterId'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      semesterType: $enumDecode(_$SemesterTypeEnumMap, json['semesterType']),
      title: json['title'] as String?,
      isPublic: json['isPublic'] as bool,
    );

Map<String, dynamic> _$$TimetableDtoImplToJson(_$TimetableDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'semesterId': instance.semesterId,
      'year': instance.year,
      'semesterType': _$SemesterTypeEnumMap[instance.semesterType]!,
      'title': instance.title,
      'isPublic': instance.isPublic,
    };

const _$SemesterTypeEnumMap = {
  SemesterType.first: 'FIRST',
  SemesterType.second: 'SECOND',
  SemesterType.summer: 'SUMMER',
  SemesterType.winter: 'WINTER',
};

_$TimetableDetailDtoImpl _$$TimetableDetailDtoImplFromJson(
  Map<String, dynamic> json,
) => _$TimetableDetailDtoImpl(
  id: (json['id'] as num).toInt(),
  semesterId: (json['semesterId'] as num).toInt(),
  year: (json['year'] as num).toInt(),
  semesterType: $enumDecode(_$SemesterTypeEnumMap, json['semesterType']),
  title: json['title'] as String?,
  isPublic: json['isPublic'] as bool,
  entries: (json['entries'] as List<dynamic>)
      .map((e) => TimetableEntryDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$TimetableDetailDtoImplToJson(
  _$TimetableDetailDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'semesterId': instance.semesterId,
  'year': instance.year,
  'semesterType': _$SemesterTypeEnumMap[instance.semesterType]!,
  'title': instance.title,
  'isPublic': instance.isPublic,
  'entries': instance.entries,
};

_$TimetableRequestDtoImpl _$$TimetableRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$TimetableRequestDtoImpl(
  semesterId: (json['semesterId'] as num?)?.toInt(),
  title: json['title'] as String?,
  isPublic: json['isPublic'] as bool?,
);

Map<String, dynamic> _$$TimetableRequestDtoImplToJson(
  _$TimetableRequestDtoImpl instance,
) => <String, dynamic>{
  'semesterId': instance.semesterId,
  'title': instance.title,
  'isPublic': instance.isPublic,
};
