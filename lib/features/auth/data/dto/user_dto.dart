import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    // 백엔드의 숫자형 ID를 문자열로 안전하게 받기 위해 dynamic으로 설정 후 toDomain에서 처리
    required dynamic id,
    required String email,
    required String nickname,
    String? fullName,
    @JsonKey(name: 'profileImageUrl') String? avatarUrl,
    String? university,
    int? universityId,
    String? major,
    int? majorId,
    @JsonKey(name: 'introduction') String? bio,
    @JsonKey(name: 'userRole') String? role,
    @JsonKey(name: 'isVerified') @Default(false) bool isEmailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserDto;

  const UserDto._();

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  /// DTO를 도메인 엔티티로 변환
  User toDomain() {
    return User(
      id: id?.toString() ?? '',
      email: email,
      nickname: nickname,
      fullName: fullName,
      avatarUrl: avatarUrl,
      university: university,
      universityId: universityId,
      major: major,
      majorId: majorId,
      bio: bio,
      role: role,
      isEmailVerified: isEmailVerified,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// 도메인 엔티티를 DTO로 변환
  factory UserDto.fromDomain(User user) {
    return UserDto(
      id: user.id, // User id is already string, just pass it
      email: user.email,
      nickname: user.nickname,
      fullName: user.fullName,
      avatarUrl: user.avatarUrl,
      university: user.university,
      universityId: user.universityId,
      major: user.major,
      majorId: user.majorId,
      bio: user.bio,
      role: user.role,
      isEmailVerified: user.isEmailVerified,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }
}