-- ============================================================================
-- COMBINED MIGRATION: 005 ~ 008
-- ============================================================================
-- 실행 방법: Supabase Dashboard → SQL Editor에서 이 전체 스크립트 실행
-- URL: https://supabase.com/dashboard/project/skmferffwiyphqvjjfrb/sql

-- ============================================================================
-- 005: ADD is_global COLUMN TO communities
-- ============================================================================

-- is_global 컬럼 추가
ALTER TABLE communities
ADD COLUMN IF NOT EXISTS is_global BOOLEAN NOT NULL DEFAULT FALSE;

-- 기존 제약 조건 삭제 (있으면)
ALTER TABLE communities
DROP CONSTRAINT IF EXISTS communities_global_check;

-- 제약 조건 추가
ALTER TABLE communities
ADD CONSTRAINT communities_global_check
CHECK (
  (is_global = TRUE AND university_id IS NULL) OR
  (is_global = FALSE AND university_id IS NOT NULL) OR
  (is_global = FALSE AND university_id IS NULL)
);

-- 인덱스 추가
CREATE INDEX IF NOT EXISTS idx_communities_is_global
  ON communities (is_global);

CREATE INDEX IF NOT EXISTS idx_communities_university
  ON communities (university_id) WHERE university_id IS NOT NULL;

-- ============================================================================
-- 006: SEED GLOBAL COMMUNITY AND BOARDS
-- ============================================================================

-- 공용 커뮤니티 생성
INSERT INTO communities (name, description, icon, is_anonymous, is_global, university_id, sort_order)
VALUES ('Community', 'Global community accessible to all students', '🌍', FALSE, TRUE, NULL, 1)
ON CONFLICT DO NOTHING;

-- 공용 커뮤니티 하위 게시판 생성
DO $$
DECLARE
  global_community_id BIGINT;
BEGIN
  SELECT id INTO global_community_id
  FROM communities
  WHERE is_global = TRUE AND name = 'Community'
  LIMIT 1;

  IF global_community_id IS NOT NULL THEN
    INSERT INTO boards (community_id, name, description, type, is_secret)
    VALUES
      (global_community_id, '자유게시판', 'Talk about anything', 'GENERAL', FALSE),
      (global_community_id, '익명게시판', 'Share anonymously', 'ANONYMOUS', FALSE),
      (global_community_id, '정보게시판', 'Share useful information', 'GENERAL', FALSE),
      (global_community_id, 'Q&A', 'Ask questions and get answers', 'QNA', FALSE),
      (global_community_id, '공지사항', 'Important announcements', 'NOTICE', FALSE)
    ON CONFLICT DO NOTHING;
  END IF;
END $$;

-- ============================================================================
-- 007: AUTO-CREATE UNIVERSITY COMMUNITIES
-- ============================================================================

-- Function: 대학교 커뮤니티 자동 생성
CREATE OR REPLACE FUNCTION create_university_community()
RETURNS TRIGGER
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO communities (
    name,
    description,
    is_global,
    university_id,
    sort_order
  )
  VALUES (
    NEW.name,
    'Community for ' || NEW.name || ' students',
    FALSE,
    NEW.id,
    100
  )
  ON CONFLICT DO NOTHING;

  RETURN NEW;
END;
$$;

-- Trigger: 대학교 생성 시 커뮤니티 자동 생성
DROP TRIGGER IF EXISTS trigger_create_university_community ON universities;
CREATE TRIGGER trigger_create_university_community
  AFTER INSERT ON universities
  FOR EACH ROW
  EXECUTE FUNCTION create_university_community();

-- 기존 대학교들에 대해 커뮤니티 생성
INSERT INTO communities (name, description, is_global, university_id, sort_order)
SELECT
  u.name,
  'Community for ' || u.name || ' students',
  FALSE,
  u.id,
  100 + u.id
FROM universities u
WHERE NOT EXISTS (
  SELECT 1 FROM communities c
  WHERE c.university_id = u.id
)
ON CONFLICT DO NOTHING;

-- ============================================================================
-- 008: UPDATE RLS POLICIES
-- ============================================================================

-- communities - SELECT policy 업데이트
DROP POLICY IF EXISTS "communities_select_authenticated" ON communities;
CREATE POLICY "communities_select_authenticated"
  ON communities FOR SELECT
  TO authenticated
  USING (
    is_global = TRUE
    OR university_id = (SELECT university_id FROM users WHERE id = get_current_user_id())
  );

-- communities - INSERT policy (관리자만)
DROP POLICY IF EXISTS "communities_insert_admin" ON communities;
CREATE POLICY "communities_insert_admin"
  ON communities FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM users
      WHERE id = get_current_user_id()
        AND user_role = 'ADMIN'
    )
  );

-- boards - INSERT policy 업데이트
DROP POLICY IF EXISTS "boards_insert_authenticated" ON boards;
CREATE POLICY "boards_insert_authenticated"
  ON boards FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM communities c
      WHERE c.id = boards.community_id
        AND (
          (c.is_global = FALSE
           AND c.university_id = (SELECT university_id FROM users WHERE id = get_current_user_id()))
          OR (c.is_global = TRUE
              AND EXISTS (SELECT 1 FROM users WHERE id = get_current_user_id() AND user_role = 'ADMIN'))
        )
    )
  );

-- boards - UPDATE policy
DROP POLICY IF EXISTS "boards_update_own" ON boards;
CREATE POLICY "boards_update_own"
  ON boards FOR UPDATE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM users
      WHERE id = get_current_user_id()
        AND user_role = 'ADMIN'
    )
  );

-- boards - DELETE policy
DROP POLICY IF EXISTS "boards_delete_admin" ON boards;
CREATE POLICY "boards_delete_admin"
  ON boards FOR DELETE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM users
      WHERE id = get_current_user_id()
        AND user_role = 'ADMIN'
    )
  );

-- ============================================================================
-- 완료!
-- ============================================================================
-- 이제 다음 구조가 생성되었습니다:
--
-- 드롭다운 (좌상단)
-- ├─ 📱 Community (공용) ← 관리자가 미리 세팅
-- │   ├─ 자유게시판
-- │   ├─ 익명게시판
-- │   ├─ 정보게시판
-- │   ├─ Q&A
-- │   └─ 공지사항
-- │
-- └─ 🏫 [각 대학교] (자동 생성)
--     └─ 유저가 Board를 자유롭게 생성 가능
-- ============================================================================
