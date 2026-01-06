import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    required String email,
    required String nickname,
    String? fullName,
    String? avatarUrl,
    String? university,
    int? universityId,
    String? major,
    int? majorId,
    String? bio,
    @Default(false) bool isEmailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserDto;

  const UserDto._();

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  /// DTO를 도메인 엔티티로 변환
  User toDomain() {
    return User(
      id: id,
      email: email,
      nickname: nickname,
      fullName: fullName,
      avatarUrl: avatarUrl,
      university: university,
      universityId: universityId,
      major: major,
      majorId: majorId,
      bio: bio,
      isEmailVerified: isEmailVerified,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// 도메인 엔티티를 DTO로 변환
  factory UserDto.fromDomain(User user) {
    return UserDto(
      id: user.id,
      email: user.email,
      nickname: user.nickname,
      fullName: user.fullName,
      avatarUrl: user.avatarUrl,
      university: user.university,
      universityId: user.universityId,
      major: user.major,
      majorId: user.majorId,
      bio: user.bio,
      isEmailVerified: user.isEmailVerified,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }
}
