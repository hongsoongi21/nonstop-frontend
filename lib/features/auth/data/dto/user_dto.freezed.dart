// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserDto _$UserDtoFromJson(Map<String, dynamic> json) {
  return _UserDto.fromJson(json);
}

/// @nodoc
mixin _$UserDto {
  // 백엔드의 숫자형 ID를 문자열로 안전하게 받기 위해 dynamic으로 설정 후 toDomain에서 처리
  dynamic get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String? get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'profileImageUrl')
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get university => throw _privateConstructorUsedError;
  int? get universityId => throw _privateConstructorUsedError;
  String? get major => throw _privateConstructorUsedError;
  int? get majorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'introduction')
  String? get bio => throw _privateConstructorUsedError;
  @JsonKey(name: 'userRole')
  String? get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'emailVerified')
  bool get isEmailVerified => throw _privateConstructorUsedError;
  String? get preferredLanguage => throw _privateConstructorUsedError;
  bool get isUniversityVerified => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserDtoCopyWith<UserDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDtoCopyWith<$Res> {
  factory $UserDtoCopyWith(UserDto value, $Res Function(UserDto) then) =
      _$UserDtoCopyWithImpl<$Res, UserDto>;
  @useResult
  $Res call({
    dynamic id,
    String email,
    String nickname,
    String? fullName,
    @JsonKey(name: 'profileImageUrl') String? avatarUrl,
    String? university,
    int? universityId,
    String? major,
    int? majorId,
    @JsonKey(name: 'introduction') String? bio,
    @JsonKey(name: 'userRole') String? role,
    @JsonKey(name: 'emailVerified') bool isEmailVerified,
    String? preferredLanguage,
    bool isUniversityVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$UserDtoCopyWithImpl<$Res, $Val extends UserDto>
    implements $UserDtoCopyWith<$Res> {
  _$UserDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? email = null,
    Object? nickname = null,
    Object? fullName = freezed,
    Object? avatarUrl = freezed,
    Object? university = freezed,
    Object? universityId = freezed,
    Object? major = freezed,
    Object? majorId = freezed,
    Object? bio = freezed,
    Object? role = freezed,
    Object? isEmailVerified = null,
    Object? preferredLanguage = freezed,
    Object? isUniversityVerified = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            nickname: null == nickname
                ? _value.nickname
                : nickname // ignore: cast_nullable_to_non_nullable
                      as String,
            fullName: freezed == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            university: freezed == university
                ? _value.university
                : university // ignore: cast_nullable_to_non_nullable
                      as String?,
            universityId: freezed == universityId
                ? _value.universityId
                : universityId // ignore: cast_nullable_to_non_nullable
                      as int?,
            major: freezed == major
                ? _value.major
                : major // ignore: cast_nullable_to_non_nullable
                      as String?,
            majorId: freezed == majorId
                ? _value.majorId
                : majorId // ignore: cast_nullable_to_non_nullable
                      as int?,
            bio: freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String?,
            role: freezed == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String?,
            isEmailVerified: null == isEmailVerified
                ? _value.isEmailVerified
                : isEmailVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            preferredLanguage: freezed == preferredLanguage
                ? _value.preferredLanguage
                : preferredLanguage // ignore: cast_nullable_to_non_nullable
                      as String?,
            isUniversityVerified: null == isUniversityVerified
                ? _value.isUniversityVerified
                : isUniversityVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserDtoImplCopyWith<$Res> implements $UserDtoCopyWith<$Res> {
  factory _$$UserDtoImplCopyWith(
    _$UserDtoImpl value,
    $Res Function(_$UserDtoImpl) then,
  ) = __$$UserDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    dynamic id,
    String email,
    String nickname,
    String? fullName,
    @JsonKey(name: 'profileImageUrl') String? avatarUrl,
    String? university,
    int? universityId,
    String? major,
    int? majorId,
    @JsonKey(name: 'introduction') String? bio,
    @JsonKey(name: 'userRole') String? role,
    @JsonKey(name: 'emailVerified') bool isEmailVerified,
    String? preferredLanguage,
    bool isUniversityVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$UserDtoImplCopyWithImpl<$Res>
    extends _$UserDtoCopyWithImpl<$Res, _$UserDtoImpl>
    implements _$$UserDtoImplCopyWith<$Res> {
  __$$UserDtoImplCopyWithImpl(
    _$UserDtoImpl _value,
    $Res Function(_$UserDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? email = null,
    Object? nickname = null,
    Object? fullName = freezed,
    Object? avatarUrl = freezed,
    Object? university = freezed,
    Object? universityId = freezed,
    Object? major = freezed,
    Object? majorId = freezed,
    Object? bio = freezed,
    Object? role = freezed,
    Object? isEmailVerified = null,
    Object? preferredLanguage = freezed,
    Object? isUniversityVerified = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$UserDtoImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        nickname: null == nickname
            ? _value.nickname
            : nickname // ignore: cast_nullable_to_non_nullable
                  as String,
        fullName: freezed == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        university: freezed == university
            ? _value.university
            : university // ignore: cast_nullable_to_non_nullable
                  as String?,
        universityId: freezed == universityId
            ? _value.universityId
            : universityId // ignore: cast_nullable_to_non_nullable
                  as int?,
        major: freezed == major
            ? _value.major
            : major // ignore: cast_nullable_to_non_nullable
                  as String?,
        majorId: freezed == majorId
            ? _value.majorId
            : majorId // ignore: cast_nullable_to_non_nullable
                  as int?,
        bio: freezed == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String?,
        role: freezed == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String?,
        isEmailVerified: null == isEmailVerified
            ? _value.isEmailVerified
            : isEmailVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        preferredLanguage: freezed == preferredLanguage
            ? _value.preferredLanguage
            : preferredLanguage // ignore: cast_nullable_to_non_nullable
                  as String?,
        isUniversityVerified: null == isUniversityVerified
            ? _value.isUniversityVerified
            : isUniversityVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserDtoImpl extends _UserDto {
  const _$UserDtoImpl({
    required this.id,
    required this.email,
    required this.nickname,
    this.fullName,
    @JsonKey(name: 'profileImageUrl') this.avatarUrl,
    this.university,
    this.universityId,
    this.major,
    this.majorId,
    @JsonKey(name: 'introduction') this.bio,
    @JsonKey(name: 'userRole') this.role,
    @JsonKey(name: 'emailVerified') this.isEmailVerified = false,
    this.preferredLanguage,
    this.isUniversityVerified = false,
    this.createdAt,
    this.updatedAt,
  }) : super._();

  factory _$UserDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserDtoImplFromJson(json);

  // 백엔드의 숫자형 ID를 문자열로 안전하게 받기 위해 dynamic으로 설정 후 toDomain에서 처리
  @override
  final dynamic id;
  @override
  final String email;
  @override
  final String nickname;
  @override
  final String? fullName;
  @override
  @JsonKey(name: 'profileImageUrl')
  final String? avatarUrl;
  @override
  final String? university;
  @override
  final int? universityId;
  @override
  final String? major;
  @override
  final int? majorId;
  @override
  @JsonKey(name: 'introduction')
  final String? bio;
  @override
  @JsonKey(name: 'userRole')
  final String? role;
  @override
  @JsonKey(name: 'emailVerified')
  final bool isEmailVerified;
  @override
  final String? preferredLanguage;
  @override
  @JsonKey()
  final bool isUniversityVerified;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'UserDto(id: $id, email: $email, nickname: $nickname, fullName: $fullName, avatarUrl: $avatarUrl, university: $university, universityId: $universityId, major: $major, majorId: $majorId, bio: $bio, role: $role, isEmailVerified: $isEmailVerified, preferredLanguage: $preferredLanguage, isUniversityVerified: $isUniversityVerified, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDtoImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.university, university) ||
                other.university == university) &&
            (identical(other.universityId, universityId) ||
                other.universityId == universityId) &&
            (identical(other.major, major) || other.major == major) &&
            (identical(other.majorId, majorId) || other.majorId == majorId) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.isEmailVerified, isEmailVerified) ||
                other.isEmailVerified == isEmailVerified) &&
            (identical(other.preferredLanguage, preferredLanguage) ||
                other.preferredLanguage == preferredLanguage) &&
            (identical(other.isUniversityVerified, isUniversityVerified) ||
                other.isUniversityVerified == isUniversityVerified) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(id),
    email,
    nickname,
    fullName,
    avatarUrl,
    university,
    universityId,
    major,
    majorId,
    bio,
    role,
    isEmailVerified,
    preferredLanguage,
    isUniversityVerified,
    createdAt,
    updatedAt,
  );

  /// Create a copy of UserDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDtoImplCopyWith<_$UserDtoImpl> get copyWith =>
      __$$UserDtoImplCopyWithImpl<_$UserDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserDtoImplToJson(this);
  }
}

abstract class _UserDto extends UserDto {
  const factory _UserDto({
    required final dynamic id,
    required final String email,
    required final String nickname,
    final String? fullName,
    @JsonKey(name: 'profileImageUrl') final String? avatarUrl,
    final String? university,
    final int? universityId,
    final String? major,
    final int? majorId,
    @JsonKey(name: 'introduction') final String? bio,
    @JsonKey(name: 'userRole') final String? role,
    @JsonKey(name: 'emailVerified') final bool isEmailVerified,
    final String? preferredLanguage,
    final bool isUniversityVerified,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$UserDtoImpl;
  const _UserDto._() : super._();

  factory _UserDto.fromJson(Map<String, dynamic> json) = _$UserDtoImpl.fromJson;

  // 백엔드의 숫자형 ID를 문자열로 안전하게 받기 위해 dynamic으로 설정 후 toDomain에서 처리
  @override
  dynamic get id;
  @override
  String get email;
  @override
  String get nickname;
  @override
  String? get fullName;
  @override
  @JsonKey(name: 'profileImageUrl')
  String? get avatarUrl;
  @override
  String? get university;
  @override
  int? get universityId;
  @override
  String? get major;
  @override
  int? get majorId;
  @override
  @JsonKey(name: 'introduction')
  String? get bio;
  @override
  @JsonKey(name: 'userRole')
  String? get role;
  @override
  @JsonKey(name: 'emailVerified')
  bool get isEmailVerified;
  @override
  String? get preferredLanguage;
  @override
  bool get isUniversityVerified;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of UserDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserDtoImplCopyWith<_$UserDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
