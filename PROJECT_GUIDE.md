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

## ✔ 다국어 지원 (Localization)
- 본 프로젝트는 영어, 러시아어, 우즈베키스탄어를 기본으로 지원합니다.
- UI에 표시되는 모든 텍스트는 하드코딩을 금지하고, 아래의 l10n 규칙을 따라야 합니다.
- **설정 파일**: 프로젝트 루트의 `l10n.yaml` 파일이 다국어 지원 설정을 관리합니다.
  - `arb-dir`: 번역 파일(.arb)이 위치할 디렉토리입니다. (`lib/core/l10n`)
  - `template-arb-file`: 기본 언어 템플릿 파일입니다. (`app_en.arb`)
- **텍스트 추가/수정 절차**:
  1. `lib/core/l10n/app_en.arb` 파일에 새로운 텍스트 키(key)와 값(value)을 추가합니다.
  2. 다른 언어 파일들(`app_ru.arb`, `app_uz.arb` 등)에도 동일한 키와 번역된 값을 추가합니다.
  3. 터미널에서 `flutter pub get` 명령을 실행하여 `app_localizations.dart` 파일을 자동으로 업데이트합니다. (또는 `flutter gen-l10n`)
- **UI 적용 예시**:
  ```dart
  import 'package:nonstop/core/l10n/app_localizations.dart';

  // BuildContext가 있는 위젯 내부에서
  Text(AppLocalizations.of(context)!.helloWorld);
  ```

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
│  ├─ l10n/
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

l10n.yaml
```

---

# 📁 **Core 폴더 설명**

| 폴더 | 용도 |
|------|------|
| `core/constants/` | 앱 전역에서 사용하는 상수, 라우트 정의, API 엔드포인트 등 |
| `core/errors/` | 공통 에러 핸들링, 예외 타입 정의 |
| `core/l10n/` | 다국어 지원(Localization)을 위한 텍스트 리소스(.arb 파일) 관리 |
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
- `flutter pub get` 실행 시, 의존성 패키지 설치와 더불어 다국어 지원 코드(`app_localizations.dart`)가 자동으로 생성/업데이트 됩니다.

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



# 📌 8. 주요 의존성 패키지



본 프로젝트는 개발 효율성, 안정성, 성능을 높이기 위해 다음의 주요 의존성 패키지들을 사용합니다.



### ✔ **`freezed` & `json_serializable`**

- **역할**: 불변(immutable) 데이터 클래스와 JSON 직렬화/역직렬화 코드를 자동으로 생성합니다.

- **필요성**:

    - API 응답(JSON)을 Dart 객체(Model/DTO)로 변환하는 반복적인 작업을 자동화합니다.

    - `copyWith`, `toString`, `==` 등 보일러플레이트 코드를 자동으로 구현하여 생산성을 높입니다.

    - 불변 객체를 사용함으로써 상태 관리의 예측 가능성과 안정성을 높입니다.

- **활용 방안**:

    - `Domain` 레이어의 `Entity`와 `Data` 레이어의 `DTO`/`Model`을 정의하는 데 사용합니다.

    - 터미널에서 `flutter pub run build_runner build` 명령을 실행하여 코드를 생성합니다.

- **예시 (`freezed` 클래스 정의)**:

  ```dart

  import 'package:freezed_annotation/freezed_annotation.dart';



  part 'user_model.freezed.dart';

  part 'user_model.g.dart';



  @freezed

  class UserModel with _$UserModel {

    const factory UserModel({

      required int id,

      required String name,

      required String email,

    }) = _UserModel;



    factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  }

  ```



### ✔ **`get_it`**

- **역할**: 서비스 로케이터(Service Locator) 패턴을 구현하여 의존성 주입(DI)을 쉽게 하도록 돕습니다.

- **필요성**:

    - `Repository`, `DataSource` 등 핵심 로직 객체들의 생명주기를 관리하고, 중앙에서 쉽게 접근할 수 있게 합니다.

    - 코드의 결합도를 낮추어 모듈화 및 테스트 용이성을 향상시킵니다.

    - Riverpod `Provider` 내부에서 직접 객체를 생성하는 대신, `get_it`으로 등록된 인스턴스를 가져와 사용함으로써 코드를 더 깔끔하게 유지할 수 있습니다.

- **활용 방안**:

    - 앱 시작 시점에 필요한 서비스(Repository 등)들을 미리 등록해 둡니다.

    - `Provider`나 `ViewModel` 등에서 등록된 서비스를 가져와 사용합니다.

- **예시 (서비스 등록 및 사용)**:

  ```dart

  // 1. 서비스 로케이터 인스턴스 생성

  final sl = GetIt.instance;



  // 2. 앱 시작 시 서비스 등록

  void setupLocator() {

    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  }



  // 3. Provider 등에서 사용

  final authRepositoryProvider = Provider((ref) => sl<AuthRepository>());

  ```



### ✔ **`go_router`**

- **역할**: Flutter 팀에서 공식 지원하는 URL 기반의 선언적 라우팅 패키지입니다.

- **필요성**:

    - Feature 기반의 복잡한 앱 구조에서 페이지 네비게이션을 체계적으로 관리할 수 있습니다.

    - URL을 통해 특정 페이지로 직접 이동하는 딥링킹(Deep Linking) 구현이 용이합니다.

    - 각 라우트에 이름을 부여하고 파라미터를 전달하는 과정이 직관적입니다.

- **활용 방안**:

    - 앱의 전체적인 라우팅 규칙을 한 파일에서 정의하고 관리합니다.

- **예시 (라우터 설정)**:

  ```dart

  final router = GoRouter(

    initialLocation: '/splash',

    routes: [

      GoRoute(

        path: '/splash',

        builder: (context, state) => const SplashScreen(),

      ),

      GoRoute(

        path: '/board/:id',

        builder: (context, state) {

          final id = state.pathParameters['id']!;

          return BoardDetailScreen(boardId: id);

        },

      ),

    ],

  );



  // MaterialApp.router에 설정

  // return MaterialApp.router(routerConfig: router);

  ```



### ✔ **`cached_network_image`**

- **역할**: 네트워크 이미지를 불러오고 기기에 캐싱(caching)합니다.

- **필요성**:

    - 게시판의 썸네일, 사용자 프로필 사진 등 반복적으로 사용되는 이미지를 매번 새로 다운로드하지 않아 성능을 최적화하고 데이터 사용량을 절약합니다.

    - 이미지를 불러오는 동안 로딩 인디케이터(placeholder)나 에러 위젯을 쉽게 표시할 수 있습니다.

- **활용 방안**:

    - `Image.network` 대신 `CachedNetworkImage` 위젯을 사용합니다.

- **예시**:

  ```dart

  CachedNetworkImage(

    imageUrl: "http://example.com/image.jpg",

    placeholder: (context, url) => CircularProgressIndicator(),

    errorWidget: (context, url, error) => Icon(Icons.error),

  ),

  ```



### ✔ **`dio` & `flutter_secure_storage`**

- **`dio` 역할**: 강력하고 유연한 기능을 제공하는 HTTP 클라이언트입니다.

- **`flutter_secure_storage` 역할**: JWT 토큰, 로그인 정보 등 민감한 데이터를 암호화하여 안전하게 로컬에 저장합니다.

- **필요성 및 활용 방안**:

    - `dio`의 `Interceptor`를 사용하여 모든 API 요청 헤더에 `flutter_secure_storage`에 저장된 JWT 토큰을 자동으로 추가하는 로직을 구현합니다.

    - 이를 통해 인증이 필요한 API를 간편하게 호출할 수 있습니다.





# 📌 9. 문의 / 담당자



- **FE Lead**: 홍순기, 딜런

- **BE Lead**: 심현수

- **디자인**: 박지선
