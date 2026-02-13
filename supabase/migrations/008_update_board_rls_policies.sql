-- ============================================================================
-- UPDATE RLS POLICIES FOR COMMUNITY AND BOARD
-- ============================================================================
-- Community: 공용은 모두 접근, 대학교는 해당 대학 유저만
-- Board: 공용 커뮤니티 하위는 관리자만 생성, 대학교 커뮤니티 하위는 유저가 생성

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- communities - SELECT policy 업데이트
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DROP POLICY IF EXISTS "communities_select_authenticated" ON communities;

CREATE POLICY "communities_select_authenticated"
  ON communities FOR SELECT
  TO authenticated
  USING (
    is_global = TRUE  -- 공용 커뮤니티는 모두 볼 수 있음
    OR university_id = (SELECT university_id FROM users WHERE id = get_current_user_id())
  );

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- communities - INSERT policy (관리자만)
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- boards - INSERT policy 업데이트
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DROP POLICY IF EXISTS "boards_insert_authenticated" ON boards;

CREATE POLICY "boards_insert_authenticated"
  ON boards FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM communities c
      WHERE c.id = boards.community_id
        AND (
          -- 대학교 커뮤니티: 해당 대학 유저가 board 생성 가능
          (c.is_global = FALSE
           AND c.university_id = (SELECT university_id FROM users WHERE id = get_current_user_id()))

          -- 공용 커뮤니티: 관리자만 board 생성 가능
          OR (c.is_global = TRUE
              AND EXISTS (SELECT 1 FROM users WHERE id = get_current_user_id() AND user_role = 'ADMIN'))
        )
    )
  );

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- boards - UPDATE policy (관리자 또는 본인이 만든 board)
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DROP POLICY IF EXISTS "boards_update_own" ON boards;

CREATE POLICY "boards_update_own"
  ON boards FOR UPDATE
  TO authenticated
  USING (
    -- 관리자는 모든 board 수정 가능
    EXISTS (
      SELECT 1 FROM users
      WHERE id = get_current_user_id()
        AND user_role = 'ADMIN'
    )
    -- TODO: board creator 추적 시 본인이 만든 board만 수정 가능하도록
  );

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- boards - DELETE policy (관리자만)
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
