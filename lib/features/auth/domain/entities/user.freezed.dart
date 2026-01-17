// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String? get fullName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get university => throw _privateConstructorUsedError;
  int? get universityId => throw _privateConstructorUsedError;
  String? get major => throw _privateConstructorUsedError;
  int? get majorId => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  bool get isEmailVerified => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call({
    String id,
    String email,
    String nickname,
    String? fullName,
    String? avatarUrl,
    String? university,
    int? universityId,
    String? major,
    int? majorId,
    String? bio,
    bool isEmailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? nickname = null,
    Object? fullName = freezed,
    Object? avatarUrl = freezed,
    Object? university = freezed,
    Object? universityId = freezed,
    Object? major = freezed,
    Object? majorId = freezed,
    Object? bio = freezed,
    Object? isEmailVerified = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
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
            isEmailVerified: null == isEmailVerified
                ? _value.isEmailVerified
                : isEmailVerified // ignore: cast_nullable_to_non_nullable
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
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
    _$UserImpl value,
    $Res Function(_$UserImpl) then,
  ) = __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String email,
    String nickname,
    String? fullName,
    String? avatarUrl,
    String? university,
    int? universityId,
    String? major,
    int? majorId,
    String? bio,
    bool isEmailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
    : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? nickname = null,
    Object? fullName = freezed,
    Object? avatarUrl = freezed,
    Object? university = freezed,
    Object? universityId = freezed,
    Object? major = freezed,
    Object? majorId = freezed,
    Object? bio = freezed,
    Object? isEmailVerified = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$UserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
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
        isEmailVerified: null == isEmailVerified
            ? _value.isEmailVerified
            : isEmailVerified // ignore: cast_nullable_to_non_nullable
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

class _$UserImpl extends _User {
  const _$UserImpl({
    required this.id,
    required this.email,
    required this.nickname,
    this.fullName,
    this.avatarUrl,
    this.university,
    this.universityId,
    this.major,
    this.majorId,
    this.bio,
    this.isEmailVerified = false,
    this.createdAt,
    this.updatedAt,
  }) : super._();

  @override
  final String id;
  @override
  final String email;
  @override
  final String nickname;
  @override
  final String? fullName;
  @override
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
  final String? bio;
  @override
  @JsonKey()
  final bool isEmailVerified;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'User(id: $id, email: $email, nickname: $nickname, fullName: $fullName, avatarUrl: $avatarUrl, university: $university, universityId: $universityId, major: $major, majorId: $majorId, bio: $bio, isEmailVerified: $isEmailVerified, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
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
            (identical(other.isEmailVerified, isEmailVerified) ||
                other.isEmailVerified == isEmailVerified) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    email,
    nickname,
    fullName,
    avatarUrl,
    university,
    universityId,
    major,
    majorId,
    bio,
    isEmailVerified,
    createdAt,
    updatedAt,
  );

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);
}

abstract class _User extends User {
  const factory _User({
    required final String id,
    required final String email,
    required final String nickname,
    final String? fullName,
    final String? avatarUrl,
    final String? university,
    final int? universityId,
    final String? major,
    final int? majorId,
    final String? bio,
    final bool isEmailVerified,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$UserImpl;
  const _User._() : super._();

  @override
  String get id;
  @override
  String get email;
  @override
  String get nickname;
  @override
  String? get fullName;
  @override
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
  String? get bio;
  @override
  bool get isEmailVerified;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
