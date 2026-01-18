// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimetableEntryDtoImpl _$$TimetableEntryDtoImplFromJson(
  Map<String, dynamic> json,
) => _$TimetableEntryDtoImpl(
  id: (json['id'] as num).toInt(),
  timetableId: (json['timetableId'] as num).toInt(),
  subjectName: json['subjectName'] as String,
  professor: json['professor'] as String?,
  dayOfWeek: $enumDecode(_$DayOfWeekEnumMap, json['dayOfWeek']),
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  place: json['place'] as String?,
  color: json['color'] as String?,
);

Map<String, dynamic> _$$TimetableEntryDtoImplToJson(
  _$TimetableEntryDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'timetableId': instance.timetableId,
  'subjectName': instance.subjectName,
  'professor': instance.professor,
  'dayOfWeek': _$DayOfWeekEnumMap[instance.dayOfWeek]!,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'place': instance.place,
  'color': instance.color,
};

const _$DayOfWeekEnumMap = {
  DayOfWeek.monday: 'MONDAY',
  DayOfWeek.tuesday: 'TUESDAY',
  DayOfWeek.wednesday: 'WEDNESDAY',
  DayOfWeek.thursday: 'THURSDAY',
  DayOfWeek.friday: 'FRIDAY',
  DayOfWeek.saturday: 'SATURDAY',
  DayOfWeek.sunday: 'SUNDAY',
};

_$TimetableEntryRequestDtoImpl _$$TimetableEntryRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$TimetableEntryRequestDtoImpl(
  subjectName: json['subjectName'] as String,
  professor: json['professor'] as String?,
  dayOfWeek: $enumDecode(_$DayOfWeekEnumMap, json['dayOfWeek']),
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  place: json['place'] as String?,
  color: json['color'] as String?,
);

Map<String, dynamic> _$$TimetableEntryRequestDtoImplToJson(
  _$TimetableEntryRequestDtoImpl instance,
) => <String, dynamic>{
  'subjectName': instance.subjectName,
  'professor': instance.professor,
  'dayOfWeek': _$DayOfWeekEnumMap[instance.dayOfWeek]!,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'place': instance.place,
  'color': instance.color,
};
