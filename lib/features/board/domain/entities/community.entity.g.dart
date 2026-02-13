// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommunityImpl _$$CommunityImplFromJson(Map<String, dynamic> json) =>
    _$CommunityImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
      universityRequired: json['universityRequired'] as bool? ?? false,
      isAnonymous: json['isAnonymous'] as bool? ?? false,
      isGlobal: json['isGlobal'] as bool? ?? false,
      universityId: (json['universityId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CommunityImplToJson(_$CommunityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'icon': instance.icon,
      'universityRequired': instance.universityRequired,
      'isAnonymous': instance.isAnonymous,
      'isGlobal': instance.isGlobal,
      'universityId': instance.universityId,
    };
