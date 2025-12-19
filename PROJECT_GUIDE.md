# 🚀 Nonstop — Project Development Guideline

**Your Single Source of Truth**

---

## 📄 **Document Info**

**Version**: 1.0

**📅 Last Updated**: December 16, 2025

**👥 Authors**: 홍순기, Dylan, Sim Hyun-soo

---

## 🎯 **1. Purpose**

This document defines the **shared engineering standards** for the **Nonstop** Flutter application — covering architecture, structure, coding conventions, networking, real-time communication, UI patterns, Git workflow, and operational checklists.

**✨ Goal**: Keep the codebase **scalable, consistent, testable, and easy** for any team member to extend.

---

## 🧠 **2. Engineering Principles**

### 🔀 **Separation of Concerns**

- **UI renders state**; it does **not** own business logic.
- **Business logic** lives in **Notifiers/UseCases**.
- **Data access** (API, storage) is isolated behind **repositories**.

### 🏗️ **Clean Architecture (3 Layers)**

- **📱 Presentation** → UI + state (Riverpod) + navigation
- **🧠 Domain** → entities + repository interfaces + use cases (pure Dart)
- **💾 Data** → DTOs + API clients + repository implementations + persistence

### 📁 **Feature-Based Organization**

- Organize code by **feature**, not by layer at the top level.
- Each feature contains: `data/`, `domain/`, `presentation/`.

### 🚫 **Domain Layer Isolation (Strict)**

- Domain must **not import** Flutter framework, Dio, or other infrastructure libraries.
- Domain types should remain **portable and framework-agnostic**.

---

## 🗺️ **3. Architecture Overview**

```
┌─────────────────────────────────────────────────┐
│         📱 Presentation Layer (UI + State)      │
│  • Screens (ConsumerWidget)                     │
│  • Providers (Riverpod)                         │
│  • Notifiers (StateNotifier, AsyncNotifier)     │
└───────────────────┬─────────────────────────────┘
                    ↕ (One-way dependency)
┌─────────────────────────────────────────────────┐
│         🧠 Domain Layer (Business Logic)        │
│  • Entities (Data models)                       │
│  • Repository Interfaces                        │
│  • UseCases (Business rules)                    │
└───────────────────┬─────────────────────────────┘
                    ↕ (One-way dependency)
┌─────────────────────────────────────────────────┐
│         💾 Data Layer (Persistence & Networking)│
│  • API (Dio)                                    │
│  • DTOs/Models                                  │
│  • Repository Implementations                   │
│  • Local Storage (Hive)                         │
└─────────────────────────────────────────────────┘

```

### ⚙️ **Core Layer (Cross-cutting concerns)**

- **🌐 Routing and navigation** (go_router)
- **🌍 Localization** (l10n)
- **🎨 Theme system**
- **🛠️ Utilities & extensions**
- **⚠️ Error handling infrastructure**
- **📡 Network client** (Dio + interceptors)
- **🔌 WebSocket client** (reconnection, protocol, keep-alive)
- **🧩 Shared widgets** (scaffold, loaders, error UI)

---

## ✍️ **4. Coding Standards**

### 🏷️ **Naming Conventions**

- **📄 Files**: `snake_case` (e.g., `user_profile_screen.dart`)
- **🏛️ Classes / Types**: `PascalCase` (e.g., `UserProfileScreen`)
- **📦 Variables / Methods**: `camelCase` (e.g., `userName`, `getUserData()`)
- **🔒 Constants**: `lowerCamelCase` (e.g., `defaultTimeout`)
- **🙈 Private members**: prefix with `_` (e.g., `_initData()`)

### 🏗️ **Build Method Discipline**

- Keep `build()` **minimal** (ideal < ~50 lines).
- Extract complex UI into:
  - **private methods** (`_buildHeader()`)
  - **reusable widgets** (separate files)
- Prefer `const` constructors **whenever possible**.

### 🧩 **UI Logic Rule**

- **No business logic in widgets**.
- **Widgets**:
  - watch providers
  - display loading / error / data states
  - forward user intents to notifiers/usecases

---

## 📂 **5. Folder Structure**

### 🗂️ **Directory Layout (Reference)**

```
lib/
│
├─ 🧠 core/
│  ├─ ⚙️ config/
│  │  ├─ env_config.dart
│  │  └─ app_config.dart
│  │
│  ├─ 📏 constants/
│  │  ├─ api_constants.dart
│  │  ├─ app_constants.dart
│  │  └─ routes.dart                  # 🎯 SINGLE SOURCE OF TRUTH
│  │
│  ├─ ⚠️ errors/
│  │  ├─ failures.dart                # Failure types (@freezed)
│  │  ├─ exception_handler.dart       # Exception → Failure mapping
│  │  └─ error_messages.dart
│  │
│  ├─ 🔧 extensions/
│  │  ├─ string_extensions.dart
│  │  ├─ date_extensions.dart
│  │  └─ context_extensions.dart
│  │
│  ├─ 🌍 l10n/
│  │  ├─ app_en.arb
│  │  ├─ app_ru.arb
│  │  ├─ app_uz.arb
│  │  └─ app_localizations.dart       # generated
│  │
│  ├─ 📡 network/
│  │  ├─ dio_client.dart
│  │  ├─ websocket_client.dart
│  │  ├─ reconnection_manager.dart
│  │  └─ api_interceptor.dart
│  │
│  ├─ 🧭 router/
│  │  ├─ app_router.dart
│  │  ├─ deep_link_handler.dart
│  │  └─ router_provider.dart
│  │
│  ├─ 🎨 theme/
│  │  ├─ app_theme.dart
│  │  ├─ app_colors.dart
│  │  ├─ app_typography.dart
│  │  ├─ app_spacing.dart
│  │  └─ app_dimensions.dart
│  │
│  ├─ 🛠️ utils/
│  │  ├─ validators.dart
│  │  ├─ date_formatter.dart
│  │  ├─ string_utils.dart
│  │  ├─ logger.dart
│  │  └─ device_info.dart
│  │
│  └─ 🧩 widgets/
│     ├─ app_scaffold.dart
│     ├─ app_loading_indicator.dart
│     ├─ app_error_widget.dart
│     ├─ app_button.dart
│     └─ global_error_handler.dart
│
├─ 🚀 features/
│  ├─ 🔐 auth/
│  │  ├─ data/
│  │  ├─ domain/
│  │  └─ presentation/
│  ├─ 📋 board/
│  │  ├─ data/
│  │  ├─ domain/
│  │  └─ presentation/
│  ├─ 💬 chat/
│  │  ├─ data/
│  │  ├─ domain/
│  │  └─ presentation/
│  ├─ 👥 friends/
│  │  └─ ... (same 3-layer structure)
│  └─ 📅 timetable/
│     └─ ... (same 3-layer structure)
│
├─ 📱 app.dart
├─ 🚀 main.dart
└─ ⚙️ l10n.yaml

```

### 📌 **Folder Purpose Reference**

| Folder                     | Purpose                                       |
| -------------------------- | --------------------------------------------- |
| `core/config/`             | ⚙️ Environment-specific settings              |
| `core/constants/`          | 📏 App-wide constants, routes, API endpoints  |
| `core/errors/`             | ⚠️ Failure types + exception handling         |
| `core/extensions/`         | 🔧 Dart extensions                            |
| `core/l10n/`               | 🌍 Localization ARB + generated code          |
| `core/network/`            | 📡 Dio + WebSocket + interceptors             |
| `core/router/`             | 🧭 go_router configuration + navigation logic |
| `core/theme/`              | 🎨 Colors, typography, spacing, dimensions    |
| `core/utils/`              | 🛠️ Validators, formatters, helpers            |
| `core/widgets/`            | 🧩 Shared reusable widgets                    |
| `features/*/data/`         | 💾 API/DTOs/models/repo impl                  |
| `features/*/domain/`       | 🧠 entities/repo interfaces/usecases          |
| `features/*/presentation/` | 📱 screens/providers/widgets                  |

---

## 🧭 **6. Navigation & Routing (go_router)**

### 🛣️ **Routes: Single Source of Truth**

```dart
// lib/core/constants/routes.dart

class Routes {
  // 🚦 Splash & Auth
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // 🏠 Main Navigation
  static const String home = '/home';
  static const String board = '/board';
  static const String chat = '/chat';
  static const String friends = '/friends';
  static const String timetable = '/timetable';
  static const String settings = '/settings';

  // 📄 Detail Screens (with parameters)
  static const String boardDetail = '/board/:id';
  static const String chatRoom = '/chat/:roomId';
  static const String userProfile = '/profile/:userId';

  // 🔍 Query parameters
  static const String search = '/search?query=:query';
  static const String notifications = '/notifications';

  // 🛠️ Helpers
  static String boardDetailPath(String id) => '/board/$id';
  static String chatRoomPath(String roomId) => '/chat/$roomId';
  static String userProfilePath(String userId) => '/profile/$userId';
  static String searchPath(String query) => '/search?query=$query';
}

```

### 🌐 **Router Setup (Auth Guard + Shell Navigation)**

```dart
// lib/core/router/app_router.dart

import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authProvider);

  return GoRouter(
    initialLocation: Routes.splash,
    redirect: (context, state) {
      final isAuthenticated = auth.maybeWhen(
        data: (user) => user != null,
        orElse: () => false,
      );

      final isGoingToLogin = state.uri.toString().startsWith(Routes.login) ||
          state.uri.toString().startsWith(Routes.register);

      if (!isAuthenticated && !isGoingToLogin) return Routes.login;
      if (isAuthenticated && state.uri.toString() == Routes.splash) return Routes.home;

      return null;
    },
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => const RegisterScreen(),
      ),

      // 🏠 Main navigation (example)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          // 📋 Board
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.board,
                builder: (context, state) => const BoardListScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return BoardDetailScreen(boardId: id);
                    },
                  ),
                ],
              ),
            ],
          ),

          // 💬 Chat
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.chat,
                builder: (context, state) => const ChatListScreen(),
                routes: [
                  GoRoute(
                    path: ':roomId',
                    builder: (context, state) {
                      final roomId = state.pathParameters['roomId']!;
                      return ChatRoomScreen(roomId: roomId);
                    },
                  ),
                ],
              ),
            ],
          ),

          // 👥 Friends
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.friends,
                builder: (context, state) => const FriendsListScreen(),
                routes: [
                  GoRoute(
                    path: ':userId',
                    builder: (context, state) {
                      final userId = state.pathParameters['userId']!;
                      return UserProfileScreen(userId: userId);
                    },
                  ),
                ],
              ),
            ],
          ),

          // 📅 Timetable
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.timetable,
                builder: (context, state) => const TimetableScreen(),
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: Routes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
  );
});

```

### 📱 **Navigation Usage Rules**

- Use `context.go()` or `context.push()`.
- Use `context.pop()` for back navigation.
- ❌ Do **not** call `Navigator.push/pop` directly.

---

## 🧠 **7. State Management (Riverpod)**

### 🎭 **Recommended Provider Patterns**

- `StateProvider`: small mutable UI-only values
- `StateNotifier`: complex synchronous state
- `AsyncNotifier`: async workflows (auth bootstrap, login, refresh)
- `FutureProvider.autoDispose`: fetch-once, disposable
- `StreamProvider.autoDispose`: real-time streams

### ✅ **Best Practices**

- Watch providers at the **top** of `build()`.
- Use `select()` to **limit rebuilds**.
- Use `listen()` only for **side effects** (navigation, snackbars).
- Use `autoDispose` for **temporary flows and streams**.

---

## ⚠️ **8. Error Handling**

### 🏗️ **Failure Hierarchy (Domain-Friendly)**

```dart
// lib/core/errors/failures.dart

@freezed
class Failure with _$Failure {
  const factory Failure.network({ required String message }) = NetworkFailure;
  const factory Failure.authentication({ required String message }) = AuthenticationFailure;
  const factory Failure.authorization({ required String message }) = AuthorizationFailure;
  const factory Failure.validation({
    required String message,
    @Default({}) Map<String, String> errors,
  }) = ValidationFailure;
  const factory Failure.server({ required String message, required int statusCode }) = ServerFailure;
  const factory Failure.timeout({ required String message }) = TimeoutFailure;
  const factory Failure.unknown({ required String message }) = UnknownFailure;
}

```

### 🔄 **Exception → Failure Mapping**

- Centralize mapping in `ExceptionHandler`.
- Keep **user-friendly text** separate from raw exceptions.
- Prefer **predictable failure types** across the app.

### 🌐 **Global Error UX**

- Centralize snackbar/dialog patterns in `GlobalErrorHandler`.
- Use `ref.listen()` to react to error transitions and show UI feedback.

---

## 📡 **9. API Communication (Dio)**

### ⚙️ **Dio Client + Interceptors**

- BaseOptions configured from `EnvConfig`.
- **Interceptors**:
  - 🔐 JWT injection (Authorization header)
  - 📝 Error logging / standardization
  - 🔍 Optional request/response logging (dev only)
- Token refresh behavior (on 401) is handled inside the interceptor.

---

## 🔌 **10. WebSocket Architecture**

### 📨 **Protocol (JSON Messages)**

Use typed messages (via `freezed`) to keep payload contracts stable:

- `auth`
- `message` (send/delivered/new/read)
- `presence` (typing/online/offline)
- `ping`
- `error`

### 🛠️ **Client Responsibilities**

- Connect with token
- Wait for auth handshake
- Keep-alive (ping interval)
- Reconnection (exponential backoff via `ReconnectionManager`)
- Broadcast:
  - message stream
  - status stream

---

## 🛠️ **11. Feature Implementation Blueprint (Example)**

When building a new feature (e.g., Board):

1. 🧠 **Entity** in `domain/entities`
2. 📦 **DTO** in `data/dto` with `toDomain()`
3. 🌐 **API interface + implementation** in `data/api`
4. 📡 **Repository interface** in `domain/repository`
5. 💾 **Repository implementation** in `data/repository_impl`
6. 🎭 **Providers / Notifiers** in `presentation/providers`
7. 📱 **Screens** in `presentation/screens`
8. 🧩 **Widgets** in `presentation/widgets`
9. 🛣️ Add routes + localization if needed
10. 🧪 Add tests

---

## 📦 **12. Dependencies & Configuration**

### 📄 **pubspec.yaml (Key Notes)**

- Use `freezed` + `json_serializable` for models.
- Prefer `flutter_secure_storage` for tokens.
- Use `cached_network_image` for remote images.
- Use `flutter_dotenv` for environment configuration.

### 🔤 **Fonts (Pretendard)**

```yaml
fonts:
  - family: Pretendard
    fonts:
      - asset: assets/fonts/Pretendard-Regular.ttf
      - asset: assets/fonts/Pretendard-Bold.ttf
        weight: 700
```

### 🌍 **Localization (l10n.yaml)**

```yaml
l10n:
  arb-dir: lib/core/l10n
  template-arb-file: app_en.arb
```

---

## 🐙 **13. Git Workflow**

### 📝 **Conventional Commits**

Format: `<type>(<scope>): <subject>`

**Types**:

- `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `perf`, `ci`, `init`

**Examples**:

```
feat(chat): implement WebSocket real-time messaging
fix(board): correct pagination offset calculation
docs(readme): add installation instructions
refactor(auth): extract token refresh logic
test(chat): add message delivery confirmation test

```

### 🌿 **Branch Strategy (Git Flow)**

```
main (production)
  ↓ PR + code review required
dev (integration)
  ↓ PR recommended
feature/<name> (development)

```

**Branch naming**:

- `feature/auth-login`
- `feature/chat-websocket`
- `fix/crash-on-logout`
- `docs/setup-guide`

---

## 🚀 **14. Project Execution**

### 🛠️ **Initial Setup**

```
git clone <repo>
cd nonstop
flutter clean
flutter pub get
flutter gen-l10n

cp .env.example .env
# ✏️ Edit .env with values

flutter pub run build_runner build --delete-conflicting-outputs
flutter run

```

**Optional**:

```
flutter run -d <device_id>
flutter run -d chrome
flutter run -d emulator-5554

```

### 🌍 **Environment Variables (.env)**

```
API_BASE_URL=https://api-staging.nonstop.app
WS_BASE_URL=wss://api-staging.nonstop.app/ws
ENVIRONMENT=staging

```

### ⚙️ **Code Generation**

```
flutter pub run build_runner build --delete-conflicting-outputs
flutter pub run build_runner watch
flutter gen-l10n

```

---

## 🧪 **15. Testing**

### ✅ **What to Test**

- Provider/Notifier behavior (**unit tests**)
- Screen rendering and interaction (**widget tests**)
- Critical end-to-end flows (**integration tests**)

### 🏃‍♂️ **Run Tests**

```
flutter test
flutter test test/unit/features/board/providers/posts_provider_test.dart
flutter test --coverage
flutter test --watch

```

---

## ⚡ **16. Performance Rules**

- Prefer `const` widgets.
- Avoid watching entire objects when only one field is needed (`select()`).
- Use `autoDispose` to prevent **memory leaks**.
- **Debounce** user input for search and live filters.
- Use **optimized images** (correct sizing + caching).

---

## 🌍 **17. Localization**

### ➕ **Adding Text**

1. Add key to `app_en.arb`
2. Add translations to other ARB files
3. Run `flutter gen-l10n`
4. Use in UI:

```dart
Text(AppLocalizations.of(context)!.helloWorld)

```

---

## 🎨 **18. Theme & Styling**

### 🎨 **Color System**

Keep all colors in `AppColors` (❌ no hardcoded colors in UI).

### 🔤 **Typography System**

Keep all text styles in `AppTypography`.

### 📏 **Spacing System**

```dart
class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
}

```

---

## 🛠️ **19. Troubleshooting**

| Issue                               | Solution                                                                                              |
| ----------------------------------- | ----------------------------------------------------------------------------------------------------- |
| 🔌 WebSocket disconnects frequently | Verify ping interval, server keep-alive settings, network stability                                   |
| 📨 Duplicate messages               | Ensure `clientMessageId` uniqueness; deduplicate on server                                            |
| 🧠 Memory leak                      | Use `autoDispose` on StreamProviders; verify provider lifecycle                                       |
| 🖼️ Slow image loading               | Use `CachedNetworkImage` with correct sizing; optimize resolution                                     |
| 🔑 Token expired                    | Confirm refresh logic in Dio interceptor; store token securely                                        |
| ⚙️ Build runner failures            | `flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs` |
| 🌍 Localization not updating        | Run `flutter gen-l10n` after ARB changes                                                              |
| 🧭 Navigation issues                | Check `Routes` and path parameters; verify router initialization                                      |
| 📱 UI not rebuilding                | Confirm `.watch()` is used; avoid `.read()` in build                                                  |

---

## ✅ **20. Checklists**

### 🚀 **Before Starting a Feature**

- [ ] Create feature structure (`data/domain/presentation`)
- [ ] Define entity + DTO mapping
- [ ] Implement API interface + impl
- [ ] Implement repository interface + impl
- [ ] Add providers/notifiers
- [ ] Build screens/widgets
- [ ] Add error handling and UX messaging
- [ ] Add tests
- [ ] Add routes and localization keys if needed
- [ ] Validate WebSocket flows (if real-time)

### 📝 **Before Committing**

- [ ] Style rules followed
- [ ] No hardcoded strings (use l10n)
- [ ] No hardcoded colors (use AppColors)
- [ ] Failure mapping used consistently
- [ ] Tests pass and build succeeds
- [ ] Commit message follows convention

### 🚀 **Before Pushing to Dev**

- [ ] Tested on real device
- [ ] No console warnings/errors
- [ ] Performance acceptable
- [ ] Memory stable (no leaking streams)
- [ ] Screenshots added to PR (if UI changes)
- [ ] PR description is clear

---

## 📞 **21. Contacts & Support**

**👨‍💻 FE Lead**: 홍순기, Dylan

**👨‍💻 BE Lead**: 심현수

**🎨 Design**: 박지선

For questions or clarifications, contact the leads above. 💬

---

_✨ Let's build something amazing together! 🚀_
