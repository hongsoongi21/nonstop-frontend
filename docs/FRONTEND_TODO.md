# Frontend TODO List

> Last updated: 2026-01-30
> Based on codebase analysis and PRD review

## 1. TODO Items (UI Only - No Real Implementation)

### HIGH Priority

| Location | Description | Backend Status | Related Branch |
|----------|-------------|----------------|----------------|
| ~~`login_screen_v1.dart:134`~~ | ~~비밀번호 찾기 화면~~ | ~~BE API 완료~~ | `feat/forgot-password-screen` (Done) |
| `signup_screen.dart:305-317` | Google/Apple 회원가입 | BE 완료 | Merged |
| `chat_screen.dart:26` | 1:1 채팅방 생성 (User picker) | BE 완료 (STOMP/Kafka) | Merged |

### MEDIUM Priority

| Location | Description | Backend Status | Related Branch |
|----------|-------------|----------------|----------------|
| `main_scaffold.dart:42` | 관리자 기능 구현 | Admin API 부분 완료 | - |
| `home_screen.dart:191` | 알림(Notifications) 화면 | FCM 연동 필요 | - |
| `language_selector.dart:56` | 언어 변경 로직 (i18n) | FE Only | - |
| `timetable_screen.dart:318` | 새 시간표 생성 화면 | BE 완료 | - |

### LOW Priority

| Location | Description | Backend Status | Related Branch |
|----------|-------------|----------------|----------------|
| `home_screen.dart:64` | Pull-to-refresh 로직 | - | - |
| `dio_client.dart:35` | SSL 인증서 고정 | - | - |
| `app_router.dart:193` | Auth guard redirect 로직 | - | - |
| `signup_screen.dart:443-452` | Terms/Privacy onTap | FE Only | - |

---

## 2. Mock API Usage (Need Real Backend Integration)

| Feature | Mock File | Provider Usage | Backend Status |
|---------|-----------|----------------|----------------|
| ~~**Chat**~~ | ~~`chat_api_mock.dart`~~ | ~~`chat_provider.dart:21`~~ | ✅ **완료** - Real API 연동 완료 |
| ~~**Profile**~~ | ~~`profile_api_mock.dart`~~ | ~~`profile_provider.dart:338`~~ | ✅ **완료** - Real API 연동 완료 |
| ~~**Posts**~~ | ~~`profile_post_card.dart` (MockPosts)~~ | ~~`profile_screen.dart:130`~~ | ✅ **완료** - Real API 연동 완료 |

---

## 3. Recently Merged Features (2026-01-30)

### From `feature/chat-full-implementation`:
- [x] birthDate field in signup flow
- [x] Full chat functionality with real API integration
- [x] Chat widgets: message bubbles, input bar, image picker
- [x] Read receipts and connection status
- [x] Korean localization (app_ko.arb)

### From `feat/firebase-crashlytics-analytics`:
- [x] Firebase Crashlytics integration
- [x] Firebase Analytics integration
- [x] google_sign_in v7.x migration

### From `feat/fastlane-deployment`:
- [x] Android Fastlane setup
- [x] iOS Fastlane setup
- [x] GitHub Actions CI/CD workflows

### From `feat/forgot-password-screen`:
- [x] ForgotPasswordScreen with 3-step flow (email → code → new password)
- [x] ForgotPasswordProvider for state management
- [x] Backend API integration (reset request, verify, confirm)
- [x] Route and navigation from login screen

### Chat Real API Migration (2026-01-30):
- [x] Removed mock API usage from `chat_provider.dart`
- [x] Now uses `ChatApiImpl` with real backend (STOMP/Kafka)
- [x] Full functionality: messages, images, read receipts, pagination

### Profile Real API Migration (2026-01-30):
- [x] Created `ProfileApiImpl` with real backend API calls
- [x] Updated `profile_provider.dart` to use `ProfileApiImpl`
- [x] Uses current user ID from auth provider
- [x] Settings API - using local defaults (backend pending)
- [x] Profile Stats API - using placeholder (backend pending)

### Posts Real API Migration (2026-01-30):
- [x] Added `getMyPosts` to BoardRepository
- [x] Added `myPostsProvider` in profile_provider.dart
- [x] Updated profile_screen.dart to display real user posts
- [x] Backend: Added GET /users/me/posts endpoint (PR pending)

---

## 4. Branches Status

| Branch | Status | Notes |
|--------|--------|-------|
| `origin/dylan` | Not merged | Dev environment, Google sign-out |
| `origin/feat/initial-stage` | Not merged | .vscode removal, profile stats |

---

## 5. From Backend PRD (v2.5.17)

### Backend Complete, Frontend Needed

- [ ] Push Notification (FCM) - BE ready, FE implementation needed
- [ ] Board Admin APIs - BE 90% complete
- [ ] isUniversityVerified refactoring - Use for access control
- [ ] Policy versioning frontend support

### Both BE & FE Needed

- [ ] Admin Dashboard UI
- [ ] Real-time notification center
- [ ] Advanced search filters

---

## 6. Recommended Next Tasks

1. ~~**비밀번호 찾기 화면**~~ - ✅ Done (`feat/forgot-password-screen`)
2. ~~**Chat Mock → Real API**~~ - ✅ Done (Real API 연동 완료)
3. ~~**Profile Mock → Real API**~~ - ✅ Done (Real API 연동 완료)
4. ~~**Posts Mock → Real API**~~ - ✅ Done (Real API 연동 완료)
5. **FCM Push Notification** - Firebase already configured
6. **i18n Language Support** - FE only, no backend dependency
