// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserProfileDto _$UserProfileDtoFromJson(Map<String, dynamic> json) {
  return _UserProfileDto.fromJson(json);
}

/// @nodoc
mixin _$UserProfileDto {
  dynamic get id => throw _privateConstructorUsedError;
  dynamic get userId => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'introduction')
  String? get bio => throw _privateConstructorUsedError;
  @JsonKey(name: 'profileImageUrl')
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get coverImageUrl => throw _privateConstructorUsedError;
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  @JsonKey(name: 'universityId')
  dynamic get universityId => throw _privateConstructorUsedError;
  String? get major => throw _privateConstructorUsedError;
  int? get year => throw _privateConstructorUsedError;
  double? get gpa => throw _privateConstructorUsedError;
  String? get linkedinUrl => throw _privateConstructorUsedError;
  String? get githubUrl => throw _privateConstructorUsedError;
  String? get instagramUrl => throw _privateConstructorUsedError;
  bool? get isPublic => throw _privateConstructorUsedError;
  bool? get showEmail => throw _privateConstructorUsedError;
  bool? get showPhone => throw _privateConstructorUsedError;
  bool? get showGpa => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get lastActiveAt => throw _privateConstructorUsedError;

  /// Serializes this UserProfileDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileDtoCopyWith<UserProfileDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileDtoCopyWith<$Res> {
  factory $UserProfileDtoCopyWith(
    UserProfileDto value,
    $Res Function(UserProfileDto) then,
  ) = _$UserProfileDtoCopyWithImpl<$Res, UserProfileDto>;
  @useResult
  $Res call({
    dynamic id,
    dynamic userId,
    String fullName,
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
  });
}

/// @nodoc
class _$UserProfileDtoCopyWithImpl<$Res, $Val extends UserProfileDto>
    implements $UserProfileDtoCopyWith<$Res> {
  _$UserProfileDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? fullName = null,
    Object? displayName = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? bio = freezed,
    Object? avatarUrl = freezed,
    Object? coverImageUrl = freezed,
    Object? dateOfBirth = freezed,
    Object? gender = freezed,
    Object? location = freezed,
    Object? website = freezed,
    Object? universityId = freezed,
    Object? major = freezed,
    Object? year = freezed,
    Object? gpa = freezed,
    Object? linkedinUrl = freezed,
    Object? githubUrl = freezed,
    Object? instagramUrl = freezed,
    Object? isPublic = freezed,
    Object? showEmail = freezed,
    Object? showPhone = freezed,
    Object? showGpa = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastActiveAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            bio: freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            coverImageUrl: freezed == coverImageUrl
                ? _value.coverImageUrl
                : coverImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateOfBirth: freezed == dateOfBirth
                ? _value.dateOfBirth
                : dateOfBirth // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            gender: freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            website: freezed == website
                ? _value.website
                : website // ignore: cast_nullable_to_non_nullable
                      as String?,
            universityId: freezed == universityId
                ? _value.universityId
                : universityId // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            major: freezed == major
                ? _value.major
                : major // ignore: cast_nullable_to_non_nullable
                      as String?,
            year: freezed == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int?,
            gpa: freezed == gpa
                ? _value.gpa
                : gpa // ignore: cast_nullable_to_non_nullable
                      as double?,
            linkedinUrl: freezed == linkedinUrl
                ? _value.linkedinUrl
                : linkedinUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            githubUrl: freezed == githubUrl
                ? _value.githubUrl
                : githubUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            instagramUrl: freezed == instagramUrl
                ? _value.instagramUrl
                : instagramUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPublic: freezed == isPublic
                ? _value.isPublic
                : isPublic // ignore: cast_nullable_to_non_nullable
                      as bool?,
            showEmail: freezed == showEmail
                ? _value.showEmail
                : showEmail // ignore: cast_nullable_to_non_nullable
                      as bool?,
            showPhone: freezed == showPhone
                ? _value.showPhone
                : showPhone // ignore: cast_nullable_to_non_nullable
                      as bool?,
            showGpa: freezed == showGpa
                ? _value.showGpa
                : showGpa // ignore: cast_nullable_to_non_nullable
                      as bool?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastActiveAt: freezed == lastActiveAt
                ? _value.lastActiveAt
                : lastActiveAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserProfileDtoImplCopyWith<$Res>
    implements $UserProfileDtoCopyWith<$Res> {
  factory _$$UserProfileDtoImplCopyWith(
    _$UserProfileDtoImpl value,
    $Res Function(_$UserProfileDtoImpl) then,
  ) = __$$UserProfileDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    dynamic id,
    dynamic userId,
    String fullName,
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
  });
}

/// @nodoc
class __$$UserProfileDtoImplCopyWithImpl<$Res>
    extends _$UserProfileDtoCopyWithImpl<$Res, _$UserProfileDtoImpl>
    implements _$$UserProfileDtoImplCopyWith<$Res> {
  __$$UserProfileDtoImplCopyWithImpl(
    _$UserProfileDtoImpl _value,
    $Res Function(_$UserProfileDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? fullName = null,
    Object? displayName = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? bio = freezed,
    Object? avatarUrl = freezed,
    Object? coverImageUrl = freezed,
    Object? dateOfBirth = freezed,
    Object? gender = freezed,
    Object? location = freezed,
    Object? website = freezed,
    Object? universityId = freezed,
    Object? major = freezed,
    Object? year = freezed,
    Object? gpa = freezed,
    Object? linkedinUrl = freezed,
    Object? githubUrl = freezed,
    Object? instagramUrl = freezed,
    Object? isPublic = freezed,
    Object? showEmail = freezed,
    Object? showPhone = freezed,
    Object? showGpa = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastActiveAt = freezed,
  }) {
    return _then(
      _$UserProfileDtoImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: freezed == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        phoneNumber: freezed == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        bio: freezed == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        coverImageUrl: freezed == coverImageUrl
            ? _value.coverImageUrl
            : coverImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateOfBirth: freezed == dateOfBirth
            ? _value.dateOfBirth
            : dateOfBirth // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        gender: freezed == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        website: freezed == website
            ? _value.website
            : website // ignore: cast_nullable_to_non_nullable
                  as String?,
        universityId: freezed == universityId
            ? _value.universityId
            : universityId // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        major: freezed == major
            ? _value.major
            : major // ignore: cast_nullable_to_non_nullable
                  as String?,
        year: freezed == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int?,
        gpa: freezed == gpa
            ? _value.gpa
            : gpa // ignore: cast_nullable_to_non_nullable
                  as double?,
        linkedinUrl: freezed == linkedinUrl
            ? _value.linkedinUrl
            : linkedinUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        githubUrl: freezed == githubUrl
            ? _value.githubUrl
            : githubUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        instagramUrl: freezed == instagramUrl
            ? _value.instagramUrl
            : instagramUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPublic: freezed == isPublic
            ? _value.isPublic
            : isPublic // ignore: cast_nullable_to_non_nullable
                  as bool?,
        showEmail: freezed == showEmail
            ? _value.showEmail
            : showEmail // ignore: cast_nullable_to_non_nullable
                  as bool?,
        showPhone: freezed == showPhone
            ? _value.showPhone
            : showPhone // ignore: cast_nullable_to_non_nullable
                  as bool?,
        showGpa: freezed == showGpa
            ? _value.showGpa
            : showGpa // ignore: cast_nullable_to_non_nullable
                  as bool?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastActiveAt: freezed == lastActiveAt
            ? _value.lastActiveAt
            : lastActiveAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileDtoImpl extends _UserProfileDto {
  const _$UserProfileDtoImpl({
    required this.id,
    required this.userId,
    required this.fullName,
    this.displayName,
    this.email,
    this.phoneNumber,
    @JsonKey(name: 'introduction') this.bio,
    @JsonKey(name: 'profileImageUrl') this.avatarUrl,
    this.coverImageUrl,
    this.dateOfBirth,
    this.gender,
    this.location,
    this.website,
    @JsonKey(name: 'universityId') this.universityId,
    this.major,
    this.year,
    this.gpa,
    this.linkedinUrl,
    this.githubUrl,
    this.instagramUrl,
    this.isPublic,
    this.showEmail,
    this.showPhone,
    this.showGpa,
    this.createdAt,
    this.updatedAt,
    this.lastActiveAt,
  }) : super._();

  factory _$UserProfileDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileDtoImplFromJson(json);

  @override
  final dynamic id;
  @override
  final dynamic userId;
  @override
  final String fullName;
  @override
  final String? displayName;
  @override
  final String? email;
  @override
  final String? phoneNumber;
  @override
  @JsonKey(name: 'introduction')
  final String? bio;
  @override
  @JsonKey(name: 'profileImageUrl')
  final String? avatarUrl;
  @override
  final String? coverImageUrl;
  @override
  final DateTime? dateOfBirth;
  @override
  final String? gender;
  @override
  final String? location;
  @override
  final String? website;
  @override
  @JsonKey(name: 'universityId')
  final dynamic universityId;
  @override
  final String? major;
  @override
  final int? year;
  @override
  final double? gpa;
  @override
  final String? linkedinUrl;
  @override
  final String? githubUrl;
  @override
  final String? instagramUrl;
  @override
  final bool? isPublic;
  @override
  final bool? showEmail;
  @override
  final bool? showPhone;
  @override
  final bool? showGpa;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? lastActiveAt;

  @override
  String toString() {
    return 'UserProfileDto(id: $id, userId: $userId, fullName: $fullName, displayName: $displayName, email: $email, phoneNumber: $phoneNumber, bio: $bio, avatarUrl: $avatarUrl, coverImageUrl: $coverImageUrl, dateOfBirth: $dateOfBirth, gender: $gender, location: $location, website: $website, universityId: $universityId, major: $major, year: $year, gpa: $gpa, linkedinUrl: $linkedinUrl, githubUrl: $githubUrl, instagramUrl: $instagramUrl, isPublic: $isPublic, showEmail: $showEmail, showPhone: $showPhone, showGpa: $showGpa, createdAt: $createdAt, updatedAt: $updatedAt, lastActiveAt: $lastActiveAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileDtoImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.website, website) || other.website == website) &&
            const DeepCollectionEquality().equals(
              other.universityId,
              universityId,
            ) &&
            (identical(other.major, major) || other.major == major) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.gpa, gpa) || other.gpa == gpa) &&
            (identical(other.linkedinUrl, linkedinUrl) ||
                other.linkedinUrl == linkedinUrl) &&
            (identical(other.githubUrl, githubUrl) ||
                other.githubUrl == githubUrl) &&
            (identical(other.instagramUrl, instagramUrl) ||
                other.instagramUrl == instagramUrl) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.showEmail, showEmail) ||
                other.showEmail == showEmail) &&
            (identical(other.showPhone, showPhone) ||
                other.showPhone == showPhone) &&
            (identical(other.showGpa, showGpa) || other.showGpa == showGpa) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastActiveAt, lastActiveAt) ||
                other.lastActiveAt == lastActiveAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    const DeepCollectionEquality().hash(id),
    const DeepCollectionEquality().hash(userId),
    fullName,
    displayName,
    email,
    phoneNumber,
    bio,
    avatarUrl,
    coverImageUrl,
    dateOfBirth,
    gender,
    location,
    website,
    const DeepCollectionEquality().hash(universityId),
    major,
    year,
    gpa,
    linkedinUrl,
    githubUrl,
    instagramUrl,
    isPublic,
    showEmail,
    showPhone,
    showGpa,
    createdAt,
    updatedAt,
    lastActiveAt,
  ]);

  /// Create a copy of UserProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileDtoImplCopyWith<_$UserProfileDtoImpl> get copyWith =>
      __$$UserProfileDtoImplCopyWithImpl<_$UserProfileDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileDtoImplToJson(this);
  }
}

abstract class _UserProfileDto extends UserProfileDto {
  const factory _UserProfileDto({
    required final dynamic id,
    required final dynamic userId,
    required final String fullName,
    final String? displayName,
    final String? email,
    final String? phoneNumber,
    @JsonKey(name: 'introduction') final String? bio,
    @JsonKey(name: 'profileImageUrl') final String? avatarUrl,
    final String? coverImageUrl,
    final DateTime? dateOfBirth,
    final String? gender,
    final String? location,
    final String? website,
    @JsonKey(name: 'universityId') final dynamic universityId,
    final String? major,
    final int? year,
    final double? gpa,
    final String? linkedinUrl,
    final String? githubUrl,
    final String? instagramUrl,
    final bool? isPublic,
    final bool? showEmail,
    final bool? showPhone,
    final bool? showGpa,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final DateTime? lastActiveAt,
  }) = _$UserProfileDtoImpl;
  const _UserProfileDto._() : super._();

  factory _UserProfileDto.fromJson(Map<String, dynamic> json) =
      _$UserProfileDtoImpl.fromJson;

  @override
  dynamic get id;
  @override
  dynamic get userId;
  @override
  String get fullName;
  @override
  String? get displayName;
  @override
  String? get email;
  @override
  String? get phoneNumber;
  @override
  @JsonKey(name: 'introduction')
  String? get bio;
  @override
  @JsonKey(name: 'profileImageUrl')
  String? get avatarUrl;
  @override
  String? get coverImageUrl;
  @override
  DateTime? get dateOfBirth;
  @override
  String? get gender;
  @override
  String? get location;
  @override
  String? get website;
  @override
  @JsonKey(name: 'universityId')
  dynamic get universityId;
  @override
  String? get major;
  @override
  int? get year;
  @override
  double? get gpa;
  @override
  String? get linkedinUrl;
  @override
  String? get githubUrl;
  @override
  String? get instagramUrl;
  @override
  bool? get isPublic;
  @override
  bool? get showEmail;
  @override
  bool? get showPhone;
  @override
  bool? get showGpa;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get lastActiveAt;

  /// Create a copy of UserProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileDtoImplCopyWith<_$UserProfileDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateUserProfileDto _$UpdateUserProfileDtoFromJson(Map<String, dynamic> json) {
  return _UpdateUserProfileDto.fromJson(json);
}

/// @nodoc
mixin _$UpdateUserProfileDto {
  String? get fullName => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'introduction')
  String? get bio => throw _privateConstructorUsedError;
  @JsonKey(name: 'profileImageUrl')
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get coverImageUrl => throw _privateConstructorUsedError;
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  dynamic get universityId => throw _privateConstructorUsedError;
  String? get major => throw _privateConstructorUsedError;
  int? get year => throw _privateConstructorUsedError;
  double? get gpa => throw _privateConstructorUsedError;
  String? get linkedinUrl => throw _privateConstructorUsedError;
  String? get githubUrl => throw _privateConstructorUsedError;
  String? get instagramUrl => throw _privateConstructorUsedError;
  bool? get isPublic => throw _privateConstructorUsedError;
  bool? get showEmail => throw _privateConstructorUsedError;
  bool? get showPhone => throw _privateConstructorUsedError;
  bool? get showGpa => throw _privateConstructorUsedError;

  /// Serializes this UpdateUserProfileDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateUserProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateUserProfileDtoCopyWith<UpdateUserProfileDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateUserProfileDtoCopyWith<$Res> {
  factory $UpdateUserProfileDtoCopyWith(
    UpdateUserProfileDto value,
    $Res Function(UpdateUserProfileDto) then,
  ) = _$UpdateUserProfileDtoCopyWithImpl<$Res, UpdateUserProfileDto>;
  @useResult
  $Res call({
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
  });
}

/// @nodoc
class _$UpdateUserProfileDtoCopyWithImpl<
  $Res,
  $Val extends UpdateUserProfileDto
>
    implements $UpdateUserProfileDtoCopyWith<$Res> {
  _$UpdateUserProfileDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateUserProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = freezed,
    Object? displayName = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? bio = freezed,
    Object? avatarUrl = freezed,
    Object? coverImageUrl = freezed,
    Object? dateOfBirth = freezed,
    Object? gender = freezed,
    Object? location = freezed,
    Object? website = freezed,
    Object? universityId = freezed,
    Object? major = freezed,
    Object? year = freezed,
    Object? gpa = freezed,
    Object? linkedinUrl = freezed,
    Object? githubUrl = freezed,
    Object? instagramUrl = freezed,
    Object? isPublic = freezed,
    Object? showEmail = freezed,
    Object? showPhone = freezed,
    Object? showGpa = freezed,
  }) {
    return _then(
      _value.copyWith(
            fullName: freezed == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String?,
            displayName: freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            bio: freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            coverImageUrl: freezed == coverImageUrl
                ? _value.coverImageUrl
                : coverImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateOfBirth: freezed == dateOfBirth
                ? _value.dateOfBirth
                : dateOfBirth // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            gender: freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            website: freezed == website
                ? _value.website
                : website // ignore: cast_nullable_to_non_nullable
                      as String?,
            universityId: freezed == universityId
                ? _value.universityId
                : universityId // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            major: freezed == major
                ? _value.major
                : major // ignore: cast_nullable_to_non_nullable
                      as String?,
            year: freezed == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int?,
            gpa: freezed == gpa
                ? _value.gpa
                : gpa // ignore: cast_nullable_to_non_nullable
                      as double?,
            linkedinUrl: freezed == linkedinUrl
                ? _value.linkedinUrl
                : linkedinUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            githubUrl: freezed == githubUrl
                ? _value.githubUrl
                : githubUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            instagramUrl: freezed == instagramUrl
                ? _value.instagramUrl
                : instagramUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPublic: freezed == isPublic
                ? _value.isPublic
                : isPublic // ignore: cast_nullable_to_non_nullable
                      as bool?,
            showEmail: freezed == showEmail
                ? _value.showEmail
                : showEmail // ignore: cast_nullable_to_non_nullable
                      as bool?,
            showPhone: freezed == showPhone
                ? _value.showPhone
                : showPhone // ignore: cast_nullable_to_non_nullable
                      as bool?,
            showGpa: freezed == showGpa
                ? _value.showGpa
                : showGpa // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateUserProfileDtoImplCopyWith<$Res>
    implements $UpdateUserProfileDtoCopyWith<$Res> {
  factory _$$UpdateUserProfileDtoImplCopyWith(
    _$UpdateUserProfileDtoImpl value,
    $Res Function(_$UpdateUserProfileDtoImpl) then,
  ) = __$$UpdateUserProfileDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
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
  });
}

/// @nodoc
class __$$UpdateUserProfileDtoImplCopyWithImpl<$Res>
    extends _$UpdateUserProfileDtoCopyWithImpl<$Res, _$UpdateUserProfileDtoImpl>
    implements _$$UpdateUserProfileDtoImplCopyWith<$Res> {
  __$$UpdateUserProfileDtoImplCopyWithImpl(
    _$UpdateUserProfileDtoImpl _value,
    $Res Function(_$UpdateUserProfileDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateUserProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = freezed,
    Object? displayName = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? bio = freezed,
    Object? avatarUrl = freezed,
    Object? coverImageUrl = freezed,
    Object? dateOfBirth = freezed,
    Object? gender = freezed,
    Object? location = freezed,
    Object? website = freezed,
    Object? universityId = freezed,
    Object? major = freezed,
    Object? year = freezed,
    Object? gpa = freezed,
    Object? linkedinUrl = freezed,
    Object? githubUrl = freezed,
    Object? instagramUrl = freezed,
    Object? isPublic = freezed,
    Object? showEmail = freezed,
    Object? showPhone = freezed,
    Object? showGpa = freezed,
  }) {
    return _then(
      _$UpdateUserProfileDtoImpl(
        fullName: freezed == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String?,
        displayName: freezed == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        phoneNumber: freezed == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        bio: freezed == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        coverImageUrl: freezed == coverImageUrl
            ? _value.coverImageUrl
            : coverImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateOfBirth: freezed == dateOfBirth
            ? _value.dateOfBirth
            : dateOfBirth // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        gender: freezed == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        website: freezed == website
            ? _value.website
            : website // ignore: cast_nullable_to_non_nullable
                  as String?,
        universityId: freezed == universityId
            ? _value.universityId
            : universityId // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        major: freezed == major
            ? _value.major
            : major // ignore: cast_nullable_to_non_nullable
                  as String?,
        year: freezed == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int?,
        gpa: freezed == gpa
            ? _value.gpa
            : gpa // ignore: cast_nullable_to_non_nullable
                  as double?,
        linkedinUrl: freezed == linkedinUrl
            ? _value.linkedinUrl
            : linkedinUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        githubUrl: freezed == githubUrl
            ? _value.githubUrl
            : githubUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        instagramUrl: freezed == instagramUrl
            ? _value.instagramUrl
            : instagramUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPublic: freezed == isPublic
            ? _value.isPublic
            : isPublic // ignore: cast_nullable_to_non_nullable
                  as bool?,
        showEmail: freezed == showEmail
            ? _value.showEmail
            : showEmail // ignore: cast_nullable_to_non_nullable
                  as bool?,
        showPhone: freezed == showPhone
            ? _value.showPhone
            : showPhone // ignore: cast_nullable_to_non_nullable
                  as bool?,
        showGpa: freezed == showGpa
            ? _value.showGpa
            : showGpa // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateUserProfileDtoImpl extends _UpdateUserProfileDto {
  const _$UpdateUserProfileDtoImpl({
    this.fullName,
    this.displayName,
    this.email,
    this.phoneNumber,
    @JsonKey(name: 'introduction') this.bio,
    @JsonKey(name: 'profileImageUrl') this.avatarUrl,
    this.coverImageUrl,
    this.dateOfBirth,
    this.gender,
    this.location,
    this.website,
    this.universityId,
    this.major,
    this.year,
    this.gpa,
    this.linkedinUrl,
    this.githubUrl,
    this.instagramUrl,
    this.isPublic,
    this.showEmail,
    this.showPhone,
    this.showGpa,
  }) : super._();

  factory _$UpdateUserProfileDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateUserProfileDtoImplFromJson(json);

  @override
  final String? fullName;
  @override
  final String? displayName;
  @override
  final String? email;
  @override
  final String? phoneNumber;
  @override
  @JsonKey(name: 'introduction')
  final String? bio;
  @override
  @JsonKey(name: 'profileImageUrl')
  final String? avatarUrl;
  @override
  final String? coverImageUrl;
  @override
  final DateTime? dateOfBirth;
  @override
  final String? gender;
  @override
  final String? location;
  @override
  final String? website;
  @override
  final dynamic universityId;
  @override
  final String? major;
  @override
  final int? year;
  @override
  final double? gpa;
  @override
  final String? linkedinUrl;
  @override
  final String? githubUrl;
  @override
  final String? instagramUrl;
  @override
  final bool? isPublic;
  @override
  final bool? showEmail;
  @override
  final bool? showPhone;
  @override
  final bool? showGpa;

  @override
  String toString() {
    return 'UpdateUserProfileDto(fullName: $fullName, displayName: $displayName, email: $email, phoneNumber: $phoneNumber, bio: $bio, avatarUrl: $avatarUrl, coverImageUrl: $coverImageUrl, dateOfBirth: $dateOfBirth, gender: $gender, location: $location, website: $website, universityId: $universityId, major: $major, year: $year, gpa: $gpa, linkedinUrl: $linkedinUrl, githubUrl: $githubUrl, instagramUrl: $instagramUrl, isPublic: $isPublic, showEmail: $showEmail, showPhone: $showPhone, showGpa: $showGpa)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateUserProfileDtoImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.website, website) || other.website == website) &&
            const DeepCollectionEquality().equals(
              other.universityId,
              universityId,
            ) &&
            (identical(other.major, major) || other.major == major) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.gpa, gpa) || other.gpa == gpa) &&
            (identical(other.linkedinUrl, linkedinUrl) ||
                other.linkedinUrl == linkedinUrl) &&
            (identical(other.githubUrl, githubUrl) ||
                other.githubUrl == githubUrl) &&
            (identical(other.instagramUrl, instagramUrl) ||
                other.instagramUrl == instagramUrl) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.showEmail, showEmail) ||
                other.showEmail == showEmail) &&
            (identical(other.showPhone, showPhone) ||
                other.showPhone == showPhone) &&
            (identical(other.showGpa, showGpa) || other.showGpa == showGpa));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    fullName,
    displayName,
    email,
    phoneNumber,
    bio,
    avatarUrl,
    coverImageUrl,
    dateOfBirth,
    gender,
    location,
    website,
    const DeepCollectionEquality().hash(universityId),
    major,
    year,
    gpa,
    linkedinUrl,
    githubUrl,
    instagramUrl,
    isPublic,
    showEmail,
    showPhone,
    showGpa,
  ]);

  /// Create a copy of UpdateUserProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateUserProfileDtoImplCopyWith<_$UpdateUserProfileDtoImpl>
  get copyWith =>
      __$$UpdateUserProfileDtoImplCopyWithImpl<_$UpdateUserProfileDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateUserProfileDtoImplToJson(this);
  }
}

abstract class _UpdateUserProfileDto extends UpdateUserProfileDto {
  const factory _UpdateUserProfileDto({
    final String? fullName,
    final String? displayName,
    final String? email,
    final String? phoneNumber,
    @JsonKey(name: 'introduction') final String? bio,
    @JsonKey(name: 'profileImageUrl') final String? avatarUrl,
    final String? coverImageUrl,
    final DateTime? dateOfBirth,
    final String? gender,
    final String? location,
    final String? website,
    final dynamic universityId,
    final String? major,
    final int? year,
    final double? gpa,
    final String? linkedinUrl,
    final String? githubUrl,
    final String? instagramUrl,
    final bool? isPublic,
    final bool? showEmail,
    final bool? showPhone,
    final bool? showGpa,
  }) = _$UpdateUserProfileDtoImpl;
  const _UpdateUserProfileDto._() : super._();

  factory _UpdateUserProfileDto.fromJson(Map<String, dynamic> json) =
      _$UpdateUserProfileDtoImpl.fromJson;

  @override
  String? get fullName;
  @override
  String? get displayName;
  @override
  String? get email;
  @override
  String? get phoneNumber;
  @override
  @JsonKey(name: 'introduction')
  String? get bio;
  @override
  @JsonKey(name: 'profileImageUrl')
  String? get avatarUrl;
  @override
  String? get coverImageUrl;
  @override
  DateTime? get dateOfBirth;
  @override
  String? get gender;
  @override
  String? get location;
  @override
  String? get website;
  @override
  dynamic get universityId;
  @override
  String? get major;
  @override
  int? get year;
  @override
  double? get gpa;
  @override
  String? get linkedinUrl;
  @override
  String? get githubUrl;
  @override
  String? get instagramUrl;
  @override
  bool? get isPublic;
  @override
  bool? get showEmail;
  @override
  bool? get showPhone;
  @override
  bool? get showGpa;

  /// Create a copy of UpdateUserProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateUserProfileDtoImplCopyWith<_$UpdateUserProfileDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

UserProfileResponseDto _$UserProfileResponseDtoFromJson(
  Map<String, dynamic> json,
) {
  return _UserProfileResponseDto.fromJson(json);
}

/// @nodoc
mixin _$UserProfileResponseDto {
  bool get success => throw _privateConstructorUsedError;
  UserProfileDto get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<String>? get errors => throw _privateConstructorUsedError;

  /// Serializes this UserProfileResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfileResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileResponseDtoCopyWith<UserProfileResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileResponseDtoCopyWith<$Res> {
  factory $UserProfileResponseDtoCopyWith(
    UserProfileResponseDto value,
    $Res Function(UserProfileResponseDto) then,
  ) = _$UserProfileResponseDtoCopyWithImpl<$Res, UserProfileResponseDto>;
  @useResult
  $Res call({
    bool success,
    UserProfileDto data,
    String? message,
    List<String>? errors,
  });

  $UserProfileDtoCopyWith<$Res> get data;
}

/// @nodoc
class _$UserProfileResponseDtoCopyWithImpl<
  $Res,
  $Val extends UserProfileResponseDto
>
    implements $UserProfileResponseDtoCopyWith<$Res> {
  _$UserProfileResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? message = freezed,
    Object? errors = freezed,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as UserProfileDto,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            errors: freezed == errors
                ? _value.errors
                : errors // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
          )
          as $Val,
    );
  }

  /// Create a copy of UserProfileResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileDtoCopyWith<$Res> get data {
    return $UserProfileDtoCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserProfileResponseDtoImplCopyWith<$Res>
    implements $UserProfileResponseDtoCopyWith<$Res> {
  factory _$$UserProfileResponseDtoImplCopyWith(
    _$UserProfileResponseDtoImpl value,
    $Res Function(_$UserProfileResponseDtoImpl) then,
  ) = __$$UserProfileResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    UserProfileDto data,
    String? message,
    List<String>? errors,
  });

  @override
  $UserProfileDtoCopyWith<$Res> get data;
}

/// @nodoc
class __$$UserProfileResponseDtoImplCopyWithImpl<$Res>
    extends
        _$UserProfileResponseDtoCopyWithImpl<$Res, _$UserProfileResponseDtoImpl>
    implements _$$UserProfileResponseDtoImplCopyWith<$Res> {
  __$$UserProfileResponseDtoImplCopyWithImpl(
    _$UserProfileResponseDtoImpl _value,
    $Res Function(_$UserProfileResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfileResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? message = freezed,
    Object? errors = freezed,
  }) {
    return _then(
      _$UserProfileResponseDtoImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as UserProfileDto,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        errors: freezed == errors
            ? _value._errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileResponseDtoImpl extends _UserProfileResponseDto {
  const _$UserProfileResponseDtoImpl({
    required this.success,
    required this.data,
    this.message,
    final List<String>? errors,
  }) : _errors = errors,
       super._();

  factory _$UserProfileResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileResponseDtoImplFromJson(json);

  @override
  final bool success;
  @override
  final UserProfileDto data;
  @override
  final String? message;
  final List<String>? _errors;
  @override
  List<String>? get errors {
    final value = _errors;
    if (value == null) return null;
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UserProfileResponseDto(success: $success, data: $data, message: $message, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileResponseDtoImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    data,
    message,
    const DeepCollectionEquality().hash(_errors),
  );

  /// Create a copy of UserProfileResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileResponseDtoImplCopyWith<_$UserProfileResponseDtoImpl>
  get copyWith =>
      __$$UserProfileResponseDtoImplCopyWithImpl<_$UserProfileResponseDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileResponseDtoImplToJson(this);
  }
}

abstract class _UserProfileResponseDto extends UserProfileResponseDto {
  const factory _UserProfileResponseDto({
    required final bool success,
    required final UserProfileDto data,
    final String? message,
    final List<String>? errors,
  }) = _$UserProfileResponseDtoImpl;
  const _UserProfileResponseDto._() : super._();

  factory _UserProfileResponseDto.fromJson(Map<String, dynamic> json) =
      _$UserProfileResponseDtoImpl.fromJson;

  @override
  bool get success;
  @override
  UserProfileDto get data;
  @override
  String? get message;
  @override
  List<String>? get errors;

  /// Create a copy of UserProfileResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileResponseDtoImplCopyWith<_$UserProfileResponseDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SimpleResponseDto _$SimpleResponseDtoFromJson(Map<String, dynamic> json) {
  return _SimpleResponseDto.fromJson(json);
}

/// @nodoc
mixin _$SimpleResponseDto {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<String>? get errors => throw _privateConstructorUsedError;

  /// Serializes this SimpleResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SimpleResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SimpleResponseDtoCopyWith<SimpleResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimpleResponseDtoCopyWith<$Res> {
  factory $SimpleResponseDtoCopyWith(
    SimpleResponseDto value,
    $Res Function(SimpleResponseDto) then,
  ) = _$SimpleResponseDtoCopyWithImpl<$Res, SimpleResponseDto>;
  @useResult
  $Res call({bool success, String? message, List<String>? errors});
}

/// @nodoc
class _$SimpleResponseDtoCopyWithImpl<$Res, $Val extends SimpleResponseDto>
    implements $SimpleResponseDtoCopyWith<$Res> {
  _$SimpleResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SimpleResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? errors = freezed,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            errors: freezed == errors
                ? _value.errors
                : errors // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SimpleResponseDtoImplCopyWith<$Res>
    implements $SimpleResponseDtoCopyWith<$Res> {
  factory _$$SimpleResponseDtoImplCopyWith(
    _$SimpleResponseDtoImpl value,
    $Res Function(_$SimpleResponseDtoImpl) then,
  ) = __$$SimpleResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String? message, List<String>? errors});
}

/// @nodoc
class __$$SimpleResponseDtoImplCopyWithImpl<$Res>
    extends _$SimpleResponseDtoCopyWithImpl<$Res, _$SimpleResponseDtoImpl>
    implements _$$SimpleResponseDtoImplCopyWith<$Res> {
  __$$SimpleResponseDtoImplCopyWithImpl(
    _$SimpleResponseDtoImpl _value,
    $Res Function(_$SimpleResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SimpleResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? errors = freezed,
  }) {
    return _then(
      _$SimpleResponseDtoImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        errors: freezed == errors
            ? _value._errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SimpleResponseDtoImpl extends _SimpleResponseDto {
  const _$SimpleResponseDtoImpl({
    required this.success,
    this.message,
    final List<String>? errors,
  }) : _errors = errors,
       super._();

  factory _$SimpleResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SimpleResponseDtoImplFromJson(json);

  @override
  final bool success;
  @override
  final String? message;
  final List<String>? _errors;
  @override
  List<String>? get errors {
    final value = _errors;
    if (value == null) return null;
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SimpleResponseDto(success: $success, message: $message, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimpleResponseDtoImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    message,
    const DeepCollectionEquality().hash(_errors),
  );

  /// Create a copy of SimpleResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimpleResponseDtoImplCopyWith<_$SimpleResponseDtoImpl> get copyWith =>
      __$$SimpleResponseDtoImplCopyWithImpl<_$SimpleResponseDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SimpleResponseDtoImplToJson(this);
  }
}

abstract class _SimpleResponseDto extends SimpleResponseDto {
  const factory _SimpleResponseDto({
    required final bool success,
    final String? message,
    final List<String>? errors,
  }) = _$SimpleResponseDtoImpl;
  const _SimpleResponseDto._() : super._();

  factory _SimpleResponseDto.fromJson(Map<String, dynamic> json) =
      _$SimpleResponseDtoImpl.fromJson;

  @override
  bool get success;
  @override
  String? get message;
  @override
  List<String>? get errors;

  /// Create a copy of SimpleResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimpleResponseDtoImplCopyWith<_$SimpleResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
