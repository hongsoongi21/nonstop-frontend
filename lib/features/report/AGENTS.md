<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-03-08 | Updated: 2026-03-08 -->

# report

## Purpose
Provides content moderation by allowing users to report posts, comments, other users, and chat messages to administrators. The feature is intentionally minimal — it is a fire-and-forget API call with no persistent state or dedicated screen. Report dialogs are shown inline from the board detail screen and chat room screen as bottom sheets or dialogs. The `ReportRequestDto` carries a typed `ReportReasonType` (8 reasons: spam, abuse, sexual, hate, illegal, privacy, impersonation, etc.) and an optional description.

## Key Files
| File | Description |
|------|-------------|
| `data/api/report_api.dart` | Abstract API interface with 4 methods: `reportPost`, `reportComment`, `reportUser`, `reportChatMessage` |
| `data/api/report_api_impl.dart` | Supabase implementation |
| `data/dto/report_dto.dart` | `ReportRequestDto` + `ReportReasonType` enum (8 values with `@JsonValue` annotations) |

## Subdirectories
| Directory | Purpose |
|-----------|---------|
| `data/` | API interface, Supabase implementation, request DTO |
| `domain/` | Not present — no domain entities or use cases; report is stateless |
| `presentation/` | Not present — no dedicated screen; report UI is inline in board/chat features |

## For AI Agents

### Working In This Directory
- This feature has no Riverpod providers, no state, and no dedicated screen — it is purely a data-layer utility.
- To use reporting in a screen, read `report_api_impl.dart`'s provider directly, call the appropriate method, and show a success/failure snackbar.
- `ReportReasonType` enum values must match the backend enum exactly — use the `@JsonValue` strings when serializing.
- Add a provider in `report_api_impl.dart` if one is not already present, following the pattern from other `*_api_impl.dart` files.
- If adding a new reportable entity type (e.g., `reportTimetable`), add to both `ReportApi` interface and `ReportApiImpl`.

### Key Providers
None defined in this feature. The API implementation should expose a `reportApiProvider` if consumed by other features.

### API Endpoints
Backed by Supabase (via `report_api_impl.dart`):
- `POST /reports/posts/{postId}` — report a post
- `POST /reports/comments/{commentId}` — report a comment
- `POST /reports/users/{userId}` — report a user
- `POST /reports/messages/{messageId}` — report a chat message

Request body: `{ "reason": "SPAM", "description": "optional text" }`

### ReportReasonType Values
| Enum | JSON Value |
|------|-----------|
| `spam` | `SPAM` |
| `abuse` | `ABUSE` |
| `sexual` | `SEXUAL` |
| `hate` | `HATE` |
| `illegal` | `ILLEGAL` |
| `privacy` | `PRIVACY` |
| `impersonation` | `IMPERSONATION` |
| `etc` | `ETC` |

## Dependencies

### Internal
- `core/errors/exceptions.dart` — `ApiException` (report API uses `Either<ApiException, void>` not `Either<Failure, void>`)

### External
- `fpdart` — `Either<ApiException, void>`
- `freezed_annotation` + `json_annotation` — `ReportRequestDto` serialization

<!-- MANUAL: -->
