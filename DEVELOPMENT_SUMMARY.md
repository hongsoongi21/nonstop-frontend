# Nonstop App Development Summary

## Project Overview
- **App Name**: Nonstop (논스톱)
- **Package Name**: `uz.merge4.nonstop`
- **Target Users**: Uzbekistan university students
- **Firebase Project**: `nonstop-c2aa4`

---

## Design System: "Samarkand Modern"

### Theme Colors
| Color | Hex | Usage |
|-------|-----|-------|
| Primary | `#1E3A5F` | Main actions, headers |
| Primary Light | `#2E5A8F` | Hover states |
| Secondary | `#D4AF37` | Accents, highlights |
| Success | `#2E7D32` | Success states |
| Warning | `#F9A825` | Warnings |
| Error | `#C62828` | Errors |
| Background | `#FAFAFA` | App background |
| Surface | `#FFFFFF` | Cards, sheets |

### Typography
- Headlines: `Pretendard` (Bold)
- Body: `Pretendard` (Regular/Medium)
- Captions: `Pretendard` (Light)

---

## Features Implemented

### 1. Authentication
- [x] Email/Password login
- [x] Google Sign-in integration
- [x] Sign up with policy agreement
- [x] Forgot password flow
- [x] Session management with secure storage

### 2. University Verification
- [x] Student ID photo upload verification
- [x] School email verification with 6-digit code
- [x] Verification status tracking
- [x] Dual-tab UI (Student ID / Email)

### 3. Community Board
- [x] Board list with categories
- [x] Post creation with images
- [x] Comments and replies
- [x] Like/Unlike functionality
- [x] Search posts
- [x] Report posts/comments

### 4. Chat System
- [x] Real-time messaging (WebSocket)
- [x] Chat room list
- [x] Message search
- [x] Report chat messages
- [x] Block users

### 5. Timetable
- [x] Weekly schedule view
- [x] Class management
- [x] Time conflict detection

### 6. Friends
- [x] Friend list
- [x] Friend requests (send/accept/reject)
- [x] Block/Unblock users
- [x] Blocked users management

### 7. Profile & Settings
- [x] Profile view/edit
- [x] University info display
- [x] Settings management
- [x] Notification preferences
- [x] Language selection
- [x] Theme selection
- [x] Blocked users screen

### 8. Notifications
- [x] Push notifications (FCM)
- [x] Notification list
- [x] Read/Unread status

---

## Report & Block System (App Store Compliance)

### Report Types
| Target | Endpoint |
|--------|----------|
| Post | `POST /api/v1/community/posts/{postId}/report` |
| Comment | `POST /api/v1/community/comments/{commentId}/report` |
| User | `POST /api/v1/users/{userId}/report` |
| Chat Message | `POST /api/v1/chat/messages/{messageId}/report` |

### Report Reasons
- `SPAM` - Spam or advertising
- `HARASSMENT` - Harassment or bullying
- `INAPPROPRIATE` - Inappropriate content
- `HATE_SPEECH` - Hate speech
- `VIOLENCE` - Violence or threats
- `FALSE_INFO` - False information
- `OTHER` - Other (with description)

### Block System
- Block user: `POST /api/v1/friends/block/{userId}`
- Unblock user: `DELETE /api/v1/friends/block/{blockedId}`
- Get blocked list: `GET /api/v1/friends/blocked`

---

## Internationalization (i18n)

### Supported Languages
| Code | Language | Status |
|------|----------|--------|
| `uz` | Uzbek | ✅ Complete |
| `ru` | Russian | ✅ Complete |
| `en` | English | ✅ Complete |
| `ko` | Korean | ✅ Complete |

### ARB Files Location
```
lib/core/l10n/arb/
├── app_uz.arb
├── app_ru.arb
├── app_en.arb
└── app_ko.arb
```

---

## UX Enhancements

### Loading States
- Skeleton loaders for lists (Shimmer effect)
- Pull-to-refresh on all list screens
- Infinite scroll pagination

### Feedback
- Haptic feedback on interactions
- Toast messages for actions
- Loading indicators for async operations

### Navigation
- Bottom navigation with 5 tabs
- Smooth page transitions
- Deep linking support

---

## Technical Stack

### Frontend
- **Framework**: Flutter 3.x
- **State Management**: Riverpod
- **HTTP Client**: Dio
- **Code Generation**: Freezed, json_serializable
- **Local Storage**: flutter_secure_storage, shared_preferences
- **Push Notifications**: firebase_messaging
- **Image Handling**: image_picker, cached_network_image

### Backend Integration
- REST API with JWT authentication
- WebSocket for real-time chat
- Multipart form data for file uploads
- FCM for push notifications

---

## Firebase Configuration

### Project Details
- **Project ID**: `nonstop-c2aa4`
- **Storage Bucket**: `nonstop-c2aa4.firebasestorage.app`

### App IDs
| Platform | App ID |
|----------|--------|
| Android | `1:127473148279:android:2109fc50be2bbc3ec2c172` |
| iOS | `1:127473148279:ios:1fe527d213701a6dc2c172` |

### Services Enabled
- Firebase Cloud Messaging (FCM)
- Firebase Analytics
- Firebase Crashlytics
- Firebase App Distribution

---

## Build Configuration

### Android
- **Min SDK**: 21
- **Target SDK**: 34
- **Package**: `uz.merge4.nonstop`

### iOS
- **Min Version**: iOS 15.0
- **Bundle ID**: `uz.merge4.nonstop`

---

## Deployment

### Fastlane Lanes

**Android:**
```bash
# Internal testing via Firebase
fastlane android firebase_internal

# Play Store tracks
fastlane android internal
fastlane android alpha
fastlane android beta
fastlane android production
```

**iOS:**
```bash
# Internal testing via Firebase
fastlane ios firebase_internal

# TestFlight
fastlane ios testflight_internal
fastlane ios testflight_beta

# App Store
fastlane ios production
```

---

## Environment Variables Required

```bash
# Firebase
FIREBASE_CLI_TOKEN=<token>
FIREBASE_ANDROID_APP_ID=1:127473148279:android:2109fc50be2bbc3ec2c172
FIREBASE_IOS_APP_ID=1:127473148279:ios:1fe527d213701a6dc2c172

# iOS Code Signing
APPLE_ID=<apple_id>
TEAM_ID=<team_id>
ITC_TEAM_ID=<itc_team_id>
MATCH_GIT_URL=<certificates_repo>
MATCH_PASSWORD=<match_password>

# Android
GOOGLE_PLAY_JSON_KEY_FILE=<path_to_key>
```

---

## Git Branches

| Branch | Purpose |
|--------|---------|
| `main` | Production releases |
| `dev` | Development integration |
| `feat/*` | Feature branches |
| `fix/*` | Bug fix branches |

---

## Recent Changes (Latest Session)

1. **Report/Block Feature** - Full implementation for app store compliance
2. **Package Name Change** - `com.example.nonstop` → `uz.merge4.nonstop`
3. **University Verification** - Student ID and email verification UI
4. **Firebase Setup** - Configured with project `nonstop-c2aa4`
5. **iOS 15.0 Minimum** - Updated for Firebase compatibility

---

*Last Updated: January 2026*
