-- ============================================================================
-- Migration 028: Dedupe duplicate boards inside the same community
-- ============================================================================
-- Symptom: the Board tab in the app shows the same board twice in its chip
-- list (e.g. 자유게시판 / 자유게시판 / 비밀게시판 / 비밀게시판 / ...).
--
-- Root cause: the original schema (001) never declared a UNIQUE constraint
-- on `boards`, and `create_default_boards_for_community` (migration 024)
-- relies on `INSERT ... ON CONFLICT DO NOTHING` — but `ON CONFLICT` requires
-- a matching unique index/constraint to suppress duplicates. Without one,
-- every re-run of the helper kept inserting another row, accumulating
-- duplicate (community_id, slug) pairs.
--
-- This migration:
--   1) merges duplicates within each community (keeping the lowest id),
--      re-pointing any posts to the keeper so no content is lost
--   2) installs a partial UNIQUE index on (community_id, slug) so future
--      helper re-runs and direct inserts can no longer create duplicates
--
-- Globally-unique slugs across communities are intentionally NOT enforced:
-- a board with slug='free' may exist independently in the global community
-- and a university community.
-- ============================================================================

BEGIN;

-- 1) Build a map: every duplicate row -> the keeper (lowest id) in its group
CREATE TEMP TABLE _board_dedupe_map AS
SELECT
  b.id     AS dup_id,
  k.id     AS keeper_id,
  b.community_id,
  b.slug
FROM boards b
JOIN LATERAL (
  SELECT id
  FROM boards b2
  WHERE b2.community_id = b.community_id
    AND b2.slug         = b.slug
  ORDER BY id ASC
  LIMIT 1
) k ON TRUE
WHERE b.slug IS NOT NULL
  AND b.id <> k.id;

DO $$
DECLARE n INT;
BEGIN
  SELECT COUNT(*) INTO n FROM _board_dedupe_map;
  RAISE NOTICE 'Migration 028: merging % duplicate board row(s)', n;
END
$$;

-- 2) Re-point posts of duplicate boards to the keeper.
--    (Boards with NO posts simply skip this step.)
UPDATE posts p
SET    board_id = m.keeper_id
FROM   _board_dedupe_map m
WHERE  p.board_id = m.dup_id;

-- 3) Drop the duplicate boards. Posts have already been moved.
DELETE FROM boards
WHERE id IN (SELECT dup_id FROM _board_dedupe_map);

-- 4) Install the missing UNIQUE index so this can't happen again.
--    Partial: only enforce when slug is non-NULL (legacy boards without a
--    slug are still allowed to coexist; they have to be deduped manually
--    if they occur).
CREATE UNIQUE INDEX IF NOT EXISTS idx_boards_community_slug_unique
  ON boards (community_id, slug)
  WHERE slug IS NOT NULL;

DROP TABLE _board_dedupe_map;

COMMIT;
