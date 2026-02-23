import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nonstop/core/errors/failures.dart';
import 'package:nonstop/core/supabase/supabase_provider.dart';
import 'package:nonstop/features/auth/presentation/providers/auth_provider.dart'
    show currentUserProvider, authProvider;
import 'package:nonstop/features/board/data/repositories/board_repository_impl.dart';
import 'package:nonstop/features/board/domain/entities/post.entity.dart';
import 'package:nonstop/features/board/presentation/providers/board_provider.dart';
import '../../data/api/profile_api.dart';
import '../../data/api/profile_api_impl.dart';
import '../../data/repository_impl/profile_repository_impl.dart';
import '../../domain/entities/profile_stats.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/user_settings.dart';
import '../../domain/repository/profile_repository.dart';
import '../../domain/usecases/get_profile_stats_usecase.dart';
import '../../domain/usecases/get_user_profile_usecase.dart';
import '../../domain/usecases/get_user_settings_usecase.dart';
import '../../domain/usecases/update_user_profile_usecase.dart';
import '../../domain/usecases/update_user_settings_usecase.dart';

/// State for the profile feature
class ProfileState {
  final bool isLoading;
  final String? error;
  final UserProfile? profile;
  final UserSettings? settings;
  final ProfileStats? stats;
  final bool isEditing;
  final bool isUploadingAvatar;
  final bool isUploadingCover;

  const ProfileState({
    this.isLoading = false,
    this.error,
    this.profile,
    this.settings,
    this.stats,
    this.isEditing = false,
    this.isUploadingAvatar = false,
    this.isUploadingCover = false,
  });

  ProfileState copyWith({
    bool? isLoading,
    String? error,
    UserProfile? profile,
    UserSettings? settings,
    ProfileStats? stats,
    bool? isEditing,
    bool? isUploadingAvatar,
    bool? isUploadingCover,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      profile: profile ?? this.profile,
      settings: settings ?? this.settings,
      stats: stats ?? this.stats,
      isEditing: isEditing ?? this.isEditing,
      isUploadingAvatar: isUploadingAvatar ?? this.isUploadingAvatar,
      isUploadingCover: isUploadingCover ?? this.isUploadingCover,
    );
  }

  /// Check if profile data is loaded
  bool get isLoaded => profile != null && settings != null;

  /// Check if user can edit profile
  bool get canEdit => profile != null;

  /// Get profile completion status
  int get profileCompletion => profile?.profileCompletionPercentage ?? 0;

  /// Check if profile is complete
  bool get isProfileComplete => profileCompletion >= 100;
}

/// Profile provider for managing profile state and operations
class ProfileNotifier extends StateNotifier<ProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;
  final UpdateUserProfileUseCase updateUserProfileUseCase;
  final GetUserSettingsUseCase getUserSettingsUseCase;
  final UpdateUserSettingsUseCase updateUserSettingsUseCase;
  final GetProfileStatsUseCase getProfileStatsUseCase;
  final ProfileRepository _repository;
  final Ref _ref;

  String get _currentUserId => _ref.read(currentUserProvider)?.id ?? '';

  ProfileNotifier({
    required this.getUserProfileUseCase,
    required this.updateUserProfileUseCase,
    required this.getUserSettingsUseCase,
    required this.updateUserSettingsUseCase,
    required this.getProfileStatsUseCase,
    required ProfileRepository repository,
    required Ref ref,
  }) : _repository = repository,
       _ref = ref,
       super(const ProfileState()) {
    loadProfile();
  }

  /// Load user profile and settings
  Future<void> loadProfile() async {
    state = state.copyWith(isLoading: true, error: null);

    // Load profile
    final profileResult = await getUserProfileUseCase(
      GetUserProfileParams(userId: _currentUserId),
    );

    // Load settings
    final settingsResult = await getUserSettingsUseCase(
      GetUserSettingsParams(userId: _currentUserId),
    );

    // Load stats
    final statsResult = await getProfileStatsUseCase(
      GetProfileStatsParams(userId: _currentUserId),
    );

    profileResult.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: _mapFailureToMessage(failure),
      ),
      (profile) {
        settingsResult.fold(
          (failure) => state = state.copyWith(
            isLoading: false,
            error: _mapFailureToMessage(failure),
            profile: profile,
          ),
          (settings) {
            statsResult.fold(
              (failure) => state = state.copyWith(
                isLoading: false,
                error: _mapFailureToMessage(failure),
                profile: profile,
                settings: settings,
              ),
              (stats) => state = state.copyWith(
                isLoading: false,
                profile: profile,
                settings: settings,
                stats: stats,
              ),
            );
          },
        );
      },
    );
  }

  /// Update user profile
  Future<bool> updateProfile(UserProfile updatedProfile) async {
    if (state.profile == null) return false;

    state = state.copyWith(isLoading: true, error: null);

    final result = await updateUserProfileUseCase(
      UpdateUserProfileParams(
        userId: _currentUserId,
        profile: updatedProfile,
      ),
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: _mapFailureToMessage(failure),
        );
        return false;
      },
      (profile) {
        // Update board posts if displayName changed
        final oldDisplayName = state.profile?.displayName;
        final newDisplayName = profile.displayName;
        if (oldDisplayName != null && newDisplayName != null && oldDisplayName != newDisplayName) {
          _ref.read(boardProvider.notifier).updateMyPostsNickname(newDisplayName);
        }

        // Update auth state if university changed
        final oldUniversityId = state.profile?.universityId;
        final newUniversityId = profile.universityId;
        if (oldUniversityId != newUniversityId) {
          final newUniIdInt = int.tryParse(newUniversityId ?? '');
          _ref.read(authProvider.notifier).updateUniversityId(newUniIdInt);
        }

        state = state.copyWith(
          isLoading: false,
          profile: profile,
        );
        return true;
      },
    );
  }

  /// Update user settings
  Future<bool> updateSettings(UserSettings updatedSettings) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await updateUserSettingsUseCase(
      UpdateUserSettingsParams(
        userId: _currentUserId,
        settings: updatedSettings,
      ),
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: _mapFailureToMessage(failure),
        );
        return false;
      },
      (settings) {
        state = state.copyWith(
          isLoading: false,
          settings: settings,
        );
        return true;
      },
    );
  }

  /// Update specific profile fields
  Future<bool> updateProfileFields({
    String? fullName,
    String? displayName,
    String? bio,
    String? location,
    String? website,
    String? major,
    String? linkedinUrl,
    String? githubUrl,
    String? instagramUrl,
    bool? isPublic,
    bool? showEmail,
    bool? showPhone,
    bool? showGpa,
  }) async {
    if (state.profile == null) return false;

    final updatedProfile = state.profile!.copyWithProfile(
      fullName: fullName,
      displayName: displayName,
      bio: bio,
      location: location,
      website: website,
      major: major,
      linkedinUrl: linkedinUrl,
      githubUrl: githubUrl,
      instagramUrl: instagramUrl,
      isPublic: isPublic,
      showEmail: showEmail,
      showPhone: showPhone,
      showGpa: showGpa,
    );

    return updateProfile(updatedProfile);
  }

  /// Update notification settings
  Future<bool> updateNotificationSettings({
    bool? push,
    bool? email,
    bool? board,
    bool? chat,
    bool? timetable,
    bool? sound,
  }) async {
    if (state.settings == null) return false;

    final updatedSettings = state.settings!.copyWithNotifications(
      push: push,
      email: email,
      board: board,
      chat: chat,
      timetable: timetable,
      sound: sound,
    );

    return updateSettings(updatedSettings);
  }

  /// Update privacy settings
  Future<bool> updatePrivacySettings({
    bool? friendRequests,
    bool? onlineStatus,
    bool? messageRequests,
    bool? profileVisibility,
  }) async {
    if (state.settings == null) return false;

    final updatedSettings = state.settings!.copyWithPrivacy(
      friendRequests: friendRequests,
      onlineStatus: onlineStatus,
      messageRequests: messageRequests,
      profileVisibility: profileVisibility,
    );

    return updateSettings(updatedSettings);
  }

  /// Update appearance settings
  Future<bool> updateAppearanceSettings({
    AppThemeMode? themeMode,
    String? language,
    String? region,
  }) async {
    if (state.settings == null) return false;

    final updatedSettings = state.settings!.copyWithAppearance(
      themeMode: themeMode,
      language: language,
      region: region,
    );

    return updateSettings(updatedSettings);
  }

  /// Set editing mode
  void setEditing(bool isEditing) {
    state = state.copyWith(isEditing: isEditing);
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Upload avatar image and update profile
  Future<bool> uploadAvatar(String imagePath) async {
    state = state.copyWith(isUploadingAvatar: true);

    final result = await _repository.uploadAvatar(
      userId: _currentUserId,
      imagePath: imagePath,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isUploadingAvatar: false,
          error: _mapFailureToMessage(failure),
        );
        return false;
      },
      (avatarUrl) {
        if (state.profile != null) {
          state = state.copyWith(
            isUploadingAvatar: false,
            profile: state.profile!.copyWith(avatarUrl: avatarUrl),
          );
        } else {
          state = state.copyWith(isUploadingAvatar: false);
        }
        return true;
      },
    );
  }

  /// Refresh profile data
  Future<void> refresh() async {
    await loadProfile();
  }

  /// Map failure to user-friendly message
  String _mapFailureToMessage(Failure failure) {
    return failure.when(
      network: (message, code) =>
          'Network connection failed. Please check your internet connection.',
      server: (message, statusCode, code) =>
          'Server error occurred. Please try again later.',
      validation: (message, errors) => message,
      authentication: (message, code) =>
          'Authentication failed. Please log in again.',
      authorization: (message, code) =>
          'You do not have permission to perform this action.',
      timeout: (message) => 'Request timed out. Please try again.',
      websocket: (message, code) =>
          'Connection error. Please check your internet connection.',
      cache: (message, code) => 'Cache error occurred.',
      storage: (message, code) => 'Storage error occurred.',
      unknown: (message, error, stackTrace) => message,
    );
  }
}

/// Profile API provider
final profileApiProvider = Provider<ProfileApi>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return ProfileApiImpl(supabaseClient);
});

/// Repository provider
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final api = ref.watch(profileApiProvider);
  return ProfileRepositoryImpl(api);
});

/// Use case providers
final getUserProfileUseCaseProvider = Provider<GetUserProfileUseCase>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return GetUserProfileUseCase(repository);
});

final updateUserProfileUseCaseProvider = Provider<UpdateUserProfileUseCase>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return UpdateUserProfileUseCase(repository);
});

final getUserSettingsUseCaseProvider = Provider<GetUserSettingsUseCase>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return GetUserSettingsUseCase(repository);
});

final updateUserSettingsUseCaseProvider = Provider<UpdateUserSettingsUseCase>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return UpdateUserSettingsUseCase(repository);
});

final getProfileStatsUseCaseProvider = Provider<GetProfileStatsUseCase>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return GetProfileStatsUseCase(repository);
});

/// Main profile provider
final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  final getUserProfileUseCase = ref.watch(getUserProfileUseCaseProvider);
  final updateUserProfileUseCase = ref.watch(updateUserProfileUseCaseProvider);
  final getUserSettingsUseCase = ref.watch(getUserSettingsUseCaseProvider);
  final updateUserSettingsUseCase = ref.watch(updateUserSettingsUseCaseProvider);
  final getProfileStatsUseCase = ref.watch(getProfileStatsUseCaseProvider);
  final repository = ref.watch(profileRepositoryProvider);

  return ProfileNotifier(
    getUserProfileUseCase: getUserProfileUseCase,
    updateUserProfileUseCase: updateUserProfileUseCase,
    getUserSettingsUseCase: getUserSettingsUseCase,
    updateUserSettingsUseCase: updateUserSettingsUseCase,
    getProfileStatsUseCase: getProfileStatsUseCase,
    repository: repository,
    ref: ref,
  );
});

/// Convenience providers for specific state slices
final profileLoadingProvider = Provider<bool>((ref) {
  return ref.watch(profileProvider).isLoading;
});

final profileErrorProvider = Provider<String?>((ref) {
  return ref.watch(profileProvider).error;
});

final userProfileProvider = Provider<UserProfile?>((ref) {
  return ref.watch(profileProvider).profile;
});

final userSettingsProvider = Provider<UserSettings?>((ref) {
  return ref.watch(profileProvider).settings;
});

final profileStatsProvider = Provider<ProfileStats?>((ref) {
  return ref.watch(profileProvider).stats;
});

final isProfileLoadedProvider = Provider<bool>((ref) {
  return ref.watch(profileProvider).isLoaded;
});

final isProfileEditingProvider = Provider<bool>((ref) {
  return ref.watch(profileProvider).isEditing;
});

final profileCompletionProvider = Provider<int>((ref) {
  return ref.watch(profileProvider).profileCompletion;
});

/// Provider for current user's posts
final myPostsProvider = FutureProvider<List<PostEntity>>((ref) async {
  final boardRepo = ref.watch(boardRepositoryProvider);
  final result = await boardRepo.getMyPosts(page: 1, size: 20);
  return result.fold(
    (error) => <PostEntity>[],
    (posts) => posts,
  );
});

/// Provider for tracking selected filter tab on profile screen
final profileFilterIndexProvider = StateProvider<int>((ref) => 0);

/// Provider for current user's comments
final myCommentsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final supabase = ref.read(supabaseClientProvider);
  final authUser = supabase.auth.currentUser;
  if (authUser == null) return [];

  // Get user's internal ID
  final userData = await supabase
      .from('users')
      .select('id')
      .eq('auth_id', authUser.id)
      .single();
  final userId = userData['id'] as int;

  // Fetch comments with post title for context
  final data = await supabase
      .from('comments')
      .select('id, content, created_at, post_id, posts(id, title)')
      .eq('user_id', userId)
      .isFilter('deleted_at', null)
      .order('created_at', ascending: false)
      .limit(20);

  return (data as List).cast<Map<String, dynamic>>();
});
