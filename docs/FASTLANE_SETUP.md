# Fastlane 배포 자동화 설정 가이드

## 개요

이 프로젝트는 Fastlane을 사용하여 Android/iOS 앱 배포를 자동화합니다.

## 배포 트랙

| 트랙 | Android | iOS | 용도 |
|------|---------|-----|------|
| Firebase | Firebase App Distribution | Firebase App Distribution | 내부 테스트 |
| Internal | Play Store Internal | TestFlight Internal | QA 테스트 |
| Alpha/Beta | Play Store Alpha/Beta | TestFlight External | 베타 테스트 |
| Production | Play Store Production | App Store | 정식 출시 |

## 로컬 실행

### Android

```bash
cd android

# 테스트 실행
bundle exec fastlane test

# Debug APK 빌드
bundle exec fastlane build_debug

# Release APK 빌드
bundle exec fastlane build_release

# Firebase 배포
bundle exec fastlane firebase_internal

# Play Store Internal 배포
bundle exec fastlane internal

# Play Store Production 배포
bundle exec fastlane production
```

### iOS

```bash
cd ios

# 테스트 실행
bundle exec fastlane test

# 인증서 동기화
bundle exec fastlane sync_certs

# Firebase 배포
bundle exec fastlane firebase_internal

# TestFlight 배포
bundle exec fastlane testflight_internal

# App Store 배포
bundle exec fastlane production
```

## GitHub Secrets 설정

### 공통

| Secret | 설명 |
|--------|------|
| `FIREBASE_CLI_TOKEN` | Firebase CLI 인증 토큰 (`firebase login:ci`) |
| `FIREBASE_ANDROID_APP_ID` | Firebase Android 앱 ID |
| `FIREBASE_IOS_APP_ID` | Firebase iOS 앱 ID |

### Android

| Secret | 설명 |
|--------|------|
| `ANDROID_KEYSTORE_BASE64` | Release 서명 키스토어 (Base64 인코딩) |
| `KEYSTORE_PASSWORD` | 키스토어 비밀번호 |
| `KEY_ALIAS` | 키 별칭 |
| `KEY_PASSWORD` | 키 비밀번호 |
| `GOOGLE_PLAY_JSON_KEY_BASE64` | Google Play Service Account JSON (Base64) |

### iOS

| Secret | 설명 |
|--------|------|
| `MATCH_GIT_URL` | Match 인증서 저장소 URL |
| `MATCH_PASSWORD` | Match 암호화 비밀번호 |
| `MATCH_SSH_PRIVATE_KEY` | Match 저장소 SSH 키 |
| `APP_IDENTIFIER` | 앱 Bundle ID |
| `APPLE_ID` | Apple ID 이메일 |
| `TEAM_ID` | Apple Developer Team ID |
| `ITC_TEAM_ID` | App Store Connect Team ID |
| `APP_STORE_CONNECT_API_KEY_ID` | API Key ID |
| `APP_STORE_CONNECT_ISSUER_ID` | Issuer ID |
| `APP_STORE_CONNECT_API_KEY_CONTENT` | API Key 내용 (Base64) |

## GitHub Actions 워크플로우

### 자동 배포 (Push)

- `main` 브랜치 push → Firebase App Distribution 배포
- `v*` 태그 push → Production 배포

### 수동 배포

1. GitHub → Actions → "Android Deploy" 또는 "iOS Deploy"
2. "Run workflow" 클릭
3. 배포 트랙 선택 후 실행

## 초기 설정 순서

### 1. Android 키스토어 생성

```bash
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload

# Base64 인코딩
base64 -i upload-keystore.jks | pbcopy
```

### 2. Google Play Service Account 설정

1. Google Play Console → 설정 → API 액세스
2. 서비스 계정 생성
3. JSON 키 다운로드
4. Base64 인코딩: `base64 -i service-account.json | pbcopy`

### 3. iOS Match 설정

```bash
cd ios
bundle exec fastlane match init
# Git 저장소 URL 입력

# 인증서 생성
bundle exec fastlane match appstore
bundle exec fastlane match adhoc
bundle exec fastlane match development
```

### 4. Firebase CLI 토큰 발급

```bash
firebase login:ci
# 출력된 토큰을 FIREBASE_CLI_TOKEN에 저장
```

### 5. App Store Connect API Key 생성

1. App Store Connect → Users and Access → Keys
2. API Key 생성 (Admin 권한)
3. Key ID, Issuer ID, .p8 파일 저장
4. .p8 파일 Base64 인코딩: `base64 -i AuthKey.p8 | pbcopy`

## 트러블슈팅

### Android 빌드 실패

- `key.properties` 파일 확인
- 키스토어 경로/비밀번호 확인

### iOS 코드 서명 실패

- `fastlane match` 재실행
- Provisioning Profile 만료 확인
- Team ID 일치 확인

### Firebase 배포 실패

- `FIREBASE_CLI_TOKEN` 만료 여부 확인
- Firebase 프로젝트 권한 확인
