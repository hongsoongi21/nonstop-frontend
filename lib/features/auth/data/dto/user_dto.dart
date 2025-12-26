import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    required String email,
    required String fullName,
    String? avatarUrl,
    String? university,
    String? major,
    String? bio,
    @Default(false) bool isEmailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserDto;

  const UserDto._();

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  /// Convert DTO to domain entity
  User toDomain() {
    return User(
      id: id,
      email: email,
      fullName: fullName,
      avatarUrl: avatarUrl,
      university: university,
      major: major,
      bio: bio,
      isEmailVerified: isEmailVerified,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create DTO from domain entity
  factory UserDto.fromDomain(User user) {
    return UserDto(
      id: user.id,
      email: user.email,
      fullName: user.fullName,
      avatarUrl: user.avatarUrl,
      university: user.university,
      major: user.major,
      bio: user.bio,
      isEmailVerified: user.isEmailVerified,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }
}
