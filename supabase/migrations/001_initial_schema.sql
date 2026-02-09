-- ============================================================================
-- NONSTOP INITIAL SCHEMA MIGRATION
-- ============================================================================
-- Migrated from Spring Boot + Azure backend to Supabase
-- Supabase Project: https://skmferffwiyphqvjjfrb.supabase.co
--
-- Key changes from Spring Boot:
--   - auth.users (Supabase Auth) replaces custom auth tables
--   - refresh_tokens and login_history tables removed (Supabase handles)
--   - users.auth_id bridges BIGSERIAL IDs with Supabase Auth UUIDs
--   - users.password kept nullable for schema flexibility
--   - Row Level Security (RLS) on all tables
--   - Supabase Storage buckets for file uploads
--   - Supabase Realtime enabled for chat and notifications
--
-- Run order: ENUMs -> Tables -> Indexes -> Functions -> Triggers -> RLS ->
--            Storage -> Realtime
-- ============================================================================


-- ============================================================================
-- SECTION 1: ENUM TYPES
-- ============================================================================

CREATE TYPE auth_provider AS ENUM ('EMAIL', 'GOOGLE', 'APPLE');
CREATE TYPE user_role AS ENUM ('USER', 'ADMIN', 'MANAGER');
CREATE TYPE friend_status AS ENUM ('WAITING', 'ACCEPTED', 'REJECTED', 'BLOCKED');
CREATE TYPE board_type AS ENUM ('GENERAL', 'NOTICE', 'QNA', 'ANONYMOUS');
CREATE TYPE comment_type AS ENUM ('GENERAL', 'ANONYMOUS');
CREATE TYPE notification_type AS ENUM (
  'FRIEND_REQUEST', 'FRIEND_ACCEPT',
  'POST_LIKE', 'COMMENT_LIKE',
  'NEW_COMMENT', 'NEW_REPLY',
  'CHAT_MESSAGE', 'ANNOUNCEMENT'
);
CREATE TYPE semester_type AS ENUM ('FIRST', 'SECOND', 'SUMMER', 'WINTER');
CREATE TYPE report_target_type AS ENUM ('POST', 'COMMENT', 'USER', 'CHAT_MESSAGE');
CREATE TYPE report_reason_type AS ENUM (
  'SPAM', 'ABUSE', 'SEXUAL', 'HATE',
  'ILLEGAL', 'PRIVACY', 'IMPERSONATION', 'ETC'
);
CREATE TYPE report_status AS ENUM ('PENDING', 'REVIEWED', 'ACTION_TAKEN', 'REJECTED');
CREATE TYPE chat_room_type AS ENUM ('ONE_TO_ONE', 'GROUP');
CREATE TYPE verification_method AS ENUM ('EMAIL_DOMAIN', 'MANUAL_REVIEW', 'STUDENT_ID_PHOTO');
CREATE TYPE file_purpose AS ENUM (
  'PROFILE_IMAGE', 'BOARD_ATTACHMENT',
  'STUDENT_ID_VERIFICATION', 'UNIVERSITY_LOGO', 'CHAT_IMAGE'
);
CREATE TYPE message_type AS ENUM ('TEXT', 'IMAGE', 'SYSTEM_INVITE', 'SYSTEM_LEAVE', 'SYSTEM_KICK');
CREATE TYPE policy_type AS ENUM ('TERMS_OF_SERVICE', 'PRIVACY_POLICY', 'MARKETING');


-- ============================================================================
-- SECTION 2: TABLES (ordered by FK dependencies)
-- ============================================================================

-- --------------------------------------------------------------------------
-- 1. universities
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS universities (
  id         BIGSERIAL    PRIMARY KEY,
  name       VARCHAR(255) NOT NULL UNIQUE,
  region     VARCHAR(100),
  logo_image_url VARCHAR(512),
  created_at TIMESTAMP    NOT NULL DEFAULT now()
);

-- --------------------------------------------------------------------------
-- 2. university_email_domains
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS university_email_domains (
  id            BIGSERIAL    PRIMARY KEY,
  university_id BIGINT       NOT NULL REFERENCES universities(id) ON DELETE CASCADE,
  domain        VARCHAR(255) NOT NULL,
  UNIQUE (university_id, domain)
);

-- --------------------------------------------------------------------------
-- 3. majors
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS majors (
  id            BIGSERIAL    PRIMARY KEY,
  university_id BIGINT       NOT NULL REFERENCES universities(id) ON DELETE CASCADE,
  name          VARCHAR(255) NOT NULL,
  UNIQUE (university_id, name)
);

-- --------------------------------------------------------------------------
-- 4. users
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
  id                  BIGSERIAL           PRIMARY KEY,
  auth_id             UUID                UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
  user_role           user_role           NOT NULL DEFAULT 'USER',
  email               VARCHAR(255),
  password            VARCHAR(255),       -- nullable, not used with Supabase Auth
  auth_provider       auth_provider       NOT NULL,
  provider_id         VARCHAR(255),
  nickname            VARCHAR(30)         NOT NULL,
  student_number      VARCHAR(50),
  university_id       BIGINT              REFERENCES universities(id) ON DELETE SET NULL,
  major_id            BIGINT              REFERENCES majors(id) ON DELETE SET NULL,
  profile_image_url   VARCHAR(512),
  introduction        TEXT,
  preferred_language  VARCHAR(5),
  birth_date          DATE,
  is_active           BOOLEAN             NOT NULL DEFAULT TRUE,
  is_verified         BOOLEAN             NOT NULL DEFAULT FALSE,
  is_email_verified   BOOLEAN             NOT NULL DEFAULT FALSE,
  verification_method verification_method,
  last_login_at       TIMESTAMP,
  created_at          TIMESTAMP           NOT NULL DEFAULT now(),
  updated_at          TIMESTAMP           NOT NULL DEFAULT now(),
  deleted_at          TIMESTAMP
);

-- Partial unique indexes for users
CREATE UNIQUE INDEX IF NOT EXISTS idx_users_email_unique
  ON users (email) WHERE email IS NOT NULL;

CREATE UNIQUE INDEX IF NOT EXISTS idx_users_nickname_active
  ON users (nickname) WHERE deleted_at IS NULL;

CREATE UNIQUE INDEX IF NOT EXISTS idx_users_student_number_unique
  ON users (student_number) WHERE student_number IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_users_is_verified
  ON users (is_verified);

-- --------------------------------------------------------------------------
-- 5. semesters
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS semesters (
  id            BIGSERIAL     PRIMARY KEY,
  university_id BIGINT        NOT NULL REFERENCES universities(id) ON DELETE CASCADE,
  year          INTEGER       NOT NULL,
  type          semester_type NOT NULL,
  created_at    TIMESTAMP     NOT NULL DEFAULT now(),
  UNIQUE (university_id, year, type)
);

CREATE INDEX IF NOT EXISTS idx_semesters_university
  ON semesters (university_id);

-- --------------------------------------------------------------------------
-- 6. communities
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS communities (
  id            BIGSERIAL    PRIMARY KEY,
  university_id BIGINT       REFERENCES universities(id) ON DELETE CASCADE,  -- nullable for global
  name          VARCHAR(255) NOT NULL,
  description   TEXT,
  icon          VARCHAR(255),
  is_anonymous  BOOLEAN      NOT NULL DEFAULT FALSE,
  sort_order    INT,
  created_at    TIMESTAMP    NOT NULL DEFAULT now()
);

-- --------------------------------------------------------------------------
-- 7. boards
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS boards (
  id           BIGSERIAL    PRIMARY KEY,
  community_id BIGINT       NOT NULL REFERENCES communities(id) ON DELETE CASCADE,
  name         VARCHAR(255) NOT NULL,
  description  TEXT,
  type         board_type   NOT NULL,
  is_secret    BOOLEAN      NOT NULL DEFAULT FALSE,
  created_at   TIMESTAMP    NOT NULL DEFAULT now()
);

-- --------------------------------------------------------------------------
-- 8. posts
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS posts (
  id           BIGSERIAL    PRIMARY KEY,
  board_id     BIGINT       NOT NULL REFERENCES boards(id) ON DELETE CASCADE,
  user_id      BIGINT       NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  title        VARCHAR(150),
  content      TEXT,
  view_count   BIGINT       NOT NULL DEFAULT 0,
  is_anonymous BOOLEAN      NOT NULL DEFAULT FALSE,
  is_secret    BOOLEAN      NOT NULL DEFAULT FALSE,
  deleted_at   TIMESTAMP,
  created_at   TIMESTAMP    NOT NULL DEFAULT now(),
  updated_at   TIMESTAMP    NOT NULL DEFAULT now()
);

-- --------------------------------------------------------------------------
-- 9. comments
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS comments (
  id               BIGSERIAL    PRIMARY KEY,
  post_id          BIGINT       NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  user_id          BIGINT       NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  upper_comment_id BIGINT       REFERENCES comments(id) ON DELETE CASCADE,  -- self-ref for replies
  content          TEXT         NOT NULL,
  type             comment_type NOT NULL,
  is_anonymous     BOOLEAN      NOT NULL DEFAULT FALSE,
  depth            INT          NOT NULL DEFAULT 0,
  deleted_at       TIMESTAMP,
  created_at       TIMESTAMP    NOT NULL DEFAULT now(),
  updated_at       TIMESTAMP    NOT NULL DEFAULT now()
);

-- --------------------------------------------------------------------------
-- 10. user_post_likes
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS user_post_likes (
  user_id    BIGINT    NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  post_id    BIGINT    NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  deleted_at TIMESTAMP,
  PRIMARY KEY (user_id, post_id)
);

-- --------------------------------------------------------------------------
-- 11. user_comment_likes
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS user_comment_likes (
  user_id    BIGINT    NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  comment_id BIGINT    NOT NULL REFERENCES comments(id) ON DELETE CASCADE,
  deleted_at TIMESTAMP,
  PRIMARY KEY (user_id, comment_id)
);

-- --------------------------------------------------------------------------
-- 12. chat_rooms
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS chat_rooms (
  id         BIGSERIAL      PRIMARY KEY,
  type       chat_room_type NOT NULL,
  name       VARCHAR(255),
  creator_id BIGINT         REFERENCES users(id) ON DELETE SET NULL,
  created_at TIMESTAMP      NOT NULL DEFAULT now(),
  updated_at TIMESTAMP      NOT NULL DEFAULT now()
);

-- --------------------------------------------------------------------------
-- 13. one_to_one_chat_rooms
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS one_to_one_chat_rooms (
  room_id  BIGINT PRIMARY KEY REFERENCES chat_rooms(id) ON DELETE CASCADE,
  user_a_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  user_b_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE
);

-- Ensure uniqueness regardless of user order
CREATE UNIQUE INDEX IF NOT EXISTS idx_one_to_one_unique_pair
  ON one_to_one_chat_rooms (LEAST(user_a_id, user_b_id), GREATEST(user_a_id, user_b_id));

-- --------------------------------------------------------------------------
-- 14. messages
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS messages (
  id                BIGSERIAL    PRIMARY KEY,
  chat_room_id      BIGINT       NOT NULL REFERENCES chat_rooms(id) ON DELETE CASCADE,
  sender_id         BIGINT       REFERENCES users(id) ON DELETE SET NULL,
  client_message_id BIGINT,
  type              message_type NOT NULL DEFAULT 'TEXT',
  content           TEXT,
  sent_at           TIMESTAMP    NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_messages_client_id_unique
  ON messages (client_message_id) WHERE client_message_id IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_messages_room_sent
  ON messages (chat_room_id, sent_at DESC);

-- --------------------------------------------------------------------------
-- 15. chat_room_members
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS chat_room_members (
  id                   BIGSERIAL PRIMARY KEY,
  room_id              BIGINT    NOT NULL REFERENCES chat_rooms(id) ON DELETE CASCADE,
  user_id              BIGINT    NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  last_read_message_id BIGINT    REFERENCES messages(id) ON DELETE SET NULL,
  joined_at            TIMESTAMP NOT NULL DEFAULT now(),
  left_at              TIMESTAMP,
  UNIQUE (room_id, user_id)
);

CREATE INDEX IF NOT EXISTS idx_chat_room_members_active
  ON chat_room_members (user_id) WHERE left_at IS NULL;

-- --------------------------------------------------------------------------
-- 16. message_deletions
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS message_deletions (
  message_id BIGINT    NOT NULL REFERENCES messages(id) ON DELETE CASCADE,
  user_id    BIGINT    NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  deleted_at TIMESTAMP NOT NULL DEFAULT now(),
  PRIMARY KEY (message_id, user_id)
);

-- --------------------------------------------------------------------------
-- 17. time_tables
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS time_tables (
  id          BIGSERIAL    PRIMARY KEY,
  user_id     BIGINT       NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  semester_id BIGINT       NOT NULL REFERENCES semesters(id) ON DELETE CASCADE,
  title       VARCHAR(255),
  is_public   BOOLEAN      NOT NULL DEFAULT FALSE,
  created_at  TIMESTAMP    NOT NULL DEFAULT now(),
  UNIQUE (user_id, semester_id)
);

-- --------------------------------------------------------------------------
-- 18. time_table_entries
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS time_table_entries (
  id             BIGSERIAL    PRIMARY KEY,
  time_table_id  BIGINT       NOT NULL REFERENCES time_tables(id) ON DELETE CASCADE,
  subject_name   VARCHAR(255),
  professor      VARCHAR(255),
  day_of_week    VARCHAR(20),
  start_time     TIME,
  end_time       TIME,
  place          VARCHAR(255),
  color          VARCHAR(50)
);

-- --------------------------------------------------------------------------
-- 19. friends
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS friends (
  id          BIGSERIAL     PRIMARY KEY,
  sender_id   BIGINT        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  receiver_id BIGINT        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  status      friend_status NOT NULL,
  created_at  TIMESTAMP     NOT NULL DEFAULT now(),
  updated_at  TIMESTAMP     NOT NULL DEFAULT now(),
  deleted_at  TIMESTAMP
);

-- Ensure one friendship record per pair (regardless of direction)
CREATE UNIQUE INDEX IF NOT EXISTS idx_friends_unique_pair
  ON friends (LEAST(sender_id, receiver_id), GREATEST(sender_id, receiver_id))
  WHERE deleted_at IS NULL;

-- --------------------------------------------------------------------------
-- 20. user_blocks
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS user_blocks (
  blocker_id BIGINT    NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  blocked_id BIGINT    NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  created_at TIMESTAMP NOT NULL DEFAULT now(),
  PRIMARY KEY (blocker_id, blocked_id)
);

-- --------------------------------------------------------------------------
-- 21. notifications
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS notifications (
  id             BIGSERIAL         PRIMARY KEY,
  user_id        BIGINT            NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  actor_id       BIGINT,
  actor_nickname VARCHAR(30),
  type           notification_type NOT NULL,
  post_id        BIGINT            REFERENCES posts(id) ON DELETE CASCADE,
  comment_id     BIGINT            REFERENCES comments(id) ON DELETE CASCADE,
  chat_room_id   BIGINT            REFERENCES chat_rooms(id) ON DELETE CASCADE,
  message        TEXT,
  is_read        BOOLEAN           NOT NULL DEFAULT FALSE,
  created_at     TIMESTAMP         NOT NULL DEFAULT now()
);

-- --------------------------------------------------------------------------
-- 22. reports
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS reports (
  id          BIGSERIAL          PRIMARY KEY,
  reporter_id BIGINT             NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  target_type report_target_type NOT NULL,
  target_id   BIGINT             NOT NULL,
  reason      report_reason_type NOT NULL,
  description TEXT,
  status      report_status      NOT NULL DEFAULT 'PENDING',
  handled_by  BIGINT             REFERENCES users(id) ON DELETE SET NULL,
  handled_at  TIMESTAMP,
  created_at  TIMESTAMP          NOT NULL DEFAULT now(),
  updated_at  TIMESTAMP          NOT NULL DEFAULT now()
);

-- --------------------------------------------------------------------------
-- 23. files
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS files (
  id                 BIGSERIAL    PRIMARY KEY,
  uploader_id        BIGINT       NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  target_domain      VARCHAR(100) NOT NULL,
  target_id          BIGINT       NOT NULL,
  purpose            file_purpose NOT NULL,
  file_url           VARCHAR(512) NOT NULL,
  original_file_name VARCHAR(255),
  content_type       VARCHAR(100),
  file_size_bytes    BIGINT,
  created_at         TIMESTAMP    NOT NULL DEFAULT now(),
  deleted_at         TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_files_target
  ON files (target_domain, target_id);

CREATE INDEX IF NOT EXISTS idx_files_uploader
  ON files (uploader_id);

CREATE INDEX IF NOT EXISTS idx_files_purpose
  ON files (purpose);

-- --------------------------------------------------------------------------
-- 24. device_tokens
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS device_tokens (
  id          BIGSERIAL    PRIMARY KEY,
  user_id     BIGINT       NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  device_type VARCHAR(20)  NOT NULL,
  token       VARCHAR(512) NOT NULL UNIQUE,
  is_active   BOOLEAN      NOT NULL DEFAULT TRUE,
  created_at  TIMESTAMP    NOT NULL DEFAULT now(),
  updated_at  TIMESTAMP    NOT NULL DEFAULT now()
);

-- --------------------------------------------------------------------------
-- 25. student_verification_requests
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS student_verification_requests (
  id            BIGSERIAL     PRIMARY KEY,
  user_id       BIGINT        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  image_url     VARCHAR(512)  NOT NULL,
  status        report_status NOT NULL DEFAULT 'PENDING',
  reject_reason VARCHAR(255),
  reviewed_by   BIGINT        REFERENCES users(id) ON DELETE SET NULL,
  reviewed_at   TIMESTAMP,
  created_at    TIMESTAMP     NOT NULL DEFAULT now(),
  updated_at    TIMESTAMP     NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_verification_user_unique
  ON student_verification_requests (user_id);

CREATE INDEX IF NOT EXISTS idx_verification_status
  ON student_verification_requests (status);

CREATE INDEX IF NOT EXISTS idx_verification_created
  ON student_verification_requests (created_at DESC);

-- --------------------------------------------------------------------------
-- 26. policies
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS policies (
  id           BIGSERIAL    PRIMARY KEY,
  type         policy_type  NOT NULL,
  title        VARCHAR(255) NOT NULL,
  content      TEXT,
  url          VARCHAR(512),
  is_mandatory BOOLEAN      NOT NULL DEFAULT FALSE,
  version      INT          NOT NULL DEFAULT 1,
  is_active    BOOLEAN      NOT NULL DEFAULT TRUE,
  created_at   TIMESTAMP    NOT NULL DEFAULT now(),
  updated_at   TIMESTAMP    NOT NULL DEFAULT now()
);

-- --------------------------------------------------------------------------
-- 27. user_policy_agreements
-- --------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS user_policy_agreements (
  id        BIGSERIAL PRIMARY KEY,
  user_id   BIGINT    NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  policy_id BIGINT    NOT NULL REFERENCES policies(id) ON DELETE CASCADE,
  agreed_at TIMESTAMP NOT NULL DEFAULT now(),
  UNIQUE (user_id, policy_id)
);


-- ============================================================================
-- SECTION 3: HELPER FUNCTIONS
-- ============================================================================

-- --------------------------------------------------------------------------
-- get_current_user_id(): Bridge Supabase auth.uid() (UUID) to app user id (BIGINT)
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION get_current_user_id()
RETURNS BIGINT
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT id FROM public.users WHERE auth_id = auth.uid()
$$;

-- --------------------------------------------------------------------------
-- handle_new_user(): Auto-create public.users row on auth.users insert
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  INSERT INTO public.users (auth_id, email, auth_provider, nickname, is_email_verified)
  VALUES (
    NEW.id,
    NEW.email,
    CASE
      WHEN NEW.raw_app_meta_data->>'provider' = 'google' THEN 'GOOGLE'::auth_provider
      WHEN NEW.raw_app_meta_data->>'provider' = 'apple'  THEN 'APPLE'::auth_provider
      ELSE 'EMAIL'::auth_provider
    END,
    COALESCE(NEW.raw_user_meta_data->>'nickname', split_part(NEW.email, '@', 1)),
    COALESCE(NEW.email_confirmed_at IS NOT NULL, FALSE)
  );
  RETURN NEW;
END;
$$;

-- --------------------------------------------------------------------------
-- update_updated_at_column(): Auto-set updated_at on row modification
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;


-- ============================================================================
-- SECTION 4: TRIGGERS
-- ============================================================================

-- Auth user creation trigger
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- updated_at triggers
CREATE TRIGGER trg_users_updated_at
  BEFORE UPDATE ON users
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER trg_posts_updated_at
  BEFORE UPDATE ON posts
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER trg_comments_updated_at
  BEFORE UPDATE ON comments
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER trg_chat_rooms_updated_at
  BEFORE UPDATE ON chat_rooms
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER trg_friends_updated_at
  BEFORE UPDATE ON friends
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER trg_reports_updated_at
  BEFORE UPDATE ON reports
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER trg_student_verification_updated_at
  BEFORE UPDATE ON student_verification_requests
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER trg_policies_updated_at
  BEFORE UPDATE ON policies
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER trg_device_tokens_updated_at
  BEFORE UPDATE ON device_tokens
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();


-- ============================================================================
-- SECTION 5: ROW LEVEL SECURITY (RLS)
-- ============================================================================

-- Enable RLS on ALL tables
ALTER TABLE universities                 ENABLE ROW LEVEL SECURITY;
ALTER TABLE university_email_domains     ENABLE ROW LEVEL SECURITY;
ALTER TABLE majors                       ENABLE ROW LEVEL SECURITY;
ALTER TABLE users                        ENABLE ROW LEVEL SECURITY;
ALTER TABLE semesters                    ENABLE ROW LEVEL SECURITY;
ALTER TABLE communities                  ENABLE ROW LEVEL SECURITY;
ALTER TABLE boards                       ENABLE ROW LEVEL SECURITY;
ALTER TABLE posts                        ENABLE ROW LEVEL SECURITY;
ALTER TABLE comments                     ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_post_likes              ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_comment_likes           ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_rooms                   ENABLE ROW LEVEL SECURITY;
ALTER TABLE one_to_one_chat_rooms        ENABLE ROW LEVEL SECURITY;
ALTER TABLE messages                     ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_room_members            ENABLE ROW LEVEL SECURITY;
ALTER TABLE message_deletions            ENABLE ROW LEVEL SECURITY;
ALTER TABLE time_tables                  ENABLE ROW LEVEL SECURITY;
ALTER TABLE time_table_entries           ENABLE ROW LEVEL SECURITY;
ALTER TABLE friends                      ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_blocks                  ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications                ENABLE ROW LEVEL SECURITY;
ALTER TABLE reports                      ENABLE ROW LEVEL SECURITY;
ALTER TABLE files                        ENABLE ROW LEVEL SECURITY;
ALTER TABLE device_tokens                ENABLE ROW LEVEL SECURITY;
ALTER TABLE student_verification_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE policies                     ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_policy_agreements       ENABLE ROW LEVEL SECURITY;


-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- universities: Public read (needed for signup flow)
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "universities_select_public"
  ON universities FOR SELECT
  TO anon, authenticated
  USING (true);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- university_email_domains: Public read
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "university_email_domains_select_public"
  ON university_email_domains FOR SELECT
  TO anon, authenticated
  USING (true);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- majors: Public read
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "majors_select_public"
  ON majors FOR SELECT
  TO anon, authenticated
  USING (true);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- semesters: Public read
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "semesters_select_public"
  ON semesters FOR SELECT
  TO anon, authenticated
  USING (true);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- users
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "users_select_active"
  ON users FOR SELECT
  TO authenticated
  USING (is_active = TRUE AND deleted_at IS NULL);

CREATE POLICY "users_update_own"
  ON users FOR UPDATE
  TO authenticated
  USING (id = get_current_user_id())
  WITH CHECK (id = get_current_user_id());

-- Insert handled by handle_new_user trigger (SECURITY DEFINER bypasses RLS)

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- communities
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "communities_select_authenticated"
  ON communities FOR SELECT
  TO authenticated
  USING (
    university_id IS NULL  -- global communities visible to all
    OR university_id = (SELECT university_id FROM users WHERE id = get_current_user_id())
  );

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- boards
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "boards_select_authenticated"
  ON boards FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM communities c
      WHERE c.id = boards.community_id
        AND (
          c.university_id IS NULL
          OR c.university_id = (SELECT university_id FROM users WHERE id = get_current_user_id())
        )
    )
  );

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- posts
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "posts_select_authenticated"
  ON posts FOR SELECT
  TO authenticated
  USING (deleted_at IS NULL);

CREATE POLICY "posts_insert_own"
  ON posts FOR INSERT
  TO authenticated
  WITH CHECK (user_id = get_current_user_id());

CREATE POLICY "posts_update_own"
  ON posts FOR UPDATE
  TO authenticated
  USING (user_id = get_current_user_id())
  WITH CHECK (user_id = get_current_user_id());

CREATE POLICY "posts_delete_own"
  ON posts FOR DELETE
  TO authenticated
  USING (user_id = get_current_user_id());

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- comments
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "comments_select_authenticated"
  ON comments FOR SELECT
  TO authenticated
  USING (deleted_at IS NULL);

CREATE POLICY "comments_insert_own"
  ON comments FOR INSERT
  TO authenticated
  WITH CHECK (user_id = get_current_user_id());

CREATE POLICY "comments_update_own"
  ON comments FOR UPDATE
  TO authenticated
  USING (user_id = get_current_user_id())
  WITH CHECK (user_id = get_current_user_id());

CREATE POLICY "comments_delete_own"
  ON comments FOR DELETE
  TO authenticated
  USING (user_id = get_current_user_id());

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- user_post_likes
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "user_post_likes_select"
  ON user_post_likes FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "user_post_likes_insert_own"
  ON user_post_likes FOR INSERT
  TO authenticated
  WITH CHECK (user_id = get_current_user_id());

CREATE POLICY "user_post_likes_delete_own"
  ON user_post_likes FOR DELETE
  TO authenticated
  USING (user_id = get_current_user_id());

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- user_comment_likes
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "user_comment_likes_select"
  ON user_comment_likes FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "user_comment_likes_insert_own"
  ON user_comment_likes FOR INSERT
  TO authenticated
  WITH CHECK (user_id = get_current_user_id());

CREATE POLICY "user_comment_likes_delete_own"
  ON user_comment_likes FOR DELETE
  TO authenticated
  USING (user_id = get_current_user_id());

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- chat_rooms: Must be a member to access
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "chat_rooms_select_member"
  ON chat_rooms FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM chat_room_members crm
      WHERE crm.room_id = chat_rooms.id
        AND crm.user_id = get_current_user_id()
        AND crm.left_at IS NULL
    )
  );

CREATE POLICY "chat_rooms_insert_authenticated"
  ON chat_rooms FOR INSERT
  TO authenticated
  WITH CHECK (creator_id = get_current_user_id());

CREATE POLICY "chat_rooms_update_member"
  ON chat_rooms FOR UPDATE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM chat_room_members crm
      WHERE crm.room_id = chat_rooms.id
        AND crm.user_id = get_current_user_id()
        AND crm.left_at IS NULL
    )
  );

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- one_to_one_chat_rooms
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "one_to_one_chat_rooms_select_member"
  ON one_to_one_chat_rooms FOR SELECT
  TO authenticated
  USING (
    user_a_id = get_current_user_id()
    OR user_b_id = get_current_user_id()
  );

CREATE POLICY "one_to_one_chat_rooms_insert_authenticated"
  ON one_to_one_chat_rooms FOR INSERT
  TO authenticated
  WITH CHECK (
    user_a_id = get_current_user_id()
    OR user_b_id = get_current_user_id()
  );

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- messages: Must be a member of the chat room
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "messages_select_member"
  ON messages FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM chat_room_members crm
      WHERE crm.room_id = messages.chat_room_id
        AND crm.user_id = get_current_user_id()
        AND crm.left_at IS NULL
    )
  );

CREATE POLICY "messages_insert_member"
  ON messages FOR INSERT
  TO authenticated
  WITH CHECK (
    sender_id = get_current_user_id()
    AND EXISTS (
      SELECT 1 FROM chat_room_members crm
      WHERE crm.room_id = messages.chat_room_id
        AND crm.user_id = get_current_user_id()
        AND crm.left_at IS NULL
    )
  );

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- chat_room_members
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "chat_room_members_select_member"
  ON chat_room_members FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM chat_room_members crm2
      WHERE crm2.room_id = chat_room_members.room_id
        AND crm2.user_id = get_current_user_id()
        AND crm2.left_at IS NULL
    )
  );

CREATE POLICY "chat_room_members_insert_member"
  ON chat_room_members FOR INSERT
  TO authenticated
  WITH CHECK (
    -- User can add themselves, or be added by another member
    user_id = get_current_user_id()
    OR EXISTS (
      SELECT 1 FROM chat_room_members crm2
      WHERE crm2.room_id = chat_room_members.room_id
        AND crm2.user_id = get_current_user_id()
        AND crm2.left_at IS NULL
    )
  );

CREATE POLICY "chat_room_members_update_own"
  ON chat_room_members FOR UPDATE
  TO authenticated
  USING (user_id = get_current_user_id());

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- message_deletions
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "message_deletions_select_own"
  ON message_deletions FOR SELECT
  TO authenticated
  USING (user_id = get_current_user_id());

CREATE POLICY "message_deletions_insert_own"
  ON message_deletions FOR INSERT
  TO authenticated
  WITH CHECK (user_id = get_current_user_id());

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- time_tables
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "time_tables_select"
  ON time_tables FOR SELECT
  TO authenticated
  USING (
    user_id = get_current_user_id()
    OR (
      is_public = TRUE
      AND EXISTS (
        SELECT 1 FROM users owner, users viewer
        WHERE owner.id = time_tables.user_id
          AND viewer.id = get_current_user_id()
          AND owner.university_id = viewer.university_id
      )
    )
  );

CREATE POLICY "time_tables_insert_own"
  ON time_tables FOR INSERT
  TO authenticated
  WITH CHECK (user_id = get_current_user_id());

CREATE POLICY "time_tables_update_own"
  ON time_tables FOR UPDATE
  TO authenticated
  USING (user_id = get_current_user_id())
  WITH CHECK (user_id = get_current_user_id());

CREATE POLICY "time_tables_delete_own"
  ON time_tables FOR DELETE
  TO authenticated
  USING (user_id = get_current_user_id());

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- time_table_entries: Owner of parent time_table
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "time_table_entries_select"
  ON time_table_entries FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM time_tables tt
      WHERE tt.id = time_table_entries.time_table_id
        AND (
          tt.user_id = get_current_user_id()
          OR (
            tt.is_public = TRUE
            AND EXISTS (
              SELECT 1 FROM users owner, users viewer
              WHERE owner.id = tt.user_id
                AND viewer.id = get_current_user_id()
                AND owner.university_id = viewer.university_id
            )
          )
        )
    )
  );

CREATE POLICY "time_table_entries_insert_own"
  ON time_table_entries FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM time_tables tt
      WHERE tt.id = time_table_entries.time_table_id
        AND tt.user_id = get_current_user_id()
    )
  );

CREATE POLICY "time_table_entries_update_own"
  ON time_table_entries FOR UPDATE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM time_tables tt
      WHERE tt.id = time_table_entries.time_table_id
        AND tt.user_id = get_current_user_id()
    )
  );

CREATE POLICY "time_table_entries_delete_own"
  ON time_table_entries FOR DELETE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM time_tables tt
      WHERE tt.id = time_table_entries.time_table_id
        AND tt.user_id = get_current_user_id()
    )
  );

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- friends
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "friends_select_own"
  ON friends FOR SELECT
  TO authenticated
  USING (
    sender_id = get_current_user_id()
    OR receiver_id = get_current_user_id()
  );

CREATE POLICY "friends_insert_sender"
  ON friends FOR INSERT
  TO authenticated
  WITH CHECK (sender_id = get_current_user_id());

CREATE POLICY "friends_update_participant"
  ON friends FOR UPDATE
  TO authenticated
  USING (
    sender_id = get_current_user_id()
    OR receiver_id = get_current_user_id()
  );

CREATE POLICY "friends_delete_participant"
  ON friends FOR DELETE
  TO authenticated
  USING (
    sender_id = get_current_user_id()
    OR receiver_id = get_current_user_id()
  );

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- user_blocks
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "user_blocks_select_blocker"
  ON user_blocks FOR SELECT
  TO authenticated
  USING (blocker_id = get_current_user_id());

CREATE POLICY "user_blocks_insert_blocker"
  ON user_blocks FOR INSERT
  TO authenticated
  WITH CHECK (blocker_id = get_current_user_id());

CREATE POLICY "user_blocks_delete_blocker"
  ON user_blocks FOR DELETE
  TO authenticated
  USING (blocker_id = get_current_user_id());

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- notifications
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "notifications_select_own"
  ON notifications FOR SELECT
  TO authenticated
  USING (user_id = get_current_user_id());

CREATE POLICY "notifications_update_own"
  ON notifications FOR UPDATE
  TO authenticated
  USING (user_id = get_current_user_id())
  WITH CHECK (user_id = get_current_user_id());

-- Insert: system/server-side only (via service_role or SECURITY DEFINER functions)
CREATE POLICY "notifications_insert_system"
  ON notifications FOR INSERT
  TO authenticated
  WITH CHECK (true);  -- notifications are created by server logic; further restrict via functions if needed

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- reports
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "reports_insert_authenticated"
  ON reports FOR INSERT
  TO authenticated
  WITH CHECK (reporter_id = get_current_user_id());

CREATE POLICY "reports_select_own_or_admin"
  ON reports FOR SELECT
  TO authenticated
  USING (
    reporter_id = get_current_user_id()
    OR EXISTS (
      SELECT 1 FROM users WHERE id = get_current_user_id() AND user_role = 'ADMIN'
    )
  );

CREATE POLICY "reports_update_admin"
  ON reports FOR UPDATE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM users WHERE id = get_current_user_id() AND user_role = 'ADMIN'
    )
  );

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- files
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "files_select_authenticated"
  ON files FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "files_insert_own"
  ON files FOR INSERT
  TO authenticated
  WITH CHECK (uploader_id = get_current_user_id());

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- device_tokens
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "device_tokens_select_own"
  ON device_tokens FOR SELECT
  TO authenticated
  USING (user_id = get_current_user_id());

CREATE POLICY "device_tokens_insert_own"
  ON device_tokens FOR INSERT
  TO authenticated
  WITH CHECK (user_id = get_current_user_id());

CREATE POLICY "device_tokens_update_own"
  ON device_tokens FOR UPDATE
  TO authenticated
  USING (user_id = get_current_user_id())
  WITH CHECK (user_id = get_current_user_id());

CREATE POLICY "device_tokens_delete_own"
  ON device_tokens FOR DELETE
  TO authenticated
  USING (user_id = get_current_user_id());

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- student_verification_requests
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "verification_select_own"
  ON student_verification_requests FOR SELECT
  TO authenticated
  USING (
    user_id = get_current_user_id()
    OR EXISTS (
      SELECT 1 FROM users WHERE id = get_current_user_id() AND user_role = 'ADMIN'
    )
  );

CREATE POLICY "verification_insert_own"
  ON student_verification_requests FOR INSERT
  TO authenticated
  WITH CHECK (user_id = get_current_user_id());

CREATE POLICY "verification_update_admin"
  ON student_verification_requests FOR UPDATE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM users WHERE id = get_current_user_id() AND user_role = 'ADMIN'
    )
  );

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- policies: Public read for active policies
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "policies_select_public"
  ON policies FOR SELECT
  TO anon, authenticated
  USING (is_active = TRUE);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- user_policy_agreements
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE POLICY "user_policy_agreements_select_own"
  ON user_policy_agreements FOR SELECT
  TO authenticated
  USING (user_id = get_current_user_id());

CREATE POLICY "user_policy_agreements_insert_own"
  ON user_policy_agreements FOR INSERT
  TO authenticated
  WITH CHECK (user_id = get_current_user_id());


-- ============================================================================
-- SECTION 6: STORAGE BUCKETS
-- ============================================================================

-- Create storage buckets
INSERT INTO storage.buckets (id, name, public)
VALUES
  ('avatars',            'avatars',            true),
  ('board-attachments',  'board-attachments',  true),
  ('chat-images',        'chat-images',        false),
  ('verification-docs',  'verification-docs',  false)
ON CONFLICT (id) DO NOTHING;

-- --------------------------------------------------------------------------
-- Storage policies: avatars (public read, authenticated upload/delete own)
-- --------------------------------------------------------------------------
CREATE POLICY "avatars_select_public"
  ON storage.objects FOR SELECT
  TO anon, authenticated
  USING (bucket_id = 'avatars');

CREATE POLICY "avatars_insert_authenticated"
  ON storage.objects FOR INSERT
  TO authenticated
  WITH CHECK (
    bucket_id = 'avatars'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

CREATE POLICY "avatars_update_own"
  ON storage.objects FOR UPDATE
  TO authenticated
  USING (
    bucket_id = 'avatars'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

CREATE POLICY "avatars_delete_own"
  ON storage.objects FOR DELETE
  TO authenticated
  USING (
    bucket_id = 'avatars'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

-- --------------------------------------------------------------------------
-- Storage policies: board-attachments (public read, authenticated upload)
-- --------------------------------------------------------------------------
CREATE POLICY "board_attachments_select_public"
  ON storage.objects FOR SELECT
  TO anon, authenticated
  USING (bucket_id = 'board-attachments');

CREATE POLICY "board_attachments_insert_authenticated"
  ON storage.objects FOR INSERT
  TO authenticated
  WITH CHECK (
    bucket_id = 'board-attachments'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

CREATE POLICY "board_attachments_delete_own"
  ON storage.objects FOR DELETE
  TO authenticated
  USING (
    bucket_id = 'board-attachments'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

-- --------------------------------------------------------------------------
-- Storage policies: chat-images (members read, authenticated upload)
-- --------------------------------------------------------------------------
CREATE POLICY "chat_images_select_authenticated"
  ON storage.objects FOR SELECT
  TO authenticated
  USING (bucket_id = 'chat-images');

CREATE POLICY "chat_images_insert_authenticated"
  ON storage.objects FOR INSERT
  TO authenticated
  WITH CHECK (
    bucket_id = 'chat-images'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

-- --------------------------------------------------------------------------
-- Storage policies: verification-docs (uploader + admin only)
-- --------------------------------------------------------------------------
CREATE POLICY "verification_docs_select_own_or_admin"
  ON storage.objects FOR SELECT
  TO authenticated
  USING (
    bucket_id = 'verification-docs'
    AND (
      (storage.foldername(name))[1] = auth.uid()::text
      OR EXISTS (
        SELECT 1 FROM users
        WHERE auth_id = auth.uid() AND user_role = 'ADMIN'
      )
    )
  );

CREATE POLICY "verification_docs_insert_own"
  ON storage.objects FOR INSERT
  TO authenticated
  WITH CHECK (
    bucket_id = 'verification-docs'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );


-- ============================================================================
-- SECTION 7: REALTIME
-- ============================================================================

-- Enable Supabase Realtime on tables that need live updates
ALTER PUBLICATION supabase_realtime ADD TABLE messages;
ALTER PUBLICATION supabase_realtime ADD TABLE chat_room_members;
ALTER PUBLICATION supabase_realtime ADD TABLE notifications;


-- ============================================================================
-- MIGRATION COMPLETE
-- ============================================================================
