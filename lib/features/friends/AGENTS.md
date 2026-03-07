<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-03-08 | Updated: 2026-03-08 -->

# friends

## Purpose
Manages the full friend lifecycle: searching for users by nickname, sending/cancelling friend requests, accepting/rejecting incoming requests, deleting existing friendships, and blocking/unblocking users. `FriendManagementState` tracks four distinct lists — accepted friends, received requests, sent requests, and search results — plus a `sentRequestUserIds` set for O(1) lookup during search. Search results are enriched client-side with correct `FriendStatus` values (`pendingReceived`, `pendingSent`) by cross-referencing the current friends/requests lists. The `settings` feature delegates blocked-user management to `friend_api_impl.dart` via `blockedUsersProvider`.

## Key Files
| File | Description |
|------|-------------|
| `presentation/providers/friend_management_provider.dart` | `FriendManagementNotifier` / `FriendManagementState` — all friend operations |
| `presentation/screens/friends_screen.dart` | Tabbed UI: Friends list, Requests, Sent requests, Search |
| `domain/entities/friend.dart` | `Friend` entity with `FriendStatus` enum (accepted, pendingReceived, pendingSent, blocked, none) |
| `domain/repository/friend_repository.dart` | Repository interface |
| `data/api/friend_api.dart` | API interface |
| `data/api/friend_api_impl.dart` | Supabase implementation + `friendApiProvider`; also used by blocked_users_screen |
| `data/dto/friend_dto.dart` | DTOs including `BlockedUserDto` |
| `data/repository_impl/friend_repository_impl.dart` | Repository implementation + `friendRepositoryProvider` |

## Subdirectories
| Directory | Purpose |
|-----------|---------|
| `data/` | Friend API (+ blocked users), DTO, repository implementation |
| `domain/` | Friend entity with FriendStatus enum, repository interface |
| `presentation/` | 1 screen, 1 provider |

## For AI Agents

### Working In This Directory
- `Friend.id` is the target user's ID (UUID String); `Friend.relationshipId` is the friendship/request row ID used for accept/reject/cancel/delete operations — do not confuse the two.
- `searchUsers()` filters out self (by ID and nickname) and already-accepted friends before returning results; it enriches remaining results with pending status.
- `sendRequest(userId)` returns `String?` — `null` on success, error message on failure — callers should check the return value.
- `cancelRequest(friendId)` takes `relationshipId` (the request row ID), not the user ID.
- `blockedUsersProvider` (in `settings/presentation/screens/blocked_users_screen.dart`) uses `friendApiProvider` directly — it is not in the friend providers file.
- After `acceptRequest` or `deleteFriend`, the notifier automatically calls `loadFriends()` and `loadRequests()` to refresh state.

### Key Providers
| Provider | Type | Purpose |
|----------|------|---------|
| `friendManagementProvider` | `StateNotifierProvider<FriendManagementNotifier, FriendManagementState>` | All friend state |
| `friendRepositoryProvider` | `Provider<FriendRepository>` | Repository singleton |
| `friendApiProvider` | `Provider<FriendApi>` | API singleton (also used by settings) |

### API Endpoints
All backed by Supabase (via `friend_api_impl.dart`):
- `GET /friends` — accepted friends list
- `GET /friend_requests` — received requests
- `GET /friend_requests/sent` — sent requests
- `GET /users?search=` — user search
- `POST /friend_requests` — send request
- `PUT /friend_requests/{id}/accept` — accept
- `PUT /friend_requests/{id}/reject` — reject
- `DELETE /friend_requests/{id}` — cancel sent request
- `DELETE /friends/{id}` — remove friend
- `POST /blocks` / `DELETE /blocks/{id}` — block/unblock

## Dependencies

### Internal
- `features/auth/presentation/providers/auth_provider.dart` — `currentUserProvider` for filtering self from search results
- `core/errors/failures.dart` — `Failure` typed errors
- `core/utils/logger.dart` — `AppLogger.d` for debug logging in search

### External
- `flutter_riverpod` — State management
- `fpdart` — `Either<Failure, Unit>` for repository returns
- `freezed_annotation` — Immutable `Friend` entity

<!-- MANUAL: -->
