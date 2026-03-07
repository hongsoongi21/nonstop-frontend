<!-- Generated: 2026-03-08 | Updated: 2026-03-08 -->

# Nonstop Frontend

## Purpose

**Nonstop** is a Flutter-based social and campus management application featuring university community interaction, real-time messaging, friend networking, and academic timetable management. The app uses Clean Architecture with Riverpod state management, Firebase for authentication and push notifications, and Supabase for backend services.

**App Package:** `uz.merge4.nonstop`
**Current Version:** 1.0.5+31
**Target SDK:** Flutter 3.10.1+, Dart 3.10.1+

## Key Files

| File | Description |
|------|-------------|
| `pubspec.yaml` | Project dependencies and build configuration |
| `CLAUDE.md` | Development guidelines and architecture conventions |
| `lib/main.dart` | Application entry point with Firebase and Supabase initialization |
| `lib/app.dart` | Root widget with Riverpod ProviderScope and routing |
| `lib/firebase_options.dart` | Auto-generated Firebase configuration |
| `analysis_options.yaml` | Dart linting rules and analysis configuration |
| `l10n.yaml` | Localization configuration (EN, RU, KO) |

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `lib/` | Main application source code (see `lib/AGENTS.md` for detailed breakdown) |
| `lib/core/` | Cross-cutting concerns: routing, networking, theme, localization, utilities, widgets |
| `lib/features/` | Feature modules organized by domain (auth, board, chat, friends, timetable, profile, notification, settings, verification, report) |
| `lib/shared/` | Reusable UI components (post cards, course cards, dismiss keyboard) |
| `assets/images/` | Image assets organized by purpose |
| `assets/icons/` | SVG and icon assets |
| `assets/fonts/` | Pretendard font family (weights 100-900) |
| `android/` | Android native configuration and Gradle build files |
| `ios/` | iOS native configuration and CocoaPods dependencies |
| `supabase/` | Database migrations and Supabase schema |
| `.maestro/` | E2E test automation flows (e.g., auth/login_email.yaml) |
| `test/` | Unit and widget tests |

## For AI Agents

### Build & Development Commands

```bash
# Initial setup
flutter clean && flutter pub get
flutter gen-l10n                                              # Generate localization files
flutter pub run build_runner build --delete-conflicting-outputs  # Generate models (@freezed, @JsonSerializable)

# Development
flutter run                                    # Run on default device
flutter run -d chrome                          # Web debug
flutter run -d <device_id>                     # Specific device

# Code generation (watch mode during development)
flutter pub run build_runner watch             # Regenerate on file changes

# Testing & Analysis
flutter test                                   # Run all tests
flutter test test/path/to/test.dart            # Single test file
flutter test --coverage                        # Generate coverage report
flutter analyze                                # Static analysis

# Build for release
flutter build apk                              # Android APK
flutter build ios                              # iOS IPA
flutter build web                              # Web build
```

### Architecture Overview

**Clean Architecture with Riverpod** - Three-layer, feature-based organization:

```
lib/
├── core/
│   ├── config/              # App configuration (env, Firebase options)
│   ├── constants/           # Routes and constants
│   ├── errors/              # Failure types and exception handling
│   ├── extensions/          # Dart extensions (String, Date)
│   ├── l10n/                # ARB localization files (EN, RU, KO)
│   ├── mock/                # Mock data for development
│   ├── network/             # Dio HTTP client with interceptors
│   ├── providers/           # Global providers (locale, auth state)
│   ├── services/            # Firebase (FCM, Analytics, Crashlytics), Lifecycle
│   ├── storage/             # Secure storage (tokens, user data)
│   ├── supabase/            # Supabase configuration and provider
│   ├── theme/               # Design system (colors, typography, spacing, dimensions)
│   ├── usecases/            # Base UseCase abstract class
│   ├── utils/               # Utilities (logger, validators, formatters, device info)
│   └── widgets/             # Reusable UI components (buttons, cards, loaders, snackbars)
│
├── features/
│   ├── auth/                # Authentication (sign up, login, password reset, verification)
│   │   ├── data/            # DTOs, repository implementations, API clients
│   │   ├── domain/          # User entity, sign in/up usecases, repository interfaces
│   │   └── presentation/    # Auth screens, Riverpod providers
│   │
│   ├── board/               # Community posts and discussions
│   │   ├── data/            # Post DTOs, API, repository
│   │   ├── domain/          # Post entity, repository interface
│   │   └── presentation/    # Board screens and post detail provider
│   │
│   ├── chat/                # Real-time messaging (WebSocket + STOMP)
│   │   ├── data/            # Chat message DTOs, WebSocket handlers
│   │   ├── domain/          # ChatMessage, ChatRoom, ReadReceipt entities
│   │   └── presentation/    # Chat screens, input bar, image viewer
│   │
│   ├── friends/             # Friend list and friend requests
│   │   ├── data/            # Friend DTOs, API, repository
│   │   ├── domain/          # Friend entity, repository interface
│   │   └── presentation/    # Friends screen, request management
│   │
│   ├── timetable/           # University course schedule and GPA
│   │   ├── data/            # Timetable DTOs, API, repository
│   │   ├── domain/          # Timetable, Semester, DayOfWeek, GpaCourse entities
│   │   └── presentation/    # Timetable screen, GPA provider
│   │
│   ├── profile/             # User profile and settings
│   │   ├── data/            # Profile DTOs, API, repository
│   │   ├── domain/          # UserProfile, ProfileStats entities, usecases
│   │   └── presentation/    # Profile screen, glass container widget
│   │
│   ├── notification/        # Push notifications and notification history
│   │   ├── data/            # Notification DTOs, API, repository
│   │   └── domain/          # AppNotification entity
│   │
│   ├── settings/            # User settings and preferences
│   │   └── presentation/    # Settings screen
│   │
│   ├── verification/        # Email/university verification
│   │   ├── data/            # Verification DTOs, API
│   │   └── domain/          # Verification entities
│   │
│   └── report/              # Report abuse/content
│       ├── data/            # Report DTOs, API
│       └── domain/          # Report entities
│
└── shared/
    └── components/          # Reusable widgets (post cards, course cards, dismiss keyboard)
```

**Critical Rules:**
- Domain layer must NOT import Flutter, Dio, or platform libraries - keep types pure Dart
- All business logic lives in domain layer (entities, usecases)
- Data layer handles DTO serialization and API communication
- Presentation layer is UI-only, no business logic
- Repository implementations convert exceptions to typed Failures

### State Management (Riverpod)

**Pattern Usage:**
- `ref.watch()` in `build()` method for reactive updates on dependency changes
- `ref.read()` only in callbacks/event handlers to access state without watching
- `autoDispose` by default to prevent memory leaks (auto-cleanup on unused providers)
- `select()` to watch only specific fields and limit unnecessary rebuilds
- No business logic in widgets - forward user intents to Riverpod notifiers

**Provider Types:**
- `FutureProvider` for async data loading
- `StateNotifierProvider` for mutable state with custom logic
- `ChangeNotifierProvider` for complex state management
- `Computed providers` for derived data

### Navigation (go_router)

All routes are centrally defined in `lib/core/constants/routes.dart`. Navigation uses declarative routing:
- Use `context.go(routePath)` for full page replacement
- Use `context.push(routePath)` to push onto navigation stack
- Use `context.pop()` to pop current route
- NEVER use `Navigator` directly - always use go_router

### Error Handling

Uses functional error handling with `Either<Failure, T>` from **fpdart** package:
- Failure types defined in `lib/core/errors/failures.dart`
- Repository implementations catch exceptions and convert to typed Failures
- Business logic handles Failure types with pattern matching
- Error messages defined in `lib/core/errors/error_messages.dart`

Example:
```dart
Either<Failure, User> getUser() {
  try {
    return Right(user);
  } on SocketException {
    return Left(NetworkFailure());
  }
}
```

### Network Layer

**HTTP (REST):**
- Dio HTTP client at `lib/core/network/dio_client.dart`
- Interceptors for auth token injection and refresh
- Request logging and error transformation
- Base URL from environment configuration

**Real-time (WebSocket + STOMP):**
- WebSocket client at `lib/core/network/websocket_client.dart`
- STOMP protocol for chat messaging (Stomp service)
- Automatic reconnection handling
- Message serialization/deserialization

**Firebase Services:**
- Authentication: Email/password, Google Sign-In, Apple Sign-In
- Push Notifications: FCM with background message handling (FCM service)
- Analytics: Event tracking (Analytics service)
- Crashlytics: Error and exception reporting (Crashlytics service)

### Localization

ARB files in `lib/core/l10n/`:
- `app_en.arb` - English translations
- `app_ru.arb` - Russian translations
- `app_ko.arb` - Korean translations

**Workflow:**
1. Add translation key-value pairs to ARB files
2. Run `flutter gen-l10n` to generate `AppLocalizations` class
3. Access in UI: `AppLocalizations.of(context)!.keyName`

Supported locales configured in `l10n.yaml`.

### Design System & Styling

No hardcoded values - use design system classes:

| Class | Purpose |
|-------|---------|
| `AppColors` | Semantic color tokens (primary, secondary, error, surface) |
| `AppTypography` | Font styles (heading1-6, body, label, caption) |
| `AppSpacing` | Spacing constants (xs: 4, sm: 8, md: 12, lg: 16, xl: 20, etc.) |
| `AppDimensions` | Component dimensions (button height, border radius, icon size) |

**Responsive Design:** Uses `flutter_screenutil` with base resolution 375x812 (iPhone SE). Automatically scales across device sizes.

### Key Conventions

**Naming:**
- Files: `snake_case.dart`
- Classes: `PascalCase`
- Variables/Functions: `camelCase`
- Providers: `camelCaseProvider` (e.g., `authProvider`, `userStateProvider`)
- Constants: `camelCase` (e.g., `defaultTimeout`, `maxRetries`)

**File Organization:**
- One public class per file
- Private classes prefixed with underscore
- Related code grouped into subdirectories

**Code Style:**
- Format with `dart format`
- Analyze with `dart analyze`
- Use const constructors for immutability
- Prefer final fields in entities

**Commit Messages:**
- Format: `<type>(<scope>): <description>`
- Types: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`
- Scope: feature name or component
- Examples:
  - `feat(auth): email verification flow`
  - `fix(chat): message persistence with offline mode`
  - `refactor(core): simplify dio interceptor`

### Testing Requirements

**Test Structure:**
- Unit tests in `test/` directory mirroring `lib/` structure
- Widget tests for UI components
- Integration tests for feature flows

**Required Coverage:**
- Domain layer: >80% (business logic)
- Data layer: >70% (API/storage integration)
- Presentation: Smoke tests for navigation and error states

**Commands:**
```bash
flutter test                    # Run all tests
flutter test --coverage         # Generate coverage report
flutter test -j4               # Run tests in parallel (4 workers)
```

**Test Patterns:**
- Use `test` package for unit tests
- Use `flutter_test` for widget tests
- Mock repositories with `mockito`
- Test Riverpod providers with `flutter_riverpod` test utilities

## Dependencies

### Core Framework
- `flutter_riverpod: ^2.5.1` - State management
- `go_router: ^17.0.1` - Declarative navigation
- `flutter_screenutil: ^5.9.0` - Responsive sizing (375x812 base)

### State & Serialization
- `freezed_annotation: ^2.4.4` - Code generation for immutable classes
- `json_annotation: ^4.9.0` - JSON serialization metadata
- `freezed: ^2.5.8` (dev) - Code generator for @freezed
- `json_serializable: ^6.7.1` (dev) - Code generator for @JsonSerializable
- `build_runner: ^2.4.8` (dev) - Build system for code generation

### Functional Programming
- `fpdart: ^1.1.0` - Either, Option, Task for functional error handling

### Networking
- `firebase_core: ^4.4.0` - Firebase base
- `firebase_auth: ^6.1.4` - Email/password authentication
- `google_sign_in: ^7.2.0` - Google OAuth
- `sign_in_with_apple: ^6.1.4` - Apple OAuth
- `supabase_flutter: ^2.8.0` - Backend as a Service (database, auth)

### Push Notifications & Analytics
- `firebase_messaging: ^16.0.4` - FCM push notifications
- `flutter_local_notifications: ^19.0.3` - Local notification display
- `firebase_analytics: ^12.1.1` - Event analytics
- `firebase_crashlytics: ^5.0.7` - Error tracking and reporting

### Storage & Security
- `flutter_secure_storage: ^10.0.0` - Encrypted local storage for tokens
- `shared_preferences: ^2.5.4` - Simple key-value storage
- `crypto: ^3.0.6` - Cryptographic operations

### UI & Media
- `cached_network_image: ^3.3.1` - Image caching and loading
- `image_picker: ^1.1.2` - Camera/gallery image selection
- `dice_bear: ^0.1.7` - Avatar generation
- `cupertino_icons: ^1.0.8` - iOS-style icons

### Utilities
- `intl: ^0.20.2` - Internationalization and date formatting
- `url_launcher: ^6.3.2` - Open URLs and make calls
- `device_info_plus: ^12.3.0` - Device information (OS, model)
- `package_info_plus: ^9.0.0` - App version and package info
- `logging: ^1.2.0` - Logging framework

### Development
- `flutter_lints: ^6.0.0` - Recommended lint rules
- `flutter_launcher_icons: ^0.14.3` - App icon generation
- `flutter_test` - Built-in testing framework

## Project Structure Summary

```
nonstop-frontend/
├── lib/                          # Application source
│   ├── core/                     # Shared infrastructure
│   ├── features/                 # Feature modules (10 features)
│   ├── shared/                   # Reusable components
│   ├── main.dart                 # Entry point
│   ├── app.dart                  # Root widget
│   └── firebase_options.dart     # Firebase config
├── test/                         # Unit and widget tests
├── assets/                       # Images, icons, fonts
├── android/                      # Android configuration
├── ios/                          # iOS configuration
├── supabase/                     # Database migrations
├── .maestro/                     # E2E test flows
├── pubspec.yaml                  # Dependencies
├── analysis_options.yaml         # Linting rules
├── l10n.yaml                     # Localization config
├── CLAUDE.md                     # Development guidelines
└── AGENTS.md                     # This file

Version Control (Git):
- Default branch: dev
- Conventional commits
- Never auto-commit without permission
```

## Features Overview

| Feature | Purpose | Key Files |
|---------|---------|-----------|
| **Authentication** | Sign up, login, password recovery, email verification, OAuth (Google/Apple) | `lib/features/auth/` |
| **Board** | Community posts, discussions, comments | `lib/features/board/` |
| **Chat** | Real-time messaging, read receipts, image sharing | `lib/features/chat/` |
| **Friends** | Friend list, requests, blocking | `lib/features/friends/` |
| **Timetable** | University course schedule, GPA tracking | `lib/features/timetable/` |
| **Profile** | User profile, profile statistics, settings | `lib/features/profile/` |
| **Notifications** | Push notifications, notification history | `lib/features/notification/` |
| **Settings** | App preferences, language, privacy | `lib/features/settings/` |
| **Verification** | University and email verification | `lib/features/verification/` |
| **Report** | Report content/users for abuse | `lib/features/report/` |

## Common Tasks for AI Agents

### Adding a New Feature

Follow these steps when implementing a new feature:

1. **Create directory structure** under `lib/features/[feature_name]/`:
   ```
   lib/features/[feature_name]/
   ├── data/
   │   ├── api/
   │   ├── dto/
   │   └── repository_impl/
   ├── domain/
   │   ├── entities/
   │   ├── repositories/
   │   └── usecases/
   └── presentation/
       ├── providers/
       ├── screens/
       └── widgets/
   ```

2. **Domain first** (pure business logic):
   - Define entity with `@freezed` annotation
   - Create repository interface
   - Implement usecases

3. **Data layer**:
   - Create DTOs with `@JsonSerializable`
   - Implement API client if needed
   - Implement repository interface

4. **Presentation layer**:
   - Create Riverpod state notifier provider
   - Build screens and widgets
   - Use providers with `ref.watch()` and `ref.read()`

5. **Integration**:
   - Add routes to `lib/core/constants/routes.dart`
   - Add localization keys to ARB files
   - Generate code: `flutter pub run build_runner build`
   - Add unit tests

6. **Verification**:
   ```bash
   flutter analyze  # Check for errors
   flutter test     # Run tests
   flutter run      # Test on device
   ```

### Debugging Common Issues

**Build Runner Errors:**
```bash
# Regenerate all generated files
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

**Localization Not Updating:**
```bash
# Regenerate localization files after editing ARB
flutter gen-l10n
```

**State Not Updating:**
- Verify using `ref.watch()` (not `ref.read()`) in `build()`
- Ensure Riverpod notifier is using `state = newState` or `.copyWith()`
- Check that entity is using `@freezed` for immutability

**Network Issues:**
- Check Dio interceptor in `lib/core/network/dio_client.dart`
- Verify API base URL in environment config
- Check token refresh logic in auth provider

**Firebase/Supabase Not Initializing:**
- Ensure `firebase_options.dart` is generated correctly
- Check `.env` file has correct API keys
- Verify Firebase project settings in Android/iOS native configs

## Git Workflow

**Important:**
- Default branch is `dev` (not main)
- Never auto-commit - always wait for explicit user permission
- Use conventional commits: `feat(scope):`, `fix(scope):`, `refactor(scope):`
- Branch naming: `feature/`, `fix/`, `docs/`

Example workflow:
```bash
git checkout -b feature/new-feature
# Make changes
git status
# Wait for user permission
git add .
git commit -m "feat(feature-name): description"
git push origin feature/new-feature
```

---

**Last Updated:** 2026-03-08
**Maintainers:** Nonstop Development Team
**Contact:** For architecture questions or onboarding, see CLAUDE.md

