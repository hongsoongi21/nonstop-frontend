-- ============================================================================
-- ENSURE ALL UNIVERSITIES HAVE COMMUNITIES AND DEFAULT BOARDS
-- ============================================================================
-- This migration backfills communities and default boards for any universities
-- that may be missing them, ensuring every university has:
-- 1. A community row
-- 2. Default boards: 자유게시판, 비밀게시판, 정보게시판, Q&A, 공지사항

DO $$
DECLARE
  university_record RECORD;
  community_id BIGINT;
BEGIN
  -- Loop through all universities
  FOR university_record IN
    SELECT id, name FROM universities
    ORDER BY id
  LOOP
    -- Check if community already exists for this university
    SELECT c.id INTO community_id
    FROM communities c
    WHERE c.university_id = university_record.id;

    -- If no community exists, create one
    IF community_id IS NULL THEN
      INSERT INTO communities (university_id, name, description, sort_order)
      VALUES (
        university_record.id,
        university_record.name,
        'Community for ' || university_record.name || ' students',
        1
      )
      RETURNING id INTO community_id;

      RAISE NOTICE 'Created community % for university %', community_id, university_record.name;
    END IF;

    -- Ensure default boards exist (ON CONFLICT DO NOTHING prevents duplicates)
    INSERT INTO boards (community_id, name, description, type, is_secret)
    VALUES
      (community_id, '자유게시판', 'Free discussion board', 'GENERAL', FALSE),
      (community_id, '비밀게시판', 'Anonymous board', 'ANONYMOUS', FALSE),
      (community_id, '정보게시판', 'Information sharing board', 'GENERAL', FALSE),
      (community_id, 'Q&A', 'Questions and answers', 'QNA', FALSE),
      (community_id, '공지사항', 'University announcements', 'NOTICE', FALSE)
    ON CONFLICT DO NOTHING;

    RAISE NOTICE 'Ensured default boards for university %', university_record.name;
  END LOOP;
END $$;
