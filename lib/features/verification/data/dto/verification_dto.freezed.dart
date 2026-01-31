// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verification_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EmailVerificationRequestDto _$EmailVerificationRequestDtoFromJson(
  Map<String, dynamic> json,
) {
  return _EmailVerificationRequestDto.fromJson(json);
}

/// @nodoc
mixin _$EmailVerificationRequestDto {
  String get email => throw _privateConstructorUsedError;

  /// Serializes this EmailVerificationRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmailVerificationRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailVerificationRequestDtoCopyWith<EmailVerificationRequestDto>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailVerificationRequestDtoCopyWith<$Res> {
  factory $EmailVerificationRequestDtoCopyWith(
    EmailVerificationRequestDto value,
    $Res Function(EmailVerificationRequestDto) then,
  ) =
      _$EmailVerificationRequestDtoCopyWithImpl<
        $Res,
        EmailVerificationRequestDto
      >;
  @useResult
  $Res call({String email});
}

/// @nodoc
class _$EmailVerificationRequestDtoCopyWithImpl<
  $Res,
  $Val extends EmailVerificationRequestDto
>
    implements $EmailVerificationRequestDtoCopyWith<$Res> {
  _$EmailVerificationRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailVerificationRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null}) {
    return _then(
      _value.copyWith(
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EmailVerificationRequestDtoImplCopyWith<$Res>
    implements $EmailVerificationRequestDtoCopyWith<$Res> {
  factory _$$EmailVerificationRequestDtoImplCopyWith(
    _$EmailVerificationRequestDtoImpl value,
    $Res Function(_$EmailVerificationRequestDtoImpl) then,
  ) = __$$EmailVerificationRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$EmailVerificationRequestDtoImplCopyWithImpl<$Res>
    extends
        _$EmailVerificationRequestDtoCopyWithImpl<
          $Res,
          _$EmailVerificationRequestDtoImpl
        >
    implements _$$EmailVerificationRequestDtoImplCopyWith<$Res> {
  __$$EmailVerificationRequestDtoImplCopyWithImpl(
    _$EmailVerificationRequestDtoImpl _value,
    $Res Function(_$EmailVerificationRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmailVerificationRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null}) {
    return _then(
      _$EmailVerificationRequestDtoImpl(
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailVerificationRequestDtoImpl
    implements _EmailVerificationRequestDto {
  const _$EmailVerificationRequestDtoImpl({required this.email});

  factory _$EmailVerificationRequestDtoImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$EmailVerificationRequestDtoImplFromJson(json);

  @override
  final String email;

  @override
  String toString() {
    return 'EmailVerificationRequestDto(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailVerificationRequestDtoImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of EmailVerificationRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailVerificationRequestDtoImplCopyWith<_$EmailVerificationRequestDtoImpl>
  get copyWith =>
      __$$EmailVerificationRequestDtoImplCopyWithImpl<
        _$EmailVerificationRequestDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailVerificationRequestDtoImplToJson(this);
  }
}

abstract class _EmailVerificationRequestDto
    implements EmailVerificationRequestDto {
  const factory _EmailVerificationRequestDto({required final String email}) =
      _$EmailVerificationRequestDtoImpl;

  factory _EmailVerificationRequestDto.fromJson(Map<String, dynamic> json) =
      _$EmailVerificationRequestDtoImpl.fromJson;

  @override
  String get email;

  /// Create a copy of EmailVerificationRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailVerificationRequestDtoImplCopyWith<_$EmailVerificationRequestDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

EmailVerificationConfirmDto _$EmailVerificationConfirmDtoFromJson(
  Map<String, dynamic> json,
) {
  return _EmailVerificationConfirmDto.fromJson(json);
}

/// @nodoc
mixin _$EmailVerificationConfirmDto {
  String get email => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;

  /// Serializes this EmailVerificationConfirmDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmailVerificationConfirmDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailVerificationConfirmDtoCopyWith<EmailVerificationConfirmDto>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailVerificationConfirmDtoCopyWith<$Res> {
  factory $EmailVerificationConfirmDtoCopyWith(
    EmailVerificationConfirmDto value,
    $Res Function(EmailVerificationConfirmDto) then,
  ) =
      _$EmailVerificationConfirmDtoCopyWithImpl<
        $Res,
        EmailVerificationConfirmDto
      >;
  @useResult
  $Res call({String email, String code});
}

/// @nodoc
class _$EmailVerificationConfirmDtoCopyWithImpl<
  $Res,
  $Val extends EmailVerificationConfirmDto
>
    implements $EmailVerificationConfirmDtoCopyWith<$Res> {
  _$EmailVerificationConfirmDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailVerificationConfirmDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null, Object? code = null}) {
    return _then(
      _value.copyWith(
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EmailVerificationConfirmDtoImplCopyWith<$Res>
    implements $EmailVerificationConfirmDtoCopyWith<$Res> {
  factory _$$EmailVerificationConfirmDtoImplCopyWith(
    _$EmailVerificationConfirmDtoImpl value,
    $Res Function(_$EmailVerificationConfirmDtoImpl) then,
  ) = __$$EmailVerificationConfirmDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String code});
}

/// @nodoc
class __$$EmailVerificationConfirmDtoImplCopyWithImpl<$Res>
    extends
        _$EmailVerificationConfirmDtoCopyWithImpl<
          $Res,
          _$EmailVerificationConfirmDtoImpl
        >
    implements _$$EmailVerificationConfirmDtoImplCopyWith<$Res> {
  __$$EmailVerificationConfirmDtoImplCopyWithImpl(
    _$EmailVerificationConfirmDtoImpl _value,
    $Res Function(_$EmailVerificationConfirmDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmailVerificationConfirmDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null, Object? code = null}) {
    return _then(
      _$EmailVerificationConfirmDtoImpl(
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailVerificationConfirmDtoImpl
    implements _EmailVerificationConfirmDto {
  const _$EmailVerificationConfirmDtoImpl({
    required this.email,
    required this.code,
  });

  factory _$EmailVerificationConfirmDtoImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$EmailVerificationConfirmDtoImplFromJson(json);

  @override
  final String email;
  @override
  final String code;

  @override
  String toString() {
    return 'EmailVerificationConfirmDto(email: $email, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailVerificationConfirmDtoImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, code);

  /// Create a copy of EmailVerificationConfirmDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailVerificationConfirmDtoImplCopyWith<_$EmailVerificationConfirmDtoImpl>
  get copyWith =>
      __$$EmailVerificationConfirmDtoImplCopyWithImpl<
        _$EmailVerificationConfirmDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailVerificationConfirmDtoImplToJson(this);
  }
}

abstract class _EmailVerificationConfirmDto
    implements EmailVerificationConfirmDto {
  const factory _EmailVerificationConfirmDto({
    required final String email,
    required final String code,
  }) = _$EmailVerificationConfirmDtoImpl;

  factory _EmailVerificationConfirmDto.fromJson(Map<String, dynamic> json) =
      _$EmailVerificationConfirmDtoImpl.fromJson;

  @override
  String get email;
  @override
  String get code;

  /// Create a copy of EmailVerificationConfirmDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailVerificationConfirmDtoImplCopyWith<_$EmailVerificationConfirmDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

VerificationStatusDto _$VerificationStatusDtoFromJson(
  Map<String, dynamic> json,
) {
  return _VerificationStatusDto.fromJson(json);
}

/// @nodoc
mixin _$VerificationStatusDto {
  bool get isUniversityVerified => throw _privateConstructorUsedError;
  VerificationMethod? get verificationMethod =>
      throw _privateConstructorUsedError;

  /// Serializes this VerificationStatusDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VerificationStatusDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VerificationStatusDtoCopyWith<VerificationStatusDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerificationStatusDtoCopyWith<$Res> {
  factory $VerificationStatusDtoCopyWith(
    VerificationStatusDto value,
    $Res Function(VerificationStatusDto) then,
  ) = _$VerificationStatusDtoCopyWithImpl<$Res, VerificationStatusDto>;
  @useResult
  $Res call({
    bool isUniversityVerified,
    VerificationMethod? verificationMethod,
  });
}

/// @nodoc
class _$VerificationStatusDtoCopyWithImpl<
  $Res,
  $Val extends VerificationStatusDto
>
    implements $VerificationStatusDtoCopyWith<$Res> {
  _$VerificationStatusDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerificationStatusDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isUniversityVerified = null,
    Object? verificationMethod = freezed,
  }) {
    return _then(
      _value.copyWith(
            isUniversityVerified: null == isUniversityVerified
                ? _value.isUniversityVerified
                : isUniversityVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            verificationMethod: freezed == verificationMethod
                ? _value.verificationMethod
                : verificationMethod // ignore: cast_nullable_to_non_nullable
                      as VerificationMethod?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VerificationStatusDtoImplCopyWith<$Res>
    implements $VerificationStatusDtoCopyWith<$Res> {
  factory _$$VerificationStatusDtoImplCopyWith(
    _$VerificationStatusDtoImpl value,
    $Res Function(_$VerificationStatusDtoImpl) then,
  ) = __$$VerificationStatusDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isUniversityVerified,
    VerificationMethod? verificationMethod,
  });
}

/// @nodoc
class __$$VerificationStatusDtoImplCopyWithImpl<$Res>
    extends
        _$VerificationStatusDtoCopyWithImpl<$Res, _$VerificationStatusDtoImpl>
    implements _$$VerificationStatusDtoImplCopyWith<$Res> {
  __$$VerificationStatusDtoImplCopyWithImpl(
    _$VerificationStatusDtoImpl _value,
    $Res Function(_$VerificationStatusDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VerificationStatusDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isUniversityVerified = null,
    Object? verificationMethod = freezed,
  }) {
    return _then(
      _$VerificationStatusDtoImpl(
        isUniversityVerified: null == isUniversityVerified
            ? _value.isUniversityVerified
            : isUniversityVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        verificationMethod: freezed == verificationMethod
            ? _value.verificationMethod
            : verificationMethod // ignore: cast_nullable_to_non_nullable
                  as VerificationMethod?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VerificationStatusDtoImpl implements _VerificationStatusDto {
  const _$VerificationStatusDtoImpl({
    required this.isUniversityVerified,
    this.verificationMethod,
  });

  factory _$VerificationStatusDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerificationStatusDtoImplFromJson(json);

  @override
  final bool isUniversityVerified;
  @override
  final VerificationMethod? verificationMethod;

  @override
  String toString() {
    return 'VerificationStatusDto(isUniversityVerified: $isUniversityVerified, verificationMethod: $verificationMethod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerificationStatusDtoImpl &&
            (identical(other.isUniversityVerified, isUniversityVerified) ||
                other.isUniversityVerified == isUniversityVerified) &&
            (identical(other.verificationMethod, verificationMethod) ||
                other.verificationMethod == verificationMethod));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isUniversityVerified, verificationMethod);

  /// Create a copy of VerificationStatusDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerificationStatusDtoImplCopyWith<_$VerificationStatusDtoImpl>
  get copyWith =>
      __$$VerificationStatusDtoImplCopyWithImpl<_$VerificationStatusDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$VerificationStatusDtoImplToJson(this);
  }
}

abstract class _VerificationStatusDto implements VerificationStatusDto {
  const factory _VerificationStatusDto({
    required final bool isUniversityVerified,
    final VerificationMethod? verificationMethod,
  }) = _$VerificationStatusDtoImpl;

  factory _VerificationStatusDto.fromJson(Map<String, dynamic> json) =
      _$VerificationStatusDtoImpl.fromJson;

  @override
  bool get isUniversityVerified;
  @override
  VerificationMethod? get verificationMethod;

  /// Create a copy of VerificationStatusDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerificationStatusDtoImplCopyWith<_$VerificationStatusDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
