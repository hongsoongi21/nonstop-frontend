<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-03-08 | Updated: 2026-03-08 -->

# board

## Purpose
Implements a community bulletin board system where users can browse communities (global and university-specific), navigate boards within a community, and read/create/edit/delete posts and threaded comments. The board is filtered by the current user's `universityId` — global communities are always visible, while university communities only show for verified members. Posts support anonymous authorship, secret visibility, image attachments, and like toggling. `BoardNotifier` re-initializes when the user's university changes. Post detail state is separated into `postDetailProvider` (family provider per post ID).

## Key Files
| File | Description |
|------|-------------|
| `presentation/providers/board_provider.dart` | `BoardNotifier` / `BoardState` managing communities, boards, and post list |
| `presentation/providers/post_detail_provider.dart` | `postDetailProvider` family — per-post detail + comments state |
| `presentation/screens/board_screen.dart` | Main board list screen with community/board selectors |
| `presentation/screens/board_detail_screen.dart` | Post detail with comments, likes, and actions |
| `presentation/screens/create_post_screen.dart` | Post creation/editing form |
| `domain/entities/post.entity.dart` | `PostEntity` with like/comment counts, anonymity, secret, imageUrls |
| `domain/entities/community.entity.dart` | `Community` with `isGlobal` and `universityId` |
| `domain/entities/board.entity.dart` | `Board` entity |
| `domain/entities/comment.entity.dart` | `CommentEntity` with nested reply support via `upperCommentId` |
| `domain/repository/board_repository.dart` | Full repository interface — communities, boards, posts, comments, likes |
| `data/sources/board_remote_data_source.dart` | Supabase data source implementation |
| `data/repositories/board_repository_impl.dart` | Repository implementation + `boardRepositoryProvider` |

## Subdirectories
| Directory | Purpose |
|-----------|---------|
| `data/` | Remote data source, repository implementation |
| `domain/` | 4 entities (Post, Comment, Board, Community), repository interface |
| `presentation/` | 3 screens, 2 providers |

## For AI Agents

### Working In This Directory
- Community filtering logic is in `BoardNotifier.initialize()`: always show `isGlobal`, show university communities only when `currentUser.universityId` matches.
- `BoardNotifier` listens to `currentUserProvider` via `ref.listen` and re-initializes on university ID change.
- Like toggling uses optimistic updates in `state.posts` and then invalidates `postDetailProvider(postId)` to sync the detail view.
- `markNeedsRefresh()` / `refreshIfNeeded()` pattern is used when returning from post detail after adding comments.
- `PostEntity.isMine` is set by the backend based on the auth token — do not compute it client-side.
- `boardRepositoryProvider` is also consumed by `profile_provider.dart` for `getMyPosts()`.

### Key Providers
| Provider | Type | Purpose |
|----------|------|---------|
| `boardProvider` | `StateNotifierProvider<BoardNotifier, BoardState>` | Community/board/post list state |
| `boardPostsProvider` | `Provider<List<PostEntity>>` | Current board's post list |
| `boardLoadingProvider` | `Provider<bool>` | Loading state |
| `boardErrorProvider` | `Provider<String?>` | Error state |
| `postDetailProvider` | `StateNotifierProvider.family<..., int>` | Per-post detail + comment state |
| `boardRepositoryProvider` | `Provider<BoardRepository>` | Repository singleton |

### API Endpoints
All data flows through Supabase PostgREST (direct table queries via `board_remote_data_source.dart`):
- Communities: `GET /communities`
- Boards: `GET /boards?community_id=`
- Posts: `GET/POST/PUT/DELETE /posts`
- Comments: `GET/POST/PUT/DELETE /comments`
- Likes: `POST /post_likes`, `DELETE /post_likes`

## Dependencies

### Internal
- `features/auth/presentation/providers/auth_provider.dart` — `currentUserProvider` for university filtering and user ID
- `core/errors/failures.dart` — Error typing (though board uses `String` errors in state)
- `core/supabase/supabase_provider.dart` — Supabase client access

### External
- `flutter_riverpod` — State management
- `fpdart` — `Either<String, T>` for repository returns
- `freezed_annotation` — Immutable entities with `@JsonSerializable`
- `supabase_flutter` — Backend queries

<!-- MANUAL: -->
