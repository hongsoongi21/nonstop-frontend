// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BoardImpl _$$BoardImplFromJson(Map<String, dynamic> json) => _$BoardImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  type: $enumDecode(_$BoardTypeEnumMap, json['type']),
  isSecret: json['isSecret'] as bool? ?? false,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$BoardImplToJson(_$BoardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$BoardTypeEnumMap[instance.type]!,
      'isSecret': instance.isSecret,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$BoardTypeEnumMap = {
  BoardType.general: 'GENERAL',
  BoardType.notice: 'NOTICE',
  BoardType.qna: 'QNA',
  BoardType.anonymous: 'ANONYMOUS',
};
