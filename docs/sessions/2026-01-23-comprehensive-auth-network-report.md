# Comprehensive Session Report: End-to-End Google Auth & Mobile Networking (Jan 23, 2026)

## 🎯 Executive Summary
Successfully implemented and verified full-stack Google Authentication using Firebase Admin SDK. Resolved critical networking blocks for physical Android devices and performed security hardening via service account rotation.

---

## 🛠 1. Google OAuth Implementation (Frontend)
**Tracked Issue**: `nonstop-frontend-4dd`

### ❌ Initial Problems
1.  **Architecture Drift**: Logic was being implemented in `login_screen.dart` while the app was routing to `login_screen_v1.dart`.
2.  **Token Type Mismatch**: The app was sending a raw Google OAuth ID Token (Issuer: accounts.google.com). The backend's Firebase Admin SDK specifically requires a **Firebase ID Token** (Issuer: securetoken.google.com).
3.  **Client ID Mismatch**: The code was using the iOS Client ID for Android requests, resulting in `ApiException 10` (Developer Error).
4.  **Linter/API Errors**: Used mismatched `google_sign_in` versions (`7.2.0`) which caused constructor failures in the Flutter analyzer.

### ✅ Final Solutions
-   **Firebase Auth Exchange**: Integrated `firebase_auth` package to exchange Google Credentials for a Firebase ID Token before transmission to the backend.
-   **Stable Dependency**: Downgraded and locked `google_sign_in` to `6.2.1` for API stability.
-   **Web Client ID Integration**: Correctly mapped the **Web application** Client ID from GCP to the `serverClientId` parameter in Flutter.
-   **UI Refactoring**: Merged high-quality animations from the abandoned `login_screen.dart` into the active `login_screen_v1.dart` and deleted the redundant file.

---

## 🏗 2. Security & Backend Alignment (Backend)
**Location**: `/Users/thejoin/Desktop/nonstop-backend`

### ❌ Initial Problems
1.  **Stale Credentials**: `firebase-service-account.json` contained placeholder data (`placeholder-project`).
2.  **Mapping Exception**: Backend threw `500 Internal Server Error` due to a missing MyBatis statement: `com.app.nonstop.mapper.UserMapper.updateProfileImage`.
3.  **Key Exposure**: Private keys were temporarily exposed in session logs.

### ✅ Final Solutions
-   **Private Key Rotation**: Generated a fresh Service Account key from the Firebase Console, deployed it to `src/main/resources/firebase/`, and deleted the compromised old key in GCP IAM.
-   **MyBatis Patch**: Added the missing `<update id="updateProfileImage">` SQL mapping to `UserMapper.xml`.
-   **Validation Logic**: Confirmed `AuthServiceImpl.java` correctly handles user lookup by email, updates profile images for existing users, and creates new records for first-time Google sign-ins.

---

## 🌐 3. Physical Device Integration
**Tracked Issue**: `nonstop-frontend-1jq`

### ❌ Initial Problem
Physical devices connected via USB could not resolve the localhost backend. Using `10.0.2.2` only works for emulators, leading to a `30s connectTimeout`.

### ✅ Final Solution: ADB Reverse
-   **Port Tunneling**: Established a USB port forward using `adb -s <device_id> reverse tcp:28080 tcp:28080`.
-   **Conditional Networking**: Updated `EnvConfig.dart` to support a new compile-time flag:
    ```bash
    flutter run --dart-define=USE_ADB_REVERSE=true
    ```
-   **Logic**: When `USE_ADB_REVERSE` is true, the app intelligently switches from `10.0.2.2` to `127.0.0.1`, allowing the physical device to reach the MacBook's local server.

---

## 🚦 4. Verification & Testing
### Google Auth Platform (GCP Console)
-   **OAuth Consent Screen**: Configured branding (App Name: `Nonstop`) and support emails to clear security blocks.
-   **Publishing Status**: Switched to `In Production` to allow any Google account to sign in.
-   **Fingerprints**: Verified matching SHA-1 and SHA-256 fingerprints between local development keystore and Firebase Console.

### End-to-End Test Results
-   **Startup**: Skip `/users/me` call when no token exists (Zero 401 noise).
-   **Login**: "Continue with Google" -> Account Picker -> Backend 200 OK -> Redirect to Home.
-   **Consistency**: `flutter analyze` shows zero errors in all touched files.

---

## 📝 5. Artifacts Created/Modified
-   **Frontend**: `lib/features/auth/presentation/screens/login_screen_v1.dart` (Full Auth Logic)
-   **Frontend**: `lib/core/config/env_config.dart` (ADB Reverse support)
-   **Backend**: `src/main/resources/mybatis/mappers/user/UserMapper.xml` (Update mapping)
-   **Native**: `android/app/google-services.json`, `ios/Runner/Info.plist` (OAuth Config)
