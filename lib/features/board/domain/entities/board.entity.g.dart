// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BoardImpl _$$BoardImplFromJson(Map<String, dynamic> json) => _$BoardImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String?,
  type: $enumDecode(_$BoardTypeEnumMap, json['type']),
  isSecret: json['isSecret'] as bool? ?? false,
  slug: json['slug'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$BoardImplToJson(_$BoardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': _$BoardTypeEnumMap[instance.type]!,
      'isSecret': instance.isSecret,
      'slug': instance.slug,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$BoardTypeEnumMap = {
  BoardType.general: 'GENERAL',
  BoardType.notice: 'NOTICE',
  BoardType.qna: 'QNA',
  BoardType.anonymous: 'ANONYMOUS',
};
