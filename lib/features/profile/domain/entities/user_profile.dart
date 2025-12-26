import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

/// Comprehensive user profile entity
@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String userId,
    required String fullName,
    String? displayName,
    String? email,
    String? phoneNumber,
    String? bio,
    String? avatarUrl,
    String? coverImageUrl,
    DateTime? dateOfBirth,
    String? gender,
    String? location,
    String? website,

    // Academic information
    String? universityId,
    String? major,
    int? year,
    double? gpa,

    // Social links
    String? linkedinUrl,
    String? githubUrl,
    String? instagramUrl,

    // Privacy settings
    bool? isPublic,
    bool? showEmail,
    bool? showPhone,
    bool? showGpa,

    // Timestamps
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastActiveAt,
  }) = _UserProfile;

  const UserProfile._();

  /// Get display name (fallback to full name)
  String get displayNameOrFullName => displayName ?? fullName;

  /// Get age from date of birth
  int? get age {
    if (dateOfBirth == null) return null;
    final now = DateTime.now();
    int age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }

  /// Check if profile is complete
  bool get isProfileComplete {
    return fullName.isNotEmpty &&
           email?.isNotEmpty == true &&
           bio?.isNotEmpty == true &&
           avatarUrl?.isNotEmpty == true;
  }

  /// Get profile completion percentage
  int get profileCompletionPercentage {
    int completed = 0;
    int total = 6; // fullName, email, bio, avatar, major, university

    if (fullName.isNotEmpty) completed++;
    if (email?.isNotEmpty == true) completed++;
    if (bio?.isNotEmpty == true) completed++;
    if (avatarUrl?.isNotEmpty == true) completed++;
    if (major?.isNotEmpty == true) completed++;
    if (universityId?.isNotEmpty == true) completed++;

    return ((completed / total) * 100).round();
  }

  /// Create a copy with updated fields
  UserProfile copyWithProfile({
    String? fullName,
    String? displayName,
    String? email,
    String? phoneNumber,
    String? bio,
    String? avatarUrl,
    String? coverImageUrl,
    DateTime? dateOfBirth,
    String? gender,
    String? location,
    String? website,
    String? universityId,
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
  }) {
    return copyWith(
      fullName: fullName ?? this.fullName,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      location: location ?? this.location,
      website: website ?? this.website,
      universityId: universityId ?? this.universityId,
      major: major ?? this.major,
      year: year ?? this.year,
      gpa: gpa ?? this.gpa,
      linkedinUrl: linkedinUrl ?? this.linkedinUrl,
      githubUrl: githubUrl ?? this.githubUrl,
      instagramUrl: instagramUrl ?? this.instagramUrl,
      isPublic: isPublic ?? this.isPublic,
      showEmail: showEmail ?? this.showEmail,
      showPhone: showPhone ?? this.showPhone,
      showGpa: showGpa ?? this.showGpa,
      updatedAt: DateTime.now(),
    );
  }
}
