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
  dayOfWeek: _dayOfWeekFromJson(json['dayOfWeek'] as String),
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
  'dayOfWeek': _dayOfWeekToJson(instance.dayOfWeek),
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'place': instance.place,
  'color': instance.color,
};

_$TimetableEntryRequestDtoImpl _$$TimetableEntryRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$TimetableEntryRequestDtoImpl(
  subjectName: json['subjectName'] as String,
  professor: json['professor'] as String?,
  dayOfWeek: _dayOfWeekFromJson(json['dayOfWeek'] as String),
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
  'dayOfWeek': _dayOfWeekToJson(instance.dayOfWeek),
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'place': instance.place,
  'color': instance.color,
};
