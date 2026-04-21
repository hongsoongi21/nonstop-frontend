// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_semester.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HomeSemester {
  int get id => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Create a copy of HomeSemester
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeSemesterCopyWith<HomeSemester> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeSemesterCopyWith<$Res> {
  factory $HomeSemesterCopyWith(
    HomeSemester value,
    $Res Function(HomeSemester) then,
  ) = _$HomeSemesterCopyWithImpl<$Res, HomeSemester>;
  @useResult
  $Res call({int id, int year, String type});
}

/// @nodoc
class _$HomeSemesterCopyWithImpl<$Res, $Val extends HomeSemester>
    implements $HomeSemesterCopyWith<$Res> {
  _$HomeSemesterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeSemester
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? year = null, Object? type = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HomeSemesterImplCopyWith<$Res>
    implements $HomeSemesterCopyWith<$Res> {
  factory _$$HomeSemesterImplCopyWith(
    _$HomeSemesterImpl value,
    $Res Function(_$HomeSemesterImpl) then,
  ) = __$$HomeSemesterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int year, String type});
}

/// @nodoc
class __$$HomeSemesterImplCopyWithImpl<$Res>
    extends _$HomeSemesterCopyWithImpl<$Res, _$HomeSemesterImpl>
    implements _$$HomeSemesterImplCopyWith<$Res> {
  __$$HomeSemesterImplCopyWithImpl(
    _$HomeSemesterImpl _value,
    $Res Function(_$HomeSemesterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeSemester
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? year = null, Object? type = null}) {
    return _then(
      _$HomeSemesterImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$HomeSemesterImpl implements _HomeSemester {
  const _$HomeSemesterImpl({
    required this.id,
    required this.year,
    required this.type,
  });

  @override
  final int id;
  @override
  final int year;
  @override
  final String type;

  @override
  String toString() {
    return 'HomeSemester(id: $id, year: $year, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeSemesterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, year, type);

  /// Create a copy of HomeSemester
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeSemesterImplCopyWith<_$HomeSemesterImpl> get copyWith =>
      __$$HomeSemesterImplCopyWithImpl<_$HomeSemesterImpl>(this, _$identity);
}

abstract class _HomeSemester implements HomeSemester {
  const factory _HomeSemester({
    required final int id,
    required final int year,
    required final String type,
  }) = _$HomeSemesterImpl;

  @override
  int get id;
  @override
  int get year;
  @override
  String get type;

  /// Create a copy of HomeSemester
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeSemesterImplCopyWith<_$HomeSemesterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
