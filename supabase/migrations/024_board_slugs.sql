-- ============================================================================
-- ADD SLUG COLUMN TO BOARDS FOR I18N MAPPING
-- ============================================================================

-- Add slug column for i18n mapping
ALTER TABLE boards ADD COLUMN IF NOT EXISTS slug VARCHAR(50);

-- Backfill seed boards
UPDATE boards SET slug = 'free' WHERE name = '자유게시판' AND slug IS NULL;
UPDATE boards SET slug = 'anonymous' WHERE name IN ('비밀게시판', '익명게시판') AND slug IS NULL;
UPDATE boards SET slug = 'info' WHERE name = '정보게시판' AND slug IS NULL;
UPDATE boards SET slug = 'qna' WHERE name = 'Q&A' AND slug IS NULL;
UPDATE boards SET slug = 'notice' WHERE name = '공지사항' AND slug IS NULL;

-- Update the trigger function to include slug when creating default boards
CREATE OR REPLACE FUNCTION create_default_boards_for_community(p_community_id BIGINT)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  INSERT INTO boards (community_id, name, description, type, is_secret, slug)
  VALUES
    (p_community_id, '자유게시판', 'Free discussion board', 'GENERAL', FALSE, 'free'),
    (p_community_id, '비밀게시판', 'Anonymous board', 'ANONYMOUS', FALSE, 'anonymous'),
    (p_community_id, '정보게시판', 'Information sharing board', 'GENERAL', FALSE, 'info'),
    (p_community_id, 'Q&A', 'Questions and answers', 'QNA', FALSE, 'qna'),
    (p_community_id, '공지사항', 'University announcements', 'NOTICE', FALSE, 'notice')
  ON CONFLICT DO NOTHING;
END;
$$;
