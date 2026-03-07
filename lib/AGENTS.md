<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-03-08 | Updated: 2026-03-08 -->

# lib

## Purpose
Main application source code organized in **Clean Architecture** with **Riverpod** state management. Contains the complete Flutter application for the Nonstop university social platform.

## Overview

The lib/ directory follows a feature-based architecture with three distinct layers:
- **Domain**: Business logic and entities (pure Dart, no framework dependencies)
- **Data**: API clients, repository implementations, DTOs
- **Presentation**: UI screens, providers (state management), widgets

This separation ensures testability, maintainability, and clear dependency direction.

## Key Files

| File | Purpose |
|------|---------|
| `main.dart` | Application entry point: Firebase/Supabase initialization, error handling, Riverpod setup |
| `app.dart` | Root widget: auth state management, router setup, theming, localization |
| `firebase_options.dart` | Auto-generated Firebase configuration |

## Subdirectories

| Directory | Purpose | Status |
|-----------|---------|--------|
| `core/` | Cross-cutting concerns: routing, networking, theming, l10n, services (see `core/AGENTS.md`) | Active |
| `features/` | Feature modules following clean architecture (see `features/AGENTS.md`) | Active |
| `shared/` | Reusable UI components across features | Active |

## Architecture Pattern: Clean Architecture + Riverpod

### Dependency Flow (STRICT)
```
Presentation → Domain
     ↓           ↓
  Riverpod   Repositories (interfaces)
     ↓           ↓
   Data ← API Clients, DTOs, Repository Implementations
```

**Critical Rule**: Domain layer must NOT import Flutter, Dio, or any platform libraries.

### Layer Responsibilities

#### Domain Layer (`features/[feature]/domain/`)
- **Entities**: @freezed immutable data classes (pure Dart)
- **Repositories**: Abstract interfaces defining contracts
- **UseCases**: Business logic with `Either<Failure, T>` returns
- **No imports**: Flutter, Dio, platform libraries, or presentation layer

Example:
```dart
// ✅ GOOD: Domain entity
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
  }) = _User;
}

// ✅ GOOD: Domain repository interface
abstract class UserRepository {
  Future<Either<Failure, User>> getUser(String id);
}
```

#### Data Layer (`features/[feature]/data/`)
- **DTOs**: JSON serializable data transfer objects with `.toDomain()` converters
- **API Clients**: Dio-based HTTP clients or mock implementations
- **Repository Implementations**: Convert exceptions to Failures, map DTOs to entities
- **No presentation imports**: Repositories are presentation-agnostic

Example:
```dart
// ✅ GOOD: DTO with conversion
@freezed
class UserDto with _$UserDto {
  @JsonSerializable()
  const factory UserDto({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'email') required String email,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  // Convert to domain entity
  User toDomain() => User(id: id, email: email);
}

// ✅ GOOD: Repository implementation
class UserRepositoryImpl implements UserRepository {
  @override
  Future<Either<Failure, User>> getUser(String id) async {
    try {
      final dto = await _api.getUser(id);
      return Right(dto.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
```

#### Presentation Layer (`features/[feature]/presentation/`)
- **Screens**: Full-page widgets using Riverpod providers
- **Providers**: State management with Riverpod (StateNotifier, FutureProvider, etc.)
- **Widgets**: Reusable UI components (buttons, cards, forms)

Example:
```dart
// ✅ GOOD: Riverpod provider
final userProvider = FutureProvider.autoDispose<User>((ref) async {
  final repository = ref.watch(userRepositoryProvider);
  final result = await repository.getUser('123');
  return result.fold(
    (failure) => throw failure,
    (user) => user,
  );
});

// ✅ GOOD: Screen using providers
class UserScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return user.when(
      data: (user) => UserView(user: user),
      loading: () => const LoadingIndicator(),
      error: (err, st) => ErrorWidget(error: err),
    );
  }
}
```

### Error Handling Pattern

**Failures** (domain layer) vs **Exceptions** (data layer):

```dart
// ✅ Domain: Either<Failure, T>
Future<Either<Failure, User>> getUser(String id);

// Failure types (domain/failures.dart)
factory Failure.network({required String message, String? code})
factory Failure.authentication({required String message, String? code})
factory Failure.server({required String message, required int statusCode})
factory Failure.validation({required String message, Map<String, String> errors})
factory Failure.timeout({required String message})

// ✅ Data: Exception → Failure conversion
try {
  final dto = await _api.getUser(id);
  return Right(dto.toDomain());
} on DioException catch (e) {
  return Left(NetworkFailure(message: e.message ?? 'Network error'));
} on ServerException catch (e) {
  return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
}
```

## Core Module Structure

```
core/
├── router/                    # go_router configuration, route guards
├── theme/                     # AppTheme, AppColors, AppTypography, AppSpacing
├── l10n/                      # ARB localization files (en, ru, uz)
├── network/                   # Dio client, interceptors, websocket
├── supabase/                  # Supabase configuration and provider
├── services/                  # FCM, analytics, app lifecycle, secure storage
├── providers/                 # Riverpod providers (locale, router)
├── extensions/                # ContextExtensions, StringExtensions, DateExtensions
├── widgets/                   # Reusable: AppButton, AppCard, AppScaffold, AppSnackbar
├── errors/                    # Failures, Exceptions
├── usecases/                  # UseCase base class
├── utils/                     # Formatters, validators, device info, logger
├── mock/                      # Mock data for testing
└── constants/                 # Routes, constants
```

## Features Module Structure

Each feature follows the same pattern:

```
features/[feature]/
├── data/
│   ├── api/                   # HTTP clients (Dio-based)
│   ├── dto/                   # JSON serializable DTOs
│   └── repository_impl/       # Repository implementations
├── domain/
│   ├── entities/              # @freezed domain objects
│   ├── repository/            # Abstract repository interfaces
│   └── usecases/              # Business logic
└── presentation/
    ├── screens/               # Full-page widgets (ConsumerWidget/StatefulWidget)
    ├── providers/             # Riverpod providers, notifiers
    └── widgets/               # Reusable UI components
```

### Implemented Features

| Feature | Purpose | Status |
|---------|---------|--------|
| **auth** | User authentication, login, signup, email verification | Core |
| **board** | Discussion board, posts, comments | Active |
| **chat** | Real-time messaging with WebSocket/STOMP | Active |
| **friends** | Friend management, friend requests | Active |
| **profile** | User profiles, settings, statistics | Active |
| **timetable** | Course schedule, GPA calculator | Active |
| **settings** | App preferences, theme, language | Active |
| **notification** | Push notifications, notification center | Active |
| **verification** | Email/university verification | Active |
| **report** | Reporting inappropriate content | Active |

## Shared Components

```
shared/
├── components/
│   ├── main_scaffold.dart      # Main app layout with bottom navigation
│   ├── post_card.dart          # Reusable board post component
│   ├── post_card_compact.dart  # Compact post display
│   ├── course_card.dart        # Course/timetable component
│   └── dismiss_keyboard.dart   # Utility to close keyboard
```

## For AI Agents

### Critical Rules
1. **Domain Layer Purity**: No Flutter, Dio, platform imports in domain/
2. **Riverpod Usage**: `ref.watch()` in build, `ref.read()` in callbacks
3. **AutoDispose**: Use `autoDispose` by default to prevent memory leaks
4. **Navigation**: go_router only, never use Navigator
5. **Error Handling**: Always return `Either<Failure, T>` from repositories
6. **Localization**: Use `AppLocalizations.of(context)!.keyName` after running `flutter gen-l10n`

### Working in This Directory

#### When Adding a Feature
1. Create directory: `features/[name]/`
2. Domain first: Define entities → repository interface
3. Data layer: Create DTOs with `.toDomain()` → implement repository
4. Presentation: Create providers → screens → widgets
5. Register routes in `core/router/app_router.dart`
6. Add l10n keys to `lib/core/l10n/app_en.arb` (then run `flutter gen-l10n`)

#### When Adding Shared Components
1. Create file in `shared/components/[name].dart`
2. Document parameters and usage in file header
3. Keep components feature-agnostic
4. Use design system (AppColors, AppTypography, AppSpacing)

#### When Modifying Core Services
- **Router changes**: Update `core/router/app_router.dart` and `core/constants/routes.dart`
- **Theme changes**: Edit `core/theme/app_theme.dart` and color definitions
- **Network changes**: Modify `core/network/dio_client.dart` and interceptors
- **New service**: Create in `core/services/` and expose via Riverpod provider

### Common Patterns

#### Riverpod Provider Setup
```dart
// ✅ Repository provider
final userRepositoryProvider = Provider((ref) {
  final api = ref.watch(userApiProvider);
  return UserRepositoryImpl(api);
});

// ✅ Data provider (auto-dispose for memory efficiency)
final currentUserProvider = FutureProvider.autoDispose<User>((ref) async {
  final repo = ref.watch(userRepositoryProvider);
  final result = await repo.getCurrentUser();
  return result.fold((l) => throw l, (r) => r);
});

// ✅ State notifier for mutations
class UserNotifier extends StateNotifier<User> {
  UserNotifier(this._repo) : super(User.empty());
  final UserRepository _repo;

  Future<void> updateProfile(User user) async {
    final result = await _repo.updateUser(user);
    result.fold(
      (failure) => throw failure,
      (updated) => state = updated,
    );
  }
}

final userNotifierProvider = StateNotifierProvider.autoDispose<UserNotifier, User>((ref) {
  final repo = ref.watch(userRepositoryProvider);
  return UserNotifier(repo);
});
```

#### Selecting Specific Fields to Prevent Rebuilds
```dart
// ✅ Only rebuild when email changes, not entire user
final userEmailProvider = FutureProvider.autoDispose<String>((ref) {
  return ref.watch(userProvider.select((user) => user.email));
});
```

#### Screen with Loading/Error States
```dart
class UserProfileScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    return userAsync.when(
      data: (user) => UserProfileView(user: user),
      loading: () => const AppLoadingIndicator(),
      error: (error, stackTrace) {
        final failure = error as Failure;
        return AppErrorWidget(
          message: failure.message,
          onRetry: () => ref.refresh(currentUserProvider),
        );
      },
    );
  }
}
```

#### Using Repository Pattern
```dart
// ✅ Always return Either<Failure, T>
@override
Future<Either<Failure, User>> getUser(String id) async {
  try {
    final dto = await _api.getUser(id);
    return Right(dto.toDomain());
  } on DioException catch (e) {
    return Left(NetworkFailure(message: e.message ?? 'Network error'));
  } on ServerException catch (e) {
    return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
  } on UnimplementedError {
    return Left(NetworkFailure(message: 'Feature not implemented'));
  } catch (e) {
    return Left(UnknownFailure(message: e.toString(), error: e));
  }
}
```

### Code Generation

After modifying:
- **@freezed entities or DTOs**: Run `flutter pub run build_runner build --delete-conflicting-outputs`
- **@JsonSerializable DTOs**: Same command above
- **Localization (ARB files)**: Run `flutter gen-l10n`

Watch mode for development:
```bash
flutter pub run build_runner watch
```

### Testing Patterns

```dart
// ✅ Domain layer (pure Dart, no Flutter dependencies)
test('User initials are correct', () {
  final user = User(id: '1', email: 'john@example.com', nickname: 'John Doe');
  expect(user.initials, equals('JD'));
});

// ✅ Data layer (mock API, test repository conversion)
test('UserRepository converts DTO to entity', () async {
  final mockApi = MockUserApi();
  final repo = UserRepositoryImpl(mockApi);

  final result = await repo.getUser('1');
  expect(result, isA<Right>());
  expect(result.getRight().nickname, equals('John'));
});

// ✅ Presentation layer (use ProviderContainer from riverpod)
testWidgets('UserScreen displays user data', (tester) async {
  final container = ProviderContainer(
    overrides: [
      userRepositoryProvider.overrideWithValue(mockRepository),
    ],
  );

  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const UserScreen()),
  );

  expect(find.text('John'), findsOneWidget);
});
```

### Design System Usage

```dart
// ✅ Use defined colors, typography, spacing
Container(
  color: AppColors.primary,
  padding: EdgeInsets.all(AppSpacing.md),
  child: Text('Hello', style: AppTypography.bodyMedium),
)

// ✅ Responsive sizing
double width = context.screenWidth > 600 ? 500 : context.screenWidth - 32;
```

### State Management Guidelines

**DO:**
- Use `ref.watch()` in `build()` method for reactive updates
- Use `ref.read()` in callbacks/button taps
- Use `autoDispose` by default
- Select specific fields with `.select()` to limit rebuilds

**DON'T:**
- Use `ref.watch()` outside `build()` method
- Forget `autoDispose` (causes memory leaks)
- Pass context from one widget tree to another
- Use Navigator (only go_router)
- Put business logic in widgets

### Navigation Examples

```dart
// ✅ Using context extensions
context.go('/users/123');
context.push('/settings');
context.pushNamed('user_profile', pathParameters: {'id': '123'});
context.pop();

// ✅ Via Riverpod (for complex routing)
ref.read(routerProvider).go('/board');

// ✅ Route guards (in router provider)
if (!isAuthenticated && state.uri.path != '/login') {
  return '/login';
}
```

## Dependencies

### External Packages (Core)
- **flutter_riverpod**: State management
- **go_router**: Navigation
- **freezed_annotation**: Immutable entities
- **json_serializable**: JSON serialization
- **fpdart**: Functional programming (Either type)
- **dio**: HTTP client
- **supabase_flutter**: Backend service
- **firebase_core**, **firebase_messaging**, **firebase_crashlytics**: Backend services
- **flutter_screenutil**: Responsive design
- **intl**: Localization

### Internal Dependencies
- `core/`: Shared utilities, theme, services, router
- `features/`: Independent feature modules
- `shared/`: Cross-feature UI components

## BuildRunner & Code Generation

Code generation is required for @freezed and @JsonSerializable:

```bash
# Single build (after model changes)
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (during development)
flutter pub run build_runner watch

# Clean generated files
flutter pub run build_runner clean
```

Generated files (.freezed.dart, .g.dart) should be committed to version control.

## Localization

Add strings to `lib/core/l10n/app_en.arb` (English), then run:
```bash
flutter gen-l10n
```

Access in UI:
```dart
final l10n = AppLocalizations.of(context)!;
Text(l10n.helloWorld)
```

## Testing

Run tests:
```bash
flutter test
flutter test test/features/auth/
flutter test --coverage
```

## Styling & Design System

All hard-coded values are forbidden. Use:
- **Colors**: `AppColors` class (light/dark variants)
- **Typography**: `AppTypography` class
- **Spacing**: `AppSpacing` constants
- **Sizing**: `AppDimensions` class
- **Responsive**: `flutter_screenutil` or `context.screenWidth`

## Manual AGENTS Maintenance

This document covers static structure. For dynamic documentation:
- Update when new features are created
- Document architectural decisions in feature-specific comments
- Link to design docs for complex screens
- Track deprecated patterns
