import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required int id,
    required String email,
    @JsonKey(name: 'nickname') required String fullName,
    @JsonKey(name: 'profileImageUrl') String? avatarUrl,
    @JsonKey(name: 'universityId') int? universityId,
    @JsonKey(name: 'majorId') int? majorId,
    @JsonKey(name: 'introduction') String? bio,
    @JsonKey(name: 'isVerified') @Default(false) bool isEmailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserDto;

  const UserDto._();

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  /// Convert DTO to domain entity
  User toDomain() {
    return User(
      id: id.toString(),
      email: email,
      fullName: fullName,
      avatarUrl: avatarUrl,
      university: universityId?.toString(),
      major: majorId?.toString(),
      bio: bio,
      isEmailVerified: isEmailVerified,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create DTO from domain entity
  factory UserDto.fromDomain(User user) {
    return UserDto(
      id: int.tryParse(user.id) ?? 0,
      email: user.email,
      fullName: user.fullName,
      avatarUrl: user.avatarUrl,
      universityId: int.tryParse(user.university ?? '') ?? 0,
      majorId: int.tryParse(user.major ?? '') ?? 0,
      bio: user.bio,
      isEmailVerified: user.isEmailVerified,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }
}
