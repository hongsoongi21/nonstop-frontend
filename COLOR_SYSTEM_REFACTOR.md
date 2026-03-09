# Nonstop Modern Color System Expansion

이 문서는 `#6E89F8`을 메인 브랜드 컬러로 하고, 제공해주신 15개의 핵심 컬러와 `healthnyou-client` 스타일의 그레이 스케일을 결합한 새로운 디자인 시스템 명세입니다.

## 1. Brand Primary Palette (Blue Spectrum)
메인 컬러 `#6E89F8`을 중심으로 한 10단계 팔레트입니다.

| Step | Hex Code | Description | Origin |
| :--- | :--- | :--- | :--- |
| **50** | `#EBECFF` | 최상단 배경, 아주 연한 블루 | 제공 (gl50) |
| **100** | `#DCDDFE` | 비활성 배경, 강조용 연한 블루 | 제공 (gl100) |
| **200** | `#81A9FF` | 호버 상태, 보조 강조 | 제공 (at100) |
| **300** | `#7FABE3` | 차분한 파스텔 블루 | 제공 (sl100) |
| **400** | `#7190FF` | 선명한 스카이 블루 | 제공 (mlFat) |
| **500** | `#6E89F8` | **Main Brand Color** | 제공 (slMiddle) |
| **600** | `#6A5DFB` | 강조 포인트, 버튼 활성 | 제공 (gl600) |
| **700** | `#2F5BF9` | 딥 블루, 인터랙션 강조 | 제공 (at500) |
| **800** | `#0046A5` | 다크 블루, 텍스트 강조 | 제공 (slHigh) |
| **900** | `#092E97` | 가장 어두운 네이비 | 제공 (pbf500) |

## 2. Extended Neutral Palette (Grey Scale)
`healthnyou-client`에서 검증된 12단계 그레이 스케일입니다. UI의 깊이감과 가독성을 결정합니다.

| Step | Hex Code | Usage |
| :--- | :--- | :--- |
| **grey05** | `#F8F8F8` | 메인 앱 배경 (Surface Background) |
| **grey10** | `#F3F3F7` | 카드 배경, 구분선 (Light) |
| **grey40** | `#ECECF0` | 보조 구분선, 비활성 필드 |
| **grey50** | `#E5E5EA` | 테두리 (Default Border) |
| **grey100** | `#D1D1D6` | 힌트 텍스트, 아이콘 (Disabled) |
| **grey200** | `#C7C7CC` | 보조 아이콘 |
| **grey300** | `#AEAEB2` | 캡션 텍스트 |
| **grey400** | `#8E8E93` | 보조 텍스트 (Secondary Text) |
| **grey500** | `#636366` | 본문 텍스트 (Body Text) |
| **grey600** | `#49484B` | 강조 텍스트 |
| **grey800** | `#2C2D2E` | 제목 텍스트 (Title Text) |
| **grey900** | `#1C1C1E` | 가장 어두운 텍스트 (Deep Black) |

## 3. Accent & Special Colors
제공해주신 코드 중 개성 있는 컬러들을 별도 포인트 컬러로 지정했습니다.

*   **Secondary (Purple):** `#BB8FF9` (골드 대신 보랏빛 포인트를 선호할 때 사용)
*   **Tertiary (Lavender):** `#8A86FF` (체중 데이터 등에서 쓰이던 차분한 퍼플)
*   **Highlight:** `#7C7EFC` (경쾌한 느낌의 포인트 블루)
*   **Sub-Accent:** `#7E94E0` (디저트/휴식 느낌의 부드러운 블루)

## 4. Semantic Mapping
*   **Background:** `grey05` (#F8F8F8)
*   **Surface:** `white` (#FFFFFF)
*   **Primary Text:** `grey900` (#1C1C1E)
*   **Secondary Text:** `grey500` (#636366)
*   **Border:** `grey50` (#E5E5EA)
