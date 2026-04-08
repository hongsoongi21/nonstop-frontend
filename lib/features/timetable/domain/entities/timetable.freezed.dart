// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timetable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Timetable {
  int get id => throw _privateConstructorUsedError;
  int get semesterId => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  SemesterType get semesterType => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  bool get isPublic => throw _privateConstructorUsedError;
  TimetableKind get kind => throw _privateConstructorUsedError;

  /// Create a copy of Timetable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimetableCopyWith<Timetable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimetableCopyWith<$Res> {
  factory $TimetableCopyWith(Timetable value, $Res Function(Timetable) then) =
      _$TimetableCopyWithImpl<$Res, Timetable>;
  @useResult
  $Res call({
    int id,
    int semesterId,
    int year,
    SemesterType semesterType,
    String? title,
    bool isPublic,
    TimetableKind kind,
  });
}

/// @nodoc
class _$TimetableCopyWithImpl<$Res, $Val extends Timetable>
    implements $TimetableCopyWith<$Res> {
  _$TimetableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Timetable
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
    Object? kind = null,
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
            kind: null == kind
                ? _value.kind
                : kind // ignore: cast_nullable_to_non_nullable
                      as TimetableKind,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TimetableImplCopyWith<$Res>
    implements $TimetableCopyWith<$Res> {
  factory _$$TimetableImplCopyWith(
    _$TimetableImpl value,
    $Res Function(_$TimetableImpl) then,
  ) = __$$TimetableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int semesterId,
    int year,
    SemesterType semesterType,
    String? title,
    bool isPublic,
    TimetableKind kind,
  });
}

/// @nodoc
class __$$TimetableImplCopyWithImpl<$Res>
    extends _$TimetableCopyWithImpl<$Res, _$TimetableImpl>
    implements _$$TimetableImplCopyWith<$Res> {
  __$$TimetableImplCopyWithImpl(
    _$TimetableImpl _value,
    $Res Function(_$TimetableImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Timetable
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
    Object? kind = null,
  }) {
    return _then(
      _$TimetableImpl(
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
        kind: null == kind
            ? _value.kind
            : kind // ignore: cast_nullable_to_non_nullable
                  as TimetableKind,
      ),
    );
  }
}

/// @nodoc

class _$TimetableImpl extends _Timetable {
  const _$TimetableImpl({
    required this.id,
    required this.semesterId,
    required this.year,
    required this.semesterType,
    this.title,
    required this.isPublic,
    required this.kind,
  }) : super._();

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
  final TimetableKind kind;

  @override
  String toString() {
    return 'Timetable(id: $id, semesterId: $semesterId, year: $year, semesterType: $semesterType, title: $title, isPublic: $isPublic, kind: $kind)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimetableImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.semesterId, semesterId) ||
                other.semesterId == semesterId) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.semesterType, semesterType) ||
                other.semesterType == semesterType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.kind, kind) || other.kind == kind));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    semesterId,
    year,
    semesterType,
    title,
    isPublic,
    kind,
  );

  /// Create a copy of Timetable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimetableImplCopyWith<_$TimetableImpl> get copyWith =>
      __$$TimetableImplCopyWithImpl<_$TimetableImpl>(this, _$identity);
}

abstract class _Timetable extends Timetable {
  const factory _Timetable({
    required final int id,
    required final int semesterId,
    required final int year,
    required final SemesterType semesterType,
    final String? title,
    required final bool isPublic,
    required final TimetableKind kind,
  }) = _$TimetableImpl;
  const _Timetable._() : super._();

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
  TimetableKind get kind;

  /// Create a copy of Timetable
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimetableImplCopyWith<_$TimetableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TimetableDetail {
  int get id => throw _privateConstructorUsedError;
  int get semesterId => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  SemesterType get semesterType => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  bool get isPublic => throw _privateConstructorUsedError;
  TimetableKind get kind => throw _privateConstructorUsedError;
  List<TimetableEntry> get entries => throw _privateConstructorUsedError;

  /// Create a copy of TimetableDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimetableDetailCopyWith<TimetableDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimetableDetailCopyWith<$Res> {
  factory $TimetableDetailCopyWith(
    TimetableDetail value,
    $Res Function(TimetableDetail) then,
  ) = _$TimetableDetailCopyWithImpl<$Res, TimetableDetail>;
  @useResult
  $Res call({
    int id,
    int semesterId,
    int year,
    SemesterType semesterType,
    String? title,
    bool isPublic,
    TimetableKind kind,
    List<TimetableEntry> entries,
  });
}

/// @nodoc
class _$TimetableDetailCopyWithImpl<$Res, $Val extends TimetableDetail>
    implements $TimetableDetailCopyWith<$Res> {
  _$TimetableDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimetableDetail
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
    Object? kind = null,
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
            kind: null == kind
                ? _value.kind
                : kind // ignore: cast_nullable_to_non_nullable
                      as TimetableKind,
            entries: null == entries
                ? _value.entries
                : entries // ignore: cast_nullable_to_non_nullable
                      as List<TimetableEntry>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TimetableDetailImplCopyWith<$Res>
    implements $TimetableDetailCopyWith<$Res> {
  factory _$$TimetableDetailImplCopyWith(
    _$TimetableDetailImpl value,
    $Res Function(_$TimetableDetailImpl) then,
  ) = __$$TimetableDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int semesterId,
    int year,
    SemesterType semesterType,
    String? title,
    bool isPublic,
    TimetableKind kind,
    List<TimetableEntry> entries,
  });
}

/// @nodoc
class __$$TimetableDetailImplCopyWithImpl<$Res>
    extends _$TimetableDetailCopyWithImpl<$Res, _$TimetableDetailImpl>
    implements _$$TimetableDetailImplCopyWith<$Res> {
  __$$TimetableDetailImplCopyWithImpl(
    _$TimetableDetailImpl _value,
    $Res Function(_$TimetableDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimetableDetail
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
    Object? kind = null,
    Object? entries = null,
  }) {
    return _then(
      _$TimetableDetailImpl(
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
        kind: null == kind
            ? _value.kind
            : kind // ignore: cast_nullable_to_non_nullable
                  as TimetableKind,
        entries: null == entries
            ? _value._entries
            : entries // ignore: cast_nullable_to_non_nullable
                  as List<TimetableEntry>,
      ),
    );
  }
}

/// @nodoc

class _$TimetableDetailImpl extends _TimetableDetail {
  const _$TimetableDetailImpl({
    required this.id,
    required this.semesterId,
    required this.year,
    required this.semesterType,
    this.title,
    required this.isPublic,
    required this.kind,
    required final List<TimetableEntry> entries,
  }) : _entries = entries,
       super._();

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
  final TimetableKind kind;
  final List<TimetableEntry> _entries;
  @override
  List<TimetableEntry> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  String toString() {
    return 'TimetableDetail(id: $id, semesterId: $semesterId, year: $year, semesterType: $semesterType, title: $title, isPublic: $isPublic, kind: $kind, entries: $entries)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimetableDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.semesterId, semesterId) ||
                other.semesterId == semesterId) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.semesterType, semesterType) ||
                other.semesterType == semesterType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            const DeepCollectionEquality().equals(other._entries, _entries));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    semesterId,
    year,
    semesterType,
    title,
    isPublic,
    kind,
    const DeepCollectionEquality().hash(_entries),
  );

  /// Create a copy of TimetableDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimetableDetailImplCopyWith<_$TimetableDetailImpl> get copyWith =>
      __$$TimetableDetailImplCopyWithImpl<_$TimetableDetailImpl>(
        this,
        _$identity,
      );
}

abstract class _TimetableDetail extends TimetableDetail {
  const factory _TimetableDetail({
    required final int id,
    required final int semesterId,
    required final int year,
    required final SemesterType semesterType,
    final String? title,
    required final bool isPublic,
    required final TimetableKind kind,
    required final List<TimetableEntry> entries,
  }) = _$TimetableDetailImpl;
  const _TimetableDetail._() : super._();

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
  TimetableKind get kind;
  @override
  List<TimetableEntry> get entries;

  /// Create a copy of TimetableDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimetableDetailImplCopyWith<_$TimetableDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
