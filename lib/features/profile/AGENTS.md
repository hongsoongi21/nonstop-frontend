<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-03-08 | Updated: 2026-03-08 -->

# profile

## Purpose
Manages the current user's extended profile — beyond the minimal `User` entity in `auth/` — including bio, cover image, avatar upload, social links (LinkedIn, GitHub, Instagram), academic info (major, year, GPA), and privacy controls. Also manages `UserSettings` (notification toggles, privacy toggles, theme/language preferences) and `ProfileStats` (post/comment/friend counts). On update, the notifier cross-notifies `boardProvider` when the display name changes and `authProvider` when the university ID changes. The settings screen delegates entirely to `profileProvider` for reading and writing `UserSettings`.

## Key Files
| File | Description |
|------|-------------|
| `presentation/providers/profile_provider.dart` | `ProfileNotifier` / `ProfileState` + all use-case and repository providers + `myPostsProvider`, `myCommentsProvider` |
| `presentation/screens/profile_screen.dart` | Profile view with stats, posts, comments filter tabs |
| `presentation/screens/edit_profile_screen.dart` | Profile editing form |
| `presentation/widgets/profile_header.dart` | Avatar, cover, display name header |
| `presentation/widgets/profile_stats.dart` | Post/comment/friend count chips |
| `presentation/widgets/profile_filter_tabs.dart` | Posts / Comments tab selector |
| `presentation/widgets/profile_post_card.dart` | Compact post card in profile view |
| `presentation/widgets/glass_container.dart` | Glassmorphism container widget |
| `domain/entities/user_profile.dart` | `UserProfile` with `profileCompletionPercentage`, `copyWithProfile()` |
| `domain/entities/user_settings.dart` | `UserSettings` with notification/privacy/appearance sub-settings |
| `domain/entities/profile_stats.dart` | `ProfileStats` entity |
| `domain/repository/profile_repository.dart` | Repository interface including `uploadAvatar` |
| `domain/usecases/` | 5 use cases: get/update profile, get/update settings, get stats |
| `data/api/profile_api_impl.dart` | Supabase implementation |
| `data/repository_impl/profile_repository_impl.dart` | Repository implementation |

## Subdirectories
| Directory | Purpose |
|-----------|---------|
| `data/` | API (impl + mock), 3 DTOs (UserProfile, UserSettings, ProfileStats), repository implementation |
| `domain/` | 3 entities, repository interface, 5 use cases |
| `presentation/` | 2 screens, 1 provider file, 5 widgets |

## For AI Agents

### Working In This Directory
- `profileProvider` auto-loads on construction (`loadProfile()`) — it loads profile, settings, and stats in parallel.
- Cross-feature side effects on `updateProfile()`: if `displayName` changes, calls `boardProvider.notifier.updateMyPostsNickname()`; if `universityId` changes, calls `authProvider.notifier.updateUniversityId()`.
- `myPostsProvider` uses `boardRepositoryProvider` (not a profile API) — it calls `getMyPosts()` which is in the board feature's repository.
- `myCommentsProvider` queries Supabase directly with `supabaseClientProvider` — it is a `FutureProvider`, not backed by a repository method.
- `UserSettings` has three `copyWith` variants: `copyWithNotifications`, `copyWithPrivacy`, `copyWithAppearance` — use the appropriate one instead of the base `copyWith`.
- `profileApiProvider` uses `ProfileApiImpl` backed by Supabase (not the mock). A `profile_api_mock.dart` exists for testing.
- `profileFilterIndexProvider` is a simple `StateProvider<int>` for the Posts/Comments tab.

### Key Providers
| Provider | Type | Purpose |
|----------|------|---------|
| `profileProvider` | `StateNotifierProvider<ProfileNotifier, ProfileState>` | Main profile state |
| `userProfileProvider` | `Provider<UserProfile?>` | Current profile entity |
| `userSettingsProvider` | `Provider<UserSettings?>` | Current settings |
| `profileStatsProvider` | `Provider<ProfileStats?>` | Post/comment/friend counts |
| `profileLoadingProvider` | `Provider<bool>` | Loading state |
| `isProfileLoadedProvider` | `Provider<bool>` | Both profile and settings loaded |
| `profileCompletionProvider` | `Provider<int>` | Completion percentage 0-100 |
| `myPostsProvider` | `FutureProvider<List<PostEntity>>` | Current user's posts |
| `myCommentsProvider` | `FutureProvider<List<Map<String, dynamic>>>` | Current user's comments |
| `profileFilterIndexProvider` | `StateProvider<int>` | Active tab (0=posts, 1=comments) |

### API Endpoints
Backed by Supabase via `profile_api_impl.dart`:
- `GET /user_profiles?user_id=` — fetch profile
- `PUT /user_profiles/{id}` — update profile fields
- `GET /user_settings?user_id=` — fetch settings
- `PUT /user_settings/{id}` — update settings
- `GET /profile_stats?user_id=` — fetch counts
- Supabase Storage: `avatars/{userId}` bucket for avatar uploads

## Dependencies

### Internal
- `features/auth/presentation/providers/auth_provider.dart` — `currentUserProvider`, `authProvider.notifier.updateUniversityId()`
- `features/board/presentation/providers/board_provider.dart` — `boardProvider.notifier.updateMyPostsNickname()`
- `features/board/data/repositories/board_repository_impl.dart` — `boardRepositoryProvider` for `myPostsProvider`
- `core/supabase/supabase_provider.dart` — Direct Supabase queries in `myCommentsProvider`
- `core/errors/failures.dart` — `Failure` typed errors

### External
- `flutter_riverpod` — State management
- `supabase_flutter` — Profile data + Storage
- `fpdart` — `Either<Failure, T>`
- `freezed_annotation` — Immutable entities
- `image_picker` — Avatar image selection

<!-- MANUAL: -->
