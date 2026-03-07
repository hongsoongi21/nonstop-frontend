<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-03-08 | Updated: 2026-03-08 -->

# features

Directory containing all feature modules following Clean Architecture with three layers: data, domain, and presentation.

## Purpose

This directory is the core of the application, organized by domain features. Each feature is self-contained with all its business logic, data handling, and UI components co-located. This structure ensures:

- **Feature Independence**: Each feature can be developed, tested, and maintained separately
- **Scalability**: New features can be added without modifying existing ones
- **Clean Separation**: Clear boundaries between layers (data, domain, presentation)
- **Reusability**: Shared utilities live in `../core/`

## Feature Modules

| Feature | Purpose | Key Entities | State Management |
|---------|---------|--------------|------------------|
| `auth/` | Authentication & authorization | `User`, `Policy` | Email/OAuth login, token refresh, session state |
| `board/` | Community bulletin board | `Post`, `Comment`, `Reaction` | Post listing, detail view, create/edit posts |
| `chat/` | Real-time messaging | `ChatMessage`, `ChatRoom`, `ReadReceipt` | WebSocket/STOMP messages, room state, typing indicators |
| `friends/` | Friend management | `Friend`, `FriendRequest` | Friend list, request state, blocking |
| `notification/` | Push notifications | Push state, notification history | Firebase Cloud Messaging integration |
| `profile/` | User profile management | `UserProfile`, `ProfileStats`, `UserSettings` | Profile editing, stats fetching, settings management |
| `report/` | Content & user reporting | Report submissions | Report form state, submission tracking |
| `settings/` | App settings & privacy | Privacy settings, notification preferences | Local + remote settings sync |
| `timetable/` | Class schedule management | `Timetable`, `TimetableEntry`, `Semester`, `GpaCourse` | Schedule editing, semester selection, GPA tracking |
| `verification/` | University email verification | Verification state | Email verification flow, code submission |

## Architecture Pattern

Every feature follows this strict three-layer structure:

```
feature/
├── data/                        # Data layer: External data sources
│   ├── api/                     # API client interfaces & implementations
│   │   ├── [feature]_api.dart               # API interface
│   │   └── [feature]_api_impl.dart          # API implementation (Dio)
│   │
│   ├── dto/                     # Data Transfer Objects (JSON serialization)
│   │   ├── [entity]_dto.dart                # DTO with .toDomain() / .fromDomain()
│   │   └── [request/response]_dto.dart      # API request/response types
│   │
│   ├── models/                  # (Optional) Local data models separate from DTOs
│   │
│   └── repository_impl/         # Repository implementations
│       └── [feature]_repository_impl.dart   # Converts DTO→Entity, handles errors
│
├── domain/                      # Domain layer: Pure Dart business logic
│   ├── entities/                # Domain models (@freezed)
│   │   ├── [entity].dart                    # Main entity with computed properties
│   │   └── [enum/value_object].dart         # Enums, ValueObjects
│   │
│   ├── repository/              # Repository interfaces (contracts)
│   │   └── [feature]_repository.dart        # Abstract class defining data operations
│   │
│   └── usecases/                # Business logic encapsulation
│       └── [usecase]_usecase.dart           # Implements specific business rules
│
└── presentation/                # Presentation layer: UI & state management
    ├── providers/               # Riverpod state management
    │   ├── [feature]_provider.dart          # Main feature state (StateNotifierProvider)
    │   └── [sub]_provider.dart              # Sub-feature providers (FutureProvider, etc)
    │
    ├── screens/                 # Full-page screens/routes
    │   ├── [feature]_screen.dart            # Main screen widget
    │   └── [sub]_screen.dart                # Sub-screens
    │
    └── widgets/                 # Reusable feature-specific widgets
        └── [component]_widget.dart          # Custom widgets for this feature
```

## Critical Rules for All Features

### 1. Domain Layer (Pure Business Logic)
- **NO imports** from `flutter`, `dio`, platform libraries
- Only pure Dart + `freezed`, `fpdart`
- Entities use `@freezed` for immutability
- All async operations return `Future<Either<Failure, T>>`

Example:
```dart
// domain/entities/user.dart - CORRECT
import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    String? nickname,
  }) = _User;

  const User._();

  bool get isEmailVerified => email.isNotEmpty;
}
```

### 2. Data Transfer Objects (DTOs)
- Must have `@JsonSerializable` with `fromJson` factory
- Implement `.toDomain()` to convert to domain entity
- Implement `.fromDomain()` static method (or constructor)
- Handle API field name mismatches with `@JsonKey(name: 'apiFieldName')`

Example:
```dart
// data/dto/user_dto.dart
@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    @JsonKey(name: 'emailAddress') required String email,
    String? nickname,
  }) = _UserDto;

  const UserDto._();

  factory UserDto.fromJson(Map<String, dynamic> json) =>
    _$UserDtoFromJson(json);

  /// DTO to Domain conversion
  UserProfile toDomain() => UserProfile(
    id: id,
    email: email,
    nickname: nickname,
  );
}
```

### 3. Repository Pattern
- **Domain**: Abstract class defining operations
- **Data**: Implementation that handles DTOs, API calls, error conversion

Domain layer:
```dart
// domain/repository/user_repository.dart
import 'package:fpdart/fpdart.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUser(String userId);
  Future<Either<Failure, User>> updateUser(User user);
}
```

Data layer:
```dart
// data/repository_impl/user_repository_impl.dart
class UserRepositoryImpl implements UserRepository {
  final UserApi _api;
  final UserCacheRepository _cache;  // Optional local cache

  @override
  Future<Either<Failure, User>> getUser(String userId) async {
    try {
      final dto = await _api.fetchUser(userId);
      return Right(dto.toDomain());
    } on DioException catch (e) {
      return Left(ApiFailure.fromDio(e));
    }
  }
}
```

### 4. State Management (Riverpod)
- Use `StateNotifierProvider` for stateful features
- Use `FutureProvider.autoDispose` for one-off data fetches
- Use `StreamProvider.autoDispose` for real-time data (WebSocket, Firestore)
- Always use `.autoDispose` modifier to prevent memory leaks
- **Never put business logic in widgets** - delegate to notifiers

Example:
```dart
// presentation/providers/user_provider.dart
final userProvider = StateNotifierProvider.autoDispose<UserNotifier, AsyncValue<User>>((ref) {
  final repo = ref.watch(userRepositoryProvider);
  return UserNotifier(repo);
});

class UserNotifier extends StateNotifier<AsyncValue<User>> {
  final UserRepository _repo;

  UserNotifier(this._repo) : super(const AsyncValue.loading());

  Future<void> fetchUser(String id) async {
    state = const AsyncValue.loading();
    final result = await _repo.getUser(id);
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (user) => AsyncValue.data(user),
    );
  }
}
```

### 5. API Client Pattern
- Use `Dio` with interceptors from `../core/network/dio_client.dart`
- Define API interface first, then implementation
- Handle pagination, errors, timeouts consistently

```dart
// data/api/user_api.dart
abstract class UserApi {
  Future<UserDto> fetchUser(String userId);
  Future<UserDto> updateUser(String userId, UpdateUserDto dto);
}

// data/api/user_api_impl.dart
class UserApiImpl implements UserApi {
  final Dio _dio;

  UserApiImpl(this._dio);

  @override
  Future<UserDto> fetchUser(String userId) async {
    final response = await _dio.get('/users/$userId');
    return UserDto.fromJson(response.data);
  }
}
```

### 6. Error Handling
- All repository methods return `Either<Failure, T>`
- Convert exceptions to typed failures from `../core/errors/failures.dart`
- Never throw exceptions from presentation layer

```dart
// In repository_impl
try {
  final response = await _api.getUser(id);
  return Right(response.toDomain());
} on DioException catch (e) {
  if (e.response?.statusCode == 401) {
    return Left(AuthFailure('Unauthorized'));
  }
  return Left(ApiFailure(e.message ?? 'Unknown error'));
} catch (e) {
  return Left(UnexpectedFailure('$e'));
}
```

## Feature-Specific Guidelines

### Chat Feature (`chat/`)
- Uses **WebSocket + STOMP** for real-time messages
- `ChatMessage` has `isSending` and `hasError` states for optimistic updates
- `MessageType` enum handles different message types (text, image, system)
- Real-time updates via `StreamProvider` connected to WebSocket

### Timetable Feature (`timetable/`)
- `Semester` enum (SPRING, SUMMER, FALL, WINTER) with display names
- `TimetableEntry` has `dayOfWeek` and time range for schedule display
- `TimetableDetail` contains entries and provides `entriesForDay()` helper
- Conflict detection via `hasConflicts()` method
- Multiple timetables per semester supported

### Profile Feature (`profile/`)
- Separate DTOs for GET (UserProfileDto) and UPDATE (UpdateUserProfileDto)
- `UserProfile` entity includes computed properties and privacy settings
- `ProfileStats` tracks engagement metrics (posts, friends, followers)
- Image upload via dedicated methods (`uploadAvatar`, `uploadCoverImage`)
- Settings sync between local and remote

### Auth Feature (`auth/`)
- Supports multiple auth methods: email/password, Google OAuth, Apple OAuth
- `User` entity has computed properties: `isAdmin`, `isProfileComplete`, `displayName`, `initials`
- Token refresh handled by Dio interceptors
- Policy acceptance tracked separately

## Common Implementation Patterns

### Adding a New Endpoint
1. **Domain**: Add method to repository interface
2. **DTO**: Create request/response DTOs with proper mapping
3. **API**: Add method to API client interface + implementation
4. **Impl**: Implement repository method with error handling
5. **Provider**: Create provider/notifier to expose the operation
6. **Widget**: Use provider in UI with proper error/loading states

### Handling Pagination
```dart
// domain/repository
Future<Either<Failure, List<Item>>> getItems({
  required int page,
  required int pageSize,
});

// presentation/provider
final itemsProvider = StateNotifierProvider.autoDispose<
  ItemsPaginationNotifier,
  AsyncValue<PaginatedItems>
>((ref) => ItemsPaginationNotifier(ref.watch(itemRepositoryProvider)));

class ItemsPaginationNotifier extends StateNotifier<AsyncValue<PaginatedItems>> {
  int _currentPage = 1;

  Future<void> loadMore() async {
    final result = await _repo.getItems(
      page: _currentPage + 1,
      pageSize: 20,
    );
    // Update state with accumulated items
  }
}
```

### Optimistic Updates
```dart
// In notifier, update UI immediately while API call is in-flight
state = AsyncValue.data(currentList..add(newItem));

// Then verify with API
final result = await _repo.addItem(newItem);
result.fold(
  (failure) {
    // Rollback on error
    state = AsyncValue.error(failure, StackTrace.current);
  },
  (_) {
    // Keep the optimistic update
  },
);
```

## Testing Guidelines

Each feature should have:
- **Unit tests** for entities, usecases, repositories (with mocks)
- **Widget tests** for screens and widgets
- **Provider tests** using `ProviderContainer` from `riverpod_test`

```dart
// test/features/user/domain/usecases/get_user_usecase_test.dart
void main() {
  late MockUserRepository mockRepo;
  late GetUserUsecase usecase;

  setUp(() {
    mockRepo = MockUserRepository();
    usecase = GetUserUsecase(mockRepo);
  });

  test('should return User when repository succeeds', () async {
    final user = User(id: '1', email: 'test@test.com');
    when(mockRepo.getUser('1')).thenAnswer((_) async => Right(user));

    final result = await usecase('1');

    expect(result, Right(user));
    verify(mockRepo.getUser('1')).called(1);
  });
}
```

## Key Dependencies

All features depend on:
- `../core/errors/failures.dart` - Failure types
- `../core/network/dio_client.dart` - HTTP client
- `../core/constants/` - Routes, endpoints
- `../core/l10n/` - Localization strings

## File Naming Conventions

| File Type | Naming | Example |
|-----------|--------|---------|
| Entity | `[name].dart` | `user.dart`, `post.dart` |
| DTO | `[name]_dto.dart` | `user_dto.dart`, `create_post_request_dto.dart` |
| API | `[feature]_api.dart` (interface) | `user_api.dart` |
| API Impl | `[feature]_api_impl.dart` | `user_api_impl.dart` |
| Repository | `[feature]_repository.dart` (interface) | `user_repository.dart` |
| Repository Impl | `[feature]_repository_impl.dart` | `user_repository_impl.dart` |
| Usecase | `[action]_usecase.dart` | `get_user_usecase.dart`, `update_user_usecase.dart` |
| Provider | `[feature]_provider.dart` | `user_provider.dart` |
| Screen | `[feature]_screen.dart` | `user_profile_screen.dart` |
| Widget | `[name]_widget.dart` | `user_card_widget.dart` |

## Code Generation

After modifying models with `@freezed` or DTOs with `@JsonSerializable`:

```bash
# Watch mode (recommended during development)
flutter pub run build_runner watch

# One-time build
flutter pub run build_runner build --delete-conflicting-outputs
```

Generated files are `*.freezed.dart` and `*.g.dart` - never edit these directly.

## Quick Checklist for New Features

- [ ] Create 3-layer structure (data, domain, presentation)
- [ ] Domain entities use `@freezed`
- [ ] DTOs implement `.toDomain()` and `.fromDomain()`
- [ ] Repository has interface (abstract) + implementation
- [ ] All async ops return `Either<Failure, T>`
- [ ] Providers use `.autoDispose` modifier
- [ ] Add routes to `../core/constants/routes.dart`
- [ ] Add localization strings to `../core/l10n/app_*.arb`
- [ ] Run `build_runner` to generate code
- [ ] Run `flutter analyze` and `flutter test`

