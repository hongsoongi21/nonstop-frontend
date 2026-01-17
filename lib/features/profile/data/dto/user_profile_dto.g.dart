// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileDtoImpl _$$UserProfileDtoImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileDtoImpl(
      id: json['id'],
      userId: json['userId'],
      fullName: json['fullName'] as String,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      bio: json['introduction'] as String?,
      avatarUrl: json['profileImageUrl'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      gender: json['gender'] as String?,
      location: json['location'] as String?,
      website: json['website'] as String?,
      universityId: json['universityId'],
      major: json['major'] as String?,
      year: (json['year'] as num?)?.toInt(),
      gpa: (json['gpa'] as num?)?.toDouble(),
      linkedinUrl: json['linkedinUrl'] as String?,
      githubUrl: json['githubUrl'] as String?,
      instagramUrl: json['instagramUrl'] as String?,
      isPublic: json['isPublic'] as bool?,
      showEmail: json['showEmail'] as bool?,
      showPhone: json['showPhone'] as bool?,
      showGpa: json['showGpa'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      lastActiveAt: json['lastActiveAt'] == null
          ? null
          : DateTime.parse(json['lastActiveAt'] as String),
    );

Map<String, dynamic> _$$UserProfileDtoImplToJson(
  _$UserProfileDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'fullName': instance.fullName,
  'displayName': instance.displayName,
  'email': instance.email,
  'phoneNumber': instance.phoneNumber,
  'introduction': instance.bio,
  'profileImageUrl': instance.avatarUrl,
  'coverImageUrl': instance.coverImageUrl,
  'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
  'gender': instance.gender,
  'location': instance.location,
  'website': instance.website,
  'universityId': instance.universityId,
  'major': instance.major,
  'year': instance.year,
  'gpa': instance.gpa,
  'linkedinUrl': instance.linkedinUrl,
  'githubUrl': instance.githubUrl,
  'instagramUrl': instance.instagramUrl,
  'isPublic': instance.isPublic,
  'showEmail': instance.showEmail,
  'showPhone': instance.showPhone,
  'showGpa': instance.showGpa,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'lastActiveAt': instance.lastActiveAt?.toIso8601String(),
};

_$UpdateUserProfileDtoImpl _$$UpdateUserProfileDtoImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateUserProfileDtoImpl(
  fullName: json['fullName'] as String?,
  displayName: json['displayName'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  bio: json['introduction'] as String?,
  avatarUrl: json['profileImageUrl'] as String?,
  coverImageUrl: json['coverImageUrl'] as String?,
  dateOfBirth: json['dateOfBirth'] == null
      ? null
      : DateTime.parse(json['dateOfBirth'] as String),
  gender: json['gender'] as String?,
  location: json['location'] as String?,
  website: json['website'] as String?,
  universityId: json['universityId'],
  major: json['major'] as String?,
  year: (json['year'] as num?)?.toInt(),
  gpa: (json['gpa'] as num?)?.toDouble(),
  linkedinUrl: json['linkedinUrl'] as String?,
  githubUrl: json['githubUrl'] as String?,
  instagramUrl: json['instagramUrl'] as String?,
  isPublic: json['isPublic'] as bool?,
  showEmail: json['showEmail'] as bool?,
  showPhone: json['showPhone'] as bool?,
  showGpa: json['showGpa'] as bool?,
);

Map<String, dynamic> _$$UpdateUserProfileDtoImplToJson(
  _$UpdateUserProfileDtoImpl instance,
) => <String, dynamic>{
  'fullName': instance.fullName,
  'displayName': instance.displayName,
  'email': instance.email,
  'phoneNumber': instance.phoneNumber,
  'introduction': instance.bio,
  'profileImageUrl': instance.avatarUrl,
  'coverImageUrl': instance.coverImageUrl,
  'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
  'gender': instance.gender,
  'location': instance.location,
  'website': instance.website,
  'universityId': instance.universityId,
  'major': instance.major,
  'year': instance.year,
  'gpa': instance.gpa,
  'linkedinUrl': instance.linkedinUrl,
  'githubUrl': instance.githubUrl,
  'instagramUrl': instance.instagramUrl,
  'isPublic': instance.isPublic,
  'showEmail': instance.showEmail,
  'showPhone': instance.showPhone,
  'showGpa': instance.showGpa,
};

_$UserProfileResponseDtoImpl _$$UserProfileResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$UserProfileResponseDtoImpl(
  success: json['success'] as bool,
  data: UserProfileDto.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String?,
  errors: (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$$UserProfileResponseDtoImplToJson(
  _$UserProfileResponseDtoImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'message': instance.message,
  'errors': instance.errors,
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
