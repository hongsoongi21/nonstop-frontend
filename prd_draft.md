# Product Requirements Document: Nonstop App

## 1. Overview
A university community mobile application that allows students to connect, share information, and manage their academic life. 
The application will provide features such as user authentication, community boards, chat, and timetable management.

## 2. User Personas
*   **New Student:** A new student who wants to get information about the university, find friends, and get help with their courses.
*   **Existing Student:** An existing student who wants to share their knowledge, participate in the community, and manage their schedule.

## 3. Functional Requirements
### 3.1. Authentication
*   Users shall be able to sign up with their email, password, nickname, and university information.
*   Users shall be able to log in with their email and password.
*   Users shall be able to log in with Oauth2.0 like Google
*   The system shall support email and nickname duplication checks.
*   Users shall be able to log out.
*   The system shall support token refresh for session management.
*   Users shall be able to verify their university email.(not include in MVP)

### 3.2. User Management
*   Users shall be able to view and update their profile information.
*   Users shall be able to change their password.
*   Users shall be able to delete their account.

### 3.3. University Information
*   Users shall be able to select their universities.
*   Users shall be able to search for universities.(not include in MVP)
*   Users shall be able to view the details of a university.
*   Users shall be able to view the list of majors for a specific university.

### 3.4. Community & Boards
*   Users shall be able to view the list of communities for their university.
*   Users shall be able to view the list of boards within a community.
*   Users shall be able to request to create boards to Admin within a community.

### 3.5. Posts
*   Users shall be able to create, read, update, and delete posts.
*   Users shall be able to view a list of posts on a board with pagination.
*   Users shall be able to search for posts.
*   Users shall be able to like and report posts.

### 3.6. Comments
*   Users shall be able to create, read, update, and delete comments on posts.
*   Comments shall be displayed in a hierarchical structure.
*   Users shall be able to like and report comments.

### 3.7. Friends
*   Users shall be able to send, accept, reject, and cancel friend requests.
*   Users shall be able to view their friend list.
*   Users shall be able to block other users.

### 3.8. Chat
*   Users shall be able to create 1:1 chat rooms.
*   Users shall be able to send and receive messages in real-time using WebSockets.
*   Users shall be able to view their chat history.
*   Users shall be able to mark messages as read in real-time using WebSockets.

### 3.9. Timetable
*   Users shall be able to create, view, update, and delete their timetables for a specific semester.
*   Users shall be able to add, update, and delete entries in their timetable.
*   Users shall be able to view public timetables of other students.

### 3.10. Notifications
*   The system shall send push notifications for announcements, chat messages, and comments via Firebase Cloud Messaging (FCM).
*   Users shall be able to view a list of their notifications.
*   Users shall be able to mark notifications as read.

### 3.11. System
*   Users shall be able to set their preferred language.

## 4. API Endpoint Summary

### Authentication
| Method | URI | Description |
|---|---|---|
| POST | /api/v1/auth/signup | Register new user |
| GET | api/v1/policy/list | Policy Inquiry |
| POST | /api/v1/policy/consent | policy consent |
| GET | /api/v1/auth/email/check | Email duplicate check |
| GET | /api/v1/auth/nickname/check | Nickname duplicate check |
| POST | /api/v1/auth/login | Email/PW login (Issue token) |
| POST | /api/v1/auth/logout | Invalidate Refresh Token |
| POST | /api/v1/auth/refresh | Refresh Access Token |
| POST | /api/v1/auth/email/send | Send university email verification code |
| GET | /api/v1/auth/email/verify | Handle email verification link click |

### User
| Method | URI | Description |
|---|---|---|
| GET | /api/v1/users/me | Get My Info |
| PATCH | /api/v1/users/me | Update My Info |
| PATCH | /api/v1/users/me/password | Change Password |
| DELETE | /api/v1/users/me | Delete Account |

### University
| Method | URI | Description |
|---|---|---|
| GET | /api/v1/universities | University List |
| GET | /api/v1/universities/{id} | University Detail |
| GET | /api/v1/universities/{id}/majors | Major List |

### Community
| Method | URI | Description |
|---|---|---|
| GET | /api/v1/communities | Community List |
| GET | /api/v1/communities/{communityId}/boards | Board List |

### Post
| Method | URI                                         | Description |
|---|---------------------------------------------|---|
| GET | /api/v1/boards/{boardId}/posts              | Post List |
| GET | /api/v1/boards/{boardId}/posts/{searchText} | Post search |
| POST | /api/v1/boards/{boardId}/posts              | Create Post |
| GET | /api/v1/posts/{postId}                      | Post Detail |
| PATCH | /api/v1/posts/{postId}                      | Update Post |
| DELETE | /api/v1/posts/{postId}                      | Delete Post |
| POST | /api/v1/posts/report/{postId}               | Report the post |
| POST | /api/v1/posts/{postId}/like                 | Like Post |

### Comment
| Method | URI | Description |
|---|---|---|
| GET | /api/v1/posts/{postId}/comments | Comment List |
| POST | /api/v1/posts/{postId}/comments | Create Comment |
| PATCH | /api/v1/comments/{commentId} | Update Comment |
| DELETE | /api/v1/comments/{commentId} | Delete Comment |
| POST | /api/v1/comments/like/{commentId} | Like Comment |
| POST | /api/v1/comments/report/{commentId} | Report the Comment |

### Friend
| Method | URI | Description |
|---|---|---|
| GET | /api/v1/friends | Friend List |
| POST | /api/v1/friends/request | Request Friend |
| GET | /api/v1/friends/requests | Request List |
| POST | /api/v1/friends/requests/{requestId}/accept | Accept Request |
| POST | /api/v1/friends/requests/{requestId}/reject | Reject Request |
| DELETE | /api/v1/friends/requests/{requestId} | Cancel Request |
| POST | /api/v1/friends/block | Block User |

### Chat
| Method | URI | Description |
|---|---|---|
| GET | /api/v1/chat/rooms | Chat Room List |
| POST | /api/v1/chat/rooms | Create Room |
| DELETE | /api/v1/chat/rooms | Leave Chat Room |
| GET | /api/v1/chat/rooms/{roomId}/messages | Message History (via REST) |
| WS | /ws/v1/chat/rooms/{roomId} | Real-time messaging and read receipts (via WebSocket) |

### Timetable
| Method | URI | Description |
|---|---|---|
| GET | /api/v1/semesters | Semester List |
| GET | /api/v1/timetables | Timetable List |
| POST | /api/v1/timetables | Create Timetable |
| GET | /api/v1/timetables/{id} | Timetable Detail |
| PATCH | /api/v1/timetables/{id} | Update Config |
| DELETE | /api/v1/timetables/{id} | Delete Timetable |
| POST | /api/v1/timetables/{id}/entries | Add Entry |
| PATCH | /api/v1/timetables/entries/{entryId} | Update Entry |
| DELETE | /api/v1/timetables/entries/{entryId} | Delete Entry |
| GET | /api/v1/timetables/public | Public Timetables |

### Notification
| Method | URI | Description |
|---|---|---|
| POST | /api/v1/push/notice | (Backend to Firebase) Notice notification push |
| POST | /api/v1/push/chat | (Backend to Firebase) Chat notification push |
| POST | /api/v1/push/comment | (Backend to Firebase) Comment notification push |
| GET | /api/v1/notifications | My notification list |
| PATCH | /api/v1/notifications/{id}/read | Mark notification as read |
| PATCH | /api/v1/notifications/read-all | Mark all notifications as read |

### System
| Method | URI | Description |
|---|---|---|
| POST | /api/v1/setting/Language/{LanguageId} | Language Settings |
