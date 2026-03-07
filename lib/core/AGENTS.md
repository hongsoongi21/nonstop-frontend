<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-03-08 | Updated: 2026-03-08 -->

# core

## Purpose

Cross-cutting concerns shared across all features. Contains reusable infrastructure, design system, navigation, error handling, localization, networking, and global state management. This is the foundation layer that all features depend on.

## Key Files

| File | Purpose |
|------|---------|
| `constants/routes.dart` | Single source of truth for all route paths |
| `router/app_router.dart` | go_router configuration with auth guard, bottom nav, and redirect logic |
| `config/env_config.dart` | Environment variables, API/WS URLs, OAuth credentials |
| `config/app_config.dart` | App-level configuration and initialization |
| `errors/failures.dart` | @freezed union type for Either<Failure, T> error handling |
| `errors/exceptions.dart` | Framework-specific exception types |
| `errors/error_messages.dart` | User-facing and developer error messages |
| `theme/app_colors.dart` | Complete "Samarkand Modern" color palette with gradients |
| `theme/app_typography.dart` | Typography system with responsive scaling |
| `theme/app_spacing.dart` | 4px grid spacing, radius, elevation values |
| `theme/app_dimensions.dart` | Size constants for responsive design |
| `theme/app_theme.dart` | Material 3 theme builder |
| `widgets/app_scaffold.dart` | AppScaffold, AppAppBar, AppScreen wrapper widgets |
| `widgets/app_button.dart` | Styled button components (primary, secondary, icon, etc.) |
| `widgets/app_text_field.dart` | Custom text input with validation |
| `widgets/app_card.dart` | Elevated/outlined cards matching design system |
| `widgets/app_loading_indicator.dart` | Loading spinners and progress indicators |
| `widgets/app_empty_state.dart` | Empty state with icon, title, message, action |
| `widgets/app_error_widget.dart` | Error display with retry action |
| `widgets/app_error_display.dart` | Bottom sheet error display |
| `widgets/app_snackbar.dart` | Styled snackbars (success, error, info, warning) |
| `widgets/app_states.dart` | AsyncValue UI builders (loading, error, success) |
| `widgets/app_animations.dart` | Reusable animations and transitions |
| `widgets/app_loading_skeleton.dart` | Shimmer skeleton loaders |
| `widgets/app_navigation.dart` | Bottom navigation, app bar helpers |
| `extensions/context_extensions.dart` | BuildContext shortcuts (navigation, theme, screen size, responsive) |
| `extensions/string_extensions.dart` | String utilities (validation, formatting) |
| `extensions/date_extensions.dart` | DateTime extensions |
| `utils/formatters/formatters.dart` | Date, time, number, currency, file size formatters |
| `utils/validators/validators.dart` | Email, password, phone validators |
| `utils/logger.dart` | Structured logging service |
| `utils/device_info.dart` | Device info utilities |
| `utils/date_utils.dart` | Date/time calculations |
| `providers/locale_provider.dart` | Locale state, system/user preference tracking |
| `providers/package_info_provider.dart` | App version info |
| `services/analytics_service.dart` | Firebase Analytics wrapper with events |
| `services/crashlytics_service.dart` | Firebase Crashlytics error reporting |
| `services/fcm_service.dart` | Firebase Cloud Messaging notifications |
| `services/app_lifecycle_service.dart` | App lifecycle events |
| `storage/secure_storage_service.dart` | Secure token/credential storage |
| `services/secure_storage_service.dart` | Token refresh and secure storage |
| `l10n/app_localizations*.dart` | Generated localization delegates (EN, RU, UZ, KO) |
| `l10n/app_*.arb` | Translation files (4 languages) |
| `supabase/supabase_config.dart` | Supabase client initialization |
| `supabase/supabase_provider.dart` | Supabase provider for Riverpod |
| `network/dto/auth_response_dto.dart` | @JsonSerializable DTO for auth responses |
| `mock/mock_data.dart` | Development mock data |
| `usecases/usecase.dart` | Base UseCase<T, Params> abstract class |

## Subdirectories

| Directory | Purpose | Key Exports |
|-----------|---------|------------|
| **config/** | Environment, app configuration | EnvConfig, AppConfig |
| **constants/** | Route definitions, app constants | Routes |
| **errors/** | Error handling types (freezed), exceptions, messages | Failure, NetworkFailure, AuthenticationFailure |
| **extensions/** | Dart/Flutter extensions (BuildContext, String, DateTime) | ContextExtensions, navigation shortcuts |
| **l10n/** | Localization (4 languages: EN, RU, UZ, KO) | AppLocalizations, AppLocale |
| **mock/** | Test/demo data | MockData |
| **network/** | DTOs, Dio client, WebSocket, STOMP | AuthResponseDTO, DioClient |
| **providers/** | Global Riverpod providers | localeProvider, packageInfoProvider |
| **router/** | go_router configuration, navigation | routerProvider, GoRouter |
| **services/** | App services (analytics, FCM, lifecycle, secure storage) | AnalyticsService, FCMService, AppLifecycleService |
| **storage/** | Secure token storage | SecureStorageService |
| **supabase/** | Supabase client and provider | supabaseProvider, SupabaseClient |
| **theme/** | Design system (colors, typography, spacing, dimensions) | AppColors, AppTypography, AppSpacing |
| **usecases/** | Base UseCase pattern | UseCase<T, Params>, NoParams |
| **utils/** | Formatting, validation, logging, device info | Formatters, Validators, Logger |
| **widgets/** | Shared UI components (buttons, cards, scaffolds, dialogs) | AppScaffold, AppButton, AppCard, AppSnackBar |

## Design System & Styling

### Color Palette - "Samarkand Modern"

Inspired by Uzbekistan's iconic blue tiles mixed with modern university energy.

**Brand Colors:**
- Primary: `#1E4D7B` (Deep Samarkand Blue) - main brand
- Primary Light: `#3A7CA5`
- Primary Dark: `#0D2E4D`
- Secondary: `#D4A853` (Warm Gold) - Uzbek textile accent
- Tertiary: `#0891B2` (Turquoise Tile) - classic architecture
- Accent: `#EF6461` (Coral Energy) - youth & vibrancy

**Status Colors:**
- Success: `#10B981`
- Error: `#EF4444`
- Warning: `#F59E0B`
- Info: `#3B82F6`

**Feature-Specific:**
- Board: turquoise (free), purple (secret), blue (question), gold (market)
- Timetable: primary (today), gray (weekend), light gray (past), red (conflict)
- Chat: green (online), gray (offline), gold (typing)

**Dark Mode:** Automatically switches background, surface, text colors via `isDarkMode` context extension.

All colors defined in `theme/app_colors.dart`. Use design system classes—NO hardcoded hex values.

### Typography System

**Font:** Pretendard (Korean/English optimized, included in assets)

**Styles:**
- Display: Large/Medium/Small for hero sections (48px-32px)
- Headline: 1-6 for section headers (28px-14px)
- Body: 1-2 + small for content (16px-13px)
- Subtitle: 1-2 for secondary info (16px-14px)
- Button: Primary and small variants (15px-13px)
- Caption: Small, overline for UI labels (12px-10px)
- Special: Numeric (24px, tabular), code (monospace), link

Access via `AppTypography.headline1`, `AppTypography.body2`, etc.

**Responsive scaling** via `AppTypography.responsive(style, context)` or `textScaleFactor` from context.

### Spacing System

**4px grid system:**
- xxs: 2px, xs: 4px, sm: 8px, md: 16px, lg: 24px, xl: 32px, xxl: 48px, xxxl: 64px

**Semantic spacing:**
- cardPadding: md (16px)
- screenPadding: lg (24px)
- dialogPadding: xl (32px)
- sectionSpacing: xl (32px)

**Border radius:**
- radiusXs: 2px, radiusSm: 4px, radiusMd: 8px, radiusLg: 12px, radiusXl: 16px, radiusXxl: 24px, radiusFull: 999px

**Elevations:** xs (1), sm (2), md (4), lg (6), xl (8), xxl (12)

**Icon sizes:** xs (12), sm (16), md (20), lg (24), xl (32), xxl (48)

Use `EdgeInsets.symmetric()`, `EdgeInsets.only()` helpers. Access via `AppSpacing.lg`, extension on `num` (e.g., `2.lg`).

### Responsive Design

Base width: **375px** (iPhone SE scale)

**Helper getters from BuildContext:**
- `isMobile`: < 600px
- `isTablet`: 600px-1200px
- `isDesktop`: >= 1200px
- `isLandscape`, `isPortrait`

**flutter_screenutil** adapts all sizes proportionally.

## Navigation & Routing

### Routes

All routes defined in `constants/routes.dart` as class constants:
- Auth: `/login`, `/register`, `/onboarding`, `/forgot-password`
- Main tabs: `/board`, `/timetable`, `/chat`, `/friends`, `/profile`
- Details: `/board/:id`, `/chat/:roomId`, `/profile/:userId`
- Settings: `/settings`, `/profile/edit`, `/settings/blocked-users`, `/notifications`, `/verification`

### Router Configuration

`router/app_router.dart` defines:
- **Auth guard**: Redirects unauthenticated users to login
- **Bottom nav**: StatefulShellRoute with 5 indexed branches (board, timetable, chat, friends, profile)
- **Nested routes**: Detail screens as child routes (e.g., board detail, chat rooms)
- **State preservation**: Maintains tab state when switching between tabs
- **OAuth flow**: Detects pending OAuth signups, redirects to registration

**Usage:**
```dart
// Navigate
context.goTo(Routes.board);
context.push(Routes.boardDetailPath('123'));

// With parameters
context.push(Routes.chatRoomPath('456'), extra: roomName);
```

## Error Handling

### Failure Types (Either Pattern)

All operations return `Either<Failure, T>` from `fpdart` package.

**Failure types** (@freezed union in `errors/failures.dart`):
- `NetworkFailure`: HTTP errors, connectivity issues
- `AuthenticationFailure`: Token invalid, login required
- `AuthorizationFailure`: Insufficient permissions
- `ValidationFailure`: Field errors with error map
- `ServerFailure`: 5xx errors with status code
- `TimeoutFailure`: Request timeout
- `WebSocketFailure`: WS connection errors
- `CacheFailure`: Cache operations
- `StorageFailure`: Local storage errors
- `UnknownFailure`: Unexpected errors with stack trace

**Repository pattern:**
```dart
// Data layer converts exceptions to typed Failures
try {
  final data = await api.fetch();
  return Right(data.toDomain());
} on DioException catch (e) {
  return Left(Failure.network(message: e.message));
}
```

**UI layer consumes Either:**
```dart
final result = await usecase(params);
result.fold(
  (failure) => showError(failure),
  (data) => showSuccess(data),
);
```

## Localization

**Languages:** English (EN), Russian (RU), Uzbek (UZ), Korean (KO)

**System:**
- ARB files in `l10n/app_*.arb` (4 languages)
- Generated delegates: `AppLocalizations_en`, etc.
- System detects device language, defaults to Uzbek if unsupported

**Usage:**
```dart
// Access translations
AppLocalizations.of(context)!.buttonLogin
AppLocalizations.of(context)!.errorNetworkFailure

// Change locale programmatically
ref.read(localeStateProvider.notifier).setLocale(Locale('en'));
```

**Adding translations:**
1. Edit `lib/core/l10n/app_*.arb` (all 4 files)
2. Run: `flutter gen-l10n`
3. Access via `AppLocalizations.of(context)!.keyName`

**Locale provider:**
- `localeStateProvider`: Full state with user preference tracking
- `localeProvider`: Just the Locale for backward compatibility
- Persists to SharedPreferences, respects system locale as fallback

## Network Layer

### Dio Client Setup

HTTP client with auth token injection, auto-refresh, logging, and error conversion.

**Configuration:** (`network/`)
- Base URL: `EnvConfig.apiBaseUrl`
- Interceptors: Auth token, refresh on 401, request/response logging
- Timeouts: Configurable per request
- Certificate pinning: (if configured)

**Usage:**
```dart
final response = await dioClient.get('/api/endpoint');
```

### WebSocket & STOMP (Real-time Chat)

WebSocket client for chat messaging with STOMP protocol.

**Base URL:** `EnvConfig.wsBaseUrl`
**Lifecycle:**
- Connect on app startup
- Auto-reconnect with exponential backoff
- Cleanup on app terminate

**Features:**
- Message subscription/publishing
- Typing indicators
- Online status

## Global Providers (Riverpod)

| Provider | Type | Purpose |
|----------|------|---------|
| `routerProvider` | Provider<GoRouter> | Router instance with auth guard |
| `localeStateProvider` | StateNotifierProvider | Locale with user preference |
| `localeProvider` | Provider<Locale> | Current locale |
| `packageInfoProvider` | FutureProvider | App version info |
| `analyticsServiceProvider` | Provider | Firebase Analytics wrapper |
| `supabaseProvider` | Provider | Supabase client instance |

All global providers initialized in `main.dart` with ProviderContainer.

## For AI Agents

### Working In This Directory

**Read before coding:**
1. Study the architecture: Domain → Data → Presentation (clean architecture)
2. Understand the error handling: Everything returns Either<Failure, T>
3. Know the design system: Use AppColors, AppTypography, AppSpacing—NEVER hardcode colors/sizes
4. Check if the feature already exists: Look at similar features before building

**Common Tasks:**

**Adding a new route:**
1. Add constant to `constants/routes.dart`
2. Add GoRoute to `router/app_router.dart`
3. Create the screen in `features/*/presentation/screens/`
4. Add localization strings if needed

**Creating a new provider:**
1. Put it in `providers/` if global (shared across features)
2. Put it in `features/*/presentation/providers/` if feature-scoped
3. Use autoDispose by default
4. Document with doc comments

**Adding translations:**
1. Edit all 4 ARB files: `lib/core/l10n/app_*.arb`
2. Run: `flutter gen-l10n`
3. Access: `AppLocalizations.of(context)!.keyName`

**Creating a UI component:**
1. Put in `widgets/` if shared across features
2. Inherit from AppButton, AppCard, etc. for consistency
3. Use design system (AppColors, AppTypography, AppSpacing)
4. Make it responsive: test on mobile, tablet, desktop

**Error handling:**
1. Convert exceptions to Failure types at repository boundary
2. Return Either<Failure, T> from repositories and usecases
3. UI folds the Either: `fold(onFailure, onSuccess)`
4. Show user-friendly messages via `error_messages.dart`

### Code Organization

**Domain Layer (Pure Dart):**
- No Flutter imports
- Entities (@freezed), repository interfaces, usecases
- Repository returns Either<Failure, T>

**Data Layer:**
- DTOs (@JsonSerializable), API clients, repository implementations
- Converts exceptions → Failure types
- Converts DTOs → domain entities via `.toDomain()`

**Presentation Layer:**
- Riverpod providers and notifiers for state
- Screens and widgets
- No API calls directly—go through usecases

### No-Go Zones

**NEVER:**
- Hardcode colors: Use AppColors.*
- Hardcode sizes/spacing: Use AppSpacing.*, AppDimensions.*
- Use hardcoded strings: Use AppLocalizations.of(context)!.*
- Import platform-specific libs in domain layer
- Mix navigation with business logic
- Catch exceptions without converting to Failure

### Testing Approach

- Mock repositories with `@widgetTest` and `MockRepository`
- Pump screens with `WidgetTester.pumpWidget()`
- Verify UI state changes via `find.byType()`, `find.byKey()`
- Unit test usecases with Either<Failure, T> assertions

## Dependencies

### Key External Packages

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_riverpod` | Latest | State management |
| `go_router` | Latest | Navigation & routing |
| `freezed_annotation` | Latest | Immutable models, union types |
| `json_serializable` | Latest | JSON serialization |
| `fpdart` | Latest | Either, functional programming |
| `dio` | Latest | HTTP client |
| `firebase_analytics` | Latest | Event tracking |
| `firebase_crashlytics` | Latest | Error reporting |
| `firebase_messaging` | Latest | Push notifications (FCM) |
| `flutter_secure_storage` | Latest | Secure credential storage |
| `shared_preferences` | Latest | User preferences, locale |
| `intl` | Latest | i18n, date/number formatting |
| `flutter_screenutil` | Latest | Responsive design scaling |
| `supabase_flutter` | Latest | Supabase client |

### Build & Code Generation

**Before running:**
```bash
flutter clean && flutter pub get
flutter gen-l10n  # After editing ARB files
flutter pub run build_runner build --delete-conflicting-outputs  # For @freezed, @JsonSerializable
flutter pub run build_runner watch  # Watch mode during development
```

## Common Patterns

### UseCase Pattern
```dart
class FetchUserUseCase extends UseCase<User, String> {
  // params: userId
  @override
  Future<Either<Failure, User>> call(String userId) async {
    return await repository.getUser(userId);
  }
}
```

### Provider Pattern
```dart
final userProvider = FutureProvider.autoDispose<User>((ref) async {
  final repo = ref.watch(userRepositoryProvider);
  return await repo.getCurrentUser();
});

// With select() to limit rebuilds
final userNameProvider = Provider((ref) {
  return ref.watch(userProvider).whenData((user) => user.name);
});
```

### Error Handling in UI
```dart
final asyncValue = ref.watch(someProvider);

asyncValue.when(
  loading: () => LoadingWidget(),
  error: (error, st) => ErrorWidget(error: error),
  data: (data) => SuccessWidget(data: data),
);
```

### Navigation with Auth Guard
- Unauthenticated users redirected to `/login` by routerProvider
- OAuth pending redirects to `/register`
- Already authenticated users redirected away from auth pages

## File Location Reference

```
lib/core/
├── config/
│   ├── app_config.dart
│   └── env_config.dart              <- Environment, API/WS URLs
├── constants/
│   └── routes.dart                  <- Single source of truth for routes
├── errors/
│   ├── error_messages.dart
│   ├── exceptions.dart
│   └── failures.dart                <- Either<Failure, T> types
├── extensions/
│   ├── context_extensions.dart      <- Navigation, theme shortcuts
│   ├── date_extensions.dart
│   └── string_extensions.dart
├── l10n/
│   ├── app_*.arb                    <- Translation files (4 languages)
│   └── app_localizations*.dart      <- Generated files
├── mock/
│   └── mock_data.dart
├── network/
│   ├── dto/
│   │   └── auth_response_dto.dart
│   └── (dio_client.dart, websocket_client.dart if separate)
├── providers/
│   ├── locale_provider.dart         <- Locale + persistence
│   └── package_info_provider.dart
├── router/
│   └── app_router.dart              <- GoRouter with auth guard, bottom nav
├── services/
│   ├── analytics_service.dart
│   ├── app_lifecycle_service.dart
│   ├── crashlytics_service.dart
│   ├── fcm_service.dart
│   └── secure_storage_service.dart
├── storage/
│   └── secure_storage_service.dart
├── supabase/
│   ├── supabase_config.dart
│   └── supabase_provider.dart
├── theme/
│   ├── app_colors.dart              <- Design system colors
│   ├── app_dimensions.dart
│   ├── app_spacing.dart             <- 4px grid, radius, elevations
│   ├── app_theme.dart               <- Material 3 theme
│   └── app_typography.dart          <- Font styles
├── usecases/
│   └── usecase.dart                 <- Base UseCase<T, Params>
├── utils/
│   ├── date_utils.dart
│   ├── device_info.dart
│   ├── formatters/
│   │   └── formatters.dart          <- Date, currency, file size formatters
│   ├── logger.dart
│   └── validators/
│       └── validators.dart          <- Email, password, phone validators
└── widgets/
    ├── app_animations.dart
    ├── app_button.dart
    ├── app_card.dart
    ├── app_empty_state.dart
    ├── app_error_display.dart
    ├── app_error_widget.dart
    ├── app_loading_indicator.dart
    ├── app_loading_skeleton.dart
    ├── app_navigation.dart
    ├── app_scaffold.dart            <- Main scaffold, AppAppBar, AppScreen
    ├── app_snackbar.dart
    ├── app_states.dart              <- AsyncValue UI builders
    └── app_text_field.dart
```

<!-- MANUAL: Update this file when adding new subdirectories, major utilities, or changing design system specifications. -->
