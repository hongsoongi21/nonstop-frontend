# 🤖 Gemini / AI Context - Nonstop

This file serves as a context guide for AI assistants (Gemini, Copilot, etc.) working on the **Nonstop** project.
**Human Developers:** Please keep this file updated with high-level architectural decisions and AI-specific instructions.

---

## 📚 Primary Documentation

**The Single Source of Truth is [PROJECT_GUIDE.md](../PROJECT_GUIDE.md).**
Always refer to `PROJECT_GUIDE.md` for detailed engineering standards.

## 🏗 Architecture (Crucial)

*   **Pattern:** Clean Architecture (3 Layers).
*   **State Management:** Riverpod.
    *   Use `StateProvider` for simple UI state.
    *   Use `StateNotifier` for complex sync state.
    *   Use `AsyncNotifier` for async workflows.
    *   **Rule:** Logic lives in Notifiers/UseCases, NOT in UI Widgets.
*   **Navigation:** `go_router` (See `lib/core/router/`).
    *   Routes defined in `lib/core/constants/routes.dart`.
*   **Network:** Dio + WebSocket (custom implementation).

## 📂 Folder Structure Rules

*   **Feature-First:** `lib/features/<feature_name>/{data, domain, presentation}`.
*   **Core:** `lib/core/` for shared utilities, config, widgets, and theme.
*   **Domain Layer:** Pure Dart. NO Flutter imports. NO JSON serialization logic (use DTOs in Data layer).

## 📝 Coding Conventions

*   **File Names:** `snake_case.dart`
*   **Class Names:** `PascalCase`
*   **Variables:** `camelCase`
*   **Private:** Prefix with `_`
*   **Build Methods:** Keep under ~50 lines. Extract sub-widgets.

## 🛠 Common Commands

*   **Run App:** `flutter run`
*   **Code Gen (Freezed/Riverpod):** `flutter pub run build_runner build --delete-conflicting-outputs`
*   **Localization:** `flutter gen-l10n`
*   **Tests:** `flutter test`

## ⚠️ Important Rules for AI

1.  **Do NOT** introduce new libraries without checking `pubspec.yaml` first.
2.  **Do NOT** write business logic in UI widgets.
3.  **ALWAYS** follow the established folder structure.
4.  **ALWAYS** check `PROJECT_GUIDE.md` if unsure about a pattern.
5.  **Self-Review & Verification:** Before finishing a task, perform a final self-review. Check for logic errors, adherence to Clean Architecture, naming consistency, and run available tests or analysis tools (`flutter analyze`, `flutter test`) to ensure high quality.
