import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_profile.dart';

part 'user_profile_dto.freezed.dart';
part 'user_profile_dto.g.dart';

/// DTO for UserProfile entity - handles API serialization/deserialization
/// DTO for UserProfile entity - handles API serialization/deserialization
@freezed
class UserProfileDto with _$UserProfileDto {
  const factory UserProfileDto({
    required dynamic id,
    required dynamic userId,
    required String fullName,
    String? displayName,
    String? email,
    String? phoneNumber,
    @JsonKey(name: 'introduction') String? bio,
    @JsonKey(name: 'profileImageUrl') String? avatarUrl,
    String? coverImageUrl,
    DateTime? dateOfBirth,
    String? gender,
    String? location,
    String? website,
    @JsonKey(name: 'universityId') dynamic universityId,
    String? major,
    int? year,
    double? gpa,
    String? linkedinUrl,
    String? githubUrl,
    String? instagramUrl,
    bool? isPublic,
    bool? showEmail,
    bool? showPhone,
    bool? showGpa,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastActiveAt,
  }) = _UserProfileDto;

  const UserProfileDto._();

  factory UserProfileDto.fromJson(Map<String, dynamic> json) => _$UserProfileDtoFromJson(json);

  /// DTO를 도메인 엔티티로 변환
  UserProfile toDomain() {
    return UserProfile(
      id: id?.toString() ?? '',
      userId: userId?.toString() ?? '',
      fullName: fullName,
      displayName: displayName,
      email: email,
      phoneNumber: phoneNumber,
      bio: bio,
      avatarUrl: avatarUrl,
      coverImageUrl: coverImageUrl,
      dateOfBirth: dateOfBirth,
      gender: gender,
      location: location,
      website: website,
      universityId: universityId?.toString(),
      major: major,
      year: year,
      gpa: gpa,
      linkedinUrl: linkedinUrl,
      githubUrl: githubUrl,
      instagramUrl: instagramUrl,
      isPublic: isPublic,
      showEmail: showEmail,
      showPhone: showPhone,
      showGpa: showGpa,
      createdAt: createdAt,
      updatedAt: updatedAt,
      lastActiveAt: lastActiveAt,
    );
  }

  /// Convert domain entity to DTO
  static UserProfileDto fromDomain(UserProfile profile) {
    return UserProfileDto(
      id: profile.id,
      userId: profile.userId,
      fullName: profile.fullName,
      displayName: profile.displayName,
      email: profile.email,
      phoneNumber: profile.phoneNumber,
      bio: profile.bio,
      avatarUrl: profile.avatarUrl,
      coverImageUrl: profile.coverImageUrl,
      dateOfBirth: profile.dateOfBirth,
      gender: profile.gender,
      location: profile.location,
      website: profile.website,
      universityId: profile.universityId,
      major: profile.major,
      year: profile.year,
      gpa: profile.gpa,
      linkedinUrl: profile.linkedinUrl,
      githubUrl: profile.githubUrl,
      instagramUrl: profile.instagramUrl,
      isPublic: profile.isPublic,
      showEmail: profile.showEmail,
      showPhone: profile.showPhone,
      showGpa: profile.showGpa,
      createdAt: profile.createdAt,
      updatedAt: profile.updatedAt,
      lastActiveAt: profile.lastActiveAt,
    );
  }
}

/// 사용자 프로필 업데이트를 위한 DTO
@freezed
class UpdateUserProfileDto with _$UpdateUserProfileDto {
  const factory UpdateUserProfileDto({
    String? fullName,
    String? displayName,
    String? email,
    String? phoneNumber,
    @JsonKey(name: 'introduction') String? bio,
    @JsonKey(name: 'profileImageUrl') String? avatarUrl,
    String? coverImageUrl,
    DateTime? dateOfBirth,
    String? gender,
    String? location,
    String? website,
    dynamic universityId,
    String? major,
    int? year,
    double? gpa,
    String? linkedinUrl,
    String? githubUrl,
    String? instagramUrl,
    bool? isPublic,
    bool? showEmail,
    bool? showPhone,
    bool? showGpa,
  }) = _UpdateUserProfileDto;

  const UpdateUserProfileDto._();

  factory UpdateUserProfileDto.fromJson(Map<String, dynamic> json) => _$UpdateUserProfileDtoFromJson(json);

  /// 도메인 엔티티의 변경사항으로부터 생성
  static UpdateUserProfileDto fromDomain(UserProfile profile) {
    return UpdateUserProfileDto(
      fullName: profile.fullName,
      displayName: profile.displayName,
      email: profile.email,
      phoneNumber: profile.phoneNumber,
      bio: profile.bio,
      avatarUrl: profile.avatarUrl,
      coverImageUrl: profile.coverImageUrl,
      dateOfBirth: profile.dateOfBirth,
      gender: profile.gender,
      location: profile.location,
      website: profile.website,
      universityId: profile.universityId,
      major: profile.major,
      year: profile.year,
      gpa: profile.gpa,
      linkedinUrl: profile.linkedinUrl,
      githubUrl: profile.githubUrl,
      instagramUrl: profile.instagramUrl,
      isPublic: profile.isPublic,
      showEmail: profile.showEmail,
      showPhone: profile.showPhone,
      showGpa: profile.showGpa,
    );
  }
}

/// Profile response wrapper
@freezed
class UserProfileResponseDto with _$UserProfileResponseDto {
  const factory UserProfileResponseDto({
    required bool success,
    required UserProfileDto data,
    String? message,
    List<String>? errors,
  }) = _UserProfileResponseDto;

  const UserProfileResponseDto._();

  factory UserProfileResponseDto.fromJson(Map<String, dynamic> json) => _$UserProfileResponseDtoFromJson(json);
}

/// Simple response for operations without data
@freezed
class SimpleResponseDto with _$SimpleResponseDto {
  const factory SimpleResponseDto({
    required bool success,
    String? message,
    List<String>? errors,
  }) = _SimpleResponseDto;

  const SimpleResponseDto._();

  factory SimpleResponseDto.fromJson(Map<String, dynamic> json) => _$SimpleResponseDtoFromJson(json);
}
