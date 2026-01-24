# Product Requirements Document: Nonstop App
**Golden Master v2.5.12 (Backend Status: 85% Completed)**

## 1. Overview
A university community mobile application that allows students to connect, share information, and manage their academic life. 
The application will provide features such as user authentication, community boards, chat, and timetable management.

## 2. User Personas
*   **New Student:** A new student who wants to get information about the university, find friends, and get help with their courses.
*   **Existing Student:** An existing student who wants to share their knowledge, participate in the community, and manage their schedule.
*   **Admin/Manager (New):** Responsible for verifying student documents, handling reports, and managing community boards and policies.

## 3. Functional Requirements

### 3.1. Authentication
*   Users shall be able to sign up with their email, password, nickname, and university information.
*   Users shall be able to log in with their email and password.
*   Users shall be able to log in with Oauth2.0 like Google.
*   The system shall support email and nickname duplication checks.
*   Users shall be able to log out.
*   The system shall support token refresh for session management.
*   Users shall be able to verify their university email.

**[Backend Technical Specs]**
- **JWT Strategy:** Access Token (30 min), Refresh Token (30 days).
- **Refresh Token Rotation (RTR):** New Refresh Token issued upon every access token refresh.
- **Auto Login:** App handles 401 errors by attempting a silent refresh using the stored Refresh Token.
- **Signup Verification:** 6-digit code sent via email, validated via Redis (5 min TTL).

### 3.2. User Management
*   Users shall be able to view and update their profile information.
*   Users shall be able to change their password.
*   Users shall be able to delete their account.

**[Backend Technical Specs]**
- **Roles:** `USER`, `ADMIN`, `MANAGER` roles supported.
- **Account Deletion:** Supports soft delete via `deleted_at` field.
- **FCM Integration:** Supports registering/updating device tokens for push notifications.

### 3.3. University Information
*   Users shall be able to select their universities.
*   Users shall be able to search for universities.
*   Users shall be able to view the details of a university.
*   Users shall be able to view the list of majors for a specific university.

### 3.4. Community & Boards
*   Users shall be able to view the list of communities for their university.
*   Users shall be able to view the list of boards within a community.
*   Users shall be able to request to create boards to Admin within a community.

**[Backend Technical Specs]**
- **Board Visibility:** Global boards for all, university boards for verified students only (`is_verified=true`).
- **Admin Control:** Admins/Managers can create, edit, or delete boards via Admin API.

### 3.5. Posts
*   Users shall be able to create, read, update, and delete posts.
*   Users shall be able to view a list of posts on a board with pagination.
*   Users shall be able to search for posts.
*   Users shall be able to like and report posts.

**[Backend Technical Specs]**
- **Pagination:** Supports infinite scroll/paging.
- **Metadata:** DTO includes `isMine` flag for easy UI control.

### 3.6. Comments
*   Users shall be able to create, read, update, and delete comments on posts.
*   Comments shall be displayed in a hierarchical structure.
*   Users shall be able to like and report comments.

**[Backend Technical Specs]**
- **Structure:** 2-level depth (Comment -> Reply).
- **Types:** `GENERAL`, `ANONYMOUS`.

### 3.7. Friends
*   Users shall be able to send, accept, reject, and cancel friend requests.
*   Users shall be able to view their friend list.
*   Users shall be able to block other users.

**[Backend Technical Specs]**
- **Blocking Logic:** Blocked users cannot see each other's posts or start 1:1 chats.

### 3.8. Chat
*   Users shall be able to create 1:1 chat rooms.
*   Users shall be able to send and receive messages in real-time using WebSockets.
*   Users shall be able to view their chat history.
*   Users shall be able to mark messages as read in real-time using WebSockets.

**[Backend Technical Specs]**
- **Broker:** **Apache Kafka** manages message ordering and delivery.
- **Messaging:** STOMP over WebSocket.
- **Idempotency:** `clientMessageId` (UUID) prevents duplicate message processing.
- **Image Support:** Transfers via **Azure Blob Storage** using SAS URL strategy.

### 3.9. Timetable
*   Users shall be able to create, view, update, and delete their timetables for a specific semester.
*   Users shall be able to add, update, and delete entries in their timetable.
*   Users shall be able to view public timetables of other students.

**[Backend Technical Specs]**
- **Semesters:** `FIRST`, `SECOND`, `SUMMER`, `WINTER`.
- **Validation:** Server-side overlap detection for schedule entries.

### 3.10. Notifications
*   The system shall send push notifications for announcements, chat messages, and comments via Firebase Cloud Messaging (FCM).
*   Users shall be able to view a list of their notifications.
*   Users shall be able to mark notifications as read.

### 3.11. System & Policy
*   Users shall be able to set their preferred language.
*   **Dynamic Policy Agreement:** Users must agree to ToS and Privacy Policy. Policies are managed by Admin and fetched via API.

---

## 4. API Endpoint Summary (Merged & Comprehensive)

### Authentication & Policy
| Method | URI | Description |
|---|---|---|
| POST | /api/v1/auth/signup | Register new user |
| POST | /api/v1/auth/signup/verify | Verify signup 6-digit code |
| POST | /api/v1/auth/signup/resend | Resend signup verification code |
| GET | /api/v1/auth/email/check | Email duplicate check |
| GET | /api/v1/auth/nickname/check | Nickname duplicate check |
| POST | /api/v1/auth/login | Email/PW login (Issue tokens) |
| POST | /api/v1/auth/google | Google OAuth login |
| POST | /api/v1/auth/logout | Invalidate Refresh Token |
| POST | /api/v1/auth/refresh | Reissue Access Token (RTR) |
| GET | /api/v1/policies | List all active policies (id, title, url, mandatory) |
| GET | /api/v1/policies/me | Get my current policy agreement status |
| POST | /api/v1/policies/agree | Submit agreements for multiple policies |
| POST | /api/v1/auth/email/send | Send university email verification code |
| GET | /api/v1/auth/email/verify | Handle email verification link click |

### User & Verification
| Method | URI | Description |
|---|---|---|
| GET | /api/v1/users/me | Get my profile info |
| PATCH | /api/v1/users/me | Update my profile info |
| PATCH | /api/v1/users/me/university | Update university info |
| PATCH | /api/v1/users/me/password | Change password |
| DELETE | /api/v1/users/me | Delete account |
| POST | /api/v1/devices/fcm-token | Upsert device FCM token |
| GET | /api/v1/users/me/verification-status | Check student verification status |
| POST | /api/v1/verification/email/request | Request code to university email |
| POST | /api/v1/verification/student-id | Upload student ID photo (Multipart) |

### University
| Method | URI | Description |
|---|---|---|
| GET | /api/v1/universities | University List (with paging) |
| GET | /api/v1/universities/list | University List (no auth) |
| GET | /api/v1/universities/regions | List of university regions |
| GET | /api/v1/universities/{id} | University Detail |
| GET | /api/v1/universities/{id}/majors | Major List for university |

### Community & Board
| Method | URI | Description |
|---|---|---|
| GET | /api/v1/communities | Community List |
| GET | /api/v1/communities/{id}/boards | Board List in a community |
| POST | /api/v1/communities/{id}/boards | Create Board (Admin/Manager only) |
| PATCH | /api/v1/boards/{id} | Update Board Info (Admin only) |
| DELETE | /api/v1/boards/{id} | Delete Board (Admin only) |

### Post & Comment
| Method | URI | Description |
|---|---|---|
| GET | /api/v1/boards/{boardId}/posts | Post List (Paging) |
| GET | /api/v1/boards/{boardId}/posts/{search} | Search posts in board |
| POST | /api/v1/boards/{boardId}/posts | Create Post |
| GET | /api/v1/posts/{postId} | Post Detail |
| PATCH | /api/v1/posts/{postId} | Update Post |
| DELETE | /api/v1/posts/{postId} | Delete Post |
| POST | /api/v1/posts/{postId}/like | Toggle Post Like |
| POST | /api/v1/posts/{postId}/report | Report Post |
| GET | /api/v1/posts/{postId}/comments | Comment List for post |
| POST | /api/v1/posts/{postId}/comments | Create Comment/Reply |
| PATCH | /api/v1/comments/{commentId} | Update Comment |
| DELETE | /api/v1/comments/{commentId} | Delete Comment |
| POST | /api/v1/comments/{commentId}/like | Toggle Comment Like |
| POST | /api/v1/comments/{commentId}/report | Report Comment |

### Friend & Block
| Method | URI | Description |
|---|---|---|
| GET | /api/v1/friends | My Friend List |
| GET | /api/v1/friends/requests | Pending Friend Requests |
| POST | /api/v1/friends/request | Send Friend Request |
| POST | /api/v1/friends/requests/{id}/accept | Accept Request |
| POST | /api/v1/friends/requests/{id}/reject | Reject Request |
| DELETE | /api/v1/friends/requests/{id} | Cancel Request |
| POST | /api/v1/users/{userId}/block | Block User |
| DELETE | /api/v1/users/{userId}/block | Unblock User |
| GET | /api/v1/users/me/blocked | List of blocked users |
| POST | /api/v1/users/{userId}/report | Report User Profile |

### Chat
| Method | URI | Description |
|---|---|---|
| GET | /api/v1/chat/rooms | Chat Room List (1:1 & Group) |
| POST | /api/v1/chat/rooms | Create 1:1 Chat Room |
| POST | /api/v1/chat/group-rooms | Create Group Chat Room |
| PATCH | /api/v1/chat/group-rooms/{id} | Update Group Room Info |
| DELETE | /api/v1/chat/rooms/{id} | Leave Chat Room |
| GET | /api/v1/chat/rooms/{id}/messages | Message History (Paging) |
| DELETE | /api/v1/chat/rooms/{id}/messages/{msgId} | Delete specific message |
| GET | /api/v1/chat/group-rooms/{id}/members | List room members |
| POST | /api/v1/chat/group-rooms/{id}/invite | Invite user to group |
| DELETE | /api/v1/chat/group-rooms/{id}/members/{userId} | Kick user (Admin only) |
| POST | /api/v1/chat/rooms/{id}/messages/{msgId}/report | Report chat message |
| WS | /ws/v1/chat | STOMP WebSocket Connection |
| PUB | /pub/chat/message | (STOMP) Send message |

### Timetable
| Method | URI | Description |
|---|---|---|
| GET | /api/v1/semesters | List of available semesters |
| GET | /api/v1/timetables | My Timetable List |
| POST | /api/v1/timetables | Create Timetable |
| GET | /api/v1/timetables/{id} | Timetable Detail (including entries) |
| PATCH | /api/v1/timetables/{id} | Update Timetable config |
| DELETE | /api/v1/timetables/{id} | Delete Timetable |
| POST | /api/v1/timetables/{id}/entries | Add Schedule Entry |
| PATCH | /api/v1/timetables/entries/{entryId} | Update Schedule Entry |
| DELETE | /api/v1/timetables/entries/{entryId} | Delete Schedule Entry |
| GET | /api/v1/timetables/public | View public timetables of others |

### Admin (New Sections)
| Method | URI | Description |
|---|---|---|
| GET | /api/v1/admin/verifications | List student ID verification requests |
| POST | /api/v1/admin/verifications/{id}/approve | Approve student ID |
| POST | /api/v1/admin/verifications/{id}/reject | Reject student ID |
| GET | /api/v1/admin/reports | List user/content reports |
| POST | /api/v1/admin/reports/{id}/process | Action on report (Blind/Delete/Ban) |
| GET | /api/v1/admin/users | Search and list users |
| PATCH | /api/v1/admin/users/{id}/role | Change user role (USER/ADMIN) |
| PATCH | /api/v1/admin/users/{id}/status | Change user status (Active/Suspended) |
| GET | /api/v1/admin/policies | List policies for management |
| POST | /api/v1/admin/policies | Create new policy version |
| POST | /api/v1/admin/policies/upload | Upload policy HTML to CDN |

### System & Files
| Method | URI | Description |
|---|---|---|
| POST | /api/v1/setting/Language/{lang} | Set preferred language |
| POST | /api/v1/files/sas-url | Get Azure SAS URL for image upload |
| POST | /api/v1/files/upload-complete | Callback after file upload finish |
| GET | /api/v1/notifications | My notification list |
| PATCH | /api/v1/notifications/{id}/read | Mark notification as read |
| PATCH | /api/v1/notifications/read-all | Mark all notifications as read |

---

## 5. System Architecture Highlights
*   **Backend:** Spring Boot (Stateless Architecture).
*   **Database:** PostgreSQL (Primary), Redis (Auth codes, RT whitelist, Cache).
*   **Messaging:** **Apache Kafka** for reliable chat message delivery and read-event processing.
*   **Storage:** **Azure Blob Storage** for user images and static policy HTML files.
*   **Push:** **Google Firebase (FCM)** for cross-platform notifications.

## 6. Post-MVP Roadmap
*   **Academic Integration:** Enrollment year tracking, academic status (`ON_LEAVE`, `GRADUATED`).
*   **Course Metadata:** Official university course catalog integration.
*   **Graduation Progress:** Automatic GPA and credit tracking against major requirements.
*   **Advanced Social:** Full-text global search for posts, comments, and people.