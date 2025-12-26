import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_settings.dart';

part 'user_settings_dto.freezed.dart';
part 'user_settings_dto.g.dart';

/// DTO for UserSettings entity - handles API serialization/deserialization
@freezed
class UserSettingsDto with _$UserSettingsDto {
  const factory UserSettingsDto({
    required String id,
    required String userId,
    @Default(true) bool enablePushNotifications,
    @Default(true) bool enableEmailNotifications,
    @Default(true) bool enableBoardNotifications,
    @Default(true) bool enableChatNotifications,
    @Default(true) bool enableTimetableNotifications,
    @Default(false) bool enableSoundNotifications,
    @Default(true) bool allowFriendRequests,
    @Default(true) bool showOnlineStatus,
    @Default(false) bool allowMessageRequests,
    @Default(true) bool showProfileToStrangers,
    @Default('system') String themeMode,
    @Default('en') String language,
    @Default('uz') String region,
    @Default(7) int timetableReminderHours,
    @Default(true) bool showWeekendsInTimetable,
    @Default(true) bool highlightCurrentDay,
    @Default(['free', 'question']) List<String> defaultBoardCategories,
    @Default(true) bool autoLoadNewPosts,
    @Default(false) bool hideAnonymousPosts,
    @Default(true) bool showReadReceipts,
    @Default(true) bool showTypingIndicators,
    @Default(30) int messageHistoryDays,
    @Default(false) bool twoFactorEnabled,
    @Default(true) bool emailVerificationEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserSettingsDto;

  const UserSettingsDto._();

  factory UserSettingsDto.fromJson(Map<String, dynamic> json) => _$UserSettingsDtoFromJson(json);

  /// Convert DTO to domain entity
  UserSettings toDomain() {
    return UserSettings(
      id: id,
      userId: userId,
      enablePushNotifications: enablePushNotifications,
      enableEmailNotifications: enableEmailNotifications,
      enableBoardNotifications: enableBoardNotifications,
      enableChatNotifications: enableChatNotifications,
      enableTimetableNotifications: enableTimetableNotifications,
      enableSoundNotifications: enableSoundNotifications,
      allowFriendRequests: allowFriendRequests,
      showOnlineStatus: showOnlineStatus,
      allowMessageRequests: allowMessageRequests,
      showProfileToStrangers: showProfileToStrangers,
      themeMode: _parseThemeMode(themeMode),
      language: language,
      region: region,
      timetableReminderHours: timetableReminderHours,
      showWeekendsInTimetable: showWeekendsInTimetable,
      highlightCurrentDay: highlightCurrentDay,
      defaultBoardCategories: defaultBoardCategories,
      autoLoadNewPosts: autoLoadNewPosts,
      hideAnonymousPosts: hideAnonymousPosts,
      showReadReceipts: showReadReceipts,
      showTypingIndicators: showTypingIndicators,
      messageHistoryDays: messageHistoryDays,
      twoFactorEnabled: twoFactorEnabled,
      emailVerificationEnabled: emailVerificationEnabled,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Convert domain entity to DTO
  static UserSettingsDto fromDomain(UserSettings settings) {
    return UserSettingsDto(
      id: settings.id,
      userId: settings.userId,
      enablePushNotifications: settings.enablePushNotifications,
      enableEmailNotifications: settings.enableEmailNotifications,
      enableBoardNotifications: settings.enableBoardNotifications,
      enableChatNotifications: settings.enableChatNotifications,
      enableTimetableNotifications: settings.enableTimetableNotifications,
      enableSoundNotifications: settings.enableSoundNotifications,
      allowFriendRequests: settings.allowFriendRequests,
      showOnlineStatus: settings.showOnlineStatus,
      allowMessageRequests: settings.allowMessageRequests,
      showProfileToStrangers: settings.showProfileToStrangers,
      themeMode: settings.themeMode.name,
      language: settings.language,
      region: settings.region,
      timetableReminderHours: settings.timetableReminderHours,
      showWeekendsInTimetable: settings.showWeekendsInTimetable,
      highlightCurrentDay: settings.highlightCurrentDay,
      defaultBoardCategories: settings.defaultBoardCategories,
      autoLoadNewPosts: settings.autoLoadNewPosts,
      hideAnonymousPosts: settings.hideAnonymousPosts,
      showReadReceipts: settings.showReadReceipts,
      showTypingIndicators: settings.showTypingIndicators,
      messageHistoryDays: settings.messageHistoryDays,
      twoFactorEnabled: settings.twoFactorEnabled,
      emailVerificationEnabled: settings.emailVerificationEnabled,
      createdAt: settings.createdAt,
      updatedAt: settings.updatedAt,
    );
  }

  /// Parse theme mode from string
  static AppThemeMode _parseThemeMode(String mode) {
    switch (mode.toLowerCase()) {
      case 'light':
        return AppThemeMode.light;
      case 'dark':
        return AppThemeMode.dark;
      case 'system':
      default:
        return AppThemeMode.system;
    }
  }
}

/// Settings response wrapper
@freezed
class UserSettingsResponseDto with _$UserSettingsResponseDto {
  const factory UserSettingsResponseDto({
    required bool success,
    required UserSettingsDto data,
    String? message,
    List<String>? errors,
  }) = _UserSettingsResponseDto;

  const UserSettingsResponseDto._();

  factory UserSettingsResponseDto.fromJson(Map<String, dynamic> json) => _$UserSettingsResponseDtoFromJson(json);
}
