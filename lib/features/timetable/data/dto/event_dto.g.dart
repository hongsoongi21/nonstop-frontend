// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventDtoImpl _$$EventDtoImplFromJson(Map<String, dynamic> json) =>
    _$EventDtoImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      eventType: json['eventType'] as String,
      userId: json['userId'] as String,
      location: json['location'] as String?,
      color: (json['color'] as num?)?.toInt(),
      isAllDay: json['isAllDay'] as bool? ?? false,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$EventDtoImplToJson(_$EventDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'eventType': instance.eventType,
      'userId': instance.userId,
      'location': instance.location,
      'color': instance.color,
      'isAllDay': instance.isAllDay,
      'tags': instance.tags,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$CreateEventDtoImpl _$$CreateEventDtoImplFromJson(Map<String, dynamic> json) =>
    _$CreateEventDtoImpl(
      title: json['title'] as String,
      description: json['description'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      eventType: json['eventType'] as String,
      userId: json['userId'] as String,
      location: json['location'] as String?,
      color: (json['color'] as num?)?.toInt(),
      isAllDay: json['isAllDay'] as bool? ?? false,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$CreateEventDtoImplToJson(
  _$CreateEventDtoImpl instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime.toIso8601String(),
  'eventType': instance.eventType,
  'userId': instance.userId,
  'location': instance.location,
  'color': instance.color,
  'isAllDay': instance.isAllDay,
  'tags': instance.tags,
  'metadata': instance.metadata,
};

_$UpdateEventDtoImpl _$$UpdateEventDtoImplFromJson(Map<String, dynamic> json) =>
    _$UpdateEventDtoImpl(
      title: json['title'] as String,
      description: json['description'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      eventType: json['eventType'] as String,
      location: json['location'] as String?,
      color: (json['color'] as num?)?.toInt(),
      isAllDay: json['isAllDay'] as bool?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$UpdateEventDtoImplToJson(
  _$UpdateEventDtoImpl instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime.toIso8601String(),
  'eventType': instance.eventType,
  'location': instance.location,
  'color': instance.color,
  'isAllDay': instance.isAllDay,
  'tags': instance.tags,
  'metadata': instance.metadata,
};

_$EventResponseDtoImpl _$$EventResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$EventResponseDtoImpl(
  success: json['success'] as bool,
  data: EventDto.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String?,
  errors: (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$$EventResponseDtoImplToJson(
  _$EventResponseDtoImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'message': instance.message,
  'errors': instance.errors,
};

_$EventListResponseDtoImpl _$$EventListResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$EventListResponseDtoImpl(
  success: json['success'] as bool,
  data: (json['data'] as List<dynamic>)
      .map((e) => EventDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
  totalCount: (json['totalCount'] as num?)?.toInt(),
  page: (json['page'] as num?)?.toInt(),
  pageSize: (json['pageSize'] as num?)?.toInt(),
);

Map<String, dynamic> _$$EventListResponseDtoImplToJson(
  _$EventListResponseDtoImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'message': instance.message,
  'totalCount': instance.totalCount,
  'page': instance.page,
  'pageSize': instance.pageSize,
};

_$SimpleResponseDtoImpl _$$SimpleResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$SimpleResponseDtoImpl(
  success: json['success'] as bool,
  message: json['message'] as String?,
  errors: (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$$SimpleResponseDtoImplToJson(
  _$SimpleResponseDtoImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'errors': instance.errors,
};
