-- ============================================================================
-- Migration 027: Dedupe popular boards by slug + drop empty boards
-- ============================================================================
-- Two UX issues observed against the v026 implementation:
--   1) Boards with the same `slug` (e.g. "free" exists in both the global
--      community and the user's university community) showed up twice in the
--      "popular boards" list with identical-looking entries.
--   2) Boards with zero posts still occupied a row, padding the list with
--      "no posts" placeholders even when other boards had real content.
--
-- This migration replaces the popular-boards CTEs so that:
--   - rows are grouped by `COALESCE(slug, 'BOARD_' || id)` (slug-only dedupe;
--     boards without a slug fall back to their id so each is its own group)
--   - `post_count` is the sum across all boards in the group
--   - the representative board is the one with the smallest id in the group
--   - groups with `post_count = 0` are filtered out (HAVING)
--   - `topPost` is the highest-`view_count` post across the entire group
--
-- Other sections (notices, today's timetable) are unchanged.
-- ============================================================================

CREATE OR REPLACE FUNCTION public.get_home_dashboard(
  p_weekday TEXT DEFAULT NULL,
  p_notice_limit INT DEFAULT 5,
  p_popular_limit INT DEFAULT 5
)
RETURNS JSONB
LANGUAGE plpgsql
STABLE
SECURITY INVOKER
SET search_path = public, pg_temp
AS $$
DECLARE
  v_user_id   BIGINT;
  v_weekday   TEXT;
  v_result    JSONB;
BEGIN
  v_user_id := get_current_user_id();
  IF v_user_id IS NULL THEN
    RAISE EXCEPTION 'Not authenticated' USING errcode = '42501';
  END IF;

  v_weekday := COALESCE(
    UPPER(p_weekday),
    CASE EXTRACT(DOW FROM (now() AT TIME ZONE 'Asia/Seoul'))
      WHEN 0 THEN 'SUNDAY'
      WHEN 1 THEN 'MONDAY'
      WHEN 2 THEN 'TUESDAY'
      WHEN 3 THEN 'WEDNESDAY'
      WHEN 4 THEN 'THURSDAY'
      WHEN 5 THEN 'FRIDAY'
      WHEN 6 THEN 'SATURDAY'
    END
  );

  WITH
  notice_posts AS (
    SELECT
      p.id,
      p.title,
      p.created_at,
      p.board_id,
      b.name  AS board_name,
      b.slug  AS board_slug
    FROM posts p
    JOIN boards b ON b.id = p.board_id
    WHERE p.deleted_at IS NULL
      AND b.type = 'NOTICE'
    ORDER BY p.created_at DESC
    LIMIT GREATEST(p_notice_limit, 0)
  ),
  active_timetable AS (
    SELECT tt.id, tt.semester_id
    FROM time_tables tt
    WHERE tt.user_id = v_user_id
    ORDER BY
      CASE WHEN tt.timetable_kind = 'main' THEN 0 ELSE 1 END,
      tt.created_at DESC
    LIMIT 1
  ),
  active_semester AS (
    SELECT s.id, s.year, s.type
    FROM semesters s
    JOIN active_timetable at_ ON at_.semester_id = s.id
  ),
  today_entries AS (
    SELECT
      tte.id,
      tte.subject_name,
      tte.professor,
      tte.start_time,
      tte.end_time,
      tte.place,
      tte.color
    FROM time_table_entries tte
    JOIN active_timetable at_ ON at_.id = tte.time_table_id
    WHERE tte.day_of_week = v_weekday
    ORDER BY tte.start_time NULLS LAST, tte.id
  ),
  -- ── popular boards: slug-deduped, non-empty groups only ────────────────
  popular_groups AS (
    SELECT
      COALESCE(b.slug, 'BOARD_' || b.id::text) AS group_key,
      MIN(b.id)                                AS rep_board_id,
      COUNT(p.id)                              AS post_count
    FROM boards b
    LEFT JOIN posts p
      ON p.board_id = b.id
     AND p.deleted_at IS NULL
    WHERE b.type <> 'NOTICE'
    GROUP BY group_key
    HAVING COUNT(p.id) > 0
    ORDER BY post_count DESC, group_key ASC
    LIMIT GREATEST(p_popular_limit, 0)
  ),
  popular_boards AS (
    SELECT
      pg.group_key,
      pg.rep_board_id AS id,
      b.name,
      b.slug,
      b.type,
      pg.post_count
    FROM popular_groups pg
    JOIN boards b ON b.id = pg.rep_board_id
  ),
  popular_top_posts AS (
    SELECT DISTINCT ON (pg.group_key)
      pg.group_key,
      p.id,
      p.title,
      p.view_count,
      p.created_at
    FROM posts p
    JOIN boards b ON b.id = p.board_id
    JOIN popular_groups pg
      ON pg.group_key = COALESCE(b.slug, 'BOARD_' || b.id::text)
    WHERE p.deleted_at IS NULL
    ORDER BY pg.group_key, p.view_count DESC, p.created_at DESC
  )
  SELECT jsonb_build_object(
    'weekday', v_weekday,
    'notices', COALESCE((
      SELECT jsonb_agg(jsonb_build_object(
        'id',         np.id,
        'title',      np.title,
        'createdAt',  np.created_at,
        'boardId',    np.board_id,
        'boardName',  np.board_name,
        'boardSlug',  np.board_slug
      ) ORDER BY np.created_at DESC)
      FROM notice_posts np
    ), '[]'::jsonb),
    'todayTimetable', jsonb_build_object(
      'timetableId', (SELECT id FROM active_timetable),
      'semester', (
        SELECT CASE WHEN acs.id IS NULL THEN NULL
               ELSE jsonb_build_object('id', acs.id, 'year', acs.year, 'type', acs.type)
               END
        FROM active_semester acs
      ),
      'entries', COALESCE((
        SELECT jsonb_agg(jsonb_build_object(
          'id',          te.id,
          'subjectName', te.subject_name,
          'professor',   te.professor,
          'startTime',   to_char(te.start_time, 'HH24:MI'),
          'endTime',     to_char(te.end_time,   'HH24:MI'),
          'place',       te.place,
          'color',       te.color
        ) ORDER BY te.start_time NULLS LAST, te.id)
        FROM today_entries te
      ), '[]'::jsonb)
    ),
    'popularBoards', COALESCE((
      SELECT jsonb_agg(jsonb_build_object(
        'boardId',    pb.id,
        'boardName',  pb.name,
        'boardSlug',  pb.slug,
        'boardType',  pb.type,
        'postCount',  pb.post_count,
        'topPost', (
          SELECT CASE WHEN ptp.id IS NULL THEN NULL
                 ELSE jsonb_build_object(
                   'id',           ptp.id,
                   'title',        ptp.title,
                   'viewCount',    ptp.view_count,
                   'createdAt',    ptp.created_at,
                   'likeCount',    (
                     SELECT COUNT(*) FROM user_post_likes upl
                     WHERE upl.post_id = ptp.id
                       AND upl.deleted_at IS NULL
                   ),
                   'commentCount', (
                     SELECT COUNT(*) FROM comments c
                     WHERE c.post_id = ptp.id
                       AND c.deleted_at IS NULL
                   )
                 )
                 END
          FROM popular_top_posts ptp
          WHERE ptp.group_key = pb.group_key
        )
      ) ORDER BY pb.post_count DESC, pb.group_key ASC)
      FROM popular_boards pb
    ), '[]'::jsonb)
  ) INTO v_result;

  RETURN v_result;
END;
$$;

COMMENT ON FUNCTION public.get_home_dashboard(TEXT, INT, INT)
IS 'Home dashboard: notices + today timetable + slug-deduped non-empty popular boards. SECURITY INVOKER.';

REVOKE ALL ON FUNCTION public.get_home_dashboard(TEXT, INT, INT) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.get_home_dashboard(TEXT, INT, INT) TO authenticated;
