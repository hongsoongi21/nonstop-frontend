// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_dashboard.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HomeDashboard {
  String get weekday => throw _privateConstructorUsedError;
  List<HomeNotice> get notices => throw _privateConstructorUsedError;
  TodayTimetable get todayTimetable => throw _privateConstructorUsedError;
  List<PopularBoardItem> get popularBoards =>
      throw _privateConstructorUsedError;

  /// Create a copy of HomeDashboard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeDashboardCopyWith<HomeDashboard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeDashboardCopyWith<$Res> {
  factory $HomeDashboardCopyWith(
    HomeDashboard value,
    $Res Function(HomeDashboard) then,
  ) = _$HomeDashboardCopyWithImpl<$Res, HomeDashboard>;
  @useResult
  $Res call({
    String weekday,
    List<HomeNotice> notices,
    TodayTimetable todayTimetable,
    List<PopularBoardItem> popularBoards,
  });

  $TodayTimetableCopyWith<$Res> get todayTimetable;
}

/// @nodoc
class _$HomeDashboardCopyWithImpl<$Res, $Val extends HomeDashboard>
    implements $HomeDashboardCopyWith<$Res> {
  _$HomeDashboardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeDashboard
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
                      as List<HomeNotice>,
            todayTimetable: null == todayTimetable
                ? _value.todayTimetable
                : todayTimetable // ignore: cast_nullable_to_non_nullable
                      as TodayTimetable,
            popularBoards: null == popularBoards
                ? _value.popularBoards
                : popularBoards // ignore: cast_nullable_to_non_nullable
                      as List<PopularBoardItem>,
          )
          as $Val,
    );
  }

  /// Create a copy of HomeDashboard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TodayTimetableCopyWith<$Res> get todayTimetable {
    return $TodayTimetableCopyWith<$Res>(_value.todayTimetable, (value) {
      return _then(_value.copyWith(todayTimetable: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeDashboardImplCopyWith<$Res>
    implements $HomeDashboardCopyWith<$Res> {
  factory _$$HomeDashboardImplCopyWith(
    _$HomeDashboardImpl value,
    $Res Function(_$HomeDashboardImpl) then,
  ) = __$$HomeDashboardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String weekday,
    List<HomeNotice> notices,
    TodayTimetable todayTimetable,
    List<PopularBoardItem> popularBoards,
  });

  @override
  $TodayTimetableCopyWith<$Res> get todayTimetable;
}

/// @nodoc
class __$$HomeDashboardImplCopyWithImpl<$Res>
    extends _$HomeDashboardCopyWithImpl<$Res, _$HomeDashboardImpl>
    implements _$$HomeDashboardImplCopyWith<$Res> {
  __$$HomeDashboardImplCopyWithImpl(
    _$HomeDashboardImpl _value,
    $Res Function(_$HomeDashboardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeDashboard
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
      _$HomeDashboardImpl(
        weekday: null == weekday
            ? _value.weekday
            : weekday // ignore: cast_nullable_to_non_nullable
                  as String,
        notices: null == notices
            ? _value._notices
            : notices // ignore: cast_nullable_to_non_nullable
                  as List<HomeNotice>,
        todayTimetable: null == todayTimetable
            ? _value.todayTimetable
            : todayTimetable // ignore: cast_nullable_to_non_nullable
                  as TodayTimetable,
        popularBoards: null == popularBoards
            ? _value._popularBoards
            : popularBoards // ignore: cast_nullable_to_non_nullable
                  as List<PopularBoardItem>,
      ),
    );
  }
}

/// @nodoc

class _$HomeDashboardImpl implements _HomeDashboard {
  const _$HomeDashboardImpl({
    required this.weekday,
    final List<HomeNotice> notices = const [],
    required this.todayTimetable,
    final List<PopularBoardItem> popularBoards = const [],
  }) : _notices = notices,
       _popularBoards = popularBoards;

  @override
  final String weekday;
  final List<HomeNotice> _notices;
  @override
  @JsonKey()
  List<HomeNotice> get notices {
    if (_notices is EqualUnmodifiableListView) return _notices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notices);
  }

  @override
  final TodayTimetable todayTimetable;
  final List<PopularBoardItem> _popularBoards;
  @override
  @JsonKey()
  List<PopularBoardItem> get popularBoards {
    if (_popularBoards is EqualUnmodifiableListView) return _popularBoards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_popularBoards);
  }

  @override
  String toString() {
    return 'HomeDashboard(weekday: $weekday, notices: $notices, todayTimetable: $todayTimetable, popularBoards: $popularBoards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeDashboardImpl &&
            (identical(other.weekday, weekday) || other.weekday == weekday) &&
            const DeepCollectionEquality().equals(other._notices, _notices) &&
            (identical(other.todayTimetable, todayTimetable) ||
                other.todayTimetable == todayTimetable) &&
            const DeepCollectionEquality().equals(
              other._popularBoards,
              _popularBoards,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    weekday,
    const DeepCollectionEquality().hash(_notices),
    todayTimetable,
    const DeepCollectionEquality().hash(_popularBoards),
  );

  /// Create a copy of HomeDashboard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeDashboardImplCopyWith<_$HomeDashboardImpl> get copyWith =>
      __$$HomeDashboardImplCopyWithImpl<_$HomeDashboardImpl>(this, _$identity);
}

abstract class _HomeDashboard implements HomeDashboard {
  const factory _HomeDashboard({
    required final String weekday,
    final List<HomeNotice> notices,
    required final TodayTimetable todayTimetable,
    final List<PopularBoardItem> popularBoards,
  }) = _$HomeDashboardImpl;

  @override
  String get weekday;
  @override
  List<HomeNotice> get notices;
  @override
  TodayTimetable get todayTimetable;
  @override
  List<PopularBoardItem> get popularBoards;

  /// Create a copy of HomeDashboard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeDashboardImplCopyWith<_$HomeDashboardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
