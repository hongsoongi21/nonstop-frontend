# ERD

[https://dbdiagram.io/d/nonstop-erd-6932560ed6676488baae5d56](https://dbdiagram.io/d/nonstop-erd-6932560ed6676488baae5d56)

```jsx
// ========================================
//  대학생 커뮤니티 풀스택 ERD - 프로덕션 레디 버전
// ========================================

// --- Enums ---
Enum friend_status {
  WAITING
  ACCEPTED
  BLOCKED
  REJECTED
}

Enum board_type {
  GENERAL      // 일반
  NOTICE       // 공지
  QNA          // 질문답변
  ANONYMOUS    // 익명게시판
}

Enum notification_type {
  FRIEND_REQUEST
  FRIEND_ACCEPT
  POST_LIKE
  COMMENT_LIKE
  NEW_COMMENT
  NEW_REPLY
}

Enum semester_type {
  FIRST       // 1학기
  SECOND      // 2학기
  SUMMER      // 여름계절
  WINTER      // 겨울계절
}

// --- Tables ---

Table users {
  id bigint [pk, increment]
  email varchar [unique, not null]
  password varchar [not null]
  nickname varchar [not null]
  student_number varchar [unique]           // 학번 (선택적)
  university_id bigint [not null]
  major_id bigint
  profile_image varchar
  introduction text
  is_active boolean [default: true]         // 탈퇴/정지 여부
  is_verified boolean [default: false]      // 학교 이메일 인증 완료
  last_login_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp
  deleted_at timestamp                       // 소프트 삭제
}

Table universities {
  id bigint [pk, increment]
  name varchar [unique, not null]
  region varchar
  logo_image varchar
  created_at timestamp [default: `now()`]
}

Table university_email_domains {
  id bigint [pk, increment]
  university_id bigint [not null]
  domain varchar [not null]                  // ex) yonsei.ac.kr, korea.ac.kr
  indexes {
    (university_id, domain) [unique]
  }
}

Table majors {
  id bigint [pk, increment]
  university_id bigint [not null]
  name varchar [not null]
  indexes {
    (university_id, name) [unique]
  }
}

Table communities {
  id bigint [pk, increment]
  university_id bigint [not null]
  name varchar [not null]                    // ex) 자유게시판, 중고거래, 익명게시판
  description text
  icon varchar
  is_anonymous boolean [default: false]
  sort_order integer [default: 0]
  created_at timestamp [default: `now()`]
  indexes {
    (university_id, name) [unique]
  }
}

Table boards {
  id bigint [pk, increment]
  community_id bigint [not null]
  name varchar [not null]
  type board_type [default: 'GENERAL']
  is_secret boolean [default: false]         // 비밀글 허용 여부
  created_at timestamp [default: `now()`]
  indexes {
    (community_id, name) [unique]
  }
}

Table posts {
  id bigint [pk, increment]
  board_id bigint [not null]
  user_id bigint [not null]
  title varchar [not null]
  content text [not null]
  view_count bigint [default: 0]
  is_anonymous boolean [default: false]
  is_secret boolean [default: false]         // 비밀글
  is_deleted boolean [default: false]
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp
}

Table post_images {
  id bigint [pk, increment]
  post_id bigint [not null]
  image_url varchar [not null]
  sort_order integer [default: 0]
  created_at timestamp [default: `now()`]
}

Table comments {
  id bigint [pk, increment]
  post_id bigint [not null]
  user_id bigint [not null]
  upper_comment_id bigint                    // 대댓글
  content text [not null]
  is_anonymous boolean [default: false]
  is_deleted boolean [default: false]
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp
}

Table comment_images {
  id bigint [pk, increment]
  comment_id bigint [not null]
  image_url varchar [not null]
  sort_order integer [default: 0]
}

Table user_post_likes {
  user_id bigint
  post_id bigint
  created_at timestamp [default: `now()`]
  primary key (user_id, post_id)
}

Table user_comment_likes {
  user_id bigint
  comment_id bigint
  created_at timestamp [default: `now()`]
  primary key (user_id, comment_id)
}

// --- 1:1 채팅 완전 정규화 버전
Table chat_rooms {
  id bigint [pk, increment]
  created_at timestamp [default: `now()`]
  updated_at timestamp                   // 마지막 메시지 시간
}

Table chat_room_users {
  chat_room_id bigint
  user_id bigint
  last_read_message_id bigint [null]
  unread_count integer [default: 0]
  joined_at timestamp [default: `now()`]
  primary key (chat_room_id, user_id)
}

Table messages {
  id bigint [pk, increment]
  chat_room_id bigint [not null]
  sender_id bigint [not null]
  content text [not null]
  sent_at timestamp [default: `now()`]
  is_deleted boolean [default: false]
}

// 시간표 (학기별)
Table semesters {
  id bigint [pk, increment]
  university_id bigint [not null]
  year integer [note: '2025']
  semester semester_type
  start_date date
  end_date date
  indexes {
    (university_id, year, semester) [unique]
  }
}

Table time_tables {
  id bigint [pk, increment]
  user_id bigint [not null]
  semester_id bigint [not null]
  title varchar [not null]                   // ex) 컴퓨터공학과 23-1
  is_public boolean [default: false]         // 시간표 공유 여부
  created_at timestamp [default: `now()`]
}

Table time_table_entries {
  id bigint [pk, increment]
  time_table_id bigint [not null]
  subject_name varchar [not null]
  professor varchar
  day_of_week varchar [not null]             // MON, TUE, WED, THU, FRI, SAT, SUN
  start_time time [not null]
  end_time time [not null]
  place varchar
  color varchar [default: '#3B82F6']
}

Table friends {
  id bigint [pk, increment]
  sender_id bigint [not null]
  receiver_id bigint [not null]
  status friend_status [default: 'WAITING']
  created_at timestamp [default: `now()`]
  updated_at timestamp
  indexes {
    (sender_id, receiver_id) [unique]
  }
}

Table notifications {
  id bigint [pk, increment]
  user_id bigint [not null]
  actor_id bigint [not null]                 // 행동을 한 사람
  type notification_type [not null]
  post_id bigint [null]
  comment_id bigint [null]
  message text
  is_read boolean [default: false]
  created_at timestamp [default: `now()`]
}

// --- Relationships ---

Ref: users.university_id > universities.id
Ref: users.major_id > majors.id
Ref: majors.university_id > universities.id
Ref: university_email_domains.university_id > universities.id

Ref: communities.university_id > universities.id
Ref: boards.community_id > communities.id

Ref: posts.board_id > boards.id
Ref: posts.user_id > users.id
Ref: post_images.post_id > posts.id

Ref: comments.post_id > posts.id
Ref: comments.user_id > users.id
Ref: comments.upper_comment_id > comments.id
Ref: comment_images.comment_id > comments.id

Ref: user_post_likes.user_id > users.id
Ref: user_post_likes.post_id > posts.id
Ref: user_comment_likes.user_id > users.id
Ref: user_comment_likes.comment_id > comments.id

Ref: chat_room_users.chat_room_id > chat_rooms.id
Ref: chat_room_users.user_id > users.id
Ref: chat_room_users.last_read_message_id > messages.id
Ref: messages.chat_room_id > chat_rooms.id
Ref: messages.sender_id > users.id

Ref: time_tables.user_id > users.id
Ref: time_tables.semester_id > semesters.id
Ref: time_table_entries.time_table_id > time_tables.id
Ref: semesters.university_id > universities.id

Ref: friends.sender_id > users.id
Ref: friends.receiver_id > users.id

Ref: notifications.user_id > users.id
Ref: notifications.actor_id > users.id
Ref: notifications.post_id > posts.id
Ref: notifications.comment_id > comments.id
```