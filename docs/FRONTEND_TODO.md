# Frontend TODO List

> Last updated: 2026-01-31
> Based on codebase analysis and PRD review

## 1. TODO Items (UI Only - No Real Implementation)

### HIGH Priority

| Location | Description | Backend Status | Related Branch |
|----------|-------------|----------------|----------------|
| ~~`login_screen_v1.dart:134`~~ | ~~비밀번호 찾기 화면~~ | ~~BE API 완료~~ | `feat/forgot-password-screen` (Done) |
| ~~`signup_screen.dart:305-317`~~ | ~~Google/Apple 회원가입~~ | ~~BE 완료~~ | ✅ Merged |
| ~~`chat_screen.dart:26`~~ | ~~1:1 채팅방 생성 (User picker)~~ | ~~BE 완료 (STOMP/Kafka)~~ | ✅ Merged |

### MEDIUM Priority

| Location | Description | Backend Status | Related Branch |
|----------|-------------|----------------|----------------|
| `main_scaffold.dart:42` | 관리자 기능 구현 | Admin API 부분 완료 | - |
| ~~`home_screen.dart:191`~~ | ~~알림(Notifications) 화면~~ | ~~FCM 연동 필요~~ | `feat/fcm-push-notification` (Done) |
| ~~`language_selector.dart:56`~~ | ~~언어 변경 로직 (i18n)~~ | ~~FE Only~~ | ✅ Done (`feat/i18n-full-localization`) |
| `timetable_screen.dart:318` | 새 시간표 생성 화면 | BE 완료 | - |

### LOW Priority

| Location | Description | Backend Status | Related Branch |
|----------|-------------|----------------|----------------|
| ~~`home_screen.dart:64`~~ | ~~Pull-to-refresh 로직~~ | - | ✅ Done (UX improvements) |
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

## 3. Recently Completed Features (2026-01-31)

### Design System - "Samarkand Modern" Theme
- [x] Complete app redesign with new color palette
- [x] Primary: #1E3A5F, Secondary: #D4AF37
- [x] Pretendard font family
- [x] Consistent component styling

### i18n Full Localization (2026-01-30)
- [x] Complete Korean localization (app_ko.arb)
- [x] Complete Uzbek localization (app_uz.arb)
- [x] Complete Russian localization (app_ru.arb)
- [x] Complete English localization (app_en.arb)
- [x] Language switching in settings

### UX Improvements (2026-01-30)
- [x] Skeleton loaders for lists (shimmer effect)
- [x] Pull-to-refresh on all list screens
- [x] Haptic feedback on interactions
- [x] Chat search functionality
- [x] Image error handlers with placeholders

### Report & Block Feature (2026-01-31)
- [x] Report posts/comments/users/chat messages
- [x] Block/Unblock users
- [x] Blocked users management screen
- [x] Report dialog with reason selection
- [x] Backend API integration (PR #29)

### University Verification (2026-01-31)
- [x] Student ID photo upload verification
- [x] School email verification with 6-digit code
- [x] Verification status tracking
- [x] Dual-tab UI (Student ID / Email)

### App Configuration (2026-01-31)
- [x] Package name: `uz.merge4.nonstop`
- [x] Firebase project: `nonstop-c2aa4`
- [x] iOS minimum version: 15.0
- [x] New app icon (blue gradient N logo)
- [x] Android adaptive icon support

### Deployment Setup (2026-01-31)
- [x] Firebase App Distribution configured
- [x] Fastlane Android deployment working
- [x] Fastlane iOS deployment working
- [x] Development export options for iOS

---

## 4. Previous Completed Features

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

### FCM Push Notification Implementation:
- [x] Added firebase_messaging and flutter_local_notifications packages
- [x] FcmService for push notification handling
- [x] NotificationScreen with read/unread UI
- [x] FCM token registration on login/signup

---

## 5. Remaining TODO

### Backend PR Pending
- [ ] Merge PR #29 (report/block API) to main branch

### Code Quality
- [ ] Fix `unnecessary_non_null_assertion` warnings (10+ files)
- [ ] Remove unused imports (fcm_service.dart, chat_screen.dart)
- [ ] Complete remaining i18n translations (ko: 30, ru: 31, uz: 31 messages)

### Store Release Preparation
- [ ] iOS Launch Image (replace placeholder)
- [ ] Privacy Policy URL
- [ ] Terms of Service URL
- [ ] Store screenshots (4 languages)
- [ ] App descriptions (4 languages)
- [ ] iOS Ad-Hoc/App Store certificates (for production release)

### Future Features
- [ ] Admin Dashboard UI
- [ ] Advanced search filters
- [ ] New timetable creation screen

---

## 6. Git Commit History (Recent)

```
732c945 chore: update fastlane config for Firebase App Distribution
2cc4836 feat: update app icon for Android and iOS
93c1716 docs: add development summary document
a8d1c26 chore(ios): update minimum iOS version to 15.0 for Firebase compatibility
ce48b16 chore: update Firebase config for uz.merge4.nonstop
25a465d feat: implement university verification feature
c64743a chore: change package name to uz.merge4.nonstop
fb633d1 feat: implement report and block functionality
ffcb286 feat: implement UX improvements (skeleton, haptic, chat search)
0ef0b7e feat: implement FE-only improvements (image handlers, refresh, etc.)
5736df2 Merge branch 'feat/i18n-full-localization' into dev
47d6ec8 feat: complete full app localization for 4 languages (uz/ru/en/ko)
3b830dc feat: redesign entire app with "Samarkand Modern" theme
```
