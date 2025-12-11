# 📘 Nonstop — 개발 가이드 문서

---

## 🗓 작성일
2025-12-11

## ✍️ 작성자
홍순기

# 📌 1. 개발 규칙 (Development Rules)

## ✔ 코드 스타일
- Dart 공식 스타일 가이드 준수
- 파일명: `snake_case`
- 클래스명: `PascalCase`
- 메서드 및 변수명: `camelCase`
- 위젯은 반드시 `build` 함수 최소화 (리팩토링 적극 수행)
- UI, 로직, 상태 관리 분리 원칙

## ✔ 상태관리
- 전역 및 화면 단위 상태관리는 **Riverpod** 사용
- 동기적이고 간단한 상태는 `StateNotifier` 사용
- 비동기 통신 등 복잡한 로직은 `AsyncNotifier` 사용을 권장
- Domain Layer에는 상태(state) 보관 금지
- `StreamProvider`는 주로 WebSocket 기반 실시간 통신에 사용

## ✔ 아키텍처 원칙
- Feature 기반 구조(기능 단위)
- Clean Architecture 3-Layer 적용  
  - **Presentation** (UI + Riverpod)  
  - **Domain** (Entity, Repository Interface, UseCase)  
  - **Data** (API, Repository Impl, DTO/Model)

## ✔ API 통신 규칙
- Dio 사용
- Base API Client는 `core/network/dio_client.dart`에서 일괄 관리
- Interceptor 사용: JWT 자동 주입, 응답 에러 처리

## ✔ 예외 처리 규칙
- 모든 에러는 공통 Error Handler를 통해 처리
- Presentation Layer에서는 사용자 메시지 + 상태 업데이트만 담당

---

# 📌 2. 프로젝트 아키텍처 구조

본 프로젝트는 **Feature 기반 Clean Architecture + Riverpod 구조**로 작성한다.

Presentation ←→ Domain ←→ Data

### 🔹 Presentation Layer
- UI 화면 (Screens)
- Provider(StateNotifier, AsyncNotifier 등)
- 화면 전환(Navigation)
- 사용자 입력 처리
- 로딩/에러 상태 관리

### 🔹 Domain Layer
- 순수 비즈니스 로직
- Entity 정의
- Repository Interface 정의
- UseCase(비즈니스 규칙) 구성

### 🔹 Data Layer
- API 요청 처리(Dio)
- DTO / Model
- Repository 구현체
- Local Storage (Hive 등)

### 🔹 Core Layer (공통)
- 공용 위젯
- 상수/정의
- Theme
- Utils
- 오류 처리
- 네트워크 설정

---

# 📌 3. 폴더 구조 및 각 폴더의 목적

## 📁 **전체 구조**
```
lib/
├─ core/
│  ├─ constants/
│  ├─ errors/
│  ├─ network/
│  ├─ utils/
│  ├─ widgets/
│  └─ theme/
│
├─ features/
│  ├─ auth/
│  │  ├─ data/
│  │  │  ├─ api/
│  │  │  ├─ dto/
│  │  │  ├─ models/
│  │  │  └─ repository_impl/
│  │  ├─ domain/
│  │  │  ├─ entities/
│  │  │  ├─ repository/
│  │  │  └─ usecases/
│  │  └─ presentation/
│  │     ├─ providers/
│  │     ├─ screens/
│  │     └─ widgets/
│  │
│  ├─ board/
│  ├─ chat/
│  ├─ friends/
│  └─ timetable/
│
├─ app.dart
└─ main.dart
```

---

# 📁 **Core 폴더 설명**

| 폴더 | 용도 |
|------|------|
| `core/constants/` | 앱 전역에서 사용하는 상수, 라우트 정의, API 엔드포인트 등 |
| `core/errors/` | 공통 에러 핸들링, 예외 타입 정의 |
| `core/network/` | Dio client, Interceptor, API 공통 설정 |
| `core/utils/` | 날짜 변환, 문자열 처리 등 유틸 함수 |
| `core/widgets/` | 모든 Feature에서 재사용할 공용 위젯 |
| `core/theme/` | 앱 테마 설정, 색상/폰트 관리 |

---

# 📁 **Feature 폴더 설명**

| 폴더 | 목적 |
|------|-------|
| `data/api/` | API 함수 정의 |
| `data/dto/` | API 요청/응답용 DTO 모델 |
| `data/models/` | Domain Entity 변환 모델 |
| `data/repository_impl/` | Repository 구현체 |
| `domain/entities/` | 순수 데이터 구조(비즈니스 엔티티) |
| `domain/usecases/` | 기능 단위 핵심 비즈니스 로직 |
| `domain/repository/` | Repository 인터페이스 선언 |
| `presentation/providers/` | Riverpod 상태관리 |
| `presentation/screens/` | UI 화면 |
| `presentation/widgets/` | UI 구성 요소 |

---

# 📌 4. 커밋 규칙 (Commit Convention)

### ✨ **Conventional Commits 규칙 적용**

`<type>: <short summary>`

[body - optional]
[footer - optional]

### ✔ 타입 정의

| 타입 | 의미 |
|------|--------|
| `feat` | 새로운 기능 추가 |
| `fix` | 버그 수정 |
| `docs` | 문서 수정 |
| `style` | 스타일 변경(로직 영향 없음) |
| `refactor` | 코드 리팩토링 |
| `test` | 테스트 코드 추가/개선 |
| `chore` | 빌드, 설정 파일 수정 등 |
| `perf` | 성능 개선 |
| `ci` | CI/CD 수정 |
| `init` | 프로젝트 초기 세팅 |

### ✔ 커밋 예시

```
feat(auth): 회원가입 usecase 및 repository 연결

fix(board): 게시판 목록 페이지네이션 오류 수정

docs: 프로젝트 아키텍처 설명 추가

refactor(chat): WebSocket provider 구조 개선
```

---

# 📌 5. 브랜치 전략

### ✔ Git Flow 간단 버전
```
main
└─ dev
   ├─ feature/auth
   ├─ feature/chat
   ├─ feature/board
   └─ feature/timetable
```

### 브랜치 규칙
- `prod`: 배포 버전
- `dev`: 개발 통합 브랜치
- `feature/*`: 기능 단위 개발 브랜치
- 머지 전 PR 필수

---

# 📌 6. 프로젝트 실행 규칙

### ✔ FE(Flutter)
```
flutter clean
flutter pub get
flutter run
```

### ✔ 환경 변수(.env)
- `.env.example` 파일을 복사하여 `.env` 파일을 생성한 후, 아래 변수들을 자신의 환경에 맞게 설정합니다.
- `.env` 파일은 Git에 포함되지 않도록 `.gitignore`에 등록해야 합니다.

- `API_BASE_URL`
- `WS_BASE_URL`
- `JWT_SECRET` (필요 시)
- `Firebase` 옵션(푸시 알림)

---

# 📌 7. 코드 예시 (구조 참고)

### Riverpod Provider 예시

**StateNotifierProvider (동기 상태 관리)**
```dart
final counterProvider = StateNotifierProvider<Counter, int>((ref) {
  return Counter();
});

class Counter extends StateNotifier<int> {
  Counter() : super(0);
  void increment() => state++;
}
```

**AsyncNotifierProvider (비동기 데이터 처리)**
```dart
// 1. Provider 정의
final authRepositoryProvider = Provider((ref) => AuthRepository());

// 2. AsyncNotifier 정의
class AuthNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    // 초기화 로직 (필요 시)
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).login(email, password),
    );
  }
}

// 3. NotifierProvider 정의
final authProvider = AsyncNotifierProvider<AuthNotifier, void>(() {
  return AuthNotifier();
});
```

---

# 📌 8. 문의 / 담당자

- **FE Lead**: 홍순기, 딜런
- **BE Lead**: 심현수
- **디자인**: 박지선