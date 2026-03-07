<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-03-08 | Updated: 2026-03-08 -->

# settings

## Purpose
Presents a user-facing settings screen for configuring notification preferences (push, email, board, chat, timetable), privacy controls, language/theme appearance, and account management (sign out, delete account, blocked users). This feature has no own data layer — it delegates entirely to `profileProvider` for reading and writing `UserSettings`, to `authProvider` for sign-out/delete, and to `localeProvider` for in-app language switching. Blocked user management is surfaced here but uses `friend_api_impl.dart` directly.

## Key Files
| File | Description |
|------|-------------|
| `presentation/screens/settings_screen.dart` | Main settings UI with language, notifications, privacy, appearance, and account sections |
| `presentation/screens/blocked_users_screen.dart` | Blocked users list with unblock capability; uses `blockedUsersProvider` (FutureProvider backed by `friendApiProvider`) |

## Subdirectories
| Directory | Purpose |
|-----------|---------|
| `data/` | Not present — no own data layer |
| `domain/` | Not present — no own domain layer |
| `presentation/` | 2 screens only |

## For AI Agents

### Working In This Directory
- This feature owns no providers — all state comes from other features' providers.
- `settingsScreen` watches `profileProvider` (for `UserSettings`) and uses `profileProvider.notifier.updateNotificationSettings()`, `updatePrivacySettings()`, `updateAppearanceSettings()` for mutations.
- Language switching uses `localeProvider` from `core/providers/locale_provider.dart`, not a settings-specific provider.
- `blockedUsersProvider` is a `FutureProvider` defined inside `blocked_users_screen.dart` — it is not reusable from other files.
- App version display uses `packageInfoProvider` from `core/providers/package_info_provider.dart`.
- Sign-out calls `authProvider.notifier.signOut()` or `signOutFull()` (latter also clears Google session).
- Account deletion calls `authProvider.notifier.deleteAccount()`.
- When adding new settings sections, add corresponding fields to `UserSettings` entity in `profile/` feature and update `ProfileRepository`.

### Key Providers (consumed, not owned)
| Provider | Source Feature | Purpose |
|----------|---------------|---------|
| `profileProvider` | `profile/` | Read/write `UserSettings` |
| `isProfileLoadedProvider` | `profile/` | Loading gate |
| `profileLoadingProvider` | `profile/` | Loading indicator |
| `profileErrorProvider` | `profile/` | Error display |
| `authProvider` | `auth/` | Sign-out, delete account |
| `localeProvider` | `core/` | Language switching |
| `packageInfoProvider` | `core/` | App version display |
| `blockedUsersProvider` | local (blocked_users_screen.dart) | Blocked users list |

### Settings Sections
| Section | Provider Method |
|---------|----------------|
| Language | `localeProvider` |
| Push notifications | `updateNotificationSettings(push:)` |
| Email notifications | `updateNotificationSettings(email:)` |
| Board notifications | `updateNotificationSettings(board:)` |
| Chat notifications | `updateNotificationSettings(chat:)` |
| Timetable notifications | `updateNotificationSettings(timetable:)` |
| Account: Sign out | `authProvider.notifier.signOut()` |
| Account: Delete | `authProvider.notifier.deleteAccount()` |
| Blocked users | `Routes.blockedUsers` navigation |

## Dependencies

### Internal
- `features/profile/presentation/providers/profile_provider.dart` — All settings read/write
- `features/auth/presentation/providers/auth_provider.dart` — Sign-out and delete account
- `features/friends/data/api/friend_api_impl.dart` — Blocked users API
- `core/providers/locale_provider.dart` — Language switching
- `core/providers/package_info_provider.dart` — App version

### External
- `flutter_riverpod` — Provider consumption
- `go_router` — Navigation to blocked users screen

<!-- MANUAL: -->
