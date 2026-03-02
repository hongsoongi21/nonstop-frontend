// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserSettingsDto _$UserSettingsDtoFromJson(Map<String, dynamic> json) {
  return _UserSettingsDto.fromJson(json);
}

/// @nodoc
mixin _$UserSettingsDto {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  bool get enablePushNotifications => throw _privateConstructorUsedError;
  bool get enableEmailNotifications => throw _privateConstructorUsedError;
  bool get enableBoardNotifications => throw _privateConstructorUsedError;
  bool get enableChatNotifications => throw _privateConstructorUsedError;
  bool get enableTimetableNotifications => throw _privateConstructorUsedError;
  bool get enableSoundNotifications => throw _privateConstructorUsedError;
  bool get allowFriendRequests => throw _privateConstructorUsedError;
  bool get showOnlineStatus => throw _privateConstructorUsedError;
  bool get allowMessageRequests => throw _privateConstructorUsedError;
  bool get showProfileToStrangers => throw _privateConstructorUsedError;
  String get themeMode => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  String get region => throw _privateConstructorUsedError;
  int get timetableReminderHours => throw _privateConstructorUsedError;
  bool get showWeekendsInTimetable => throw _privateConstructorUsedError;
  bool get highlightCurrentDay => throw _privateConstructorUsedError;
  List<String> get defaultBoardCategories => throw _privateConstructorUsedError;
  bool get autoLoadNewPosts => throw _privateConstructorUsedError;
  bool get hideAnonymousPosts => throw _privateConstructorUsedError;
  bool get showReadReceipts => throw _privateConstructorUsedError;
  bool get showTypingIndicators => throw _privateConstructorUsedError;
  int get messageHistoryDays => throw _privateConstructorUsedError;
  bool get twoFactorEnabled => throw _privateConstructorUsedError;
  bool get emailVerificationEnabled => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserSettingsDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSettingsDtoCopyWith<UserSettingsDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSettingsDtoCopyWith<$Res> {
  factory $UserSettingsDtoCopyWith(
    UserSettingsDto value,
    $Res Function(UserSettingsDto) then,
  ) = _$UserSettingsDtoCopyWithImpl<$Res, UserSettingsDto>;
  @useResult
  $Res call({
    String id,
    String userId,
    bool enablePushNotifications,
    bool enableEmailNotifications,
    bool enableBoardNotifications,
    bool enableChatNotifications,
    bool enableTimetableNotifications,
    bool enableSoundNotifications,
    bool allowFriendRequests,
    bool showOnlineStatus,
    bool allowMessageRequests,
    bool showProfileToStrangers,
    String themeMode,
    String language,
    String region,
    int timetableReminderHours,
    bool showWeekendsInTimetable,
    bool highlightCurrentDay,
    List<String> defaultBoardCategories,
    bool autoLoadNewPosts,
    bool hideAnonymousPosts,
    bool showReadReceipts,
    bool showTypingIndicators,
    int messageHistoryDays,
    bool twoFactorEnabled,
    bool emailVerificationEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$UserSettingsDtoCopyWithImpl<$Res, $Val extends UserSettingsDto>
    implements $UserSettingsDtoCopyWith<$Res> {
  _$UserSettingsDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? enablePushNotifications = null,
    Object? enableEmailNotifications = null,
    Object? enableBoardNotifications = null,
    Object? enableChatNotifications = null,
    Object? enableTimetableNotifications = null,
    Object? enableSoundNotifications = null,
    Object? allowFriendRequests = null,
    Object? showOnlineStatus = null,
    Object? allowMessageRequests = null,
    Object? showProfileToStrangers = null,
    Object? themeMode = null,
    Object? language = null,
    Object? region = null,
    Object? timetableReminderHours = null,
    Object? showWeekendsInTimetable = null,
    Object? highlightCurrentDay = null,
    Object? defaultBoardCategories = null,
    Object? autoLoadNewPosts = null,
    Object? hideAnonymousPosts = null,
    Object? showReadReceipts = null,
    Object? showTypingIndicators = null,
    Object? messageHistoryDays = null,
    Object? twoFactorEnabled = null,
    Object? emailVerificationEnabled = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            enablePushNotifications: null == enablePushNotifications
                ? _value.enablePushNotifications
                : enablePushNotifications // ignore: cast_nullable_to_non_nullable
                      as bool,
            enableEmailNotifications: null == enableEmailNotifications
                ? _value.enableEmailNotifications
                : enableEmailNotifications // ignore: cast_nullable_to_non_nullable
                      as bool,
            enableBoardNotifications: null == enableBoardNotifications
                ? _value.enableBoardNotifications
                : enableBoardNotifications // ignore: cast_nullable_to_non_nullable
                      as bool,
            enableChatNotifications: null == enableChatNotifications
                ? _value.enableChatNotifications
                : enableChatNotifications // ignore: cast_nullable_to_non_nullable
                      as bool,
            enableTimetableNotifications: null == enableTimetableNotifications
                ? _value.enableTimetableNotifications
                : enableTimetableNotifications // ignore: cast_nullable_to_non_nullable
                      as bool,
            enableSoundNotifications: null == enableSoundNotifications
                ? _value.enableSoundNotifications
                : enableSoundNotifications // ignore: cast_nullable_to_non_nullable
                      as bool,
            allowFriendRequests: null == allowFriendRequests
                ? _value.allowFriendRequests
                : allowFriendRequests // ignore: cast_nullable_to_non_nullable
                      as bool,
            showOnlineStatus: null == showOnlineStatus
                ? _value.showOnlineStatus
                : showOnlineStatus // ignore: cast_nullable_to_non_nullable
                      as bool,
            allowMessageRequests: null == allowMessageRequests
                ? _value.allowMessageRequests
                : allowMessageRequests // ignore: cast_nullable_to_non_nullable
                      as bool,
            showProfileToStrangers: null == showProfileToStrangers
                ? _value.showProfileToStrangers
                : showProfileToStrangers // ignore: cast_nullable_to_non_nullable
                      as bool,
            themeMode: null == themeMode
                ? _value.themeMode
                : themeMode // ignore: cast_nullable_to_non_nullable
                      as String,
            language: null == language
                ? _value.language
                : language // ignore: cast_nullable_to_non_nullable
                      as String,
            region: null == region
                ? _value.region
                : region // ignore: cast_nullable_to_non_nullable
                      as String,
            timetableReminderHours: null == timetableReminderHours
                ? _value.timetableReminderHours
                : timetableReminderHours // ignore: cast_nullable_to_non_nullable
                      as int,
            showWeekendsInTimetable: null == showWeekendsInTimetable
                ? _value.showWeekendsInTimetable
                : showWeekendsInTimetable // ignore: cast_nullable_to_non_nullable
                      as bool,
            highlightCurrentDay: null == highlightCurrentDay
                ? _value.highlightCurrentDay
                : highlightCurrentDay // ignore: cast_nullable_to_non_nullable
                      as bool,
            defaultBoardCategories: null == defaultBoardCategories
                ? _value.defaultBoardCategories
                : defaultBoardCategories // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            autoLoadNewPosts: null == autoLoadNewPosts
                ? _value.autoLoadNewPosts
                : autoLoadNewPosts // ignore: cast_nullable_to_non_nullable
                      as bool,
            hideAnonymousPosts: null == hideAnonymousPosts
                ? _value.hideAnonymousPosts
                : hideAnonymousPosts // ignore: cast_nullable_to_non_nullable
                      as bool,
            showReadReceipts: null == showReadReceipts
                ? _value.showReadReceipts
                : showReadReceipts // ignore: cast_nullable_to_non_nullable
                      as bool,
            showTypingIndicators: null == showTypingIndicators
                ? _value.showTypingIndicators
                : showTypingIndicators // ignore: cast_nullable_to_non_nullable
                      as bool,
            messageHistoryDays: null == messageHistoryDays
                ? _value.messageHistoryDays
                : messageHistoryDays // ignore: cast_nullable_to_non_nullable
                      as int,
            twoFactorEnabled: null == twoFactorEnabled
                ? _value.twoFactorEnabled
                : twoFactorEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            emailVerificationEnabled: null == emailVerificationEnabled
                ? _value.emailVerificationEnabled
                : emailVerificationEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserSettingsDtoImplCopyWith<$Res>
    implements $UserSettingsDtoCopyWith<$Res> {
  factory _$$UserSettingsDtoImplCopyWith(
    _$UserSettingsDtoImpl value,
    $Res Function(_$UserSettingsDtoImpl) then,
  ) = __$$UserSettingsDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    bool enablePushNotifications,
    bool enableEmailNotifications,
    bool enableBoardNotifications,
    bool enableChatNotifications,
    bool enableTimetableNotifications,
    bool enableSoundNotifications,
    bool allowFriendRequests,
    bool showOnlineStatus,
    bool allowMessageRequests,
    bool showProfileToStrangers,
    String themeMode,
    String language,
    String region,
    int timetableReminderHours,
    bool showWeekendsInTimetable,
    bool highlightCurrentDay,
    List<String> defaultBoardCategories,
    bool autoLoadNewPosts,
    bool hideAnonymousPosts,
    bool showReadReceipts,
    bool showTypingIndicators,
    int messageHistoryDays,
    bool twoFactorEnabled,
    bool emailVerificationEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$UserSettingsDtoImplCopyWithImpl<$Res>
    extends _$UserSettingsDtoCopyWithImpl<$Res, _$UserSettingsDtoImpl>
    implements _$$UserSettingsDtoImplCopyWith<$Res> {
  __$$UserSettingsDtoImplCopyWithImpl(
    _$UserSettingsDtoImpl _value,
    $Res Function(_$UserSettingsDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? enablePushNotifications = null,
    Object? enableEmailNotifications = null,
    Object? enableBoardNotifications = null,
    Object? enableChatNotifications = null,
    Object? enableTimetableNotifications = null,
    Object? enableSoundNotifications = null,
    Object? allowFriendRequests = null,
    Object? showOnlineStatus = null,
    Object? allowMessageRequests = null,
    Object? showProfileToStrangers = null,
    Object? themeMode = null,
    Object? language = null,
    Object? region = null,
    Object? timetableReminderHours = null,
    Object? showWeekendsInTimetable = null,
    Object? highlightCurrentDay = null,
    Object? defaultBoardCategories = null,
    Object? autoLoadNewPosts = null,
    Object? hideAnonymousPosts = null,
    Object? showReadReceipts = null,
    Object? showTypingIndicators = null,
    Object? messageHistoryDays = null,
    Object? twoFactorEnabled = null,
    Object? emailVerificationEnabled = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$UserSettingsDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        enablePushNotifications: null == enablePushNotifications
            ? _value.enablePushNotifications
            : enablePushNotifications // ignore: cast_nullable_to_non_nullable
                  as bool,
        enableEmailNotifications: null == enableEmailNotifications
            ? _value.enableEmailNotifications
            : enableEmailNotifications // ignore: cast_nullable_to_non_nullable
                  as bool,
        enableBoardNotifications: null == enableBoardNotifications
            ? _value.enableBoardNotifications
            : enableBoardNotifications // ignore: cast_nullable_to_non_nullable
                  as bool,
        enableChatNotifications: null == enableChatNotifications
            ? _value.enableChatNotifications
            : enableChatNotifications // ignore: cast_nullable_to_non_nullable
                  as bool,
        enableTimetableNotifications: null == enableTimetableNotifications
            ? _value.enableTimetableNotifications
            : enableTimetableNotifications // ignore: cast_nullable_to_non_nullable
                  as bool,
        enableSoundNotifications: null == enableSoundNotifications
            ? _value.enableSoundNotifications
            : enableSoundNotifications // ignore: cast_nullable_to_non_nullable
                  as bool,
        allowFriendRequests: null == allowFriendRequests
            ? _value.allowFriendRequests
            : allowFriendRequests // ignore: cast_nullable_to_non_nullable
                  as bool,
        showOnlineStatus: null == showOnlineStatus
            ? _value.showOnlineStatus
            : showOnlineStatus // ignore: cast_nullable_to_non_nullable
                  as bool,
        allowMessageRequests: null == allowMessageRequests
            ? _value.allowMessageRequests
            : allowMessageRequests // ignore: cast_nullable_to_non_nullable
                  as bool,
        showProfileToStrangers: null == showProfileToStrangers
            ? _value.showProfileToStrangers
            : showProfileToStrangers // ignore: cast_nullable_to_non_nullable
                  as bool,
        themeMode: null == themeMode
            ? _value.themeMode
            : themeMode // ignore: cast_nullable_to_non_nullable
                  as String,
        language: null == language
            ? _value.language
            : language // ignore: cast_nullable_to_non_nullable
                  as String,
        region: null == region
            ? _value.region
            : region // ignore: cast_nullable_to_non_nullable
                  as String,
        timetableReminderHours: null == timetableReminderHours
            ? _value.timetableReminderHours
            : timetableReminderHours // ignore: cast_nullable_to_non_nullable
                  as int,
        showWeekendsInTimetable: null == showWeekendsInTimetable
            ? _value.showWeekendsInTimetable
            : showWeekendsInTimetable // ignore: cast_nullable_to_non_nullable
                  as bool,
        highlightCurrentDay: null == highlightCurrentDay
            ? _value.highlightCurrentDay
            : highlightCurrentDay // ignore: cast_nullable_to_non_nullable
                  as bool,
        defaultBoardCategories: null == defaultBoardCategories
            ? _value._defaultBoardCategories
            : defaultBoardCategories // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        autoLoadNewPosts: null == autoLoadNewPosts
            ? _value.autoLoadNewPosts
            : autoLoadNewPosts // ignore: cast_nullable_to_non_nullable
                  as bool,
        hideAnonymousPosts: null == hideAnonymousPosts
            ? _value.hideAnonymousPosts
            : hideAnonymousPosts // ignore: cast_nullable_to_non_nullable
                  as bool,
        showReadReceipts: null == showReadReceipts
            ? _value.showReadReceipts
            : showReadReceipts // ignore: cast_nullable_to_non_nullable
                  as bool,
        showTypingIndicators: null == showTypingIndicators
            ? _value.showTypingIndicators
            : showTypingIndicators // ignore: cast_nullable_to_non_nullable
                  as bool,
        messageHistoryDays: null == messageHistoryDays
            ? _value.messageHistoryDays
            : messageHistoryDays // ignore: cast_nullable_to_non_nullable
                  as int,
        twoFactorEnabled: null == twoFactorEnabled
            ? _value.twoFactorEnabled
            : twoFactorEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        emailVerificationEnabled: null == emailVerificationEnabled
            ? _value.emailVerificationEnabled
            : emailVerificationEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSettingsDtoImpl extends _UserSettingsDto {
  const _$UserSettingsDtoImpl({
    required this.id,
    required this.userId,
    this.enablePushNotifications = true,
    this.enableEmailNotifications = true,
    this.enableBoardNotifications = true,
    this.enableChatNotifications = true,
    this.enableTimetableNotifications = true,
    this.enableSoundNotifications = false,
    this.allowFriendRequests = true,
    this.showOnlineStatus = true,
    this.allowMessageRequests = true,
    this.showProfileToStrangers = true,
    this.themeMode = 'system',
    this.language = 'en',
    this.region = 'uz',
    this.timetableReminderHours = 7,
    this.showWeekendsInTimetable = true,
    this.highlightCurrentDay = true,
    final List<String> defaultBoardCategories = const ['free', 'question'],
    this.autoLoadNewPosts = true,
    this.hideAnonymousPosts = false,
    this.showReadReceipts = true,
    this.showTypingIndicators = true,
    this.messageHistoryDays = 30,
    this.twoFactorEnabled = false,
    this.emailVerificationEnabled = true,
    this.createdAt,
    this.updatedAt,
  }) : _defaultBoardCategories = defaultBoardCategories,
       super._();

  factory _$UserSettingsDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSettingsDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  @JsonKey()
  final bool enablePushNotifications;
  @override
  @JsonKey()
  final bool enableEmailNotifications;
  @override
  @JsonKey()
  final bool enableBoardNotifications;
  @override
  @JsonKey()
  final bool enableChatNotifications;
  @override
  @JsonKey()
  final bool enableTimetableNotifications;
  @override
  @JsonKey()
  final bool enableSoundNotifications;
  @override
  @JsonKey()
  final bool allowFriendRequests;
  @override
  @JsonKey()
  final bool showOnlineStatus;
  @override
  @JsonKey()
  final bool allowMessageRequests;
  @override
  @JsonKey()
  final bool showProfileToStrangers;
  @override
  @JsonKey()
  final String themeMode;
  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey()
  final String region;
  @override
  @JsonKey()
  final int timetableReminderHours;
  @override
  @JsonKey()
  final bool showWeekendsInTimetable;
  @override
  @JsonKey()
  final bool highlightCurrentDay;
  final List<String> _defaultBoardCategories;
  @override
  @JsonKey()
  List<String> get defaultBoardCategories {
    if (_defaultBoardCategories is EqualUnmodifiableListView)
      return _defaultBoardCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_defaultBoardCategories);
  }

  @override
  @JsonKey()
  final bool autoLoadNewPosts;
  @override
  @JsonKey()
  final bool hideAnonymousPosts;
  @override
  @JsonKey()
  final bool showReadReceipts;
  @override
  @JsonKey()
  final bool showTypingIndicators;
  @override
  @JsonKey()
  final int messageHistoryDays;
  @override
  @JsonKey()
  final bool twoFactorEnabled;
  @override
  @JsonKey()
  final bool emailVerificationEnabled;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'UserSettingsDto(id: $id, userId: $userId, enablePushNotifications: $enablePushNotifications, enableEmailNotifications: $enableEmailNotifications, enableBoardNotifications: $enableBoardNotifications, enableChatNotifications: $enableChatNotifications, enableTimetableNotifications: $enableTimetableNotifications, enableSoundNotifications: $enableSoundNotifications, allowFriendRequests: $allowFriendRequests, showOnlineStatus: $showOnlineStatus, allowMessageRequests: $allowMessageRequests, showProfileToStrangers: $showProfileToStrangers, themeMode: $themeMode, language: $language, region: $region, timetableReminderHours: $timetableReminderHours, showWeekendsInTimetable: $showWeekendsInTimetable, highlightCurrentDay: $highlightCurrentDay, defaultBoardCategories: $defaultBoardCategories, autoLoadNewPosts: $autoLoadNewPosts, hideAnonymousPosts: $hideAnonymousPosts, showReadReceipts: $showReadReceipts, showTypingIndicators: $showTypingIndicators, messageHistoryDays: $messageHistoryDays, twoFactorEnabled: $twoFactorEnabled, emailVerificationEnabled: $emailVerificationEnabled, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSettingsDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(
                  other.enablePushNotifications,
                  enablePushNotifications,
                ) ||
                other.enablePushNotifications == enablePushNotifications) &&
            (identical(
                  other.enableEmailNotifications,
                  enableEmailNotifications,
                ) ||
                other.enableEmailNotifications == enableEmailNotifications) &&
            (identical(
                  other.enableBoardNotifications,
                  enableBoardNotifications,
                ) ||
                other.enableBoardNotifications == enableBoardNotifications) &&
            (identical(
                  other.enableChatNotifications,
                  enableChatNotifications,
                ) ||
                other.enableChatNotifications == enableChatNotifications) &&
            (identical(
                  other.enableTimetableNotifications,
                  enableTimetableNotifications,
                ) ||
                other.enableTimetableNotifications ==
                    enableTimetableNotifications) &&
            (identical(
                  other.enableSoundNotifications,
                  enableSoundNotifications,
                ) ||
                other.enableSoundNotifications == enableSoundNotifications) &&
            (identical(other.allowFriendRequests, allowFriendRequests) ||
                other.allowFriendRequests == allowFriendRequests) &&
            (identical(other.showOnlineStatus, showOnlineStatus) ||
                other.showOnlineStatus == showOnlineStatus) &&
            (identical(other.allowMessageRequests, allowMessageRequests) ||
                other.allowMessageRequests == allowMessageRequests) &&
            (identical(other.showProfileToStrangers, showProfileToStrangers) ||
                other.showProfileToStrangers == showProfileToStrangers) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.timetableReminderHours, timetableReminderHours) ||
                other.timetableReminderHours == timetableReminderHours) &&
            (identical(
                  other.showWeekendsInTimetable,
                  showWeekendsInTimetable,
                ) ||
                other.showWeekendsInTimetable == showWeekendsInTimetable) &&
            (identical(other.highlightCurrentDay, highlightCurrentDay) ||
                other.highlightCurrentDay == highlightCurrentDay) &&
            const DeepCollectionEquality().equals(
              other._defaultBoardCategories,
              _defaultBoardCategories,
            ) &&
            (identical(other.autoLoadNewPosts, autoLoadNewPosts) ||
                other.autoLoadNewPosts == autoLoadNewPosts) &&
            (identical(other.hideAnonymousPosts, hideAnonymousPosts) ||
                other.hideAnonymousPosts == hideAnonymousPosts) &&
            (identical(other.showReadReceipts, showReadReceipts) ||
                other.showReadReceipts == showReadReceipts) &&
            (identical(other.showTypingIndicators, showTypingIndicators) ||
                other.showTypingIndicators == showTypingIndicators) &&
            (identical(other.messageHistoryDays, messageHistoryDays) ||
                other.messageHistoryDays == messageHistoryDays) &&
            (identical(other.twoFactorEnabled, twoFactorEnabled) ||
                other.twoFactorEnabled == twoFactorEnabled) &&
            (identical(
                  other.emailVerificationEnabled,
                  emailVerificationEnabled,
                ) ||
                other.emailVerificationEnabled == emailVerificationEnabled) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    userId,
    enablePushNotifications,
    enableEmailNotifications,
    enableBoardNotifications,
    enableChatNotifications,
    enableTimetableNotifications,
    enableSoundNotifications,
    allowFriendRequests,
    showOnlineStatus,
    allowMessageRequests,
    showProfileToStrangers,
    themeMode,
    language,
    region,
    timetableReminderHours,
    showWeekendsInTimetable,
    highlightCurrentDay,
    const DeepCollectionEquality().hash(_defaultBoardCategories),
    autoLoadNewPosts,
    hideAnonymousPosts,
    showReadReceipts,
    showTypingIndicators,
    messageHistoryDays,
    twoFactorEnabled,
    emailVerificationEnabled,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of UserSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSettingsDtoImplCopyWith<_$UserSettingsDtoImpl> get copyWith =>
      __$$UserSettingsDtoImplCopyWithImpl<_$UserSettingsDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSettingsDtoImplToJson(this);
  }
}

abstract class _UserSettingsDto extends UserSettingsDto {
  const factory _UserSettingsDto({
    required final String id,
    required final String userId,
    final bool enablePushNotifications,
    final bool enableEmailNotifications,
    final bool enableBoardNotifications,
    final bool enableChatNotifications,
    final bool enableTimetableNotifications,
    final bool enableSoundNotifications,
    final bool allowFriendRequests,
    final bool showOnlineStatus,
    final bool allowMessageRequests,
    final bool showProfileToStrangers,
    final String themeMode,
    final String language,
    final String region,
    final int timetableReminderHours,
    final bool showWeekendsInTimetable,
    final bool highlightCurrentDay,
    final List<String> defaultBoardCategories,
    final bool autoLoadNewPosts,
    final bool hideAnonymousPosts,
    final bool showReadReceipts,
    final bool showTypingIndicators,
    final int messageHistoryDays,
    final bool twoFactorEnabled,
    final bool emailVerificationEnabled,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$UserSettingsDtoImpl;
  const _UserSettingsDto._() : super._();

  factory _UserSettingsDto.fromJson(Map<String, dynamic> json) =
      _$UserSettingsDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  bool get enablePushNotifications;
  @override
  bool get enableEmailNotifications;
  @override
  bool get enableBoardNotifications;
  @override
  bool get enableChatNotifications;
  @override
  bool get enableTimetableNotifications;
  @override
  bool get enableSoundNotifications;
  @override
  bool get allowFriendRequests;
  @override
  bool get showOnlineStatus;
  @override
  bool get allowMessageRequests;
  @override
  bool get showProfileToStrangers;
  @override
  String get themeMode;
  @override
  String get language;
  @override
  String get region;
  @override
  int get timetableReminderHours;
  @override
  bool get showWeekendsInTimetable;
  @override
  bool get highlightCurrentDay;
  @override
  List<String> get defaultBoardCategories;
  @override
  bool get autoLoadNewPosts;
  @override
  bool get hideAnonymousPosts;
  @override
  bool get showReadReceipts;
  @override
  bool get showTypingIndicators;
  @override
  int get messageHistoryDays;
  @override
  bool get twoFactorEnabled;
  @override
  bool get emailVerificationEnabled;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of UserSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSettingsDtoImplCopyWith<_$UserSettingsDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSettingsResponseDto _$UserSettingsResponseDtoFromJson(
  Map<String, dynamic> json,
) {
  return _UserSettingsResponseDto.fromJson(json);
}

/// @nodoc
mixin _$UserSettingsResponseDto {
  bool get success => throw _privateConstructorUsedError;
  UserSettingsDto get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<String>? get errors => throw _privateConstructorUsedError;

  /// Serializes this UserSettingsResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSettingsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSettingsResponseDtoCopyWith<UserSettingsResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSettingsResponseDtoCopyWith<$Res> {
  factory $UserSettingsResponseDtoCopyWith(
    UserSettingsResponseDto value,
    $Res Function(UserSettingsResponseDto) then,
  ) = _$UserSettingsResponseDtoCopyWithImpl<$Res, UserSettingsResponseDto>;
  @useResult
  $Res call({
    bool success,
    UserSettingsDto data,
    String? message,
    List<String>? errors,
  });

  $UserSettingsDtoCopyWith<$Res> get data;
}

/// @nodoc
class _$UserSettingsResponseDtoCopyWithImpl<
  $Res,
  $Val extends UserSettingsResponseDto
>
    implements $UserSettingsResponseDtoCopyWith<$Res> {
  _$UserSettingsResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSettingsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? message = freezed,
    Object? errors = freezed,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as UserSettingsDto,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            errors: freezed == errors
                ? _value.errors
                : errors // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
          )
          as $Val,
    );
  }

  /// Create a copy of UserSettingsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSettingsDtoCopyWith<$Res> get data {
    return $UserSettingsDtoCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserSettingsResponseDtoImplCopyWith<$Res>
    implements $UserSettingsResponseDtoCopyWith<$Res> {
  factory _$$UserSettingsResponseDtoImplCopyWith(
    _$UserSettingsResponseDtoImpl value,
    $Res Function(_$UserSettingsResponseDtoImpl) then,
  ) = __$$UserSettingsResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    UserSettingsDto data,
    String? message,
    List<String>? errors,
  });

  @override
  $UserSettingsDtoCopyWith<$Res> get data;
}

/// @nodoc
class __$$UserSettingsResponseDtoImplCopyWithImpl<$Res>
    extends
        _$UserSettingsResponseDtoCopyWithImpl<
          $Res,
          _$UserSettingsResponseDtoImpl
        >
    implements _$$UserSettingsResponseDtoImplCopyWith<$Res> {
  __$$UserSettingsResponseDtoImplCopyWithImpl(
    _$UserSettingsResponseDtoImpl _value,
    $Res Function(_$UserSettingsResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSettingsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? message = freezed,
    Object? errors = freezed,
  }) {
    return _then(
      _$UserSettingsResponseDtoImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as UserSettingsDto,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        errors: freezed == errors
            ? _value._errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSettingsResponseDtoImpl extends _UserSettingsResponseDto {
  const _$UserSettingsResponseDtoImpl({
    required this.success,
    required this.data,
    this.message,
    final List<String>? errors,
  }) : _errors = errors,
       super._();

  factory _$UserSettingsResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSettingsResponseDtoImplFromJson(json);

  @override
  final bool success;
  @override
  final UserSettingsDto data;
  @override
  final String? message;
  final List<String>? _errors;
  @override
  List<String>? get errors {
    final value = _errors;
    if (value == null) return null;
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UserSettingsResponseDto(success: $success, data: $data, message: $message, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSettingsResponseDtoImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    data,
    message,
    const DeepCollectionEquality().hash(_errors),
  );

  /// Create a copy of UserSettingsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSettingsResponseDtoImplCopyWith<_$UserSettingsResponseDtoImpl>
  get copyWith =>
      __$$UserSettingsResponseDtoImplCopyWithImpl<
        _$UserSettingsResponseDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSettingsResponseDtoImplToJson(this);
  }
}

abstract class _UserSettingsResponseDto extends UserSettingsResponseDto {
  const factory _UserSettingsResponseDto({
    required final bool success,
    required final UserSettingsDto data,
    final String? message,
    final List<String>? errors,
  }) = _$UserSettingsResponseDtoImpl;
  const _UserSettingsResponseDto._() : super._();

  factory _UserSettingsResponseDto.fromJson(Map<String, dynamic> json) =
      _$UserSettingsResponseDtoImpl.fromJson;

  @override
  bool get success;
  @override
  UserSettingsDto get data;
  @override
  String? get message;
  @override
  List<String>? get errors;

  /// Create a copy of UserSettingsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSettingsResponseDtoImplCopyWith<_$UserSettingsResponseDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
