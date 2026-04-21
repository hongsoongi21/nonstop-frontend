// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'today_timetable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TodayTimetable {
  int? get timetableId => throw _privateConstructorUsedError;
  HomeSemester? get semester => throw _privateConstructorUsedError;
  List<HomeTimetableEntry> get entries => throw _privateConstructorUsedError;

  /// Create a copy of TodayTimetable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodayTimetableCopyWith<TodayTimetable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodayTimetableCopyWith<$Res> {
  factory $TodayTimetableCopyWith(
    TodayTimetable value,
    $Res Function(TodayTimetable) then,
  ) = _$TodayTimetableCopyWithImpl<$Res, TodayTimetable>;
  @useResult
  $Res call({
    int? timetableId,
    HomeSemester? semester,
    List<HomeTimetableEntry> entries,
  });

  $HomeSemesterCopyWith<$Res>? get semester;
}

/// @nodoc
class _$TodayTimetableCopyWithImpl<$Res, $Val extends TodayTimetable>
    implements $TodayTimetableCopyWith<$Res> {
  _$TodayTimetableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodayTimetable
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timetableId = freezed,
    Object? semester = freezed,
    Object? entries = null,
  }) {
    return _then(
      _value.copyWith(
            timetableId: freezed == timetableId
                ? _value.timetableId
                : timetableId // ignore: cast_nullable_to_non_nullable
                      as int?,
            semester: freezed == semester
                ? _value.semester
                : semester // ignore: cast_nullable_to_non_nullable
                      as HomeSemester?,
            entries: null == entries
                ? _value.entries
                : entries // ignore: cast_nullable_to_non_nullable
                      as List<HomeTimetableEntry>,
          )
          as $Val,
    );
  }

  /// Create a copy of TodayTimetable
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HomeSemesterCopyWith<$Res>? get semester {
    if (_value.semester == null) {
      return null;
    }

    return $HomeSemesterCopyWith<$Res>(_value.semester!, (value) {
      return _then(_value.copyWith(semester: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TodayTimetableImplCopyWith<$Res>
    implements $TodayTimetableCopyWith<$Res> {
  factory _$$TodayTimetableImplCopyWith(
    _$TodayTimetableImpl value,
    $Res Function(_$TodayTimetableImpl) then,
  ) = __$$TodayTimetableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? timetableId,
    HomeSemester? semester,
    List<HomeTimetableEntry> entries,
  });

  @override
  $HomeSemesterCopyWith<$Res>? get semester;
}

/// @nodoc
class __$$TodayTimetableImplCopyWithImpl<$Res>
    extends _$TodayTimetableCopyWithImpl<$Res, _$TodayTimetableImpl>
    implements _$$TodayTimetableImplCopyWith<$Res> {
  __$$TodayTimetableImplCopyWithImpl(
    _$TodayTimetableImpl _value,
    $Res Function(_$TodayTimetableImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodayTimetable
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timetableId = freezed,
    Object? semester = freezed,
    Object? entries = null,
  }) {
    return _then(
      _$TodayTimetableImpl(
        timetableId: freezed == timetableId
            ? _value.timetableId
            : timetableId // ignore: cast_nullable_to_non_nullable
                  as int?,
        semester: freezed == semester
            ? _value.semester
            : semester // ignore: cast_nullable_to_non_nullable
                  as HomeSemester?,
        entries: null == entries
            ? _value._entries
            : entries // ignore: cast_nullable_to_non_nullable
                  as List<HomeTimetableEntry>,
      ),
    );
  }
}

/// @nodoc

class _$TodayTimetableImpl extends _TodayTimetable {
  const _$TodayTimetableImpl({
    this.timetableId,
    this.semester,
    final List<HomeTimetableEntry> entries = const [],
  }) : _entries = entries,
       super._();

  @override
  final int? timetableId;
  @override
  final HomeSemester? semester;
  final List<HomeTimetableEntry> _entries;
  @override
  @JsonKey()
  List<HomeTimetableEntry> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  String toString() {
    return 'TodayTimetable(timetableId: $timetableId, semester: $semester, entries: $entries)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodayTimetableImpl &&
            (identical(other.timetableId, timetableId) ||
                other.timetableId == timetableId) &&
            (identical(other.semester, semester) ||
                other.semester == semester) &&
            const DeepCollectionEquality().equals(other._entries, _entries));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    timetableId,
    semester,
    const DeepCollectionEquality().hash(_entries),
  );

  /// Create a copy of TodayTimetable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodayTimetableImplCopyWith<_$TodayTimetableImpl> get copyWith =>
      __$$TodayTimetableImplCopyWithImpl<_$TodayTimetableImpl>(
        this,
        _$identity,
      );
}

abstract class _TodayTimetable extends TodayTimetable {
  const factory _TodayTimetable({
    final int? timetableId,
    final HomeSemester? semester,
    final List<HomeTimetableEntry> entries,
  }) = _$TodayTimetableImpl;
  const _TodayTimetable._() : super._();

  @override
  int? get timetableId;
  @override
  HomeSemester? get semester;
  @override
  List<HomeTimetableEntry> get entries;

  /// Create a copy of TodayTimetable
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodayTimetableImplCopyWith<_$TodayTimetableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
