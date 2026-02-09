// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TokenResponseDto _$TokenResponseDtoFromJson(Map<String, dynamic> json) {
  return _TokenResponseDto.fromJson(json);
}

/// @nodoc
mixin _$TokenResponseDto {
  String get accessToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;
  int? get userId => throw _privateConstructorUsedError;
  bool get emailVerified => throw _privateConstructorUsedError;
  bool get hasAgreedAllMandatory => throw _privateConstructorUsedError;
  bool get hasBirthDate => throw _privateConstructorUsedError;
  bool get isNewUser => throw _privateConstructorUsedError;

  /// Serializes this TokenResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenResponseDtoCopyWith<TokenResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenResponseDtoCopyWith<$Res> {
  factory $TokenResponseDtoCopyWith(
    TokenResponseDto value,
    $Res Function(TokenResponseDto) then,
  ) = _$TokenResponseDtoCopyWithImpl<$Res, TokenResponseDto>;
  @useResult
  $Res call({
    String accessToken,
    String refreshToken,
    int? userId,
    bool emailVerified,
    bool hasAgreedAllMandatory,
    bool hasBirthDate,
    bool isNewUser,
  });
}

/// @nodoc
class _$TokenResponseDtoCopyWithImpl<$Res, $Val extends TokenResponseDto>
    implements $TokenResponseDtoCopyWith<$Res> {
  _$TokenResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? userId = freezed,
    Object? emailVerified = null,
    Object? hasAgreedAllMandatory = null,
    Object? hasBirthDate = null,
    Object? isNewUser = null,
  }) {
    return _then(
      _value.copyWith(
            accessToken: null == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                      as String,
            refreshToken: null == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int?,
            emailVerified: null == emailVerified
                ? _value.emailVerified
                : emailVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasAgreedAllMandatory: null == hasAgreedAllMandatory
                ? _value.hasAgreedAllMandatory
                : hasAgreedAllMandatory // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasBirthDate: null == hasBirthDate
                ? _value.hasBirthDate
                : hasBirthDate // ignore: cast_nullable_to_non_nullable
                      as bool,
            isNewUser: null == isNewUser
                ? _value.isNewUser
                : isNewUser // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TokenResponseDtoImplCopyWith<$Res>
    implements $TokenResponseDtoCopyWith<$Res> {
  factory _$$TokenResponseDtoImplCopyWith(
    _$TokenResponseDtoImpl value,
    $Res Function(_$TokenResponseDtoImpl) then,
  ) = __$$TokenResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String accessToken,
    String refreshToken,
    int? userId,
    bool emailVerified,
    bool hasAgreedAllMandatory,
    bool hasBirthDate,
    bool isNewUser,
  });
}

/// @nodoc
class __$$TokenResponseDtoImplCopyWithImpl<$Res>
    extends _$TokenResponseDtoCopyWithImpl<$Res, _$TokenResponseDtoImpl>
    implements _$$TokenResponseDtoImplCopyWith<$Res> {
  __$$TokenResponseDtoImplCopyWithImpl(
    _$TokenResponseDtoImpl _value,
    $Res Function(_$TokenResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? userId = freezed,
    Object? emailVerified = null,
    Object? hasAgreedAllMandatory = null,
    Object? hasBirthDate = null,
    Object? isNewUser = null,
  }) {
    return _then(
      _$TokenResponseDtoImpl(
        accessToken: null == accessToken
            ? _value.accessToken
            : accessToken // ignore: cast_nullable_to_non_nullable
                  as String,
        refreshToken: null == refreshToken
            ? _value.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int?,
        emailVerified: null == emailVerified
            ? _value.emailVerified
            : emailVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasAgreedAllMandatory: null == hasAgreedAllMandatory
            ? _value.hasAgreedAllMandatory
            : hasAgreedAllMandatory // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasBirthDate: null == hasBirthDate
            ? _value.hasBirthDate
            : hasBirthDate // ignore: cast_nullable_to_non_nullable
                  as bool,
        isNewUser: null == isNewUser
            ? _value.isNewUser
            : isNewUser // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenResponseDtoImpl implements _TokenResponseDto {
  const _$TokenResponseDtoImpl({
    required this.accessToken,
    required this.refreshToken,
    this.userId,
    this.emailVerified = false,
    this.hasAgreedAllMandatory = false,
    this.hasBirthDate = false,
    this.isNewUser = false,
  });

  factory _$TokenResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenResponseDtoImplFromJson(json);

  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final int? userId;
  @override
  @JsonKey()
  final bool emailVerified;
  @override
  @JsonKey()
  final bool hasAgreedAllMandatory;
  @override
  @JsonKey()
  final bool hasBirthDate;
  @override
  @JsonKey()
  final bool isNewUser;

  @override
  String toString() {
    return 'TokenResponseDto(accessToken: $accessToken, refreshToken: $refreshToken, userId: $userId, emailVerified: $emailVerified, hasAgreedAllMandatory: $hasAgreedAllMandatory, hasBirthDate: $hasBirthDate, isNewUser: $isNewUser)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenResponseDtoImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.emailVerified, emailVerified) ||
                other.emailVerified == emailVerified) &&
            (identical(other.hasAgreedAllMandatory, hasAgreedAllMandatory) ||
                other.hasAgreedAllMandatory == hasAgreedAllMandatory) &&
            (identical(other.hasBirthDate, hasBirthDate) ||
                other.hasBirthDate == hasBirthDate) &&
            (identical(other.isNewUser, isNewUser) ||
                other.isNewUser == isNewUser));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    accessToken,
    refreshToken,
    userId,
    emailVerified,
    hasAgreedAllMandatory,
    hasBirthDate,
    isNewUser,
  );

  /// Create a copy of TokenResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenResponseDtoImplCopyWith<_$TokenResponseDtoImpl> get copyWith =>
      __$$TokenResponseDtoImplCopyWithImpl<_$TokenResponseDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenResponseDtoImplToJson(this);
  }
}

abstract class _TokenResponseDto implements TokenResponseDto {
  const factory _TokenResponseDto({
    required final String accessToken,
    required final String refreshToken,
    final int? userId,
    final bool emailVerified,
    final bool hasAgreedAllMandatory,
    final bool hasBirthDate,
    final bool isNewUser,
  }) = _$TokenResponseDtoImpl;

  factory _TokenResponseDto.fromJson(Map<String, dynamic> json) =
      _$TokenResponseDtoImpl.fromJson;

  @override
  String get accessToken;
  @override
  String get refreshToken;
  @override
  int? get userId;
  @override
  bool get emailVerified;
  @override
  bool get hasAgreedAllMandatory;
  @override
  bool get hasBirthDate;
  @override
  bool get isNewUser;

  /// Create a copy of TokenResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenResponseDtoImplCopyWith<_$TokenResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
