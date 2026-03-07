# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Development Commands

```bash
# Setup
flutter clean && flutter pub get
flutter gen-l10n
flutter pub run build_runner build --delete-conflicting-outputs

# Run
flutter run
flutter run -d chrome          # Web
flutter run -d <device_id>     # Specific device

# Code generation (after changing @freezed or @JsonSerializable models)
flutter pub run build_runner watch   # Watch mode

# Testing
flutter test
flutter test test/path/to/test.dart  # Single file
flutter test --coverage

# E2E Testing (Maestro)
maestro test .maestro/flows/auth/login_email.yaml   # Single flow
maestro test .maestro/flows/                         # All flows

# Analysis
flutter analyze

# Deploy (Fastlane + Firebase App Distribution)
cd android && bundle exec fastlane firebase_internal build_number:31
cd ios && bundle exec fastlane firebase_internal build_number:31
# Or direct Firebase CLI:
flutter build apk --release && firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk --app 1:127473148279:android:2109fc50be2bbc3ec2c172
flutter build ipa --release --export-options-plist=ios/ExportOptions-firebase.plist && firebase appdistribution:distribute build/ios/ipa/nonstop.ipa --app 1:127473148279:ios:1fe527d213701a6dc2c172
```

## Architecture Overview

**Clean Architecture with Riverpod** - Feature-based organization with three layers:

```
lib/
├── core/           # Cross-cutting: router, network, theme, l10n, utils, widgets
├── features/       # Feature modules (auth, board, chat, friends, timetable, settings, notification, profile, verification, report)
│   └── [feature]/
│       ├── data/           # DTOs, API clients, repository implementations
│       ├── domain/         # Entities (@freezed), repository interfaces, usecases
│       └── presentation/   # Screens, providers (Riverpod), widgets
└── shared/         # Shared UI components
```

**Critical Rule**: Domain layer must NOT import Flutter, Dio, or any platform libraries. Keep domain types pure Dart.

## Backend (Supabase)

- **Auth**: Supabase Auth (email/password, Google OAuth, Apple OAuth)
- **Database**: Supabase PostgreSQL with RLS policies
- **API**: Features call Supabase client directly via `supabase_flutter` (no separate REST API server)
- **Real-time**: Supabase Realtime for chat via WebSocket/STOMP
- **Config**: `lib/core/supabase/supabase_config.dart`, providers in `supabase_provider.dart`
- **Migrations**: `supabase/migrations/` — apply via Supabase Dashboard SQL Editor

## Firebase Services

- **Crashlytics**: Error reporting (production only)
- **Analytics**: Usage analytics with `AnalyticsService`
- **FCM**: Push notifications via `FcmService`
- **App Distribution**: Test builds via Fastlane or Firebase CLI
- **App IDs**: Android `1:127473148279:android:2109fc50be2bbc3ec2c172`, iOS `1:127473148279:ios:1fe527d213701a6dc2c172`

## State Management (Riverpod)

- Use `ref.watch()` in `build()` for reactive updates
- Use `ref.read()` only in callbacks/events
- Use `autoDispose` by default to prevent memory leaks
- Use `select()` to limit rebuilds to specific fields
- No business logic in widgets - forward user intents to notifiers

## Navigation (go_router)

Routes defined in `lib/core/constants/routes.dart` with path builder helpers. Router in `lib/core/router/app_router.dart` includes auth guard (redirects unauthenticated users to login). Uses `StatefulShellRoute` for bottom navigation with preserved tab state. Use `context.go()` / `context.push()` / `context.pop()`. Never use `Navigator` directly.

## Error Handling

Uses `Either<Failure, T>` from fpdart. Failure types (`@freezed`) in `lib/core/errors/failures.dart`: Network, Authentication, Authorization, Validation, Server, Timeout, WebSocket, Cache, Storage, Unknown. Repository implementations convert exceptions to typed Failures.

## Localization

ARB files in `lib/core/l10n/` — **4 languages: EN, KO, RU, UZ**. After editing ARB files, run `flutter gen-l10n`. Access via `AppLocalizations.of(context)!.keyName`.

## Styling

Use design system classes - no hardcoded values:
- Colors: `AppColors` (lib/core/theme/app_colors.dart)
- Typography: `AppTypography` (lib/core/theme/app_typography.dart)
- Spacing: `AppSpacing` (lib/core/theme/app_spacing.dart)
- Dimensions: `AppDimensions` (lib/core/theme/app_dimensions.dart)

Responsive design via flutter_screenutil (base: 375x812). Font: Pretendard.

## E2E Testing (Maestro)

Maestro flows in `.maestro/flows/`. Widgets use `Semantics(identifier:)` for stable test selectors.

Naming convention for identifiers:
- Login: `login_email_field`, `login_password_field`, `login_submit_button`, `login_google_button`, `login_apple_button`, `login_signup_link`
- Navigation: `nav_board`, `nav_timetable`, `nav_chat`, `nav_friends`, `nav_profile`
- Pattern: `{screen}_{element}_{type}` (e.g., `settings_theme_toggle`)

When adding new screens, add `Semantics(identifier:)` to key interactive widgets for E2E testability. Custom widgets accept `semanticsId` parameter (see `CustomAuthTextField`, `GradientButton`).

## Git Workflow

- Main branch: `dev`
- Conventional commits: `feat(scope):`, `fix(scope):`, `refactor(scope):`, etc.
- **Never auto-commit** - wait for explicit user permission
- Branch naming: `feature/`, `fix/`, `docs/`

## Adding a New Feature

1. Create 3-layer structure under `lib/features/[name]/`
2. Domain first: Entity → Repository interface
3. Data: DTO with `.toDomain()` → API → Repository impl
4. Presentation: Provider/Notifier → Screen → Widgets
5. Run `build_runner` for generated code
6. Add routes to `Routes` class and router config (`lib/core/router/app_router.dart`)
7. Add localization keys to all 4 ARB files (EN, KO, RU, UZ)
8. Add `Semantics(identifier:)` to key widgets for Maestro E2E tests
