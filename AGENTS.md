# Nonstop Frontend - Agent Instructions

This document provides essential instructions for AI agents working on the Nonstop Flutter codebase. 
**Strictly follow these guidelines.**

## 1. Environment & Build Commands

*   **Dependency Management**:
    *   Install: `flutter pub get`
    *   Clean: `flutter clean`
*   **Code Generation** (Run after changing models/state):
    *   One-time: `flutter pub run build_runner build --delete-conflicting-outputs`
    *   Watch: `flutter pub run build_runner watch`
*   **Localization**:
    *   Generate: `flutter gen-l10n` (after editing `.arb` files in `lib/core/l10n/`)
*   **Testing**:
    *   All tests: `flutter test`
    *   With coverage: `flutter test --coverage`
    *   Watch mode: `flutter test --watch`
    *   Single file: `flutter test test/path/to/test.dart`
*   **Running**:
    *   Default: `flutter run`
    *   Specific device: `flutter run -d <device_id>` (e.g., `chrome`)
*   **Linting**:
    *   Analyze: `flutter analyze`

## 2. Architecture: Clean Architecture (Strict)

Organize code by **Feature** first, then **Layer**.

### Layers
1.  **Presentation** (`lib/features/<feature>/presentation/`)
    *   **UI**: Widgets/Screens. **No business logic.**
    *   **State**: Riverpod Providers/Notifiers.
2.  **Domain** (`lib/features/<feature>/domain/`)
    *   **Pure Dart**. No Flutter/Dio dependencies.
    *   **Entities**: Data models (`@freezed`).
    *   **Repositories**: Interfaces (`abstract class`).
    *   **UseCases**: Business rules.
3.  **Data** (`lib/features/<feature>/data/`)
    *   **DTOs**: Data Transfer Objects (from JSON). Map to Domain Entities.
    *   **Data Sources**: API calls (Dio), Local DB.
    *   **Repositories**: Implementations of Domain Repositories.

### Core (`lib/core/`)
*   `config/`: Env vars, app config.
*   `constants/`: Routes, API endpoints (`Routes.home`).
*   `network/`: Dio client, Interceptors.
*   `router/`: `go_router` configuration.
*   `theme/`: `AppColors`, `AppTypography`.
*   `widgets/`: Shared reusable widgets.

## 3. State Management: Riverpod

*   **Providers**:
    *   `StateProvider`: Simple UI state.
    *   `StateNotifierProvider`: Complex sync state.
    *   `AsyncNotifierProvider`: Async state (API calls).
    *   `Future/StreamProvider.autoDispose`: Fetch-once/Streams.
*   **Rules**:
    *   Use `ref.watch` inside `build()`.
    *   Use `ref.read` only in callbacks/events.
    *   Use `autoDispose` by default to prevent leaks.
    *   **NEVER** put business logic in UI widgets.

## 4. Coding Standards

*   **Style**:
    *   **Files**: `snake_case.dart`
    *   **Classes**: `PascalCase`
    *   **Variables**: `camelCase`
    *   **Private**: `_underscorePrefix`
*   **Types**:
    *   Strict typing. Avoid `dynamic`.
    *   Use `const` constructors whenever possible.
*   **Models**:
    *   Use `freezed` with `json_serializable`.
    *   DTOs must have a `.toDomain()` mapper.
*   **UI**:
    *   Use `AppColors`, `AppTypography`, `AppSpacing`. **No hardcoded values.**
    *   Use `AppLocalizations.of(context)!` for strings. **No hardcoded strings.**
    *   Keep `build()` methods short (< 50 lines). Extract widgets.

## 5. Libraries & patterns

*   **Routing**: `go_router`. Define routes in `lib/core/constants/routes.dart`.
*   **Network**: `dio` (REST), `web_socket_channel` (Realtime).
*   **Assets**: Put images in `assets/images/`, icons in `assets/icons/`.
*   **Env**: `flutter_dotenv`.

## 6. Development Workflow for Agents

1.  **Check Work**: Run `bd ready` to find the next available task.
2.  **Analyze**: Understand the feature requirements and existing code in `lib/features/`.
2.  **Plan**: If adding a new feature, create the 3-layer structure (`data`, `domain`, `presentation`).
3.  **Implement**:
    *   Start with **Domain** (Entity -> Repository Interface).
    *   Implement **Data** (DTO -> API -> Repository Impl).
    *   Implement **Presentation** (Provider -> Widget).
4.  **Generate**: Run `build_runner` if you added `@freezed` or `@JsonSerializable`.
5.  **Verify**: Run `flutter analyze` and `flutter test`.

## 7. Common Tasks

*   **Adding a Page**:
    1.  Create Screen in `presentation/screens/`.
    2.  Add route in `Routes` class and `router/app_router.dart`.
*   **Fetching Data**:
    1.  Define Entity & DTO.
    2.  Add method to Repository Interface & Impl.
    3.  Create `FutureProvider` or `AsyncNotifier` to call Repo.
    4.  Watch provider in UI.

## Landing the Plane (Session Completion)

**When ending a work session**, follow these steps.

1. **File issues for remaining work** - Create issues for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **Git Safety Protocol (Strict)**
   - **NEVER** automatically commit or push changes.
   - **ALWAYS** ask for explicit user permission before running `git commit` or `git push`.
   - **EXCEPTION**: Only commit if the user explicitly uses the `/commit` command or says "commit this".
5. **Clean up** - Clear stashes
6. **Hand off** - Provide context for next session

