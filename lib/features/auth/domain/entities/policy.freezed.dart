// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'policy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Policy {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  bool get isMandatory => throw _privateConstructorUsedError;

  /// Create a copy of Policy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PolicyCopyWith<Policy> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PolicyCopyWith<$Res> {
  factory $PolicyCopyWith(Policy value, $Res Function(Policy) then) =
      _$PolicyCopyWithImpl<$Res, Policy>;
  @useResult
  $Res call({int id, String type, String title, String url, bool isMandatory});
}

/// @nodoc
class _$PolicyCopyWithImpl<$Res, $Val extends Policy>
    implements $PolicyCopyWith<$Res> {
  _$PolicyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Policy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? url = null,
    Object? isMandatory = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            isMandatory: null == isMandatory
                ? _value.isMandatory
                : isMandatory // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PolicyImplCopyWith<$Res> implements $PolicyCopyWith<$Res> {
  factory _$$PolicyImplCopyWith(
    _$PolicyImpl value,
    $Res Function(_$PolicyImpl) then,
  ) = __$$PolicyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String type, String title, String url, bool isMandatory});
}

/// @nodoc
class __$$PolicyImplCopyWithImpl<$Res>
    extends _$PolicyCopyWithImpl<$Res, _$PolicyImpl>
    implements _$$PolicyImplCopyWith<$Res> {
  __$$PolicyImplCopyWithImpl(
    _$PolicyImpl _value,
    $Res Function(_$PolicyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Policy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? url = null,
    Object? isMandatory = null,
  }) {
    return _then(
      _$PolicyImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        isMandatory: null == isMandatory
            ? _value.isMandatory
            : isMandatory // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$PolicyImpl implements _Policy {
  const _$PolicyImpl({
    required this.id,
    required this.type,
    required this.title,
    required this.url,
    required this.isMandatory,
  });

  @override
  final int id;
  @override
  final String type;
  @override
  final String title;
  @override
  final String url;
  @override
  final bool isMandatory;

  @override
  String toString() {
    return 'Policy(id: $id, type: $type, title: $title, url: $url, isMandatory: $isMandatory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PolicyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.isMandatory, isMandatory) ||
                other.isMandatory == isMandatory));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, title, url, isMandatory);

  /// Create a copy of Policy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PolicyImplCopyWith<_$PolicyImpl> get copyWith =>
      __$$PolicyImplCopyWithImpl<_$PolicyImpl>(this, _$identity);
}

abstract class _Policy implements Policy {
  const factory _Policy({
    required final int id,
    required final String type,
    required final String title,
    required final String url,
    required final bool isMandatory,
  }) = _$PolicyImpl;

  @override
  int get id;
  @override
  String get type;
  @override
  String get title;
  @override
  String get url;
  @override
  bool get isMandatory;

  /// Create a copy of Policy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PolicyImplCopyWith<_$PolicyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
