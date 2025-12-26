// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserSettingsDtoImpl _$$UserSettingsDtoImplFromJson(
  Map<String, dynamic> json,
) => _$UserSettingsDtoImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  enablePushNotifications: json['enablePushNotifications'] as bool? ?? true,
  enableEmailNotifications: json['enableEmailNotifications'] as bool? ?? true,
  enableBoardNotifications: json['enableBoardNotifications'] as bool? ?? true,
  enableChatNotifications: json['enableChatNotifications'] as bool? ?? true,
  enableTimetableNotifications:
      json['enableTimetableNotifications'] as bool? ?? true,
  enableSoundNotifications: json['enableSoundNotifications'] as bool? ?? false,
  allowFriendRequests: json['allowFriendRequests'] as bool? ?? true,
  showOnlineStatus: json['showOnlineStatus'] as bool? ?? true,
  allowMessageRequests: json['allowMessageRequests'] as bool? ?? false,
  showProfileToStrangers: json['showProfileToStrangers'] as bool? ?? true,
  themeMode: json['themeMode'] as String? ?? 'system',
  language: json['language'] as String? ?? 'en',
  region: json['region'] as String? ?? 'uz',
  timetableReminderHours:
      (json['timetableReminderHours'] as num?)?.toInt() ?? 7,
  showWeekendsInTimetable: json['showWeekendsInTimetable'] as bool? ?? true,
  highlightCurrentDay: json['highlightCurrentDay'] as bool? ?? true,
  defaultBoardCategories:
      (json['defaultBoardCategories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const ['free', 'question'],
  autoLoadNewPosts: json['autoLoadNewPosts'] as bool? ?? true,
  hideAnonymousPosts: json['hideAnonymousPosts'] as bool? ?? false,
  showReadReceipts: json['showReadReceipts'] as bool? ?? true,
  showTypingIndicators: json['showTypingIndicators'] as bool? ?? true,
  messageHistoryDays: (json['messageHistoryDays'] as num?)?.toInt() ?? 30,
  twoFactorEnabled: json['twoFactorEnabled'] as bool? ?? false,
  emailVerificationEnabled: json['emailVerificationEnabled'] as bool? ?? true,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$UserSettingsDtoImplToJson(
  _$UserSettingsDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'enablePushNotifications': instance.enablePushNotifications,
  'enableEmailNotifications': instance.enableEmailNotifications,
  'enableBoardNotifications': instance.enableBoardNotifications,
  'enableChatNotifications': instance.enableChatNotifications,
  'enableTimetableNotifications': instance.enableTimetableNotifications,
  'enableSoundNotifications': instance.enableSoundNotifications,
  'allowFriendRequests': instance.allowFriendRequests,
  'showOnlineStatus': instance.showOnlineStatus,
  'allowMessageRequests': instance.allowMessageRequests,
  'showProfileToStrangers': instance.showProfileToStrangers,
  'themeMode': instance.themeMode,
  'language': instance.language,
  'region': instance.region,
  'timetableReminderHours': instance.timetableReminderHours,
  'showWeekendsInTimetable': instance.showWeekendsInTimetable,
  'highlightCurrentDay': instance.highlightCurrentDay,
  'defaultBoardCategories': instance.defaultBoardCategories,
  'autoLoadNewPosts': instance.autoLoadNewPosts,
  'hideAnonymousPosts': instance.hideAnonymousPosts,
  'showReadReceipts': instance.showReadReceipts,
  'showTypingIndicators': instance.showTypingIndicators,
  'messageHistoryDays': instance.messageHistoryDays,
  'twoFactorEnabled': instance.twoFactorEnabled,
  'emailVerificationEnabled': instance.emailVerificationEnabled,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

_$UserSettingsResponseDtoImpl _$$UserSettingsResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$UserSettingsResponseDtoImpl(
  success: json['success'] as bool,
  data: UserSettingsDto.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String?,
  errors: (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$$UserSettingsResponseDtoImplToJson(
  _$UserSettingsResponseDtoImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'message': instance.message,
  'errors': instance.errors,
};
