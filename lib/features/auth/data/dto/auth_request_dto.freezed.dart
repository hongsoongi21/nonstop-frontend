// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LoginRequestDto _$LoginRequestDtoFromJson(Map<String, dynamic> json) {
  return _LoginRequestDto.fromJson(json);
}

/// @nodoc
mixin _$LoginRequestDto {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  /// Serializes this LoginRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginRequestDtoCopyWith<LoginRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginRequestDtoCopyWith<$Res> {
  factory $LoginRequestDtoCopyWith(
    LoginRequestDto value,
    $Res Function(LoginRequestDto) then,
  ) = _$LoginRequestDtoCopyWithImpl<$Res, LoginRequestDto>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class _$LoginRequestDtoCopyWithImpl<$Res, $Val extends LoginRequestDto>
    implements $LoginRequestDtoCopyWith<$Res> {
  _$LoginRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null, Object? password = null}) {
    return _then(
      _value.copyWith(
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoginRequestDtoImplCopyWith<$Res>
    implements $LoginRequestDtoCopyWith<$Res> {
  factory _$$LoginRequestDtoImplCopyWith(
    _$LoginRequestDtoImpl value,
    $Res Function(_$LoginRequestDtoImpl) then,
  ) = __$$LoginRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$LoginRequestDtoImplCopyWithImpl<$Res>
    extends _$LoginRequestDtoCopyWithImpl<$Res, _$LoginRequestDtoImpl>
    implements _$$LoginRequestDtoImplCopyWith<$Res> {
  __$$LoginRequestDtoImplCopyWithImpl(
    _$LoginRequestDtoImpl _value,
    $Res Function(_$LoginRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null, Object? password = null}) {
    return _then(
      _$LoginRequestDtoImpl(
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginRequestDtoImpl implements _LoginRequestDto {
  const _$LoginRequestDtoImpl({required this.email, required this.password});

  factory _$LoginRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginRequestDtoImplFromJson(json);

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginRequestDto(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginRequestDtoImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  /// Create a copy of LoginRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginRequestDtoImplCopyWith<_$LoginRequestDtoImpl> get copyWith =>
      __$$LoginRequestDtoImplCopyWithImpl<_$LoginRequestDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginRequestDtoImplToJson(this);
  }
}

abstract class _LoginRequestDto implements LoginRequestDto {
  const factory _LoginRequestDto({
    required final String email,
    required final String password,
  }) = _$LoginRequestDtoImpl;

  factory _LoginRequestDto.fromJson(Map<String, dynamic> json) =
      _$LoginRequestDtoImpl.fromJson;

  @override
  String get email;
  @override
  String get password;

  /// Create a copy of LoginRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginRequestDtoImplCopyWith<_$LoginRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SignUpRequestDto _$SignUpRequestDtoFromJson(Map<String, dynamic> json) {
  return _SignUpRequestDto.fromJson(json);
}

/// @nodoc
mixin _$SignUpRequestDto {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;

  /// Serializes this SignUpRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SignUpRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignUpRequestDtoCopyWith<SignUpRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpRequestDtoCopyWith<$Res> {
  factory $SignUpRequestDtoCopyWith(
    SignUpRequestDto value,
    $Res Function(SignUpRequestDto) then,
  ) = _$SignUpRequestDtoCopyWithImpl<$Res, SignUpRequestDto>;
  @useResult
  $Res call({String email, String password, String nickname});
}

/// @nodoc
class _$SignUpRequestDtoCopyWithImpl<$Res, $Val extends SignUpRequestDto>
    implements $SignUpRequestDtoCopyWith<$Res> {
  _$SignUpRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignUpRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? nickname = null,
  }) {
    return _then(
      _value.copyWith(
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
            nickname: null == nickname
                ? _value.nickname
                : nickname // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SignUpRequestDtoImplCopyWith<$Res>
    implements $SignUpRequestDtoCopyWith<$Res> {
  factory _$$SignUpRequestDtoImplCopyWith(
    _$SignUpRequestDtoImpl value,
    $Res Function(_$SignUpRequestDtoImpl) then,
  ) = __$$SignUpRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password, String nickname});
}

/// @nodoc
class __$$SignUpRequestDtoImplCopyWithImpl<$Res>
    extends _$SignUpRequestDtoCopyWithImpl<$Res, _$SignUpRequestDtoImpl>
    implements _$$SignUpRequestDtoImplCopyWith<$Res> {
  __$$SignUpRequestDtoImplCopyWithImpl(
    _$SignUpRequestDtoImpl _value,
    $Res Function(_$SignUpRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SignUpRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? nickname = null,
  }) {
    return _then(
      _$SignUpRequestDtoImpl(
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
        nickname: null == nickname
            ? _value.nickname
            : nickname // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SignUpRequestDtoImpl implements _SignUpRequestDto {
  const _$SignUpRequestDtoImpl({
    required this.email,
    required this.password,
    required this.nickname,
  });

  factory _$SignUpRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignUpRequestDtoImplFromJson(json);

  @override
  final String email;
  @override
  final String password;
  @override
  final String nickname;

  @override
  String toString() {
    return 'SignUpRequestDto(email: $email, password: $password, nickname: $nickname)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpRequestDtoImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, password, nickname);

  /// Create a copy of SignUpRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpRequestDtoImplCopyWith<_$SignUpRequestDtoImpl> get copyWith =>
      __$$SignUpRequestDtoImplCopyWithImpl<_$SignUpRequestDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SignUpRequestDtoImplToJson(this);
  }
}

abstract class _SignUpRequestDto implements SignUpRequestDto {
  const factory _SignUpRequestDto({
    required final String email,
    required final String password,
    required final String nickname,
  }) = _$SignUpRequestDtoImpl;

  factory _SignUpRequestDto.fromJson(Map<String, dynamic> json) =
      _$SignUpRequestDtoImpl.fromJson;

  @override
  String get email;
  @override
  String get password;
  @override
  String get nickname;

  /// Create a copy of SignUpRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignUpRequestDtoImplCopyWith<_$SignUpRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProfileUpdateRequestDto _$ProfileUpdateRequestDtoFromJson(
  Map<String, dynamic> json,
) {
  return _ProfileUpdateRequestDto.fromJson(json);
}

/// @nodoc
mixin _$ProfileUpdateRequestDto {
  String? get nickname => throw _privateConstructorUsedError;
  int? get universityId => throw _privateConstructorUsedError;
  int? get majorId => throw _privateConstructorUsedError;
  String? get introduction => throw _privateConstructorUsedError;
  String? get preferredLanguage => throw _privateConstructorUsedError;

  /// Serializes this ProfileUpdateRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileUpdateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileUpdateRequestDtoCopyWith<ProfileUpdateRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileUpdateRequestDtoCopyWith<$Res> {
  factory $ProfileUpdateRequestDtoCopyWith(
    ProfileUpdateRequestDto value,
    $Res Function(ProfileUpdateRequestDto) then,
  ) = _$ProfileUpdateRequestDtoCopyWithImpl<$Res, ProfileUpdateRequestDto>;
  @useResult
  $Res call({
    String? nickname,
    int? universityId,
    int? majorId,
    String? introduction,
    String? preferredLanguage,
  });
}

/// @nodoc
class _$ProfileUpdateRequestDtoCopyWithImpl<
  $Res,
  $Val extends ProfileUpdateRequestDto
>
    implements $ProfileUpdateRequestDtoCopyWith<$Res> {
  _$ProfileUpdateRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileUpdateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = freezed,
    Object? universityId = freezed,
    Object? majorId = freezed,
    Object? introduction = freezed,
    Object? preferredLanguage = freezed,
  }) {
    return _then(
      _value.copyWith(
            nickname: freezed == nickname
                ? _value.nickname
                : nickname // ignore: cast_nullable_to_non_nullable
                      as String?,
            universityId: freezed == universityId
                ? _value.universityId
                : universityId // ignore: cast_nullable_to_non_nullable
                      as int?,
            majorId: freezed == majorId
                ? _value.majorId
                : majorId // ignore: cast_nullable_to_non_nullable
                      as int?,
            introduction: freezed == introduction
                ? _value.introduction
                : introduction // ignore: cast_nullable_to_non_nullable
                      as String?,
            preferredLanguage: freezed == preferredLanguage
                ? _value.preferredLanguage
                : preferredLanguage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileUpdateRequestDtoImplCopyWith<$Res>
    implements $ProfileUpdateRequestDtoCopyWith<$Res> {
  factory _$$ProfileUpdateRequestDtoImplCopyWith(
    _$ProfileUpdateRequestDtoImpl value,
    $Res Function(_$ProfileUpdateRequestDtoImpl) then,
  ) = __$$ProfileUpdateRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? nickname,
    int? universityId,
    int? majorId,
    String? introduction,
    String? preferredLanguage,
  });
}

/// @nodoc
class __$$ProfileUpdateRequestDtoImplCopyWithImpl<$Res>
    extends
        _$ProfileUpdateRequestDtoCopyWithImpl<
          $Res,
          _$ProfileUpdateRequestDtoImpl
        >
    implements _$$ProfileUpdateRequestDtoImplCopyWith<$Res> {
  __$$ProfileUpdateRequestDtoImplCopyWithImpl(
    _$ProfileUpdateRequestDtoImpl _value,
    $Res Function(_$ProfileUpdateRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileUpdateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = freezed,
    Object? universityId = freezed,
    Object? majorId = freezed,
    Object? introduction = freezed,
    Object? preferredLanguage = freezed,
  }) {
    return _then(
      _$ProfileUpdateRequestDtoImpl(
        nickname: freezed == nickname
            ? _value.nickname
            : nickname // ignore: cast_nullable_to_non_nullable
                  as String?,
        universityId: freezed == universityId
            ? _value.universityId
            : universityId // ignore: cast_nullable_to_non_nullable
                  as int?,
        majorId: freezed == majorId
            ? _value.majorId
            : majorId // ignore: cast_nullable_to_non_nullable
                  as int?,
        introduction: freezed == introduction
            ? _value.introduction
            : introduction // ignore: cast_nullable_to_non_nullable
                  as String?,
        preferredLanguage: freezed == preferredLanguage
            ? _value.preferredLanguage
            : preferredLanguage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileUpdateRequestDtoImpl implements _ProfileUpdateRequestDto {
  const _$ProfileUpdateRequestDtoImpl({
    this.nickname,
    this.universityId,
    this.majorId,
    this.introduction,
    this.preferredLanguage,
  });

  factory _$ProfileUpdateRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileUpdateRequestDtoImplFromJson(json);

  @override
  final String? nickname;
  @override
  final int? universityId;
  @override
  final int? majorId;
  @override
  final String? introduction;
  @override
  final String? preferredLanguage;

  @override
  String toString() {
    return 'ProfileUpdateRequestDto(nickname: $nickname, universityId: $universityId, majorId: $majorId, introduction: $introduction, preferredLanguage: $preferredLanguage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileUpdateRequestDtoImpl &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.universityId, universityId) ||
                other.universityId == universityId) &&
            (identical(other.majorId, majorId) || other.majorId == majorId) &&
            (identical(other.introduction, introduction) ||
                other.introduction == introduction) &&
            (identical(other.preferredLanguage, preferredLanguage) ||
                other.preferredLanguage == preferredLanguage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    nickname,
    universityId,
    majorId,
    introduction,
    preferredLanguage,
  );

  /// Create a copy of ProfileUpdateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileUpdateRequestDtoImplCopyWith<_$ProfileUpdateRequestDtoImpl>
  get copyWith =>
      __$$ProfileUpdateRequestDtoImplCopyWithImpl<
        _$ProfileUpdateRequestDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileUpdateRequestDtoImplToJson(this);
  }
}

abstract class _ProfileUpdateRequestDto implements ProfileUpdateRequestDto {
  const factory _ProfileUpdateRequestDto({
    final String? nickname,
    final int? universityId,
    final int? majorId,
    final String? introduction,
    final String? preferredLanguage,
  }) = _$ProfileUpdateRequestDtoImpl;

  factory _ProfileUpdateRequestDto.fromJson(Map<String, dynamic> json) =
      _$ProfileUpdateRequestDtoImpl.fromJson;

  @override
  String? get nickname;
  @override
  int? get universityId;
  @override
  int? get majorId;
  @override
  String? get introduction;
  @override
  String? get preferredLanguage;

  /// Create a copy of ProfileUpdateRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileUpdateRequestDtoImplCopyWith<_$ProfileUpdateRequestDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

RefreshRequestDto _$RefreshRequestDtoFromJson(Map<String, dynamic> json) {
  return _RefreshRequestDto.fromJson(json);
}

/// @nodoc
mixin _$RefreshRequestDto {
  String get refreshToken => throw _privateConstructorUsedError;

  /// Serializes this RefreshRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RefreshRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RefreshRequestDtoCopyWith<RefreshRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefreshRequestDtoCopyWith<$Res> {
  factory $RefreshRequestDtoCopyWith(
    RefreshRequestDto value,
    $Res Function(RefreshRequestDto) then,
  ) = _$RefreshRequestDtoCopyWithImpl<$Res, RefreshRequestDto>;
  @useResult
  $Res call({String refreshToken});
}

/// @nodoc
class _$RefreshRequestDtoCopyWithImpl<$Res, $Val extends RefreshRequestDto>
    implements $RefreshRequestDtoCopyWith<$Res> {
  _$RefreshRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RefreshRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? refreshToken = null}) {
    return _then(
      _value.copyWith(
            refreshToken: null == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RefreshRequestDtoImplCopyWith<$Res>
    implements $RefreshRequestDtoCopyWith<$Res> {
  factory _$$RefreshRequestDtoImplCopyWith(
    _$RefreshRequestDtoImpl value,
    $Res Function(_$RefreshRequestDtoImpl) then,
  ) = __$$RefreshRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String refreshToken});
}

/// @nodoc
class __$$RefreshRequestDtoImplCopyWithImpl<$Res>
    extends _$RefreshRequestDtoCopyWithImpl<$Res, _$RefreshRequestDtoImpl>
    implements _$$RefreshRequestDtoImplCopyWith<$Res> {
  __$$RefreshRequestDtoImplCopyWithImpl(
    _$RefreshRequestDtoImpl _value,
    $Res Function(_$RefreshRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RefreshRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? refreshToken = null}) {
    return _then(
      _$RefreshRequestDtoImpl(
        refreshToken: null == refreshToken
            ? _value.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RefreshRequestDtoImpl implements _RefreshRequestDto {
  const _$RefreshRequestDtoImpl({required this.refreshToken});

  factory _$RefreshRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RefreshRequestDtoImplFromJson(json);

  @override
  final String refreshToken;

  @override
  String toString() {
    return 'RefreshRequestDto(refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshRequestDtoImpl &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, refreshToken);

  /// Create a copy of RefreshRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshRequestDtoImplCopyWith<_$RefreshRequestDtoImpl> get copyWith =>
      __$$RefreshRequestDtoImplCopyWithImpl<_$RefreshRequestDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RefreshRequestDtoImplToJson(this);
  }
}

abstract class _RefreshRequestDto implements RefreshRequestDto {
  const factory _RefreshRequestDto({required final String refreshToken}) =
      _$RefreshRequestDtoImpl;

  factory _RefreshRequestDto.fromJson(Map<String, dynamic> json) =
      _$RefreshRequestDtoImpl.fromJson;

  @override
  String get refreshToken;

  /// Create a copy of RefreshRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefreshRequestDtoImplCopyWith<_$RefreshRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
