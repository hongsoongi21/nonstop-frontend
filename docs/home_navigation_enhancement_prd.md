# Nonstop App – Home & Navigation Enhancement PRD
**Version: v1.0.0 (2026.04.15)**
**Status: Draft / High Priority**

## 1. Overview
사용자가 앱 접속 시 가장 필요한 정보를 한눈에 파악할 수 있도록 **'홈(Home)' 탭**을 신설하고, 하단 내비게이션 바의 복잡도를 낮추기 위해 **친구 관리 기능을 프로필 탭으로 통합**하는 내비게이션 개편안입니다.

### 1.1 Goals
- **첫인상 개선**: 게시판 리스트 대신 개인화된 대시보드(홈)를 첫 화면으로 제공.
- **정보 접근성 강화**: 공지, 오늘 일정, 인기 콘텐츠를 앱 실행 즉시 확인.
- **UI 단순화**: 하단 탭을 핵심 기능(홈, 게시판, 시간표, 채팅, 프로필)으로 재편하여 사용성 개선.

---

## 2. Navigation Restructuring

### 2.1 Tab Index & Order Changes
기존의 5개 탭 구성을 유지하면서 기능을 재배치합니다.

| Index | Tab Name | Icon (Outline/Solid) | Key Content |
| :--- | :--- | :--- | :--- |
| **0** | **홈 (Home)** | `home_outlined` / `home` | 공지, 오늘 시간표, 인기글 요약 |
| **1** | **게시판 (Board)** | `people_alt_outlined` / `people_alt` | 커뮤니티 및 게시판 목록 (기존 0번) |
| **2** | **시간표 (Timetable)** | `calendar_month_outlined` / `calendar_month` | 개인 시간표 관리 |
| **3** | **채팅 (Chat)** | `chat_bubble_outline` / `chat_bubble` | 1:1 및 그룹 채팅 |
| **4** | **프로필 (Profile)** | `person_outline` / `person` | 내 정보, 설정, **친구 관리 통합** |

### 2.2 Friends Tab Integration
- **기존**: 독립된 '친구' 탭(Index 3) 존재.
- **변경**: 하단 내비게이션 바에서 '친구' 탭 제거.
- **통합**: `Profile` 탭 상단 **AppBar**에 친구 아이콘 버튼(`Icons.person_add_outlined` 또는 `group`) 배치.
- **Flow**: Profile 탭 진입 → 상단 AppBar 친구 아이콘 클릭 → 기존 `FriendsScreen`으로 이동 (Stack Navigation).

### 2.3 Landing Page Change
- **기존**: 로그인 성공 또는 자동 로그인 시 `Routes.board`로 이동.
- **변경**: 로그인 성공 또는 자동 로그인 시 `Routes.home`으로 이동.

---

## 3. Home Tab Functional Requirements

### 3.1 공지사항 요약 (Notice Summary)
- **위치**: 홈 화면 최상단 (Horizontal Banner 또는 Card)
- **데이터**: `BoardType.NOTICE`인 게시판의 최신 게시글 노출.
- **Empty State**: 등록된 공지사항이 없는 경우 "현재 등록된 공지사항이 없습니다." 메시지 표시.
- **기능**: 클릭 시 해당 공지사항 상세 페이지로 이동.

### 3.2 오늘의 시간표 (Today's Timetable)
- **위치**: 홈 화면 중단 (가장 시각적인 요소)
- **데이터**: 
    - 사용자의 활성 시간표 중 **현재 요일**에 해당하는 수업 목록.
    - 시간순(시작 시간 기준)으로 정렬하여 노출.
- **UI/UX**:
    - 수업이 있는 경우: [수업명, 시간, 장소]를 타임라인 형태로 표시.
    - 수업이 없는 경우: '오늘은 수업이 없습니다. 즐거운 하루 되세요!' 메시지 표시 및 **[시간표 만들러 가기]** 버튼 배치 (시간표 탭으로 이동).
- **기능**: 클릭 시 전체 시간표(Timetable Tab)로 이동.

### 3.3 인기 콘텐츠 요약 (Popular Content)
- **위치**: 홈 화면 하단 (단일 통합 섹션)
- **선정 기준**:
    - **인기 게시판**: 게시글이 가장 많이 등록된 순위 상위 **5개**.
    - **인기 게시글**: 각 게시판 내에서 조회수(`view_count`)가 가장 높은 **상위 1개**.
- **UI/UX**:
    - 섹션 타이틀(예: "지금 인기 있는 게시판") 우측 상단에 작은 글씨로 **[더보기 >]** 버튼 배치.
    - [더보기 >] 클릭 시 전체 게시판 목록(`Routes.board`)으로 이동.
    - 리스트 형태: `[게시판 명] 게시글 제목 (댓글수/좋아요수)` 형식으로 5줄 노출.
- **Empty State**: 작성된 게시글이 없는 경우 "작성된 게시글이 없습니다." 메시지 표시.
- **기능**: 각 라인 클릭 시 해당 게시글 상세 페이지로 이동.

---

## 4. Technical Specification

### 4.1 Backend: Dashboard API
홈 화면의 로딩 성능을 위해 여러 도메인의 데이터를 통합하여 제공하는 전용 엔드포인트를 신설합니다.

- **Endpoint**: `GET /api/v1/home/dashboard`
- **Auth**: Required (`Authorization: Bearer <token>`)
- **Business Logic**:
    - `popularBoards`: `boards` 테이블과 `posts` 테이블을 Join하여 count 기준 정렬 (Limit 5).
    - `topPost`: 각 게시판의 최신/조회수 상위 1개 게시글 매칭.
- **Response Structure**:
```json
{
  "success": true,
  "data": {
    "notices": [...],
    "todayTimetable": {...},
    "popularBoards": [
      {
        "boardId": 1,
        "boardName": "자유게시판",
        "topPost": {
          "id": 501,
          "title": "오늘 학식 메뉴 대박이네요",
          "likeCount": 42,
          "commentCount": 15
        }
      },
      { "boardId": 2, "boardName": "비밀게시판", "topPost": {...} },
      { "boardId": 3, "boardName": "장터게시판", "topPost": {...} },
      { "boardId": 4, "boardName": "Q&A게시판", "topPost": {...} },
      { "boardId": 5, "boardName": "정보게시판", "topPost": {...} }
    ]
  }
}
```

### 4.2 Frontend: Routing & Refresh Strategy
- **GoRouter**: `StatefulShellRoute`의 브랜치 순서 조정 및 `Friends` 브랜치 제거.
- **Data Refresh Strategy (Recommended)**:
    - **Initial Fetch**: 앱 진입 및 탭 전환 시 데이터가 없거나 오래된 경우(5분 초과) 자동 로드.
    - **Pull-to-Refresh**: `RefreshIndicator` 위젯을 적용하여 사용자가 수동으로 최신 데이터를 갱신할 수 있도록 구현.
- **Profile Integration**: 
    - `ProfileScreen`의 `AppBar`에 `IconButton`을 추가하여 `Routes.friends`로 이동하는 로직 구현.

---

## 5. Implementation Plan & Priorities

### P0: 핵심 내비게이션 및 홈 탭 골격 (Must-Have)
- [ ] 하단 탭 순서 변경 및 친구 탭 제거.
- [ ] 로그인 후 홈 화면 진입 로직 수정.
- [ ] `GET /api/v1/home/dashboard` API 개발.
- [ ] 홈 화면 오늘의 시간표 연동.

### P1: 인기 콘텐츠 및 UX 고도화 (Should-Have)
- [ ] 인기 게시판/게시글 추출 로직 고도화.
- [ ] 공지사항 배너 UI 구현.
- [ ] 프로필 내 친구 관리 진입점 UI 구현.

### P2: 부가 기능 (Nice-to-Have)
- [ ] 홈 화면 스켈레톤 UI (Loading State).
- [ ] 오늘의 시간표 위젯 내 실시간 남은 시간 표시.
