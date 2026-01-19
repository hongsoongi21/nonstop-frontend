# Development Progress Report - Frontend

This document tracks the progress, feature implementations, and architectural milestones of the **Nonstop** Flutter application.

## 📅 Status Summary (2026-01-19)

The current phase focuses on **Stabilization and Core Module Completion**, specifically targeting the Timetable and Friends (Social) features.

---

## 🚀 Recent Implementations

### 1. Timetable Module (✅ Complete)
*   **Backend Integration**: Connected the `WeeklyTimeGrid` to real backend data via `TimetableRepository`.
*   **Feature: Add Class**: Implemented `AddTimetableEntryScreen` with full form validation, color picking, and conflict detection.
*   **Feature: Multi-Timetable Support**: Implemented ability to create and switch between multiple timetables per semester.
*   **Architecture**: Refactored `DayOfWeek` to the Domain layer to fix Clean Architecture dependency violations.

### 2. Friends & Social Module (✅ Complete)
*   **Feature: Search**: Implemented real-time user search by nickname using the `GET /api/v1/users/search` endpoint.
*   **Feature: Friend Requests**: Full UI flow for sending, receiving, accepting, and rejecting friend requests.
*   **Feature: Relationship Management**: Implemented "Unfriend" capability and status-aware UI (showing "Add", "Sent", or "Friend" badges).
*   **Bug Fix**: Resolved type casting errors (`Null is not a subtype of String`) by aligning DTOs with the backend's nested JSON structures (`UserInfoDto`, `FriendRequestDto`).

### 3. Real-time & Networking (✅ Stabilized)
*   **WebSocket/STOMP**: Fixed the connection handshake by correcting the endpoint path to `/ws/v1/chat` and injecting the JWT token as a query parameter for the initial HTTP upgrade.
*   **Infrastructure**: Switched from SockJS-only to pure WebSocket support for better reliability with the `stomp_dart_client`.

---

## 🛠 Architectural Updates
*   **Nested DTO Pattern**: Adopted a nested DTO structure (`FriendDto` containing `UserInfoDto`) to maintain data integrity across API responses.
*   **State Management**: Optimized `FriendManagementProvider` to auto-refresh local lists upon successful relationship changes (Accept/Remove).

---

## ✅ Quality Gate & Verification
*   **Linting**: `flutter analyze` is clean for all modified features.
*   **Code Generation**: All `@freezed` and `json_serializable` models updated via `build_runner`.
*   **Manual Testing**: Verified full social loop (Search → Request → Accept → List → Remove) against Azure Production DB.

---

## 💡 Technical Notes
*   **WebSocket Handshake**: Always ensure the `token` parameter is present in the WebSocket URL, as the `WebSocketAuthInterceptor` in the backend requires it before upgrading the protocol.
*   **ID Mapping**: In the social module, distinguish between `requestId` (relationship ID) and `userId` (the individual user's ID) to ensure API calls target the correct entities.
