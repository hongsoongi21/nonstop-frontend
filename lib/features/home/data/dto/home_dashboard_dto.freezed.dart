// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_dashboard_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HomeNoticeDto _$HomeNoticeDtoFromJson(Map<String, dynamic> json) {
  return _HomeNoticeDto.fromJson(json);
}

/// @nodoc
mixin _$HomeNoticeDto {
  int get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  int get boardId => throw _privateConstructorUsedError;
  String get boardName => throw _privateConstructorUsedError;
  String? get boardSlug => throw _privateConstructorUsedError;

  /// Serializes this HomeNoticeDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeNoticeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeNoticeDtoCopyWith<HomeNoticeDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeNoticeDtoCopyWith<$Res> {
  factory $HomeNoticeDtoCopyWith(
    HomeNoticeDto value,
    $Res Function(HomeNoticeDto) then,
  ) = _$HomeNoticeDtoCopyWithImpl<$Res, HomeNoticeDto>;
  @useResult
  $Res call({
    int id,
    String? title,
    String createdAt,
    int boardId,
    String boardName,
    String? boardSlug,
  });
}

/// @nodoc
class _$HomeNoticeDtoCopyWithImpl<$Res, $Val extends HomeNoticeDto>
    implements $HomeNoticeDtoCopyWith<$Res> {
  _$HomeNoticeDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeNoticeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? createdAt = null,
    Object? boardId = null,
    Object? boardName = null,
    Object? boardSlug = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            boardId: null == boardId
                ? _value.boardId
                : boardId // ignore: cast_nullable_to_non_nullable
                      as int,
            boardName: null == boardName
                ? _value.boardName
                : boardName // ignore: cast_nullable_to_non_nullable
                      as String,
            boardSlug: freezed == boardSlug
                ? _value.boardSlug
                : boardSlug // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HomeNoticeDtoImplCopyWith<$Res>
    implements $HomeNoticeDtoCopyWith<$Res> {
  factory _$$HomeNoticeDtoImplCopyWith(
    _$HomeNoticeDtoImpl value,
    $Res Function(_$HomeNoticeDtoImpl) then,
  ) = __$$HomeNoticeDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String? title,
    String createdAt,
    int boardId,
    String boardName,
    String? boardSlug,
  });
}

/// @nodoc
class __$$HomeNoticeDtoImplCopyWithImpl<$Res>
    extends _$HomeNoticeDtoCopyWithImpl<$Res, _$HomeNoticeDtoImpl>
    implements _$$HomeNoticeDtoImplCopyWith<$Res> {
  __$$HomeNoticeDtoImplCopyWithImpl(
    _$HomeNoticeDtoImpl _value,
    $Res Function(_$HomeNoticeDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeNoticeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? createdAt = null,
    Object? boardId = null,
    Object? boardName = null,
    Object? boardSlug = freezed,
  }) {
    return _then(
      _$HomeNoticeDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        boardId: null == boardId
            ? _value.boardId
            : boardId // ignore: cast_nullable_to_non_nullable
                  as int,
        boardName: null == boardName
            ? _value.boardName
            : boardName // ignore: cast_nullable_to_non_nullable
                  as String,
        boardSlug: freezed == boardSlug
            ? _value.boardSlug
            : boardSlug // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeNoticeDtoImpl implements _HomeNoticeDto {
  const _$HomeNoticeDtoImpl({
    required this.id,
    this.title,
    required this.createdAt,
    required this.boardId,
    required this.boardName,
    this.boardSlug,
  });

  factory _$HomeNoticeDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeNoticeDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String? title;
  @override
  final String createdAt;
  @override
  final int boardId;
  @override
  final String boardName;
  @override
  final String? boardSlug;

  @override
  String toString() {
    return 'HomeNoticeDto(id: $id, title: $title, createdAt: $createdAt, boardId: $boardId, boardName: $boardName, boardSlug: $boardSlug)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeNoticeDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.boardId, boardId) || other.boardId == boardId) &&
            (identical(other.boardName, boardName) ||
                other.boardName == boardName) &&
            (identical(other.boardSlug, boardSlug) ||
                other.boardSlug == boardSlug));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    createdAt,
    boardId,
    boardName,
    boardSlug,
  );

  /// Create a copy of HomeNoticeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeNoticeDtoImplCopyWith<_$HomeNoticeDtoImpl> get copyWith =>
      __$$HomeNoticeDtoImplCopyWithImpl<_$HomeNoticeDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeNoticeDtoImplToJson(this);
  }
}

abstract class _HomeNoticeDto implements HomeNoticeDto {
  const factory _HomeNoticeDto({
    required final int id,
    final String? title,
    required final String createdAt,
    required final int boardId,
    required final String boardName,
    final String? boardSlug,
  }) = _$HomeNoticeDtoImpl;

  factory _HomeNoticeDto.fromJson(Map<String, dynamic> json) =
      _$HomeNoticeDtoImpl.fromJson;

  @override
  int get id;
  @override
  String? get title;
  @override
  String get createdAt;
  @override
  int get boardId;
  @override
  String get boardName;
  @override
  String? get boardSlug;

  /// Create a copy of HomeNoticeDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeNoticeDtoImplCopyWith<_$HomeNoticeDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HomeSemesterDto _$HomeSemesterDtoFromJson(Map<String, dynamic> json) {
  return _HomeSemesterDto.fromJson(json);
}

/// @nodoc
mixin _$HomeSemesterDto {
  int get id => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this HomeSemesterDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeSemesterDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeSemesterDtoCopyWith<HomeSemesterDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeSemesterDtoCopyWith<$Res> {
  factory $HomeSemesterDtoCopyWith(
    HomeSemesterDto value,
    $Res Function(HomeSemesterDto) then,
  ) = _$HomeSemesterDtoCopyWithImpl<$Res, HomeSemesterDto>;
  @useResult
  $Res call({int id, int year, String type});
}

/// @nodoc
class _$HomeSemesterDtoCopyWithImpl<$Res, $Val extends HomeSemesterDto>
    implements $HomeSemesterDtoCopyWith<$Res> {
  _$HomeSemesterDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeSemesterDto
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
abstract class _$$HomeSemesterDtoImplCopyWith<$Res>
    implements $HomeSemesterDtoCopyWith<$Res> {
  factory _$$HomeSemesterDtoImplCopyWith(
    _$HomeSemesterDtoImpl value,
    $Res Function(_$HomeSemesterDtoImpl) then,
  ) = __$$HomeSemesterDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int year, String type});
}

/// @nodoc
class __$$HomeSemesterDtoImplCopyWithImpl<$Res>
    extends _$HomeSemesterDtoCopyWithImpl<$Res, _$HomeSemesterDtoImpl>
    implements _$$HomeSemesterDtoImplCopyWith<$Res> {
  __$$HomeSemesterDtoImplCopyWithImpl(
    _$HomeSemesterDtoImpl _value,
    $Res Function(_$HomeSemesterDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeSemesterDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? year = null, Object? type = null}) {
    return _then(
      _$HomeSemesterDtoImpl(
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
@JsonSerializable()
class _$HomeSemesterDtoImpl implements _HomeSemesterDto {
  const _$HomeSemesterDtoImpl({
    required this.id,
    required this.year,
    required this.type,
  });

  factory _$HomeSemesterDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeSemesterDtoImplFromJson(json);

  @override
  final int id;
  @override
  final int year;
  @override
  final String type;

  @override
  String toString() {
    return 'HomeSemesterDto(id: $id, year: $year, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeSemesterDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, year, type);

  /// Create a copy of HomeSemesterDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeSemesterDtoImplCopyWith<_$HomeSemesterDtoImpl> get copyWith =>
      __$$HomeSemesterDtoImplCopyWithImpl<_$HomeSemesterDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeSemesterDtoImplToJson(this);
  }
}

abstract class _HomeSemesterDto implements HomeSemesterDto {
  const factory _HomeSemesterDto({
    required final int id,
    required final int year,
    required final String type,
  }) = _$HomeSemesterDtoImpl;

  factory _HomeSemesterDto.fromJson(Map<String, dynamic> json) =
      _$HomeSemesterDtoImpl.fromJson;

  @override
  int get id;
  @override
  int get year;
  @override
  String get type;

  /// Create a copy of HomeSemesterDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeSemesterDtoImplCopyWith<_$HomeSemesterDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HomeTimetableEntryDto _$HomeTimetableEntryDtoFromJson(
  Map<String, dynamic> json,
) {
  return _HomeTimetableEntryDto.fromJson(json);
}

/// @nodoc
mixin _$HomeTimetableEntryDto {
  int get id => throw _privateConstructorUsedError;
  String? get subjectName => throw _privateConstructorUsedError;
  String? get professor => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  String? get place => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;

  /// Serializes this HomeTimetableEntryDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeTimetableEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeTimetableEntryDtoCopyWith<HomeTimetableEntryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeTimetableEntryDtoCopyWith<$Res> {
  factory $HomeTimetableEntryDtoCopyWith(
    HomeTimetableEntryDto value,
    $Res Function(HomeTimetableEntryDto) then,
  ) = _$HomeTimetableEntryDtoCopyWithImpl<$Res, HomeTimetableEntryDto>;
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
class _$HomeTimetableEntryDtoCopyWithImpl<
  $Res,
  $Val extends HomeTimetableEntryDto
>
    implements $HomeTimetableEntryDtoCopyWith<$Res> {
  _$HomeTimetableEntryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeTimetableEntryDto
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
abstract class _$$HomeTimetableEntryDtoImplCopyWith<$Res>
    implements $HomeTimetableEntryDtoCopyWith<$Res> {
  factory _$$HomeTimetableEntryDtoImplCopyWith(
    _$HomeTimetableEntryDtoImpl value,
    $Res Function(_$HomeTimetableEntryDtoImpl) then,
  ) = __$$HomeTimetableEntryDtoImplCopyWithImpl<$Res>;
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
class __$$HomeTimetableEntryDtoImplCopyWithImpl<$Res>
    extends
        _$HomeTimetableEntryDtoCopyWithImpl<$Res, _$HomeTimetableEntryDtoImpl>
    implements _$$HomeTimetableEntryDtoImplCopyWith<$Res> {
  __$$HomeTimetableEntryDtoImplCopyWithImpl(
    _$HomeTimetableEntryDtoImpl _value,
    $Res Function(_$HomeTimetableEntryDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeTimetableEntryDto
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
      _$HomeTimetableEntryDtoImpl(
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
@JsonSerializable()
class _$HomeTimetableEntryDtoImpl implements _HomeTimetableEntryDto {
  const _$HomeTimetableEntryDtoImpl({
    required this.id,
    this.subjectName,
    this.professor,
    required this.startTime,
    required this.endTime,
    this.place,
    this.color,
  });

  factory _$HomeTimetableEntryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeTimetableEntryDtoImplFromJson(json);

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
    return 'HomeTimetableEntryDto(id: $id, subjectName: $subjectName, professor: $professor, startTime: $startTime, endTime: $endTime, place: $place, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeTimetableEntryDtoImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of HomeTimetableEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeTimetableEntryDtoImplCopyWith<_$HomeTimetableEntryDtoImpl>
  get copyWith =>
      __$$HomeTimetableEntryDtoImplCopyWithImpl<_$HomeTimetableEntryDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeTimetableEntryDtoImplToJson(this);
  }
}

abstract class _HomeTimetableEntryDto implements HomeTimetableEntryDto {
  const factory _HomeTimetableEntryDto({
    required final int id,
    final String? subjectName,
    final String? professor,
    required final String startTime,
    required final String endTime,
    final String? place,
    final String? color,
  }) = _$HomeTimetableEntryDtoImpl;

  factory _HomeTimetableEntryDto.fromJson(Map<String, dynamic> json) =
      _$HomeTimetableEntryDtoImpl.fromJson;

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

  /// Create a copy of HomeTimetableEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeTimetableEntryDtoImplCopyWith<_$HomeTimetableEntryDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

TodayTimetableDto _$TodayTimetableDtoFromJson(Map<String, dynamic> json) {
  return _TodayTimetableDto.fromJson(json);
}

/// @nodoc
mixin _$TodayTimetableDto {
  int? get timetableId => throw _privateConstructorUsedError;
  HomeSemesterDto? get semester => throw _privateConstructorUsedError;
  List<HomeTimetableEntryDto> get entries => throw _privateConstructorUsedError;

  /// Serializes this TodayTimetableDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TodayTimetableDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodayTimetableDtoCopyWith<TodayTimetableDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodayTimetableDtoCopyWith<$Res> {
  factory $TodayTimetableDtoCopyWith(
    TodayTimetableDto value,
    $Res Function(TodayTimetableDto) then,
  ) = _$TodayTimetableDtoCopyWithImpl<$Res, TodayTimetableDto>;
  @useResult
  $Res call({
    int? timetableId,
    HomeSemesterDto? semester,
    List<HomeTimetableEntryDto> entries,
  });

  $HomeSemesterDtoCopyWith<$Res>? get semester;
}

/// @nodoc
class _$TodayTimetableDtoCopyWithImpl<$Res, $Val extends TodayTimetableDto>
    implements $TodayTimetableDtoCopyWith<$Res> {
  _$TodayTimetableDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodayTimetableDto
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
                      as HomeSemesterDto?,
            entries: null == entries
                ? _value.entries
                : entries // ignore: cast_nullable_to_non_nullable
                      as List<HomeTimetableEntryDto>,
          )
          as $Val,
    );
  }

  /// Create a copy of TodayTimetableDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HomeSemesterDtoCopyWith<$Res>? get semester {
    if (_value.semester == null) {
      return null;
    }

    return $HomeSemesterDtoCopyWith<$Res>(_value.semester!, (value) {
      return _then(_value.copyWith(semester: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TodayTimetableDtoImplCopyWith<$Res>
    implements $TodayTimetableDtoCopyWith<$Res> {
  factory _$$TodayTimetableDtoImplCopyWith(
    _$TodayTimetableDtoImpl value,
    $Res Function(_$TodayTimetableDtoImpl) then,
  ) = __$$TodayTimetableDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? timetableId,
    HomeSemesterDto? semester,
    List<HomeTimetableEntryDto> entries,
  });

  @override
  $HomeSemesterDtoCopyWith<$Res>? get semester;
}

/// @nodoc
class __$$TodayTimetableDtoImplCopyWithImpl<$Res>
    extends _$TodayTimetableDtoCopyWithImpl<$Res, _$TodayTimetableDtoImpl>
    implements _$$TodayTimetableDtoImplCopyWith<$Res> {
  __$$TodayTimetableDtoImplCopyWithImpl(
    _$TodayTimetableDtoImpl _value,
    $Res Function(_$TodayTimetableDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodayTimetableDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timetableId = freezed,
    Object? semester = freezed,
    Object? entries = null,
  }) {
    return _then(
      _$TodayTimetableDtoImpl(
        timetableId: freezed == timetableId
            ? _value.timetableId
            : timetableId // ignore: cast_nullable_to_non_nullable
                  as int?,
        semester: freezed == semester
            ? _value.semester
            : semester // ignore: cast_nullable_to_non_nullable
                  as HomeSemesterDto?,
        entries: null == entries
            ? _value._entries
            : entries // ignore: cast_nullable_to_non_nullable
                  as List<HomeTimetableEntryDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TodayTimetableDtoImpl implements _TodayTimetableDto {
  const _$TodayTimetableDtoImpl({
    this.timetableId,
    this.semester,
    final List<HomeTimetableEntryDto> entries = const [],
  }) : _entries = entries;

  factory _$TodayTimetableDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodayTimetableDtoImplFromJson(json);

  @override
  final int? timetableId;
  @override
  final HomeSemesterDto? semester;
  final List<HomeTimetableEntryDto> _entries;
  @override
  @JsonKey()
  List<HomeTimetableEntryDto> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  String toString() {
    return 'TodayTimetableDto(timetableId: $timetableId, semester: $semester, entries: $entries)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodayTimetableDtoImpl &&
            (identical(other.timetableId, timetableId) ||
                other.timetableId == timetableId) &&
            (identical(other.semester, semester) ||
                other.semester == semester) &&
            const DeepCollectionEquality().equals(other._entries, _entries));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    timetableId,
    semester,
    const DeepCollectionEquality().hash(_entries),
  );

  /// Create a copy of TodayTimetableDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodayTimetableDtoImplCopyWith<_$TodayTimetableDtoImpl> get copyWith =>
      __$$TodayTimetableDtoImplCopyWithImpl<_$TodayTimetableDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TodayTimetableDtoImplToJson(this);
  }
}

abstract class _TodayTimetableDto implements TodayTimetableDto {
  const factory _TodayTimetableDto({
    final int? timetableId,
    final HomeSemesterDto? semester,
    final List<HomeTimetableEntryDto> entries,
  }) = _$TodayTimetableDtoImpl;

  factory _TodayTimetableDto.fromJson(Map<String, dynamic> json) =
      _$TodayTimetableDtoImpl.fromJson;

  @override
  int? get timetableId;
  @override
  HomeSemesterDto? get semester;
  @override
  List<HomeTimetableEntryDto> get entries;

  /// Create a copy of TodayTimetableDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodayTimetableDtoImplCopyWith<_$TodayTimetableDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PopularTopPostDto _$PopularTopPostDtoFromJson(Map<String, dynamic> json) {
  return _PopularTopPostDto.fromJson(json);
}

/// @nodoc
mixin _$PopularTopPostDto {
  int get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  int get viewCount => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  int get commentCount => throw _privateConstructorUsedError;

  /// Serializes this PopularTopPostDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PopularTopPostDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PopularTopPostDtoCopyWith<PopularTopPostDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PopularTopPostDtoCopyWith<$Res> {
  factory $PopularTopPostDtoCopyWith(
    PopularTopPostDto value,
    $Res Function(PopularTopPostDto) then,
  ) = _$PopularTopPostDtoCopyWithImpl<$Res, PopularTopPostDto>;
  @useResult
  $Res call({
    int id,
    String? title,
    int viewCount,
    String createdAt,
    int likeCount,
    int commentCount,
  });
}

/// @nodoc
class _$PopularTopPostDtoCopyWithImpl<$Res, $Val extends PopularTopPostDto>
    implements $PopularTopPostDtoCopyWith<$Res> {
  _$PopularTopPostDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PopularTopPostDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? viewCount = null,
    Object? createdAt = null,
    Object? likeCount = null,
    Object? commentCount = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            viewCount: null == viewCount
                ? _value.viewCount
                : viewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            likeCount: null == likeCount
                ? _value.likeCount
                : likeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            commentCount: null == commentCount
                ? _value.commentCount
                : commentCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PopularTopPostDtoImplCopyWith<$Res>
    implements $PopularTopPostDtoCopyWith<$Res> {
  factory _$$PopularTopPostDtoImplCopyWith(
    _$PopularTopPostDtoImpl value,
    $Res Function(_$PopularTopPostDtoImpl) then,
  ) = __$$PopularTopPostDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String? title,
    int viewCount,
    String createdAt,
    int likeCount,
    int commentCount,
  });
}

/// @nodoc
class __$$PopularTopPostDtoImplCopyWithImpl<$Res>
    extends _$PopularTopPostDtoCopyWithImpl<$Res, _$PopularTopPostDtoImpl>
    implements _$$PopularTopPostDtoImplCopyWith<$Res> {
  __$$PopularTopPostDtoImplCopyWithImpl(
    _$PopularTopPostDtoImpl _value,
    $Res Function(_$PopularTopPostDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PopularTopPostDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? viewCount = null,
    Object? createdAt = null,
    Object? likeCount = null,
    Object? commentCount = null,
  }) {
    return _then(
      _$PopularTopPostDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        viewCount: null == viewCount
            ? _value.viewCount
            : viewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        likeCount: null == likeCount
            ? _value.likeCount
            : likeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        commentCount: null == commentCount
            ? _value.commentCount
            : commentCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PopularTopPostDtoImpl implements _PopularTopPostDto {
  const _$PopularTopPostDtoImpl({
    required this.id,
    this.title,
    required this.viewCount,
    required this.createdAt,
    required this.likeCount,
    required this.commentCount,
  });

  factory _$PopularTopPostDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PopularTopPostDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String? title;
  @override
  final int viewCount;
  @override
  final String createdAt;
  @override
  final int likeCount;
  @override
  final int commentCount;

  @override
  String toString() {
    return 'PopularTopPostDto(id: $id, title: $title, viewCount: $viewCount, createdAt: $createdAt, likeCount: $likeCount, commentCount: $commentCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PopularTopPostDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    viewCount,
    createdAt,
    likeCount,
    commentCount,
  );

  /// Create a copy of PopularTopPostDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PopularTopPostDtoImplCopyWith<_$PopularTopPostDtoImpl> get copyWith =>
      __$$PopularTopPostDtoImplCopyWithImpl<_$PopularTopPostDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PopularTopPostDtoImplToJson(this);
  }
}

abstract class _PopularTopPostDto implements PopularTopPostDto {
  const factory _PopularTopPostDto({
    required final int id,
    final String? title,
    required final int viewCount,
    required final String createdAt,
    required final int likeCount,
    required final int commentCount,
  }) = _$PopularTopPostDtoImpl;

  factory _PopularTopPostDto.fromJson(Map<String, dynamic> json) =
      _$PopularTopPostDtoImpl.fromJson;

  @override
  int get id;
  @override
  String? get title;
  @override
  int get viewCount;
  @override
  String get createdAt;
  @override
  int get likeCount;
  @override
  int get commentCount;

  /// Create a copy of PopularTopPostDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PopularTopPostDtoImplCopyWith<_$PopularTopPostDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PopularBoardItemDto _$PopularBoardItemDtoFromJson(Map<String, dynamic> json) {
  return _PopularBoardItemDto.fromJson(json);
}

/// @nodoc
mixin _$PopularBoardItemDto {
  int get boardId => throw _privateConstructorUsedError;
  String get boardName => throw _privateConstructorUsedError;
  String? get boardSlug => throw _privateConstructorUsedError;
  String get boardType => throw _privateConstructorUsedError;
  int get postCount => throw _privateConstructorUsedError;
  PopularTopPostDto? get topPost => throw _privateConstructorUsedError;

  /// Serializes this PopularBoardItemDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PopularBoardItemDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PopularBoardItemDtoCopyWith<PopularBoardItemDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PopularBoardItemDtoCopyWith<$Res> {
  factory $PopularBoardItemDtoCopyWith(
    PopularBoardItemDto value,
    $Res Function(PopularBoardItemDto) then,
  ) = _$PopularBoardItemDtoCopyWithImpl<$Res, PopularBoardItemDto>;
  @useResult
  $Res call({
    int boardId,
    String boardName,
    String? boardSlug,
    String boardType,
    int postCount,
    PopularTopPostDto? topPost,
  });

  $PopularTopPostDtoCopyWith<$Res>? get topPost;
}

/// @nodoc
class _$PopularBoardItemDtoCopyWithImpl<$Res, $Val extends PopularBoardItemDto>
    implements $PopularBoardItemDtoCopyWith<$Res> {
  _$PopularBoardItemDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PopularBoardItemDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? boardId = null,
    Object? boardName = null,
    Object? boardSlug = freezed,
    Object? boardType = null,
    Object? postCount = null,
    Object? topPost = freezed,
  }) {
    return _then(
      _value.copyWith(
            boardId: null == boardId
                ? _value.boardId
                : boardId // ignore: cast_nullable_to_non_nullable
                      as int,
            boardName: null == boardName
                ? _value.boardName
                : boardName // ignore: cast_nullable_to_non_nullable
                      as String,
            boardSlug: freezed == boardSlug
                ? _value.boardSlug
                : boardSlug // ignore: cast_nullable_to_non_nullable
                      as String?,
            boardType: null == boardType
                ? _value.boardType
                : boardType // ignore: cast_nullable_to_non_nullable
                      as String,
            postCount: null == postCount
                ? _value.postCount
                : postCount // ignore: cast_nullable_to_non_nullable
                      as int,
            topPost: freezed == topPost
                ? _value.topPost
                : topPost // ignore: cast_nullable_to_non_nullable
                      as PopularTopPostDto?,
          )
          as $Val,
    );
  }

  /// Create a copy of PopularBoardItemDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PopularTopPostDtoCopyWith<$Res>? get topPost {
    if (_value.topPost == null) {
      return null;
    }

    return $PopularTopPostDtoCopyWith<$Res>(_value.topPost!, (value) {
      return _then(_value.copyWith(topPost: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PopularBoardItemDtoImplCopyWith<$Res>
    implements $PopularBoardItemDtoCopyWith<$Res> {
  factory _$$PopularBoardItemDtoImplCopyWith(
    _$PopularBoardItemDtoImpl value,
    $Res Function(_$PopularBoardItemDtoImpl) then,
  ) = __$$PopularBoardItemDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int boardId,
    String boardName,
    String? boardSlug,
    String boardType,
    int postCount,
    PopularTopPostDto? topPost,
  });

  @override
  $PopularTopPostDtoCopyWith<$Res>? get topPost;
}

/// @nodoc
class __$$PopularBoardItemDtoImplCopyWithImpl<$Res>
    extends _$PopularBoardItemDtoCopyWithImpl<$Res, _$PopularBoardItemDtoImpl>
    implements _$$PopularBoardItemDtoImplCopyWith<$Res> {
  __$$PopularBoardItemDtoImplCopyWithImpl(
    _$PopularBoardItemDtoImpl _value,
    $Res Function(_$PopularBoardItemDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PopularBoardItemDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? boardId = null,
    Object? boardName = null,
    Object? boardSlug = freezed,
    Object? boardType = null,
    Object? postCount = null,
    Object? topPost = freezed,
  }) {
    return _then(
      _$PopularBoardItemDtoImpl(
        boardId: null == boardId
            ? _value.boardId
            : boardId // ignore: cast_nullable_to_non_nullable
                  as int,
        boardName: null == boardName
            ? _value.boardName
            : boardName // ignore: cast_nullable_to_non_nullable
                  as String,
        boardSlug: freezed == boardSlug
            ? _value.boardSlug
            : boardSlug // ignore: cast_nullable_to_non_nullable
                  as String?,
        boardType: null == boardType
            ? _value.boardType
            : boardType // ignore: cast_nullable_to_non_nullable
                  as String,
        postCount: null == postCount
            ? _value.postCount
            : postCount // ignore: cast_nullable_to_non_nullable
                  as int,
        topPost: freezed == topPost
            ? _value.topPost
            : topPost // ignore: cast_nullable_to_non_nullable
                  as PopularTopPostDto?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PopularBoardItemDtoImpl implements _PopularBoardItemDto {
  const _$PopularBoardItemDtoImpl({
    required this.boardId,
    required this.boardName,
    this.boardSlug,
    required this.boardType,
    required this.postCount,
    this.topPost,
  });

  factory _$PopularBoardItemDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PopularBoardItemDtoImplFromJson(json);

  @override
  final int boardId;
  @override
  final String boardName;
  @override
  final String? boardSlug;
  @override
  final String boardType;
  @override
  final int postCount;
  @override
  final PopularTopPostDto? topPost;

  @override
  String toString() {
    return 'PopularBoardItemDto(boardId: $boardId, boardName: $boardName, boardSlug: $boardSlug, boardType: $boardType, postCount: $postCount, topPost: $topPost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PopularBoardItemDtoImpl &&
            (identical(other.boardId, boardId) || other.boardId == boardId) &&
            (identical(other.boardName, boardName) ||
                other.boardName == boardName) &&
            (identical(other.boardSlug, boardSlug) ||
                other.boardSlug == boardSlug) &&
            (identical(other.boardType, boardType) ||
                other.boardType == boardType) &&
            (identical(other.postCount, postCount) ||
                other.postCount == postCount) &&
            (identical(other.topPost, topPost) || other.topPost == topPost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    boardId,
    boardName,
    boardSlug,
    boardType,
    postCount,
    topPost,
  );

  /// Create a copy of PopularBoardItemDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PopularBoardItemDtoImplCopyWith<_$PopularBoardItemDtoImpl> get copyWith =>
      __$$PopularBoardItemDtoImplCopyWithImpl<_$PopularBoardItemDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PopularBoardItemDtoImplToJson(this);
  }
}

abstract class _PopularBoardItemDto implements PopularBoardItemDto {
  const factory _PopularBoardItemDto({
    required final int boardId,
    required final String boardName,
    final String? boardSlug,
    required final String boardType,
    required final int postCount,
    final PopularTopPostDto? topPost,
  }) = _$PopularBoardItemDtoImpl;

  factory _PopularBoardItemDto.fromJson(Map<String, dynamic> json) =
      _$PopularBoardItemDtoImpl.fromJson;

  @override
  int get boardId;
  @override
  String get boardName;
  @override
  String? get boardSlug;
  @override
  String get boardType;
  @override
  int get postCount;
  @override
  PopularTopPostDto? get topPost;

  /// Create a copy of PopularBoardItemDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PopularBoardItemDtoImplCopyWith<_$PopularBoardItemDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HomeDashboardDto _$HomeDashboardDtoFromJson(Map<String, dynamic> json) {
  return _HomeDashboardDto.fromJson(json);
}

/// @nodoc
mixin _$HomeDashboardDto {
  String get weekday => throw _privateConstructorUsedError;
  List<HomeNoticeDto> get notices => throw _privateConstructorUsedError;
  TodayTimetableDto get todayTimetable => throw _privateConstructorUsedError;
  List<PopularBoardItemDto> get popularBoards =>
      throw _privateConstructorUsedError;

  /// Serializes this HomeDashboardDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeDashboardDtoCopyWith<HomeDashboardDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeDashboardDtoCopyWith<$Res> {
  factory $HomeDashboardDtoCopyWith(
    HomeDashboardDto value,
    $Res Function(HomeDashboardDto) then,
  ) = _$HomeDashboardDtoCopyWithImpl<$Res, HomeDashboardDto>;
  @useResult
  $Res call({
    String weekday,
    List<HomeNoticeDto> notices,
    TodayTimetableDto todayTimetable,
    List<PopularBoardItemDto> popularBoards,
  });

  $TodayTimetableDtoCopyWith<$Res> get todayTimetable;
}

/// @nodoc
class _$HomeDashboardDtoCopyWithImpl<$Res, $Val extends HomeDashboardDto>
    implements $HomeDashboardDtoCopyWith<$Res> {
  _$HomeDashboardDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekday = null,
    Object? notices = null,
    Object? todayTimetable = null,
    Object? popularBoards = null,
  }) {
    return _then(
      _value.copyWith(
            weekday: null == weekday
                ? _value.weekday
                : weekday // ignore: cast_nullable_to_non_nullable
                      as String,
            notices: null == notices
                ? _value.notices
                : notices // ignore: cast_nullable_to_non_nullable
                      as List<HomeNoticeDto>,
            todayTimetable: null == todayTimetable
                ? _value.todayTimetable
                : todayTimetable // ignore: cast_nullable_to_non_nullable
                      as TodayTimetableDto,
            popularBoards: null == popularBoards
                ? _value.popularBoards
                : popularBoards // ignore: cast_nullable_to_non_nullable
                      as List<PopularBoardItemDto>,
          )
          as $Val,
    );
  }

  /// Create a copy of HomeDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TodayTimetableDtoCopyWith<$Res> get todayTimetable {
    return $TodayTimetableDtoCopyWith<$Res>(_value.todayTimetable, (value) {
      return _then(_value.copyWith(todayTimetable: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeDashboardDtoImplCopyWith<$Res>
    implements $HomeDashboardDtoCopyWith<$Res> {
  factory _$$HomeDashboardDtoImplCopyWith(
    _$HomeDashboardDtoImpl value,
    $Res Function(_$HomeDashboardDtoImpl) then,
  ) = __$$HomeDashboardDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String weekday,
    List<HomeNoticeDto> notices,
    TodayTimetableDto todayTimetable,
    List<PopularBoardItemDto> popularBoards,
  });

  @override
  $TodayTimetableDtoCopyWith<$Res> get todayTimetable;
}

/// @nodoc
class __$$HomeDashboardDtoImplCopyWithImpl<$Res>
    extends _$HomeDashboardDtoCopyWithImpl<$Res, _$HomeDashboardDtoImpl>
    implements _$$HomeDashboardDtoImplCopyWith<$Res> {
  __$$HomeDashboardDtoImplCopyWithImpl(
    _$HomeDashboardDtoImpl _value,
    $Res Function(_$HomeDashboardDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekday = null,
    Object? notices = null,
    Object? todayTimetable = null,
    Object? popularBoards = null,
  }) {
    return _then(
      _$HomeDashboardDtoImpl(
        weekday: null == weekday
            ? _value.weekday
            : weekday // ignore: cast_nullable_to_non_nullable
                  as String,
        notices: null == notices
            ? _value._notices
            : notices // ignore: cast_nullable_to_non_nullable
                  as List<HomeNoticeDto>,
        todayTimetable: null == todayTimetable
            ? _value.todayTimetable
            : todayTimetable // ignore: cast_nullable_to_non_nullable
                  as TodayTimetableDto,
        popularBoards: null == popularBoards
            ? _value._popularBoards
            : popularBoards // ignore: cast_nullable_to_non_nullable
                  as List<PopularBoardItemDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeDashboardDtoImpl implements _HomeDashboardDto {
  const _$HomeDashboardDtoImpl({
    required this.weekday,
    final List<HomeNoticeDto> notices = const [],
    required this.todayTimetable,
    final List<PopularBoardItemDto> popularBoards = const [],
  }) : _notices = notices,
       _popularBoards = popularBoards;

  factory _$HomeDashboardDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeDashboardDtoImplFromJson(json);

  @override
  final String weekday;
  final List<HomeNoticeDto> _notices;
  @override
  @JsonKey()
  List<HomeNoticeDto> get notices {
    if (_notices is EqualUnmodifiableListView) return _notices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notices);
  }

  @override
  final TodayTimetableDto todayTimetable;
  final List<PopularBoardItemDto> _popularBoards;
  @override
  @JsonKey()
  List<PopularBoardItemDto> get popularBoards {
    if (_popularBoards is EqualUnmodifiableListView) return _popularBoards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_popularBoards);
  }

  @override
  String toString() {
    return 'HomeDashboardDto(weekday: $weekday, notices: $notices, todayTimetable: $todayTimetable, popularBoards: $popularBoards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeDashboardDtoImpl &&
            (identical(other.weekday, weekday) || other.weekday == weekday) &&
            const DeepCollectionEquality().equals(other._notices, _notices) &&
            (identical(other.todayTimetable, todayTimetable) ||
                other.todayTimetable == todayTimetable) &&
            const DeepCollectionEquality().equals(
              other._popularBoards,
              _popularBoards,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    weekday,
    const DeepCollectionEquality().hash(_notices),
    todayTimetable,
    const DeepCollectionEquality().hash(_popularBoards),
  );

  /// Create a copy of HomeDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeDashboardDtoImplCopyWith<_$HomeDashboardDtoImpl> get copyWith =>
      __$$HomeDashboardDtoImplCopyWithImpl<_$HomeDashboardDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeDashboardDtoImplToJson(this);
  }
}

abstract class _HomeDashboardDto implements HomeDashboardDto {
  const factory _HomeDashboardDto({
    required final String weekday,
    final List<HomeNoticeDto> notices,
    required final TodayTimetableDto todayTimetable,
    final List<PopularBoardItemDto> popularBoards,
  }) = _$HomeDashboardDtoImpl;

  factory _HomeDashboardDto.fromJson(Map<String, dynamic> json) =
      _$HomeDashboardDtoImpl.fromJson;

  @override
  String get weekday;
  @override
  List<HomeNoticeDto> get notices;
  @override
  TodayTimetableDto get todayTimetable;
  @override
  List<PopularBoardItemDto> get popularBoards;

  /// Create a copy of HomeDashboardDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeDashboardDtoImplCopyWith<_$HomeDashboardDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
