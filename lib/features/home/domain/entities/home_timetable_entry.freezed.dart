// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_timetable_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HomeTimetableEntry {
  int get id => throw _privateConstructorUsedError;
  String? get subjectName => throw _privateConstructorUsedError;
  String? get professor => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  String? get place => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;

  /// Create a copy of HomeTimetableEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeTimetableEntryCopyWith<HomeTimetableEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeTimetableEntryCopyWith<$Res> {
  factory $HomeTimetableEntryCopyWith(
    HomeTimetableEntry value,
    $Res Function(HomeTimetableEntry) then,
  ) = _$HomeTimetableEntryCopyWithImpl<$Res, HomeTimetableEntry>;
  @useResult
  $Res call({
    int id,
    String? subjectName,
    String? professor,
    String startTime,
    String endTime,
    String? place,
    String? color,
  });
}

/// @nodoc
class _$HomeTimetableEntryCopyWithImpl<$Res, $Val extends HomeTimetableEntry>
    implements $HomeTimetableEntryCopyWith<$Res> {
  _$HomeTimetableEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeTimetableEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subjectName = freezed,
    Object? professor = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? place = freezed,
    Object? color = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            subjectName: freezed == subjectName
                ? _value.subjectName
                : subjectName // ignore: cast_nullable_to_non_nullable
                      as String?,
            professor: freezed == professor
                ? _value.professor
                : professor // ignore: cast_nullable_to_non_nullable
                      as String?,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as String,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as String,
            place: freezed == place
                ? _value.place
                : place // ignore: cast_nullable_to_non_nullable
                      as String?,
            color: freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HomeTimetableEntryImplCopyWith<$Res>
    implements $HomeTimetableEntryCopyWith<$Res> {
  factory _$$HomeTimetableEntryImplCopyWith(
    _$HomeTimetableEntryImpl value,
    $Res Function(_$HomeTimetableEntryImpl) then,
  ) = __$$HomeTimetableEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String? subjectName,
    String? professor,
    String startTime,
    String endTime,
    String? place,
    String? color,
  });
}

/// @nodoc
class __$$HomeTimetableEntryImplCopyWithImpl<$Res>
    extends _$HomeTimetableEntryCopyWithImpl<$Res, _$HomeTimetableEntryImpl>
    implements _$$HomeTimetableEntryImplCopyWith<$Res> {
  __$$HomeTimetableEntryImplCopyWithImpl(
    _$HomeTimetableEntryImpl _value,
    $Res Function(_$HomeTimetableEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeTimetableEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subjectName = freezed,
    Object? professor = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? place = freezed,
    Object? color = freezed,
  }) {
    return _then(
      _$HomeTimetableEntryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        subjectName: freezed == subjectName
            ? _value.subjectName
            : subjectName // ignore: cast_nullable_to_non_nullable
                  as String?,
        professor: freezed == professor
            ? _value.professor
            : professor // ignore: cast_nullable_to_non_nullable
                  as String?,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as String,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as String,
        place: freezed == place
            ? _value.place
            : place // ignore: cast_nullable_to_non_nullable
                  as String?,
        color: freezed == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$HomeTimetableEntryImpl implements _HomeTimetableEntry {
  const _$HomeTimetableEntryImpl({
    required this.id,
    this.subjectName,
    this.professor,
    required this.startTime,
    required this.endTime,
    this.place,
    this.color,
  });

  @override
  final int id;
  @override
  final String? subjectName;
  @override
  final String? professor;
  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final String? place;
  @override
  final String? color;

  @override
  String toString() {
    return 'HomeTimetableEntry(id: $id, subjectName: $subjectName, professor: $professor, startTime: $startTime, endTime: $endTime, place: $place, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeTimetableEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.subjectName, subjectName) ||
                other.subjectName == subjectName) &&
            (identical(other.professor, professor) ||
                other.professor == professor) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.place, place) || other.place == place) &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    subjectName,
    professor,
    startTime,
    endTime,
    place,
    color,
  );

  /// Create a copy of HomeTimetableEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeTimetableEntryImplCopyWith<_$HomeTimetableEntryImpl> get copyWith =>
      __$$HomeTimetableEntryImplCopyWithImpl<_$HomeTimetableEntryImpl>(
        this,
        _$identity,
      );
}

abstract class _HomeTimetableEntry implements HomeTimetableEntry {
  const factory _HomeTimetableEntry({
    required final int id,
    final String? subjectName,
    final String? professor,
    required final String startTime,
    required final String endTime,
    final String? place,
    final String? color,
  }) = _$HomeTimetableEntryImpl;

  @override
  int get id;
  @override
  String? get subjectName;
  @override
  String? get professor;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  String? get place;
  @override
  String? get color;

  /// Create a copy of HomeTimetableEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeTimetableEntryImplCopyWith<_$HomeTimetableEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
