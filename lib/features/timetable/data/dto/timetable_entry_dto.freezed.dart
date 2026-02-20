// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timetable_entry_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TimetableEntryDto _$TimetableEntryDtoFromJson(Map<String, dynamic> json) {
  return _TimetableEntryDto.fromJson(json);
}

/// @nodoc
mixin _$TimetableEntryDto {
  int get id => throw _privateConstructorUsedError;
  int get timetableId => throw _privateConstructorUsedError;
  String get subjectName => throw _privateConstructorUsedError;
  String? get professor => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dayOfWeekFromJson, toJson: _dayOfWeekToJson)
  DayOfWeek get dayOfWeek => throw _privateConstructorUsedError;
  String get startTime =>
      throw _privateConstructorUsedError; // Format: "HH:mm" (e.g., "09:00")
  String get endTime =>
      throw _privateConstructorUsedError; // Format: "HH:mm" (e.g., "10:30")
  String? get place => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  int? get credit => throw _privateConstructorUsedError;

  /// Serializes this TimetableEntryDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimetableEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimetableEntryDtoCopyWith<TimetableEntryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimetableEntryDtoCopyWith<$Res> {
  factory $TimetableEntryDtoCopyWith(
    TimetableEntryDto value,
    $Res Function(TimetableEntryDto) then,
  ) = _$TimetableEntryDtoCopyWithImpl<$Res, TimetableEntryDto>;
  @useResult
  $Res call({
    int id,
    int timetableId,
    String subjectName,
    String? professor,
    @JsonKey(fromJson: _dayOfWeekFromJson, toJson: _dayOfWeekToJson)
    DayOfWeek dayOfWeek,
    String startTime,
    String endTime,
    String? place,
    String? color,
    int? credit,
  });
}

/// @nodoc
class _$TimetableEntryDtoCopyWithImpl<$Res, $Val extends TimetableEntryDto>
    implements $TimetableEntryDtoCopyWith<$Res> {
  _$TimetableEntryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimetableEntryDto
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
abstract class _$$TimetableEntryDtoImplCopyWith<$Res>
    implements $TimetableEntryDtoCopyWith<$Res> {
  factory _$$TimetableEntryDtoImplCopyWith(
    _$TimetableEntryDtoImpl value,
    $Res Function(_$TimetableEntryDtoImpl) then,
  ) = __$$TimetableEntryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int timetableId,
    String subjectName,
    String? professor,
    @JsonKey(fromJson: _dayOfWeekFromJson, toJson: _dayOfWeekToJson)
    DayOfWeek dayOfWeek,
    String startTime,
    String endTime,
    String? place,
    String? color,
    int? credit,
  });
}

/// @nodoc
class __$$TimetableEntryDtoImplCopyWithImpl<$Res>
    extends _$TimetableEntryDtoCopyWithImpl<$Res, _$TimetableEntryDtoImpl>
    implements _$$TimetableEntryDtoImplCopyWith<$Res> {
  __$$TimetableEntryDtoImplCopyWithImpl(
    _$TimetableEntryDtoImpl _value,
    $Res Function(_$TimetableEntryDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimetableEntryDto
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
      _$TimetableEntryDtoImpl(
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
@JsonSerializable()
class _$TimetableEntryDtoImpl implements _TimetableEntryDto {
  const _$TimetableEntryDtoImpl({
    required this.id,
    required this.timetableId,
    required this.subjectName,
    this.professor,
    @JsonKey(fromJson: _dayOfWeekFromJson, toJson: _dayOfWeekToJson)
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.place,
    this.color,
    this.credit,
  });

  factory _$TimetableEntryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimetableEntryDtoImplFromJson(json);

  @override
  final int id;
  @override
  final int timetableId;
  @override
  final String subjectName;
  @override
  final String? professor;
  @override
  @JsonKey(fromJson: _dayOfWeekFromJson, toJson: _dayOfWeekToJson)
  final DayOfWeek dayOfWeek;
  @override
  final String startTime;
  // Format: "HH:mm" (e.g., "09:00")
  @override
  final String endTime;
  // Format: "HH:mm" (e.g., "10:30")
  @override
  final String? place;
  @override
  final String? color;
  @override
  final int? credit;

  @override
  String toString() {
    return 'TimetableEntryDto(id: $id, timetableId: $timetableId, subjectName: $subjectName, professor: $professor, dayOfWeek: $dayOfWeek, startTime: $startTime, endTime: $endTime, place: $place, color: $color, credit: $credit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimetableEntryDtoImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of TimetableEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimetableEntryDtoImplCopyWith<_$TimetableEntryDtoImpl> get copyWith =>
      __$$TimetableEntryDtoImplCopyWithImpl<_$TimetableEntryDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TimetableEntryDtoImplToJson(this);
  }
}

abstract class _TimetableEntryDto implements TimetableEntryDto {
  const factory _TimetableEntryDto({
    required final int id,
    required final int timetableId,
    required final String subjectName,
    final String? professor,
    @JsonKey(fromJson: _dayOfWeekFromJson, toJson: _dayOfWeekToJson)
    required final DayOfWeek dayOfWeek,
    required final String startTime,
    required final String endTime,
    final String? place,
    final String? color,
    final int? credit,
  }) = _$TimetableEntryDtoImpl;

  factory _TimetableEntryDto.fromJson(Map<String, dynamic> json) =
      _$TimetableEntryDtoImpl.fromJson;

  @override
  int get id;
  @override
  int get timetableId;
  @override
  String get subjectName;
  @override
  String? get professor;
  @override
  @JsonKey(fromJson: _dayOfWeekFromJson, toJson: _dayOfWeekToJson)
  DayOfWeek get dayOfWeek;
  @override
  String get startTime; // Format: "HH:mm" (e.g., "09:00")
  @override
  String get endTime; // Format: "HH:mm" (e.g., "10:30")
  @override
  String? get place;
  @override
  String? get color;
  @override
  int? get credit;

  /// Create a copy of TimetableEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimetableEntryDtoImplCopyWith<_$TimetableEntryDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimetableEntryRequestDto _$TimetableEntryRequestDtoFromJson(
  Map<String, dynamic> json,
) {
  return _TimetableEntryRequestDto.fromJson(json);
}

/// @nodoc
mixin _$TimetableEntryRequestDto {
  String get subjectName => throw _privateConstructorUsedError;
  String? get professor => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dayOfWeekFromJson, toJson: _dayOfWeekToJson)
  DayOfWeek get dayOfWeek => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError; // Format: "HH:mm"
  String get endTime => throw _privateConstructorUsedError; // Format: "HH:mm"
  String? get place => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  int? get credit => throw _privateConstructorUsedError;

  /// Serializes this TimetableEntryRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimetableEntryRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimetableEntryRequestDtoCopyWith<TimetableEntryRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimetableEntryRequestDtoCopyWith<$Res> {
  factory $TimetableEntryRequestDtoCopyWith(
    TimetableEntryRequestDto value,
    $Res Function(TimetableEntryRequestDto) then,
  ) = _$TimetableEntryRequestDtoCopyWithImpl<$Res, TimetableEntryRequestDto>;
  @useResult
  $Res call({
    String subjectName,
    String? professor,
    @JsonKey(fromJson: _dayOfWeekFromJson, toJson: _dayOfWeekToJson)
    DayOfWeek dayOfWeek,
    String startTime,
    String endTime,
    String? place,
    String? color,
    int? credit,
  });
}

/// @nodoc
class _$TimetableEntryRequestDtoCopyWithImpl<
  $Res,
  $Val extends TimetableEntryRequestDto
>
    implements $TimetableEntryRequestDtoCopyWith<$Res> {
  _$TimetableEntryRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimetableEntryRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
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
abstract class _$$TimetableEntryRequestDtoImplCopyWith<$Res>
    implements $TimetableEntryRequestDtoCopyWith<$Res> {
  factory _$$TimetableEntryRequestDtoImplCopyWith(
    _$TimetableEntryRequestDtoImpl value,
    $Res Function(_$TimetableEntryRequestDtoImpl) then,
  ) = __$$TimetableEntryRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String subjectName,
    String? professor,
    @JsonKey(fromJson: _dayOfWeekFromJson, toJson: _dayOfWeekToJson)
    DayOfWeek dayOfWeek,
    String startTime,
    String endTime,
    String? place,
    String? color,
    int? credit,
  });
}

/// @nodoc
class __$$TimetableEntryRequestDtoImplCopyWithImpl<$Res>
    extends
        _$TimetableEntryRequestDtoCopyWithImpl<
          $Res,
          _$TimetableEntryRequestDtoImpl
        >
    implements _$$TimetableEntryRequestDtoImplCopyWith<$Res> {
  __$$TimetableEntryRequestDtoImplCopyWithImpl(
    _$TimetableEntryRequestDtoImpl _value,
    $Res Function(_$TimetableEntryRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimetableEntryRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
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
      _$TimetableEntryRequestDtoImpl(
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
@JsonSerializable()
class _$TimetableEntryRequestDtoImpl implements _TimetableEntryRequestDto {
  const _$TimetableEntryRequestDtoImpl({
    required this.subjectName,
    this.professor,
    @JsonKey(fromJson: _dayOfWeekFromJson, toJson: _dayOfWeekToJson)
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.place,
    this.color,
    this.credit,
  });

  factory _$TimetableEntryRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimetableEntryRequestDtoImplFromJson(json);

  @override
  final String subjectName;
  @override
  final String? professor;
  @override
  @JsonKey(fromJson: _dayOfWeekFromJson, toJson: _dayOfWeekToJson)
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
    return 'TimetableEntryRequestDto(subjectName: $subjectName, professor: $professor, dayOfWeek: $dayOfWeek, startTime: $startTime, endTime: $endTime, place: $place, color: $color, credit: $credit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimetableEntryRequestDtoImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    subjectName,
    professor,
    dayOfWeek,
    startTime,
    endTime,
    place,
    color,
    credit,
  );

  /// Create a copy of TimetableEntryRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimetableEntryRequestDtoImplCopyWith<_$TimetableEntryRequestDtoImpl>
  get copyWith =>
      __$$TimetableEntryRequestDtoImplCopyWithImpl<
        _$TimetableEntryRequestDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimetableEntryRequestDtoImplToJson(this);
  }
}

abstract class _TimetableEntryRequestDto implements TimetableEntryRequestDto {
  const factory _TimetableEntryRequestDto({
    required final String subjectName,
    final String? professor,
    @JsonKey(fromJson: _dayOfWeekFromJson, toJson: _dayOfWeekToJson)
    required final DayOfWeek dayOfWeek,
    required final String startTime,
    required final String endTime,
    final String? place,
    final String? color,
    final int? credit,
  }) = _$TimetableEntryRequestDtoImpl;

  factory _TimetableEntryRequestDto.fromJson(Map<String, dynamic> json) =
      _$TimetableEntryRequestDtoImpl.fromJson;

  @override
  String get subjectName;
  @override
  String? get professor;
  @override
  @JsonKey(fromJson: _dayOfWeekFromJson, toJson: _dayOfWeekToJson)
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

  /// Create a copy of TimetableEntryRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimetableEntryRequestDtoImplCopyWith<_$TimetableEntryRequestDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
