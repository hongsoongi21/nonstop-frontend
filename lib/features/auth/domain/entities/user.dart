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
    String? role,
    @Default(false) bool isEmailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _User;

  const User._();

  /// 관리자 여부 확인
  bool get isAdmin => role == 'ADMIN';

  /// 프로필 설정이 완료되었는지 확인
  bool get isProfileComplete => nickname.isNotEmpty && universityId != null;

  /// 표시할 이름 (닉네임이 없으면 이메일 앞부분 사용)
  String get displayName => nickname.isNotEmpty ? nickname : email.split('@').first;

  /// 아바타용 이니셜 추출
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
