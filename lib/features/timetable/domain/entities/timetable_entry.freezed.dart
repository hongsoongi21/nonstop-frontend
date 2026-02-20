// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timetable_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TimetableEntry {
  int get id => throw _privateConstructorUsedError;
  int get timetableId => throw _privateConstructorUsedError;
  String get subjectName => throw _privateConstructorUsedError;
  String? get professor => throw _privateConstructorUsedError;
  DayOfWeek get dayOfWeek => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError; // Format: "HH:mm"
  String get endTime => throw _privateConstructorUsedError; // Format: "HH:mm"
  String? get place => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  int? get credit => throw _privateConstructorUsedError;

  /// Create a copy of TimetableEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimetableEntryCopyWith<TimetableEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimetableEntryCopyWith<$Res> {
  factory $TimetableEntryCopyWith(
    TimetableEntry value,
    $Res Function(TimetableEntry) then,
  ) = _$TimetableEntryCopyWithImpl<$Res, TimetableEntry>;
  @useResult
  $Res call({
    int id,
    int timetableId,
    String subjectName,
    String? professor,
    DayOfWeek dayOfWeek,
    String startTime,
    String endTime,
    String? place,
    String? color,
    int? credit,
  });
}

/// @nodoc
class _$TimetableEntryCopyWithImpl<$Res, $Val extends TimetableEntry>
    implements $TimetableEntryCopyWith<$Res> {
  _$TimetableEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimetableEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timetableId = null,
    Object? subjectName = null,
    Object? professor = freezed,
    Object? dayOfWeek = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? place = freezed,
    Object? color = freezed,
    Object? credit = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            timetableId: null == timetableId
                ? _value.timetableId
                : timetableId // ignore: cast_nullable_to_non_nullable
                      as int,
            subjectName: null == subjectName
                ? _value.subjectName
                : subjectName // ignore: cast_nullable_to_non_nullable
                      as String,
            professor: freezed == professor
                ? _value.professor
                : professor // ignore: cast_nullable_to_non_nullable
                      as String?,
            dayOfWeek: null == dayOfWeek
                ? _value.dayOfWeek
                : dayOfWeek // ignore: cast_nullable_to_non_nullable
                      as DayOfWeek,
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
            credit: freezed == credit
                ? _value.credit
                : credit // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TimetableEntryImplCopyWith<$Res>
    implements $TimetableEntryCopyWith<$Res> {
  factory _$$TimetableEntryImplCopyWith(
    _$TimetableEntryImpl value,
    $Res Function(_$TimetableEntryImpl) then,
  ) = __$$TimetableEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int timetableId,
    String subjectName,
    String? professor,
    DayOfWeek dayOfWeek,
    String startTime,
    String endTime,
    String? place,
    String? color,
    int? credit,
  });
}

/// @nodoc
class __$$TimetableEntryImplCopyWithImpl<$Res>
    extends _$TimetableEntryCopyWithImpl<$Res, _$TimetableEntryImpl>
    implements _$$TimetableEntryImplCopyWith<$Res> {
  __$$TimetableEntryImplCopyWithImpl(
    _$TimetableEntryImpl _value,
    $Res Function(_$TimetableEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimetableEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timetableId = null,
    Object? subjectName = null,
    Object? professor = freezed,
    Object? dayOfWeek = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? place = freezed,
    Object? color = freezed,
    Object? credit = freezed,
  }) {
    return _then(
      _$TimetableEntryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        timetableId: null == timetableId
            ? _value.timetableId
            : timetableId // ignore: cast_nullable_to_non_nullable
                  as int,
        subjectName: null == subjectName
            ? _value.subjectName
            : subjectName // ignore: cast_nullable_to_non_nullable
                  as String,
        professor: freezed == professor
            ? _value.professor
            : professor // ignore: cast_nullable_to_non_nullable
                  as String?,
        dayOfWeek: null == dayOfWeek
            ? _value.dayOfWeek
            : dayOfWeek // ignore: cast_nullable_to_non_nullable
                  as DayOfWeek,
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
        credit: freezed == credit
            ? _value.credit
            : credit // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$TimetableEntryImpl extends _TimetableEntry {
  const _$TimetableEntryImpl({
    required this.id,
    required this.timetableId,
    required this.subjectName,
    this.professor,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.place,
    this.color,
    this.credit,
  }) : super._();

  @override
  final int id;
  @override
  final int timetableId;
  @override
  final String subjectName;
  @override
  final String? professor;
  @override
  final DayOfWeek dayOfWeek;
  @override
  final String startTime;
  // Format: "HH:mm"
  @override
  final String endTime;
  // Format: "HH:mm"
  @override
  final String? place;
  @override
  final String? color;
  @override
  final int? credit;

  @override
  String toString() {
    return 'TimetableEntry(id: $id, timetableId: $timetableId, subjectName: $subjectName, professor: $professor, dayOfWeek: $dayOfWeek, startTime: $startTime, endTime: $endTime, place: $place, color: $color, credit: $credit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimetableEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timetableId, timetableId) ||
                other.timetableId == timetableId) &&
            (identical(other.subjectName, subjectName) ||
                other.subjectName == subjectName) &&
            (identical(other.professor, professor) ||
                other.professor == professor) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.place, place) || other.place == place) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.credit, credit) || other.credit == credit));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    timetableId,
    subjectName,
    professor,
    dayOfWeek,
    startTime,
    endTime,
    place,
    color,
    credit,
  );

  /// Create a copy of TimetableEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimetableEntryImplCopyWith<_$TimetableEntryImpl> get copyWith =>
      __$$TimetableEntryImplCopyWithImpl<_$TimetableEntryImpl>(
        this,
        _$identity,
      );
}

abstract class _TimetableEntry extends TimetableEntry {
  const factory _TimetableEntry({
    required final int id,
    required final int timetableId,
    required final String subjectName,
    final String? professor,
    required final DayOfWeek dayOfWeek,
    required final String startTime,
    required final String endTime,
    final String? place,
    final String? color,
    final int? credit,
  }) = _$TimetableEntryImpl;
  const _TimetableEntry._() : super._();

  @override
  int get id;
  @override
  int get timetableId;
  @override
  String get subjectName;
  @override
  String? get professor;
  @override
  DayOfWeek get dayOfWeek;
  @override
  String get startTime; // Format: "HH:mm"
  @override
  String get endTime; // Format: "HH:mm"
  @override
  String? get place;
  @override
  String? get color;
  @override
  int? get credit;

  /// Create a copy of TimetableEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimetableEntryImplCopyWith<_$TimetableEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
