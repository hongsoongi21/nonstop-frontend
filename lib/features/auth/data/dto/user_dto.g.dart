// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDtoImpl _$$UserDtoImplFromJson(Map<String, dynamic> json) =>
    _$UserDtoImpl(
      id: json['id'],
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      fullName: json['fullName'] as String?,
      avatarUrl: json['profileImageUrl'] as String?,
      university: json['university'] as String?,
      universityId: (json['universityId'] as num?)?.toInt(),
      major: json['major'] as String?,
      majorId: (json['majorId'] as num?)?.toInt(),
      bio: json['introduction'] as String?,
      role: json['userRole'] as String?,
      isEmailVerified: json['emailVerified'] as bool? ?? false,
      preferredLanguage: json['preferredLanguage'] as String?,
      isUniversityVerified: json['isUniversityVerified'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UserDtoImplToJson(_$UserDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'nickname': instance.nickname,
      'fullName': instance.fullName,
      'profileImageUrl': instance.avatarUrl,
      'university': instance.university,
      'universityId': instance.universityId,
      'major': instance.major,
      'majorId': instance.majorId,
      'introduction': instance.bio,
      'userRole': instance.role,
      'emailVerified': instance.isEmailVerified,
      'preferredLanguage': instance.preferredLanguage,
      'isUniversityVerified': instance.isUniversityVerified,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
