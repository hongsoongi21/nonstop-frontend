import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
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
  }) = _User;

  const User._();

  /// Check if user has completed profile setup
  bool get isProfileComplete => nickname.isNotEmpty && universityId != null;

  /// Get user's display name (fallback to email if nickname is empty)
  String get displayName => nickname.isNotEmpty ? nickname : email.split('@').first;

  /// Get user's initials for avatar fallback
  String get initials {
    final name = nickname.isNotEmpty ? nickname : fullName ?? '';
    if (name.isEmpty) return email.substring(0, 1).toUpperCase();

    final nameParts = name.trim().split(' ');
    if (nameParts.length >= 2) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    }
    return name.substring(0, min(2, name.length)).toUpperCase();
  }
}

int min(int a, int b) => a < b ? a : b;
