<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-03-08 | Updated: 2026-03-08 -->

# chat

## Purpose
Provides real-time 1-to-1 and group chat using Supabase Realtime (channel subscriptions). The feature maintains a chat room list (`ChatListNotifier`) and per-room message state (`ChatRoomNotifier`). Messages support text and image types, plus system messages for room events (invite, leave, kick). Sending uses optimistic updates matched by a `clientMessageId` (microsecond timestamp) that the server echoes back to replace the optimistic entry. Read receipts are tracked per user via a separate Supabase channel. Images are uploaded to Supabase Storage before the message is sent. The `chatRoomProvider` is `autoDispose` — it refreshes the room list on dispose to update unread counts.

## Key Files
| File | Description |
|------|-------------|
| `presentation/providers/chat_provider.dart` | `ChatListNotifier` (room list) + `ChatRoomNotifier` (messages, real-time, optimistic updates) |
| `presentation/screens/chat_screen.dart` | Room list screen |
| `presentation/screens/chat_room_screen.dart` | Message view with real-time subscription |
| `presentation/screens/fullscreen_image_viewer.dart` | Full-screen image viewer for chat images |
| `presentation/widgets/message_bubble.dart` | Individual message UI with send status indicators |
| `presentation/widgets/chat_input_bar.dart` | Text input + send button |
| `presentation/widgets/chat_room_tile.dart` | Room list tile with unread badge |
| `presentation/widgets/create_chat_bottom_sheet.dart` | New chat room creation UI |
| `presentation/widgets/connection_status_bar.dart` | Real-time connection status indicator |
| `domain/entities/chat_message.dart` | `ChatMessage` with `MessageType` enum (text, image, systemInvite, systemLeave, systemKick) |
| `domain/entities/chat_room.dart` | `ChatRoom` entity |
| `domain/entities/read_receipt.dart` | `ReadReceipt` entity (userId, lastReadMessageId) |
| `domain/repository/chat_repository.dart` | Repository interface with streaming methods |
| `data/api/chat_api.dart` | API interface |
| `data/repository_impl/chat_repository_impl.dart` | Supabase Realtime implementation |

## Subdirectories
| Directory | Purpose |
|-----------|---------|
| `data/` | Chat API implementation, mock API, repository implementation |
| `domain/` | ChatMessage, ChatRoom, ReadReceipt entities + repository interface |
| `presentation/` | 3 screens, 6 widgets, 1 provider file |

## For AI Agents

### Working In This Directory
- `currentUserIdProvider` converts `User.id` (String) to `int` because `ChatMessage.senderId` is `int`.
- Optimistic message matching: generate `clientMsgId = DateTime.now().microsecondsSinceEpoch` → insert optimistic entry → server echoes back with same `clientMessageId` → replace in list.
- Duplicate detection is by `message.id` for server messages and `clientMessageId` for optimistic messages — check both in `_handleIncomingMessage`.
- `chatRoomProvider` is `autoDispose.family<..., int>` — each room ID gets its own notifier; dispose triggers `chatListProvider.notifier.loadRooms()`.
- Image upload: upload to Supabase Storage via `uploadChatImage(roomId, localFilePath)`, get URL, then send as `MessageType.image` message.
- `MessageType` backend values are uppercase (`TEXT`, `IMAGE`, `SYSTEM_INVITE`, etc.); the entity `_mapBackendType` handles conversion.
- `chat_api_mock.dart` exists for local testing without a backend.

### Key Providers
| Provider | Type | Purpose |
|----------|------|---------|
| `chatListProvider` | `StateNotifierProvider<ChatListNotifier, ChatListState>` | All chat rooms |
| `chatRoomProvider` | `StateNotifierProvider.autoDispose.family<ChatRoomNotifier, ChatRoomState, int>` | Messages for a specific room |
| `chatRepositoryProvider` | `Provider<ChatRepository>` | Repository singleton |
| `chatApiProvider` | `Provider<ChatApi>` | API singleton |
| `currentUserIdProvider` | `Provider<int?>` | Current user's integer ID for chat |

### API Endpoints
Backed by Supabase Realtime + PostgREST:
- `GET /chat_rooms` — list my rooms
- `POST /chat_rooms` — create 1:1 or group room
- `GET /messages?room_id=&limit=&offset=` — paginated history
- `POST /messages` — send message
- `POST /read_receipts` — mark as read
- Realtime channels: `room:{roomId}` for messages, `read_receipts:{roomId}` for read status
- Storage: `chat-images/{roomId}/` bucket for image uploads

## Dependencies

### Internal
- `features/auth/presentation/providers/auth_provider.dart` — `currentUserProvider` for sender identity
- `core/supabase/supabase_provider.dart` — Supabase client for both API and Realtime
- `core/errors/failures.dart` — `Failure` typed errors

### External
- `flutter_riverpod` — State management
- `supabase_flutter` — Realtime channels + PostgREST + Storage
- `fpdart` — `Either<Failure, T>`
- `image_picker` — Photo selection for image messages

<!-- MANUAL: -->
