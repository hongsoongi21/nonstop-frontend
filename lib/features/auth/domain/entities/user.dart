import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
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
  }) = _User;

  const User._();

  /// Check if user has completed profile setup
  bool get isProfileComplete => fullName.isNotEmpty && university != null;

  /// Get user's display name (fallback to email if name is empty)
  String get displayName => fullName.isNotEmpty ? fullName : email.split('@').first;

  /// Get user's initials for avatar fallback
  String get initials {
    if (fullName.isEmpty) return email.substring(0, 1).toUpperCase();

    final nameParts = fullName.split(' ');
    if (nameParts.length >= 2) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    }
    return fullName.substring(0, min(2, fullName.length)).toUpperCase();
  }
}

int min(int a, int b) => a < b ? a : b;
