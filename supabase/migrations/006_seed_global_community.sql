-- ============================================================================
-- SEED GLOBAL COMMUNITY AND BOARDS
-- ============================================================================
-- 공용 커뮤니티와 관리자가 미리 세팅한 게시판들 생성

-- 공용 커뮤니티 생성 (is_global = TRUE, university_id = NULL)
INSERT INTO communities (name, description, icon, is_anonymous, is_global, university_id, sort_order)
VALUES ('Community', 'Global community accessible to all students', '🌍', FALSE, TRUE, NULL, 1)
ON CONFLICT DO NOTHING;

-- 공용 커뮤니티 ID 가져오기 및 게시판 생성
DO $$
DECLARE
  global_community_id BIGINT;
BEGIN
  -- 공용 커뮤니티 ID 조회
  SELECT id INTO global_community_id
  FROM communities
  WHERE is_global = TRUE AND name = 'Community'
  LIMIT 1;

  -- 공용 커뮤니티 하위 게시판 생성 (관리자가 미리 세팅)
  IF global_community_id IS NOT NULL THEN
    INSERT INTO boards (community_id, name, description, type, is_secret)
    VALUES
      -- 자유게시판
      (global_community_id, '자유게시판', 'Talk about anything', 'GENERAL', FALSE),

      -- 익명게시판
      (global_community_id, '익명게시판', 'Share anonymously', 'ANONYMOUS', FALSE),

      -- 정보게시판
      (global_community_id, '정보게시판', 'Share useful information', 'GENERAL', FALSE),

      -- Q&A
      (global_community_id, 'Q&A', 'Ask questions and get answers', 'QNA', FALSE),

      -- 공지사항
      (global_community_id, '공지사항', 'Important announcements', 'NOTICE', FALSE)
    ON CONFLICT DO NOTHING;
  END IF;
END $$;
