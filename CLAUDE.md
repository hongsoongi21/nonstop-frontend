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

# Analysis
flutter analyze
```

## Architecture Overview

**Clean Architecture with Riverpod** - Feature-based organization with three layers:

```
lib/
├── core/           # Cross-cutting: router, network, theme, l10n, utils, widgets
├── features/       # Feature modules (auth, board, chat, friends, timetable, settings)
│   └── [feature]/
│       ├── data/           # DTOs, API clients, repository implementations
│       ├── domain/         # Entities (@freezed), repository interfaces, usecases
│       └── presentation/   # Screens, providers (Riverpod), widgets
└── shared/         # Shared UI components
```

**Critical Rule**: Domain layer must NOT import Flutter, Dio, or any platform libraries. Keep domain types pure Dart.

## State Management (Riverpod)

- Use `ref.watch()` in `build()` for reactive updates
- Use `ref.read()` only in callbacks/events
- Use `autoDispose` by default to prevent memory leaks
- Use `select()` to limit rebuilds to specific fields
- No business logic in widgets - forward user intents to notifiers

## Navigation (go_router)

Routes defined in `lib/core/constants/routes.dart`. Use `context.go()` / `context.push()` / `context.pop()`. Never use `Navigator` directly.

## Error Handling

Uses `Either<Failure, T>` from fpdart. Failure types defined in `lib/core/errors/failures.dart`. Repository implementations convert exceptions to typed Failures.

## Network Layer

- HTTP: Dio with interceptors for auth token injection, refresh, logging (`lib/core/network/dio_client.dart`)
- Real-time: WebSocket + STOMP for chat (`lib/core/network/websocket_client.dart`, `stomp_service.dart`)

## Localization

ARB files in `lib/core/l10n/` (EN, RU, UZ). After editing ARB files, run `flutter gen-l10n`. Access via `AppLocalizations.of(context)!.keyName`.

## Styling

Use design system classes - no hardcoded values:
- Colors: `AppColors`
- Typography: `AppTypography`
- Spacing: `AppSpacing`
- Dimensions: `AppDimensions`

Responsive design via flutter_screenutil (base: 375x812).

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
6. Add routes to `Routes` class and router config
7. Add localization keys to ARB files
