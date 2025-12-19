// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Failure {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code) network,
    required TResult Function(String message, String? code) authentication,
    required TResult Function(String message, String? code) authorization,
    required TResult Function(String message, Map<String, String> errors)
    validation,
    required TResult Function(String message, int statusCode, String? code)
    server,
    required TResult Function(String message) timeout,
    required TResult Function(String message, String? code) websocket,
    required TResult Function(String message, String? code) cache,
    required TResult Function(String message, String? code) storage,
    required TResult Function(
      String message,
      Object? error,
      StackTrace? stackTrace,
    )
    unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code)? network,
    TResult? Function(String message, String? code)? authentication,
    TResult? Function(String message, String? code)? authorization,
    TResult? Function(String message, Map<String, String> errors)? validation,
    TResult? Function(String message, int statusCode, String? code)? server,
    TResult? Function(String message)? timeout,
    TResult? Function(String message, String? code)? websocket,
    TResult? Function(String message, String? code)? cache,
    TResult? Function(String message, String? code)? storage,
    TResult? Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code)? network,
    TResult Function(String message, String? code)? authentication,
    TResult Function(String message, String? code)? authorization,
    TResult Function(String message, Map<String, String> errors)? validation,
    TResult Function(String message, int statusCode, String? code)? server,
    TResult Function(String message)? timeout,
    TResult Function(String message, String? code)? websocket,
    TResult Function(String message, String? code)? cache,
    TResult Function(String message, String? code)? storage,
    TResult Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(AuthenticationFailure value) authentication,
    required TResult Function(AuthorizationFailure value) authorization,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(WebSocketFailure value) websocket,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(StorageFailure value) storage,
    required TResult Function(UnknownFailure value) unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(AuthenticationFailure value)? authentication,
    TResult? Function(AuthorizationFailure value)? authorization,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(WebSocketFailure value)? websocket,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(StorageFailure value)? storage,
    TResult? Function(UnknownFailure value)? unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(AuthenticationFailure value)? authentication,
    TResult Function(AuthorizationFailure value)? authorization,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(WebSocketFailure value)? websocket,
    TResult Function(CacheFailure value)? cache,
    TResult Function(StorageFailure value)? storage,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FailureCopyWith<Failure> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NetworkFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$NetworkFailureImplCopyWith(
    _$NetworkFailureImpl value,
    $Res Function(_$NetworkFailureImpl) then,
  ) = __$$NetworkFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? code});
}

/// @nodoc
class __$$NetworkFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NetworkFailureImpl>
    implements _$$NetworkFailureImplCopyWith<$Res> {
  __$$NetworkFailureImplCopyWithImpl(
    _$NetworkFailureImpl _value,
    $Res Function(_$NetworkFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? code = freezed}) {
    return _then(
      _$NetworkFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$NetworkFailureImpl implements NetworkFailure {
  const _$NetworkFailureImpl({required this.message, this.code});

  @override
  final String message;
  @override
  final String? code;

  @override
  String toString() {
    return 'Failure.network(message: $message, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, code);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      __$$NetworkFailureImplCopyWithImpl<_$NetworkFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code) network,
    required TResult Function(String message, String? code) authentication,
    required TResult Function(String message, String? code) authorization,
    required TResult Function(String message, Map<String, String> errors)
    validation,
    required TResult Function(String message, int statusCode, String? code)
    server,
    required TResult Function(String message) timeout,
    required TResult Function(String message, String? code) websocket,
    required TResult Function(String message, String? code) cache,
    required TResult Function(String message, String? code) storage,
    required TResult Function(
      String message,
      Object? error,
      StackTrace? stackTrace,
    )
    unknown,
  }) {
    return network(message, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code)? network,
    TResult? Function(String message, String? code)? authentication,
    TResult? Function(String message, String? code)? authorization,
    TResult? Function(String message, Map<String, String> errors)? validation,
    TResult? Function(String message, int statusCode, String? code)? server,
    TResult? Function(String message)? timeout,
    TResult? Function(String message, String? code)? websocket,
    TResult? Function(String message, String? code)? cache,
    TResult? Function(String message, String? code)? storage,
    TResult? Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
  }) {
    return network?.call(message, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code)? network,
    TResult Function(String message, String? code)? authentication,
    TResult Function(String message, String? code)? authorization,
    TResult Function(String message, Map<String, String> errors)? validation,
    TResult Function(String message, int statusCode, String? code)? server,
    TResult Function(String message)? timeout,
    TResult Function(String message, String? code)? websocket,
    TResult Function(String message, String? code)? cache,
    TResult Function(String message, String? code)? storage,
    TResult Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(message, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(AuthenticationFailure value) authentication,
    required TResult Function(AuthorizationFailure value) authorization,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(WebSocketFailure value) websocket,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(StorageFailure value) storage,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(AuthenticationFailure value)? authentication,
    TResult? Function(AuthorizationFailure value)? authorization,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(WebSocketFailure value)? websocket,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(StorageFailure value)? storage,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(AuthenticationFailure value)? authentication,
    TResult Function(AuthorizationFailure value)? authorization,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(WebSocketFailure value)? websocket,
    TResult Function(CacheFailure value)? cache,
    TResult Function(StorageFailure value)? storage,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class NetworkFailure implements Failure {
  const factory NetworkFailure({
    required final String message,
    final String? code,
  }) = _$NetworkFailureImpl;

  @override
  String get message;
  String? get code;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthenticationFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$AuthenticationFailureImplCopyWith(
    _$AuthenticationFailureImpl value,
    $Res Function(_$AuthenticationFailureImpl) then,
  ) = __$$AuthenticationFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? code});
}

/// @nodoc
class __$$AuthenticationFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$AuthenticationFailureImpl>
    implements _$$AuthenticationFailureImplCopyWith<$Res> {
  __$$AuthenticationFailureImplCopyWithImpl(
    _$AuthenticationFailureImpl _value,
    $Res Function(_$AuthenticationFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? code = freezed}) {
    return _then(
      _$AuthenticationFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AuthenticationFailureImpl implements AuthenticationFailure {
  const _$AuthenticationFailureImpl({required this.message, this.code});

  @override
  final String message;
  @override
  final String? code;

  @override
  String toString() {
    return 'Failure.authentication(message: $message, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, code);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationFailureImplCopyWith<_$AuthenticationFailureImpl>
  get copyWith =>
      __$$AuthenticationFailureImplCopyWithImpl<_$AuthenticationFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code) network,
    required TResult Function(String message, String? code) authentication,
    required TResult Function(String message, String? code) authorization,
    required TResult Function(String message, Map<String, String> errors)
    validation,
    required TResult Function(String message, int statusCode, String? code)
    server,
    required TResult Function(String message) timeout,
    required TResult Function(String message, String? code) websocket,
    required TResult Function(String message, String? code) cache,
    required TResult Function(String message, String? code) storage,
    required TResult Function(
      String message,
      Object? error,
      StackTrace? stackTrace,
    )
    unknown,
  }) {
    return authentication(message, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code)? network,
    TResult? Function(String message, String? code)? authentication,
    TResult? Function(String message, String? code)? authorization,
    TResult? Function(String message, Map<String, String> errors)? validation,
    TResult? Function(String message, int statusCode, String? code)? server,
    TResult? Function(String message)? timeout,
    TResult? Function(String message, String? code)? websocket,
    TResult? Function(String message, String? code)? cache,
    TResult? Function(String message, String? code)? storage,
    TResult? Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
  }) {
    return authentication?.call(message, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code)? network,
    TResult Function(String message, String? code)? authentication,
    TResult Function(String message, String? code)? authorization,
    TResult Function(String message, Map<String, String> errors)? validation,
    TResult Function(String message, int statusCode, String? code)? server,
    TResult Function(String message)? timeout,
    TResult Function(String message, String? code)? websocket,
    TResult Function(String message, String? code)? cache,
    TResult Function(String message, String? code)? storage,
    TResult Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
    required TResult orElse(),
  }) {
    if (authentication != null) {
      return authentication(message, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(AuthenticationFailure value) authentication,
    required TResult Function(AuthorizationFailure value) authorization,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(WebSocketFailure value) websocket,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(StorageFailure value) storage,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return authentication(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(AuthenticationFailure value)? authentication,
    TResult? Function(AuthorizationFailure value)? authorization,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(WebSocketFailure value)? websocket,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(StorageFailure value)? storage,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return authentication?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(AuthenticationFailure value)? authentication,
    TResult Function(AuthorizationFailure value)? authorization,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(WebSocketFailure value)? websocket,
    TResult Function(CacheFailure value)? cache,
    TResult Function(StorageFailure value)? storage,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (authentication != null) {
      return authentication(this);
    }
    return orElse();
  }
}

abstract class AuthenticationFailure implements Failure {
  const factory AuthenticationFailure({
    required final String message,
    final String? code,
  }) = _$AuthenticationFailureImpl;

  @override
  String get message;
  String? get code;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticationFailureImplCopyWith<_$AuthenticationFailureImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthorizationFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$AuthorizationFailureImplCopyWith(
    _$AuthorizationFailureImpl value,
    $Res Function(_$AuthorizationFailureImpl) then,
  ) = __$$AuthorizationFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? code});
}

/// @nodoc
class __$$AuthorizationFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$AuthorizationFailureImpl>
    implements _$$AuthorizationFailureImplCopyWith<$Res> {
  __$$AuthorizationFailureImplCopyWithImpl(
    _$AuthorizationFailureImpl _value,
    $Res Function(_$AuthorizationFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? code = freezed}) {
    return _then(
      _$AuthorizationFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AuthorizationFailureImpl implements AuthorizationFailure {
  const _$AuthorizationFailureImpl({required this.message, this.code});

  @override
  final String message;
  @override
  final String? code;

  @override
  String toString() {
    return 'Failure.authorization(message: $message, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthorizationFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, code);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthorizationFailureImplCopyWith<_$AuthorizationFailureImpl>
  get copyWith =>
      __$$AuthorizationFailureImplCopyWithImpl<_$AuthorizationFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code) network,
    required TResult Function(String message, String? code) authentication,
    required TResult Function(String message, String? code) authorization,
    required TResult Function(String message, Map<String, String> errors)
    validation,
    required TResult Function(String message, int statusCode, String? code)
    server,
    required TResult Function(String message) timeout,
    required TResult Function(String message, String? code) websocket,
    required TResult Function(String message, String? code) cache,
    required TResult Function(String message, String? code) storage,
    required TResult Function(
      String message,
      Object? error,
      StackTrace? stackTrace,
    )
    unknown,
  }) {
    return authorization(message, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code)? network,
    TResult? Function(String message, String? code)? authentication,
    TResult? Function(String message, String? code)? authorization,
    TResult? Function(String message, Map<String, String> errors)? validation,
    TResult? Function(String message, int statusCode, String? code)? server,
    TResult? Function(String message)? timeout,
    TResult? Function(String message, String? code)? websocket,
    TResult? Function(String message, String? code)? cache,
    TResult? Function(String message, String? code)? storage,
    TResult? Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
  }) {
    return authorization?.call(message, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code)? network,
    TResult Function(String message, String? code)? authentication,
    TResult Function(String message, String? code)? authorization,
    TResult Function(String message, Map<String, String> errors)? validation,
    TResult Function(String message, int statusCode, String? code)? server,
    TResult Function(String message)? timeout,
    TResult Function(String message, String? code)? websocket,
    TResult Function(String message, String? code)? cache,
    TResult Function(String message, String? code)? storage,
    TResult Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
    required TResult orElse(),
  }) {
    if (authorization != null) {
      return authorization(message, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(AuthenticationFailure value) authentication,
    required TResult Function(AuthorizationFailure value) authorization,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(WebSocketFailure value) websocket,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(StorageFailure value) storage,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return authorization(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(AuthenticationFailure value)? authentication,
    TResult? Function(AuthorizationFailure value)? authorization,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(WebSocketFailure value)? websocket,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(StorageFailure value)? storage,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return authorization?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(AuthenticationFailure value)? authentication,
    TResult Function(AuthorizationFailure value)? authorization,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(WebSocketFailure value)? websocket,
    TResult Function(CacheFailure value)? cache,
    TResult Function(StorageFailure value)? storage,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (authorization != null) {
      return authorization(this);
    }
    return orElse();
  }
}

abstract class AuthorizationFailure implements Failure {
  const factory AuthorizationFailure({
    required final String message,
    final String? code,
  }) = _$AuthorizationFailureImpl;

  @override
  String get message;
  String? get code;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthorizationFailureImplCopyWith<_$AuthorizationFailureImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidationFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ValidationFailureImplCopyWith(
    _$ValidationFailureImpl value,
    $Res Function(_$ValidationFailureImpl) then,
  ) = __$$ValidationFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, Map<String, String> errors});
}

/// @nodoc
class __$$ValidationFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ValidationFailureImpl>
    implements _$$ValidationFailureImplCopyWith<$Res> {
  __$$ValidationFailureImplCopyWithImpl(
    _$ValidationFailureImpl _value,
    $Res Function(_$ValidationFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? errors = null}) {
    return _then(
      _$ValidationFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        errors: null == errors
            ? _value._errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
      ),
    );
  }
}

/// @nodoc

class _$ValidationFailureImpl implements ValidationFailure {
  const _$ValidationFailureImpl({
    required this.message,
    final Map<String, String> errors = const {},
  }) : _errors = errors;

  @override
  final String message;
  final Map<String, String> _errors;
  @override
  @JsonKey()
  Map<String, String> get errors {
    if (_errors is EqualUnmodifiableMapView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_errors);
  }

  @override
  String toString() {
    return 'Failure.validation(message: $message, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(_errors),
  );

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      __$$ValidationFailureImplCopyWithImpl<_$ValidationFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code) network,
    required TResult Function(String message, String? code) authentication,
    required TResult Function(String message, String? code) authorization,
    required TResult Function(String message, Map<String, String> errors)
    validation,
    required TResult Function(String message, int statusCode, String? code)
    server,
    required TResult Function(String message) timeout,
    required TResult Function(String message, String? code) websocket,
    required TResult Function(String message, String? code) cache,
    required TResult Function(String message, String? code) storage,
    required TResult Function(
      String message,
      Object? error,
      StackTrace? stackTrace,
    )
    unknown,
  }) {
    return validation(message, errors);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code)? network,
    TResult? Function(String message, String? code)? authentication,
    TResult? Function(String message, String? code)? authorization,
    TResult? Function(String message, Map<String, String> errors)? validation,
    TResult? Function(String message, int statusCode, String? code)? server,
    TResult? Function(String message)? timeout,
    TResult? Function(String message, String? code)? websocket,
    TResult? Function(String message, String? code)? cache,
    TResult? Function(String message, String? code)? storage,
    TResult? Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
  }) {
    return validation?.call(message, errors);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code)? network,
    TResult Function(String message, String? code)? authentication,
    TResult Function(String message, String? code)? authorization,
    TResult Function(String message, Map<String, String> errors)? validation,
    TResult Function(String message, int statusCode, String? code)? server,
    TResult Function(String message)? timeout,
    TResult Function(String message, String? code)? websocket,
    TResult Function(String message, String? code)? cache,
    TResult Function(String message, String? code)? storage,
    TResult Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(message, errors);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(AuthenticationFailure value) authentication,
    required TResult Function(AuthorizationFailure value) authorization,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(WebSocketFailure value) websocket,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(StorageFailure value) storage,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return validation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(AuthenticationFailure value)? authentication,
    TResult? Function(AuthorizationFailure value)? authorization,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(WebSocketFailure value)? websocket,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(StorageFailure value)? storage,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return validation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(AuthenticationFailure value)? authentication,
    TResult Function(AuthorizationFailure value)? authorization,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(WebSocketFailure value)? websocket,
    TResult Function(CacheFailure value)? cache,
    TResult Function(StorageFailure value)? storage,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(this);
    }
    return orElse();
  }
}

abstract class ValidationFailure implements Failure {
  const factory ValidationFailure({
    required final String message,
    final Map<String, String> errors,
  }) = _$ValidationFailureImpl;

  @override
  String get message;
  Map<String, String> get errors;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ServerFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ServerFailureImplCopyWith(
    _$ServerFailureImpl value,
    $Res Function(_$ServerFailureImpl) then,
  ) = __$$ServerFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, int statusCode, String? code});
}

/// @nodoc
class __$$ServerFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ServerFailureImpl>
    implements _$$ServerFailureImplCopyWith<$Res> {
  __$$ServerFailureImplCopyWithImpl(
    _$ServerFailureImpl _value,
    $Res Function(_$ServerFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? statusCode = null,
    Object? code = freezed,
  }) {
    return _then(
      _$ServerFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        statusCode: null == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ServerFailureImpl implements ServerFailure {
  const _$ServerFailureImpl({
    required this.message,
    required this.statusCode,
    this.code,
  });

  @override
  final String message;
  @override
  final int statusCode;
  @override
  final String? code;

  @override
  String toString() {
    return 'Failure.server(message: $message, statusCode: $statusCode, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, statusCode, code);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerFailureImplCopyWith<_$ServerFailureImpl> get copyWith =>
      __$$ServerFailureImplCopyWithImpl<_$ServerFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code) network,
    required TResult Function(String message, String? code) authentication,
    required TResult Function(String message, String? code) authorization,
    required TResult Function(String message, Map<String, String> errors)
    validation,
    required TResult Function(String message, int statusCode, String? code)
    server,
    required TResult Function(String message) timeout,
    required TResult Function(String message, String? code) websocket,
    required TResult Function(String message, String? code) cache,
    required TResult Function(String message, String? code) storage,
    required TResult Function(
      String message,
      Object? error,
      StackTrace? stackTrace,
    )
    unknown,
  }) {
    return server(message, statusCode, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code)? network,
    TResult? Function(String message, String? code)? authentication,
    TResult? Function(String message, String? code)? authorization,
    TResult? Function(String message, Map<String, String> errors)? validation,
    TResult? Function(String message, int statusCode, String? code)? server,
    TResult? Function(String message)? timeout,
    TResult? Function(String message, String? code)? websocket,
    TResult? Function(String message, String? code)? cache,
    TResult? Function(String message, String? code)? storage,
    TResult? Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
  }) {
    return server?.call(message, statusCode, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code)? network,
    TResult Function(String message, String? code)? authentication,
    TResult Function(String message, String? code)? authorization,
    TResult Function(String message, Map<String, String> errors)? validation,
    TResult Function(String message, int statusCode, String? code)? server,
    TResult Function(String message)? timeout,
    TResult Function(String message, String? code)? websocket,
    TResult Function(String message, String? code)? cache,
    TResult Function(String message, String? code)? storage,
    TResult Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(message, statusCode, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(AuthenticationFailure value) authentication,
    required TResult Function(AuthorizationFailure value) authorization,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(WebSocketFailure value) websocket,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(StorageFailure value) storage,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return server(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(AuthenticationFailure value)? authentication,
    TResult? Function(AuthorizationFailure value)? authorization,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(WebSocketFailure value)? websocket,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(StorageFailure value)? storage,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return server?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(AuthenticationFailure value)? authentication,
    TResult Function(AuthorizationFailure value)? authorization,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(WebSocketFailure value)? websocket,
    TResult Function(CacheFailure value)? cache,
    TResult Function(StorageFailure value)? storage,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(this);
    }
    return orElse();
  }
}

abstract class ServerFailure implements Failure {
  const factory ServerFailure({
    required final String message,
    required final int statusCode,
    final String? code,
  }) = _$ServerFailureImpl;

  @override
  String get message;
  int get statusCode;
  String? get code;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerFailureImplCopyWith<_$ServerFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TimeoutFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$TimeoutFailureImplCopyWith(
    _$TimeoutFailureImpl value,
    $Res Function(_$TimeoutFailureImpl) then,
  ) = __$$TimeoutFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$TimeoutFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$TimeoutFailureImpl>
    implements _$$TimeoutFailureImplCopyWith<$Res> {
  __$$TimeoutFailureImplCopyWithImpl(
    _$TimeoutFailureImpl _value,
    $Res Function(_$TimeoutFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$TimeoutFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$TimeoutFailureImpl implements TimeoutFailure {
  const _$TimeoutFailureImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.timeout(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeoutFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeoutFailureImplCopyWith<_$TimeoutFailureImpl> get copyWith =>
      __$$TimeoutFailureImplCopyWithImpl<_$TimeoutFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code) network,
    required TResult Function(String message, String? code) authentication,
    required TResult Function(String message, String? code) authorization,
    required TResult Function(String message, Map<String, String> errors)
    validation,
    required TResult Function(String message, int statusCode, String? code)
    server,
    required TResult Function(String message) timeout,
    required TResult Function(String message, String? code) websocket,
    required TResult Function(String message, String? code) cache,
    required TResult Function(String message, String? code) storage,
    required TResult Function(
      String message,
      Object? error,
      StackTrace? stackTrace,
    )
    unknown,
  }) {
    return timeout(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code)? network,
    TResult? Function(String message, String? code)? authentication,
    TResult? Function(String message, String? code)? authorization,
    TResult? Function(String message, Map<String, String> errors)? validation,
    TResult? Function(String message, int statusCode, String? code)? server,
    TResult? Function(String message)? timeout,
    TResult? Function(String message, String? code)? websocket,
    TResult? Function(String message, String? code)? cache,
    TResult? Function(String message, String? code)? storage,
    TResult? Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
  }) {
    return timeout?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code)? network,
    TResult Function(String message, String? code)? authentication,
    TResult Function(String message, String? code)? authorization,
    TResult Function(String message, Map<String, String> errors)? validation,
    TResult Function(String message, int statusCode, String? code)? server,
    TResult Function(String message)? timeout,
    TResult Function(String message, String? code)? websocket,
    TResult Function(String message, String? code)? cache,
    TResult Function(String message, String? code)? storage,
    TResult Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(AuthenticationFailure value) authentication,
    required TResult Function(AuthorizationFailure value) authorization,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(WebSocketFailure value) websocket,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(StorageFailure value) storage,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return timeout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(AuthenticationFailure value)? authentication,
    TResult? Function(AuthorizationFailure value)? authorization,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(WebSocketFailure value)? websocket,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(StorageFailure value)? storage,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return timeout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(AuthenticationFailure value)? authentication,
    TResult Function(AuthorizationFailure value)? authorization,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(WebSocketFailure value)? websocket,
    TResult Function(CacheFailure value)? cache,
    TResult Function(StorageFailure value)? storage,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(this);
    }
    return orElse();
  }
}

abstract class TimeoutFailure implements Failure {
  const factory TimeoutFailure({required final String message}) =
      _$TimeoutFailureImpl;

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeoutFailureImplCopyWith<_$TimeoutFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WebSocketFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$WebSocketFailureImplCopyWith(
    _$WebSocketFailureImpl value,
    $Res Function(_$WebSocketFailureImpl) then,
  ) = __$$WebSocketFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? code});
}

/// @nodoc
class __$$WebSocketFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$WebSocketFailureImpl>
    implements _$$WebSocketFailureImplCopyWith<$Res> {
  __$$WebSocketFailureImplCopyWithImpl(
    _$WebSocketFailureImpl _value,
    $Res Function(_$WebSocketFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? code = freezed}) {
    return _then(
      _$WebSocketFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$WebSocketFailureImpl implements WebSocketFailure {
  const _$WebSocketFailureImpl({required this.message, this.code});

  @override
  final String message;
  @override
  final String? code;

  @override
  String toString() {
    return 'Failure.websocket(message: $message, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, code);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSocketFailureImplCopyWith<_$WebSocketFailureImpl> get copyWith =>
      __$$WebSocketFailureImplCopyWithImpl<_$WebSocketFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code) network,
    required TResult Function(String message, String? code) authentication,
    required TResult Function(String message, String? code) authorization,
    required TResult Function(String message, Map<String, String> errors)
    validation,
    required TResult Function(String message, int statusCode, String? code)
    server,
    required TResult Function(String message) timeout,
    required TResult Function(String message, String? code) websocket,
    required TResult Function(String message, String? code) cache,
    required TResult Function(String message, String? code) storage,
    required TResult Function(
      String message,
      Object? error,
      StackTrace? stackTrace,
    )
    unknown,
  }) {
    return websocket(message, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code)? network,
    TResult? Function(String message, String? code)? authentication,
    TResult? Function(String message, String? code)? authorization,
    TResult? Function(String message, Map<String, String> errors)? validation,
    TResult? Function(String message, int statusCode, String? code)? server,
    TResult? Function(String message)? timeout,
    TResult? Function(String message, String? code)? websocket,
    TResult? Function(String message, String? code)? cache,
    TResult? Function(String message, String? code)? storage,
    TResult? Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
  }) {
    return websocket?.call(message, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code)? network,
    TResult Function(String message, String? code)? authentication,
    TResult Function(String message, String? code)? authorization,
    TResult Function(String message, Map<String, String> errors)? validation,
    TResult Function(String message, int statusCode, String? code)? server,
    TResult Function(String message)? timeout,
    TResult Function(String message, String? code)? websocket,
    TResult Function(String message, String? code)? cache,
    TResult Function(String message, String? code)? storage,
    TResult Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
    required TResult orElse(),
  }) {
    if (websocket != null) {
      return websocket(message, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(AuthenticationFailure value) authentication,
    required TResult Function(AuthorizationFailure value) authorization,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(WebSocketFailure value) websocket,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(StorageFailure value) storage,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return websocket(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(AuthenticationFailure value)? authentication,
    TResult? Function(AuthorizationFailure value)? authorization,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(WebSocketFailure value)? websocket,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(StorageFailure value)? storage,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return websocket?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(AuthenticationFailure value)? authentication,
    TResult Function(AuthorizationFailure value)? authorization,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(WebSocketFailure value)? websocket,
    TResult Function(CacheFailure value)? cache,
    TResult Function(StorageFailure value)? storage,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (websocket != null) {
      return websocket(this);
    }
    return orElse();
  }
}

abstract class WebSocketFailure implements Failure {
  const factory WebSocketFailure({
    required final String message,
    final String? code,
  }) = _$WebSocketFailureImpl;

  @override
  String get message;
  String? get code;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebSocketFailureImplCopyWith<_$WebSocketFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CacheFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$CacheFailureImplCopyWith(
    _$CacheFailureImpl value,
    $Res Function(_$CacheFailureImpl) then,
  ) = __$$CacheFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? code});
}

/// @nodoc
class __$$CacheFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$CacheFailureImpl>
    implements _$$CacheFailureImplCopyWith<$Res> {
  __$$CacheFailureImplCopyWithImpl(
    _$CacheFailureImpl _value,
    $Res Function(_$CacheFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? code = freezed}) {
    return _then(
      _$CacheFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CacheFailureImpl implements CacheFailure {
  const _$CacheFailureImpl({required this.message, this.code});

  @override
  final String message;
  @override
  final String? code;

  @override
  String toString() {
    return 'Failure.cache(message: $message, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CacheFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, code);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CacheFailureImplCopyWith<_$CacheFailureImpl> get copyWith =>
      __$$CacheFailureImplCopyWithImpl<_$CacheFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code) network,
    required TResult Function(String message, String? code) authentication,
    required TResult Function(String message, String? code) authorization,
    required TResult Function(String message, Map<String, String> errors)
    validation,
    required TResult Function(String message, int statusCode, String? code)
    server,
    required TResult Function(String message) timeout,
    required TResult Function(String message, String? code) websocket,
    required TResult Function(String message, String? code) cache,
    required TResult Function(String message, String? code) storage,
    required TResult Function(
      String message,
      Object? error,
      StackTrace? stackTrace,
    )
    unknown,
  }) {
    return cache(message, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code)? network,
    TResult? Function(String message, String? code)? authentication,
    TResult? Function(String message, String? code)? authorization,
    TResult? Function(String message, Map<String, String> errors)? validation,
    TResult? Function(String message, int statusCode, String? code)? server,
    TResult? Function(String message)? timeout,
    TResult? Function(String message, String? code)? websocket,
    TResult? Function(String message, String? code)? cache,
    TResult? Function(String message, String? code)? storage,
    TResult? Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
  }) {
    return cache?.call(message, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code)? network,
    TResult Function(String message, String? code)? authentication,
    TResult Function(String message, String? code)? authorization,
    TResult Function(String message, Map<String, String> errors)? validation,
    TResult Function(String message, int statusCode, String? code)? server,
    TResult Function(String message)? timeout,
    TResult Function(String message, String? code)? websocket,
    TResult Function(String message, String? code)? cache,
    TResult Function(String message, String? code)? storage,
    TResult Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
    required TResult orElse(),
  }) {
    if (cache != null) {
      return cache(message, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(AuthenticationFailure value) authentication,
    required TResult Function(AuthorizationFailure value) authorization,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(WebSocketFailure value) websocket,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(StorageFailure value) storage,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return cache(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(AuthenticationFailure value)? authentication,
    TResult? Function(AuthorizationFailure value)? authorization,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(WebSocketFailure value)? websocket,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(StorageFailure value)? storage,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return cache?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(AuthenticationFailure value)? authentication,
    TResult Function(AuthorizationFailure value)? authorization,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(WebSocketFailure value)? websocket,
    TResult Function(CacheFailure value)? cache,
    TResult Function(StorageFailure value)? storage,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (cache != null) {
      return cache(this);
    }
    return orElse();
  }
}

abstract class CacheFailure implements Failure {
  const factory CacheFailure({
    required final String message,
    final String? code,
  }) = _$CacheFailureImpl;

  @override
  String get message;
  String? get code;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CacheFailureImplCopyWith<_$CacheFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StorageFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$StorageFailureImplCopyWith(
    _$StorageFailureImpl value,
    $Res Function(_$StorageFailureImpl) then,
  ) = __$$StorageFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? code});
}

/// @nodoc
class __$$StorageFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$StorageFailureImpl>
    implements _$$StorageFailureImplCopyWith<$Res> {
  __$$StorageFailureImplCopyWithImpl(
    _$StorageFailureImpl _value,
    $Res Function(_$StorageFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? code = freezed}) {
    return _then(
      _$StorageFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$StorageFailureImpl implements StorageFailure {
  const _$StorageFailureImpl({required this.message, this.code});

  @override
  final String message;
  @override
  final String? code;

  @override
  String toString() {
    return 'Failure.storage(message: $message, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorageFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, code);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StorageFailureImplCopyWith<_$StorageFailureImpl> get copyWith =>
      __$$StorageFailureImplCopyWithImpl<_$StorageFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code) network,
    required TResult Function(String message, String? code) authentication,
    required TResult Function(String message, String? code) authorization,
    required TResult Function(String message, Map<String, String> errors)
    validation,
    required TResult Function(String message, int statusCode, String? code)
    server,
    required TResult Function(String message) timeout,
    required TResult Function(String message, String? code) websocket,
    required TResult Function(String message, String? code) cache,
    required TResult Function(String message, String? code) storage,
    required TResult Function(
      String message,
      Object? error,
      StackTrace? stackTrace,
    )
    unknown,
  }) {
    return storage(message, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code)? network,
    TResult? Function(String message, String? code)? authentication,
    TResult? Function(String message, String? code)? authorization,
    TResult? Function(String message, Map<String, String> errors)? validation,
    TResult? Function(String message, int statusCode, String? code)? server,
    TResult? Function(String message)? timeout,
    TResult? Function(String message, String? code)? websocket,
    TResult? Function(String message, String? code)? cache,
    TResult? Function(String message, String? code)? storage,
    TResult? Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
  }) {
    return storage?.call(message, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code)? network,
    TResult Function(String message, String? code)? authentication,
    TResult Function(String message, String? code)? authorization,
    TResult Function(String message, Map<String, String> errors)? validation,
    TResult Function(String message, int statusCode, String? code)? server,
    TResult Function(String message)? timeout,
    TResult Function(String message, String? code)? websocket,
    TResult Function(String message, String? code)? cache,
    TResult Function(String message, String? code)? storage,
    TResult Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
    required TResult orElse(),
  }) {
    if (storage != null) {
      return storage(message, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(AuthenticationFailure value) authentication,
    required TResult Function(AuthorizationFailure value) authorization,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(WebSocketFailure value) websocket,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(StorageFailure value) storage,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return storage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(AuthenticationFailure value)? authentication,
    TResult? Function(AuthorizationFailure value)? authorization,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(WebSocketFailure value)? websocket,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(StorageFailure value)? storage,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return storage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(AuthenticationFailure value)? authentication,
    TResult Function(AuthorizationFailure value)? authorization,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(WebSocketFailure value)? websocket,
    TResult Function(CacheFailure value)? cache,
    TResult Function(StorageFailure value)? storage,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (storage != null) {
      return storage(this);
    }
    return orElse();
  }
}

abstract class StorageFailure implements Failure {
  const factory StorageFailure({
    required final String message,
    final String? code,
  }) = _$StorageFailureImpl;

  @override
  String get message;
  String? get code;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StorageFailureImplCopyWith<_$StorageFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$UnknownFailureImplCopyWith(
    _$UnknownFailureImpl value,
    $Res Function(_$UnknownFailureImpl) then,
  ) = __$$UnknownFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, Object? error, StackTrace? stackTrace});
}

/// @nodoc
class __$$UnknownFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UnknownFailureImpl>
    implements _$$UnknownFailureImplCopyWith<$Res> {
  __$$UnknownFailureImplCopyWithImpl(
    _$UnknownFailureImpl _value,
    $Res Function(_$UnknownFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? error = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(
      _$UnknownFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        error: freezed == error ? _value.error : error,
        stackTrace: freezed == stackTrace
            ? _value.stackTrace
            : stackTrace // ignore: cast_nullable_to_non_nullable
                  as StackTrace?,
      ),
    );
  }
}

/// @nodoc

class _$UnknownFailureImpl implements UnknownFailure {
  const _$UnknownFailureImpl({
    required this.message,
    this.error,
    this.stackTrace,
  });

  @override
  final String message;
  @override
  final Object? error;
  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'Failure.unknown(message: $message, error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(error),
    stackTrace,
  );

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      __$$UnknownFailureImplCopyWithImpl<_$UnknownFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code) network,
    required TResult Function(String message, String? code) authentication,
    required TResult Function(String message, String? code) authorization,
    required TResult Function(String message, Map<String, String> errors)
    validation,
    required TResult Function(String message, int statusCode, String? code)
    server,
    required TResult Function(String message) timeout,
    required TResult Function(String message, String? code) websocket,
    required TResult Function(String message, String? code) cache,
    required TResult Function(String message, String? code) storage,
    required TResult Function(
      String message,
      Object? error,
      StackTrace? stackTrace,
    )
    unknown,
  }) {
    return unknown(message, error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code)? network,
    TResult? Function(String message, String? code)? authentication,
    TResult? Function(String message, String? code)? authorization,
    TResult? Function(String message, Map<String, String> errors)? validation,
    TResult? Function(String message, int statusCode, String? code)? server,
    TResult? Function(String message)? timeout,
    TResult? Function(String message, String? code)? websocket,
    TResult? Function(String message, String? code)? cache,
    TResult? Function(String message, String? code)? storage,
    TResult? Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
  }) {
    return unknown?.call(message, error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code)? network,
    TResult Function(String message, String? code)? authentication,
    TResult Function(String message, String? code)? authorization,
    TResult Function(String message, Map<String, String> errors)? validation,
    TResult Function(String message, int statusCode, String? code)? server,
    TResult Function(String message)? timeout,
    TResult Function(String message, String? code)? websocket,
    TResult Function(String message, String? code)? cache,
    TResult Function(String message, String? code)? storage,
    TResult Function(String message, Object? error, StackTrace? stackTrace)?
    unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(message, error, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(AuthenticationFailure value) authentication,
    required TResult Function(AuthorizationFailure value) authorization,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(WebSocketFailure value) websocket,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(StorageFailure value) storage,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(AuthenticationFailure value)? authentication,
    TResult? Function(AuthorizationFailure value)? authorization,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(WebSocketFailure value)? websocket,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(StorageFailure value)? storage,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(AuthenticationFailure value)? authentication,
    TResult Function(AuthorizationFailure value)? authorization,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(WebSocketFailure value)? websocket,
    TResult Function(CacheFailure value)? cache,
    TResult Function(StorageFailure value)? storage,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class UnknownFailure implements Failure {
  const factory UnknownFailure({
    required final String message,
    final Object? error,
    final StackTrace? stackTrace,
  }) = _$UnknownFailureImpl;

  @override
  String get message;
  Object? get error;
  StackTrace? get stackTrace;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
