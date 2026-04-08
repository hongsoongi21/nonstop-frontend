// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timetable_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TimetableDto _$TimetableDtoFromJson(Map<String, dynamic> json) {
  return _TimetableDto.fromJson(json);
}

/// @nodoc
mixin _$TimetableDto {
  int get id => throw _privateConstructorUsedError;
  int get semesterId => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  SemesterType get semesterType => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  bool get isPublic => throw _privateConstructorUsedError;
  @JsonKey(name: 'timetable_kind')
  String get timetableKind => throw _privateConstructorUsedError;

  /// Serializes this TimetableDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimetableDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimetableDtoCopyWith<TimetableDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimetableDtoCopyWith<$Res> {
  factory $TimetableDtoCopyWith(
    TimetableDto value,
    $Res Function(TimetableDto) then,
  ) = _$TimetableDtoCopyWithImpl<$Res, TimetableDto>;
  @useResult
  $Res call({
    int id,
    int semesterId,
    int year,
    SemesterType semesterType,
    String? title,
    bool isPublic,
    @JsonKey(name: 'timetable_kind') String timetableKind,
  });
}

/// @nodoc
class _$TimetableDtoCopyWithImpl<$Res, $Val extends TimetableDto>
    implements $TimetableDtoCopyWith<$Res> {
  _$TimetableDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimetableDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? semesterId = null,
    Object? year = null,
    Object? semesterType = null,
    Object? title = freezed,
    Object? isPublic = null,
    Object? timetableKind = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            semesterId: null == semesterId
                ? _value.semesterId
                : semesterId // ignore: cast_nullable_to_non_nullable
                      as int,
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            semesterType: null == semesterType
                ? _value.semesterType
                : semesterType // ignore: cast_nullable_to_non_nullable
                      as SemesterType,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPublic: null == isPublic
                ? _value.isPublic
                : isPublic // ignore: cast_nullable_to_non_nullable
                      as bool,
            timetableKind: null == timetableKind
                ? _value.timetableKind
                : timetableKind // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TimetableDtoImplCopyWith<$Res>
    implements $TimetableDtoCopyWith<$Res> {
  factory _$$TimetableDtoImplCopyWith(
    _$TimetableDtoImpl value,
    $Res Function(_$TimetableDtoImpl) then,
  ) = __$$TimetableDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int semesterId,
    int year,
    SemesterType semesterType,
    String? title,
    bool isPublic,
    @JsonKey(name: 'timetable_kind') String timetableKind,
  });
}

/// @nodoc
class __$$TimetableDtoImplCopyWithImpl<$Res>
    extends _$TimetableDtoCopyWithImpl<$Res, _$TimetableDtoImpl>
    implements _$$TimetableDtoImplCopyWith<$Res> {
  __$$TimetableDtoImplCopyWithImpl(
    _$TimetableDtoImpl _value,
    $Res Function(_$TimetableDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimetableDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? semesterId = null,
    Object? year = null,
    Object? semesterType = null,
    Object? title = freezed,
    Object? isPublic = null,
    Object? timetableKind = null,
  }) {
    return _then(
      _$TimetableDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        semesterId: null == semesterId
            ? _value.semesterId
            : semesterId // ignore: cast_nullable_to_non_nullable
                  as int,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        semesterType: null == semesterType
            ? _value.semesterType
            : semesterType // ignore: cast_nullable_to_non_nullable
                  as SemesterType,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPublic: null == isPublic
            ? _value.isPublic
            : isPublic // ignore: cast_nullable_to_non_nullable
                  as bool,
        timetableKind: null == timetableKind
            ? _value.timetableKind
            : timetableKind // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TimetableDtoImpl implements _TimetableDto {
  const _$TimetableDtoImpl({
    required this.id,
    required this.semesterId,
    required this.year,
    required this.semesterType,
    this.title,
    required this.isPublic,
    @JsonKey(name: 'timetable_kind') this.timetableKind = 'backup',
  });

  factory _$TimetableDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimetableDtoImplFromJson(json);

  @override
  final int id;
  @override
  final int semesterId;
  @override
  final int year;
  @override
  final SemesterType semesterType;
  @override
  final String? title;
  @override
  final bool isPublic;
  @override
  @JsonKey(name: 'timetable_kind')
  final String timetableKind;

  @override
  String toString() {
    return 'TimetableDto(id: $id, semesterId: $semesterId, year: $year, semesterType: $semesterType, title: $title, isPublic: $isPublic, timetableKind: $timetableKind)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimetableDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.semesterId, semesterId) ||
                other.semesterId == semesterId) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.semesterType, semesterType) ||
                other.semesterType == semesterType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.timetableKind, timetableKind) ||
                other.timetableKind == timetableKind));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    semesterId,
    year,
    semesterType,
    title,
    isPublic,
    timetableKind,
  );

  /// Create a copy of TimetableDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimetableDtoImplCopyWith<_$TimetableDtoImpl> get copyWith =>
      __$$TimetableDtoImplCopyWithImpl<_$TimetableDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimetableDtoImplToJson(this);
  }
}

abstract class _TimetableDto implements TimetableDto {
  const factory _TimetableDto({
    required final int id,
    required final int semesterId,
    required final int year,
    required final SemesterType semesterType,
    final String? title,
    required final bool isPublic,
    @JsonKey(name: 'timetable_kind') final String timetableKind,
  }) = _$TimetableDtoImpl;

  factory _TimetableDto.fromJson(Map<String, dynamic> json) =
      _$TimetableDtoImpl.fromJson;

  @override
  int get id;
  @override
  int get semesterId;
  @override
  int get year;
  @override
  SemesterType get semesterType;
  @override
  String? get title;
  @override
  bool get isPublic;
  @override
  @JsonKey(name: 'timetable_kind')
  String get timetableKind;

  /// Create a copy of TimetableDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimetableDtoImplCopyWith<_$TimetableDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimetableDetailDto _$TimetableDetailDtoFromJson(Map<String, dynamic> json) {
  return _TimetableDetailDto.fromJson(json);
}

/// @nodoc
mixin _$TimetableDetailDto {
  int get id => throw _privateConstructorUsedError;
  int get semesterId => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  SemesterType get semesterType => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  bool get isPublic => throw _privateConstructorUsedError;
  @JsonKey(name: 'timetable_kind')
  String get timetableKind => throw _privateConstructorUsedError;
  List<TimetableEntryDto> get entries => throw _privateConstructorUsedError;

  /// Serializes this TimetableDetailDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimetableDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimetableDetailDtoCopyWith<TimetableDetailDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimetableDetailDtoCopyWith<$Res> {
  factory $TimetableDetailDtoCopyWith(
    TimetableDetailDto value,
    $Res Function(TimetableDetailDto) then,
  ) = _$TimetableDetailDtoCopyWithImpl<$Res, TimetableDetailDto>;
  @useResult
  $Res call({
    int id,
    int semesterId,
    int year,
    SemesterType semesterType,
    String? title,
    bool isPublic,
    @JsonKey(name: 'timetable_kind') String timetableKind,
    List<TimetableEntryDto> entries,
  });
}

/// @nodoc
class _$TimetableDetailDtoCopyWithImpl<$Res, $Val extends TimetableDetailDto>
    implements $TimetableDetailDtoCopyWith<$Res> {
  _$TimetableDetailDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimetableDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? semesterId = null,
    Object? year = null,
    Object? semesterType = null,
    Object? title = freezed,
    Object? isPublic = null,
    Object? timetableKind = null,
    Object? entries = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            semesterId: null == semesterId
                ? _value.semesterId
                : semesterId // ignore: cast_nullable_to_non_nullable
                      as int,
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            semesterType: null == semesterType
                ? _value.semesterType
                : semesterType // ignore: cast_nullable_to_non_nullable
                      as SemesterType,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPublic: null == isPublic
                ? _value.isPublic
                : isPublic // ignore: cast_nullable_to_non_nullable
                      as bool,
            timetableKind: null == timetableKind
                ? _value.timetableKind
                : timetableKind // ignore: cast_nullable_to_non_nullable
                      as String,
            entries: null == entries
                ? _value.entries
                : entries // ignore: cast_nullable_to_non_nullable
                      as List<TimetableEntryDto>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TimetableDetailDtoImplCopyWith<$Res>
    implements $TimetableDetailDtoCopyWith<$Res> {
  factory _$$TimetableDetailDtoImplCopyWith(
    _$TimetableDetailDtoImpl value,
    $Res Function(_$TimetableDetailDtoImpl) then,
  ) = __$$TimetableDetailDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int semesterId,
    int year,
    SemesterType semesterType,
    String? title,
    bool isPublic,
    @JsonKey(name: 'timetable_kind') String timetableKind,
    List<TimetableEntryDto> entries,
  });
}

/// @nodoc
class __$$TimetableDetailDtoImplCopyWithImpl<$Res>
    extends _$TimetableDetailDtoCopyWithImpl<$Res, _$TimetableDetailDtoImpl>
    implements _$$TimetableDetailDtoImplCopyWith<$Res> {
  __$$TimetableDetailDtoImplCopyWithImpl(
    _$TimetableDetailDtoImpl _value,
    $Res Function(_$TimetableDetailDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimetableDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? semesterId = null,
    Object? year = null,
    Object? semesterType = null,
    Object? title = freezed,
    Object? isPublic = null,
    Object? timetableKind = null,
    Object? entries = null,
  }) {
    return _then(
      _$TimetableDetailDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        semesterId: null == semesterId
            ? _value.semesterId
            : semesterId // ignore: cast_nullable_to_non_nullable
                  as int,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        semesterType: null == semesterType
            ? _value.semesterType
            : semesterType // ignore: cast_nullable_to_non_nullable
                  as SemesterType,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPublic: null == isPublic
            ? _value.isPublic
            : isPublic // ignore: cast_nullable_to_non_nullable
                  as bool,
        timetableKind: null == timetableKind
            ? _value.timetableKind
            : timetableKind // ignore: cast_nullable_to_non_nullable
                  as String,
        entries: null == entries
            ? _value._entries
            : entries // ignore: cast_nullable_to_non_nullable
                  as List<TimetableEntryDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TimetableDetailDtoImpl implements _TimetableDetailDto {
  const _$TimetableDetailDtoImpl({
    required this.id,
    required this.semesterId,
    required this.year,
    required this.semesterType,
    this.title,
    required this.isPublic,
    @JsonKey(name: 'timetable_kind') this.timetableKind = 'backup',
    required final List<TimetableEntryDto> entries,
  }) : _entries = entries;

  factory _$TimetableDetailDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimetableDetailDtoImplFromJson(json);

  @override
  final int id;
  @override
  final int semesterId;
  @override
  final int year;
  @override
  final SemesterType semesterType;
  @override
  final String? title;
  @override
  final bool isPublic;
  @override
  @JsonKey(name: 'timetable_kind')
  final String timetableKind;
  final List<TimetableEntryDto> _entries;
  @override
  List<TimetableEntryDto> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  String toString() {
    return 'TimetableDetailDto(id: $id, semesterId: $semesterId, year: $year, semesterType: $semesterType, title: $title, isPublic: $isPublic, timetableKind: $timetableKind, entries: $entries)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimetableDetailDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.semesterId, semesterId) ||
                other.semesterId == semesterId) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.semesterType, semesterType) ||
                other.semesterType == semesterType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.timetableKind, timetableKind) ||
                other.timetableKind == timetableKind) &&
            const DeepCollectionEquality().equals(other._entries, _entries));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    semesterId,
    year,
    semesterType,
    title,
    isPublic,
    timetableKind,
    const DeepCollectionEquality().hash(_entries),
  );

  /// Create a copy of TimetableDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimetableDetailDtoImplCopyWith<_$TimetableDetailDtoImpl> get copyWith =>
      __$$TimetableDetailDtoImplCopyWithImpl<_$TimetableDetailDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TimetableDetailDtoImplToJson(this);
  }
}

abstract class _TimetableDetailDto implements TimetableDetailDto {
  const factory _TimetableDetailDto({
    required final int id,
    required final int semesterId,
    required final int year,
    required final SemesterType semesterType,
    final String? title,
    required final bool isPublic,
    @JsonKey(name: 'timetable_kind') final String timetableKind,
    required final List<TimetableEntryDto> entries,
  }) = _$TimetableDetailDtoImpl;

  factory _TimetableDetailDto.fromJson(Map<String, dynamic> json) =
      _$TimetableDetailDtoImpl.fromJson;

  @override
  int get id;
  @override
  int get semesterId;
  @override
  int get year;
  @override
  SemesterType get semesterType;
  @override
  String? get title;
  @override
  bool get isPublic;
  @override
  @JsonKey(name: 'timetable_kind')
  String get timetableKind;
  @override
  List<TimetableEntryDto> get entries;

  /// Create a copy of TimetableDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimetableDetailDtoImplCopyWith<_$TimetableDetailDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimetableRequestDto _$TimetableRequestDtoFromJson(Map<String, dynamic> json) {
  return _TimetableRequestDto.fromJson(json);
}

/// @nodoc
mixin _$TimetableRequestDto {
  int? get year => throw _privateConstructorUsedError; // Required for create
  @JsonKey(toJson: _semesterTypeToJson, fromJson: _semesterTypeFromJson)
  SemesterType? get semesterType => throw _privateConstructorUsedError; // Required for create (FIRST, SECOND, SUMMER, WINTER)
  String? get title => throw _privateConstructorUsedError;
  bool? get isPublic => throw _privateConstructorUsedError;
  String? get timetableKind => throw _privateConstructorUsedError;

  /// Serializes this TimetableRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimetableRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimetableRequestDtoCopyWith<TimetableRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimetableRequestDtoCopyWith<$Res> {
  factory $TimetableRequestDtoCopyWith(
    TimetableRequestDto value,
    $Res Function(TimetableRequestDto) then,
  ) = _$TimetableRequestDtoCopyWithImpl<$Res, TimetableRequestDto>;
  @useResult
  $Res call({
    int? year,
    @JsonKey(toJson: _semesterTypeToJson, fromJson: _semesterTypeFromJson)
    SemesterType? semesterType,
    String? title,
    bool? isPublic,
    String? timetableKind,
  });
}

/// @nodoc
class _$TimetableRequestDtoCopyWithImpl<$Res, $Val extends TimetableRequestDto>
    implements $TimetableRequestDtoCopyWith<$Res> {
  _$TimetableRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimetableRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = freezed,
    Object? semesterType = freezed,
    Object? title = freezed,
    Object? isPublic = freezed,
    Object? timetableKind = freezed,
  }) {
    return _then(
      _value.copyWith(
            year: freezed == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int?,
            semesterType: freezed == semesterType
                ? _value.semesterType
                : semesterType // ignore: cast_nullable_to_non_nullable
                      as SemesterType?,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPublic: freezed == isPublic
                ? _value.isPublic
                : isPublic // ignore: cast_nullable_to_non_nullable
                      as bool?,
            timetableKind: freezed == timetableKind
                ? _value.timetableKind
                : timetableKind // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TimetableRequestDtoImplCopyWith<$Res>
    implements $TimetableRequestDtoCopyWith<$Res> {
  factory _$$TimetableRequestDtoImplCopyWith(
    _$TimetableRequestDtoImpl value,
    $Res Function(_$TimetableRequestDtoImpl) then,
  ) = __$$TimetableRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? year,
    @JsonKey(toJson: _semesterTypeToJson, fromJson: _semesterTypeFromJson)
    SemesterType? semesterType,
    String? title,
    bool? isPublic,
    String? timetableKind,
  });
}

/// @nodoc
class __$$TimetableRequestDtoImplCopyWithImpl<$Res>
    extends _$TimetableRequestDtoCopyWithImpl<$Res, _$TimetableRequestDtoImpl>
    implements _$$TimetableRequestDtoImplCopyWith<$Res> {
  __$$TimetableRequestDtoImplCopyWithImpl(
    _$TimetableRequestDtoImpl _value,
    $Res Function(_$TimetableRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimetableRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = freezed,
    Object? semesterType = freezed,
    Object? title = freezed,
    Object? isPublic = freezed,
    Object? timetableKind = freezed,
  }) {
    return _then(
      _$TimetableRequestDtoImpl(
        year: freezed == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int?,
        semesterType: freezed == semesterType
            ? _value.semesterType
            : semesterType // ignore: cast_nullable_to_non_nullable
                  as SemesterType?,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPublic: freezed == isPublic
            ? _value.isPublic
            : isPublic // ignore: cast_nullable_to_non_nullable
                  as bool?,
        timetableKind: freezed == timetableKind
            ? _value.timetableKind
            : timetableKind // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TimetableRequestDtoImpl implements _TimetableRequestDto {
  const _$TimetableRequestDtoImpl({
    this.year,
    @JsonKey(toJson: _semesterTypeToJson, fromJson: _semesterTypeFromJson)
    this.semesterType,
    this.title,
    this.isPublic,
    this.timetableKind,
  });

  factory _$TimetableRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimetableRequestDtoImplFromJson(json);

  @override
  final int? year;
  // Required for create
  @override
  @JsonKey(toJson: _semesterTypeToJson, fromJson: _semesterTypeFromJson)
  final SemesterType? semesterType;
  // Required for create (FIRST, SECOND, SUMMER, WINTER)
  @override
  final String? title;
  @override
  final bool? isPublic;
  @override
  final String? timetableKind;

  @override
  String toString() {
    return 'TimetableRequestDto(year: $year, semesterType: $semesterType, title: $title, isPublic: $isPublic, timetableKind: $timetableKind)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimetableRequestDtoImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.semesterType, semesterType) ||
                other.semesterType == semesterType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.timetableKind, timetableKind) ||
                other.timetableKind == timetableKind));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    year,
    semesterType,
    title,
    isPublic,
    timetableKind,
  );

  /// Create a copy of TimetableRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimetableRequestDtoImplCopyWith<_$TimetableRequestDtoImpl> get copyWith =>
      __$$TimetableRequestDtoImplCopyWithImpl<_$TimetableRequestDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TimetableRequestDtoImplToJson(this);
  }
}

abstract class _TimetableRequestDto implements TimetableRequestDto {
  const factory _TimetableRequestDto({
    final int? year,
    @JsonKey(toJson: _semesterTypeToJson, fromJson: _semesterTypeFromJson)
    final SemesterType? semesterType,
    final String? title,
    final bool? isPublic,
    final String? timetableKind,
  }) = _$TimetableRequestDtoImpl;

  factory _TimetableRequestDto.fromJson(Map<String, dynamic> json) =
      _$TimetableRequestDtoImpl.fromJson;

  @override
  int? get year; // Required for create
  @override
  @JsonKey(toJson: _semesterTypeToJson, fromJson: _semesterTypeFromJson)
  SemesterType? get semesterType; // Required for create (FIRST, SECOND, SUMMER, WINTER)
  @override
  String? get title;
  @override
  bool? get isPublic;
  @override
  String? get timetableKind;

  /// Create a copy of TimetableRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimetableRequestDtoImplCopyWith<_$TimetableRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
