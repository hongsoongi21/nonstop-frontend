-- ============================================================================
-- SEED UNIVERSITY COMMUNITY BOARDS
-- ============================================================================
-- Create default communities and boards for each university
-- and set up a trigger to auto-create boards for future universities

-- ============================================================================
-- SECTION 1: HELPER FUNCTION - Create default boards for a community
-- ============================================================================

CREATE OR REPLACE FUNCTION create_default_boards_for_community(p_community_id BIGINT)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  INSERT INTO boards (community_id, name, description, type, is_secret)
  VALUES
    -- 자유게시판
    (p_community_id, '자유게시판', 'Free discussion board', 'GENERAL', FALSE),

    -- 비밀게시판 (익명게시판)
    (p_community_id, '비밀게시판', 'Anonymous board', 'ANONYMOUS', FALSE),

    -- 정보게시판
    (p_community_id, '정보게시판', 'Information sharing board', 'GENERAL', FALSE),

    -- Q&A
    (p_community_id, 'Q&A', 'Questions and answers', 'QNA', FALSE),

    -- 공지사항
    (p_community_id, '공지사항', 'University announcements', 'NOTICE', FALSE)
  ON CONFLICT DO NOTHING;
END;
$$;


-- ============================================================================
-- SECTION 2: SEED COMMUNITIES AND BOARDS FOR EXISTING UNIVERSITIES
-- ============================================================================

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
    SELECT id INTO community_id
    FROM communities
    WHERE university_id = university_record.id;

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
    END IF;

    -- Create default boards for this community
    PERFORM create_default_boards_for_community(community_id);
  END LOOP;
END $$;


-- ============================================================================
-- SECTION 3: TRIGGER FUNCTION - Auto-create boards for new communities
-- ============================================================================

CREATE OR REPLACE FUNCTION handle_new_community()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  -- Only create boards for university communities (not global)
  IF NEW.university_id IS NOT NULL THEN
    PERFORM create_default_boards_for_community(NEW.id);
  END IF;
  RETURN NEW;
END;
$$;


-- ============================================================================
-- SECTION 4: CREATE TRIGGER ON COMMUNITY INSERT
-- ============================================================================

-- Drop trigger if it exists (to avoid duplication)
DROP TRIGGER IF EXISTS trg_community_create_default_boards ON communities;

-- Create trigger to auto-create boards for new communities
CREATE TRIGGER trg_community_create_default_boards
  AFTER INSERT ON communities
  FOR EACH ROW
  EXECUTE FUNCTION handle_new_community();


-- ============================================================================
-- MIGRATION COMPLETE
-- ============================================================================
