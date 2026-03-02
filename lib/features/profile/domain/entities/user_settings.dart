import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_settings.freezed.dart';

/// User settings for app customization and preferences
@freezed
class UserSettings with _$UserSettings {
  const factory UserSettings({
    required String id,
    required String userId,

    // Notification settings
    @Default(true) bool enablePushNotifications,
    @Default(true) bool enableEmailNotifications,
    @Default(true) bool enableBoardNotifications,
    @Default(true) bool enableChatNotifications,
    @Default(true) bool enableTimetableNotifications,
    @Default(false) bool enableSoundNotifications,

    // Privacy settings
    @Default(true) bool allowFriendRequests,
    @Default(true) bool showOnlineStatus,
    @Default(true) bool allowMessageRequests,
    @Default(true) bool showProfileToStrangers,

    // Appearance settings
    @Default(AppThemeMode.system) AppThemeMode themeMode,
    @Default('en') String language,
    @Default('uz') String region,

    // Timetable settings
    @Default(7) int timetableReminderHours,
    @Default(true) bool showWeekendsInTimetable,
    @Default(true) bool highlightCurrentDay,

    // Board settings
    @Default(['free', 'question']) List<String> defaultBoardCategories,
    @Default(true) bool autoLoadNewPosts,
    @Default(false) bool hideAnonymousPosts,

    // Chat settings
    @Default(true) bool showReadReceipts,
    @Default(true) bool showTypingIndicators,
    @Default(30) int messageHistoryDays,

    // Account settings
    @Default(false) bool twoFactorEnabled,
    @Default(true) bool emailVerificationEnabled,

    // Timestamps
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserSettings;

  const UserSettings._();

  /// Create default settings for new users
  factory UserSettings.defaultSettings(String userId) {
    return UserSettings(
      id: 'settings_$userId',
      userId: userId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// Check if notifications are enabled for a specific feature
  bool isNotificationEnabled(String feature) {
    switch (feature.toLowerCase()) {
      case 'push':
        return enablePushNotifications;
      case 'email':
        return enableEmailNotifications;
      case 'board':
        return enableBoardNotifications;
      case 'chat':
        return enableChatNotifications;
      case 'timetable':
        return enableTimetableNotifications;
      default:
        return false;
    }
  }

  /// Get all notification settings as a map
  Map<String, bool> get notificationSettings {
    return {
      'push': enablePushNotifications,
      'email': enableEmailNotifications,
      'board': enableBoardNotifications,
      'chat': enableChatNotifications,
      'timetable': enableTimetableNotifications,
      'sound': enableSoundNotifications,
    };
  }

  /// Get all privacy settings as a map
  Map<String, bool> get privacySettings {
    return {
      'friendRequests': allowFriendRequests,
      'onlineStatus': showOnlineStatus,
      'messageRequests': allowMessageRequests,
      'profileVisibility': showProfileToStrangers,
    };
  }

  /// Update notification settings
  UserSettings copyWithNotifications({
    bool? push,
    bool? email,
    bool? board,
    bool? chat,
    bool? timetable,
    bool? sound,
  }) {
    return copyWith(
      enablePushNotifications: push ?? enablePushNotifications,
      enableEmailNotifications: email ?? enableEmailNotifications,
      enableBoardNotifications: board ?? enableBoardNotifications,
      enableChatNotifications: chat ?? enableChatNotifications,
      enableTimetableNotifications: timetable ?? enableTimetableNotifications,
      enableSoundNotifications: sound ?? enableSoundNotifications,
      updatedAt: DateTime.now(),
    );
  }

  /// Update privacy settings
  UserSettings copyWithPrivacy({
    bool? friendRequests,
    bool? onlineStatus,
    bool? messageRequests,
    bool? profileVisibility,
  }) {
    return copyWith(
      allowFriendRequests: friendRequests ?? allowFriendRequests,
      showOnlineStatus: onlineStatus ?? showOnlineStatus,
      allowMessageRequests: messageRequests ?? allowMessageRequests,
      showProfileToStrangers: profileVisibility ?? showProfileToStrangers,
      updatedAt: DateTime.now(),
    );
  }

  /// Update appearance settings
  UserSettings copyWithAppearance({
    AppThemeMode? themeMode,
    String? language,
    String? region,
  }) {
    return copyWith(
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
      region: region ?? this.region,
      updatedAt: DateTime.now(),
    );
  }
}

/// Supported theme modes
enum AppThemeMode {
  system,
  light,
  dark,
}

/// Supported languages
class SupportedLanguages {
  static const Map<String, String> languages = {
    'en': 'English',
    'uz': 'O\'zbek',
    'ru': 'Русский',
  };

  static const Map<String, String> regions = {
    'uz': 'Uzbekistan',
    'us': 'United States',
    'ru': 'Russia',
  };
}
