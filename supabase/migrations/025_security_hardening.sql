-- ============================================================================
-- MIGRATION 025: Security Hardening
-- ============================================================================
-- Fixes Supabase database linter warnings:
--   1. function_search_path_mutable: Add SET search_path = '' to 13 functions
--      and fully qualify all table references
--   2. rls_policy_always_true: Restrict notifications INSERT policy
--   3. public_bucket_allows_listing: Restrict storage SELECT policies
-- ============================================================================


-- ============================================================================
-- SECTION 1: FIX function_search_path_mutable (13 functions)
-- ============================================================================

-- --------------------------------------------------------------------------
-- 1.1 get_current_user_id (from 001_initial_schema.sql)
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.get_current_user_id()
RETURNS BIGINT
LANGUAGE sql
SECURITY DEFINER
STABLE
SET search_path = ''
AS $$
  SELECT id FROM public.users WHERE auth_id = auth.uid()
$$;

-- --------------------------------------------------------------------------
-- 1.2 update_updated_at_column (from 001_initial_schema.sql)
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER
LANGUAGE plpgsql
SET search_path = ''
AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;

-- --------------------------------------------------------------------------
-- 1.3 increment_view_count (from 002_triggers_and_rpc.sql)
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.increment_view_count(target_post_id BIGINT)
RETURNS void
LANGUAGE sql
SECURITY DEFINER
SET search_path = ''
AS $$
  UPDATE public.posts
  SET view_count = view_count + 1
  WHERE id = target_post_id
    AND deleted_at IS NULL;
$$;

-- --------------------------------------------------------------------------
-- 1.4 call_send_notification (from 022_fix_notification_error_handling.sql)
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.call_send_notification(
  p_type TEXT,
  p_actor_id BIGINT,
  p_receiver_id BIGINT,
  p_post_id BIGINT DEFAULT NULL,
  p_comment_id BIGINT DEFAULT NULL,
  p_chat_room_id BIGINT DEFAULT NULL,
  p_message TEXT DEFAULT NULL
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_supabase_url TEXT;
  v_service_role_key TEXT;
  v_payload JSONB;
BEGIN
  -- Don't notify self
  IF p_actor_id = p_receiver_id THEN
    RETURN;
  END IF;

  -- Always insert notification row first (so in-app notifications work even if push fails)
  BEGIN
    INSERT INTO public.notifications (user_id, actor_id, actor_nickname, type, post_id, comment_id, chat_room_id, message)
    SELECT
      p_receiver_id,
      p_actor_id,
      u.nickname,
      p_type::public.notification_type,
      p_post_id,
      p_comment_id,
      p_chat_room_id,
      p_message
    FROM public.users u
    WHERE u.id = p_actor_id;
  EXCEPTION WHEN OTHERS THEN
    RAISE WARNING 'Failed to insert notification: %', SQLERRM;
  END;

  -- Get Supabase URL from config (set via ALTER DATABASE ... SET)
  v_supabase_url := current_setting('app.settings.supabase_url', true);
  v_service_role_key := current_setting('app.settings.service_role_key', true);

  -- If settings not configured, skip push notification
  IF v_supabase_url IS NULL OR v_service_role_key IS NULL THEN
    RETURN;
  END IF;

  -- Build payload
  v_payload := jsonb_build_object(
    'type', p_type,
    'actor_id', p_actor_id,
    'receiver_id', p_receiver_id
  );
  IF p_post_id IS NOT NULL THEN
    v_payload := v_payload || jsonb_build_object('post_id', p_post_id);
  END IF;
  IF p_comment_id IS NOT NULL THEN
    v_payload := v_payload || jsonb_build_object('comment_id', p_comment_id);
  END IF;
  IF p_chat_room_id IS NOT NULL THEN
    v_payload := v_payload || jsonb_build_object('chat_room_id', p_chat_room_id);
  END IF;
  IF p_message IS NOT NULL THEN
    v_payload := v_payload || jsonb_build_object('message', p_message);
  END IF;

  -- Call Edge Function via pg_net (wrapped in exception handler)
  BEGIN
    PERFORM extensions.http_post(
      url := v_supabase_url || '/functions/v1/send-notification',
      body := v_payload,
      headers := jsonb_build_object(
        'Content-Type', 'application/json',
        'Authorization', 'Bearer ' || v_service_role_key
      )
    );
  EXCEPTION WHEN OTHERS THEN
    -- Log warning but don't crash the triggering transaction
    RAISE WARNING 'Failed to send push notification (type=%, receiver=%): %', p_type, p_receiver_id, SQLERRM;
  END;
END;
$$;

-- --------------------------------------------------------------------------
-- 1.5 trigger_notify_post_like (from 002_triggers_and_rpc.sql)
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.trigger_notify_post_like()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_post_author_id BIGINT;
BEGIN
  SELECT user_id INTO v_post_author_id
  FROM public.posts WHERE id = NEW.post_id AND deleted_at IS NULL;

  IF v_post_author_id IS NOT NULL THEN
    PERFORM public.call_send_notification(
      'POST_LIKE', NEW.user_id, v_post_author_id,
      p_post_id := NEW.post_id
    );
  END IF;
  RETURN NEW;
END;
$$;

-- --------------------------------------------------------------------------
-- 1.6 trigger_notify_comment_like (from 002_triggers_and_rpc.sql)
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.trigger_notify_comment_like()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_comment_author_id BIGINT;
  v_post_id BIGINT;
BEGIN
  SELECT user_id, post_id INTO v_comment_author_id, v_post_id
  FROM public.comments WHERE id = NEW.comment_id AND deleted_at IS NULL;

  IF v_comment_author_id IS NOT NULL THEN
    PERFORM public.call_send_notification(
      'COMMENT_LIKE', NEW.user_id, v_comment_author_id,
      p_post_id := v_post_id,
      p_comment_id := NEW.comment_id
    );
  END IF;
  RETURN NEW;
END;
$$;

-- --------------------------------------------------------------------------
-- 1.7 trigger_notify_new_comment (from 002_triggers_and_rpc.sql)
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.trigger_notify_new_comment()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_post_author_id BIGINT;
  v_parent_comment_author_id BIGINT;
BEGIN
  -- Notify post author
  SELECT user_id INTO v_post_author_id
  FROM public.posts WHERE id = NEW.post_id AND deleted_at IS NULL;

  IF v_post_author_id IS NOT NULL AND v_post_author_id != NEW.user_id THEN
    PERFORM public.call_send_notification(
      'NEW_COMMENT', NEW.user_id, v_post_author_id,
      p_post_id := NEW.post_id,
      p_comment_id := NEW.id
    );
  END IF;

  -- If this is a reply, also notify parent comment author
  IF NEW.upper_comment_id IS NOT NULL THEN
    SELECT user_id INTO v_parent_comment_author_id
    FROM public.comments WHERE id = NEW.upper_comment_id AND deleted_at IS NULL;

    IF v_parent_comment_author_id IS NOT NULL
       AND v_parent_comment_author_id != NEW.user_id
       AND v_parent_comment_author_id != v_post_author_id THEN
      PERFORM public.call_send_notification(
        'NEW_REPLY', NEW.user_id, v_parent_comment_author_id,
        p_post_id := NEW.post_id,
        p_comment_id := NEW.id
      );
    END IF;
  END IF;

  RETURN NEW;
END;
$$;

-- --------------------------------------------------------------------------
-- 1.8 trigger_notify_friend_request (from 002_triggers_and_rpc.sql)
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.trigger_notify_friend_request()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
BEGIN
  IF NEW.status = 'WAITING' THEN
    PERFORM public.call_send_notification(
      'FRIEND_REQUEST', NEW.sender_id, NEW.receiver_id
    );
  END IF;
  RETURN NEW;
END;
$$;

-- --------------------------------------------------------------------------
-- 1.9 trigger_notify_friend_accept (from 002_triggers_and_rpc.sql)
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.trigger_notify_friend_accept()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
BEGIN
  IF OLD.status = 'WAITING' AND NEW.status = 'ACCEPTED' THEN
    PERFORM public.call_send_notification(
      'FRIEND_ACCEPT', NEW.receiver_id, NEW.sender_id
    );
  END IF;
  RETURN NEW;
END;
$$;

-- --------------------------------------------------------------------------
-- 1.10 trigger_notify_chat_message (from 002_triggers_and_rpc.sql)
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.trigger_notify_chat_message()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_member RECORD;
BEGIN
  -- Only notify for user messages (not system messages)
  IF NEW.type IN ('SYSTEM_INVITE', 'SYSTEM_LEAVE', 'SYSTEM_KICK') THEN
    RETURN NEW;
  END IF;

  -- Notify all active room members except sender
  FOR v_member IN
    SELECT user_id FROM public.chat_room_members
    WHERE room_id = NEW.chat_room_id
      AND left_at IS NULL
      AND user_id != NEW.sender_id
  LOOP
    PERFORM public.call_send_notification(
      'CHAT_MESSAGE', NEW.sender_id, v_member.user_id,
      p_chat_room_id := NEW.chat_room_id,
      p_message := LEFT(NEW.content, 100)
    );
  END LOOP;

  RETURN NEW;
END;
$$;

-- --------------------------------------------------------------------------
-- 1.11 cleanup_old_verifications (from 009_email_verifications.sql)
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.cleanup_old_verifications()
RETURNS TRIGGER
LANGUAGE plpgsql
SET search_path = ''
AS $$
BEGIN
  DELETE FROM public.email_verifications WHERE expires_at < NOW() - INTERVAL '1 hour';
  RETURN NEW;
END;
$$;

-- --------------------------------------------------------------------------
-- 1.12 create_default_boards_for_community (from 024_board_slugs.sql)
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.create_default_boards_for_community(p_community_id BIGINT)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
BEGIN
  INSERT INTO public.boards (community_id, name, description, type, is_secret, slug)
  VALUES
    (p_community_id, '자유게시판', 'Free discussion board', 'GENERAL', FALSE, 'free'),
    (p_community_id, '비밀게시판', 'Anonymous board', 'ANONYMOUS', FALSE, 'anonymous'),
    (p_community_id, '정보게시판', 'Information sharing board', 'GENERAL', FALSE, 'info'),
    (p_community_id, 'Q&A', 'Questions and answers', 'QNA', FALSE, 'qna'),
    (p_community_id, '공지사항', 'University announcements', 'NOTICE', FALSE, 'notice')
  ON CONFLICT DO NOTHING;
END;
$$;

-- --------------------------------------------------------------------------
-- 1.13 handle_new_community (from 014_seed_university_community_boards.sql)
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.handle_new_community()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
BEGIN
  -- Only create boards for university communities (not global)
  IF NEW.university_id IS NOT NULL THEN
    PERFORM public.create_default_boards_for_community(NEW.id);
  END IF;
  RETURN NEW;
END;
$$;


-- ============================================================================
-- SECTION 2: FIX rls_policy_always_true (notifications_insert_system)
-- ============================================================================
-- notifications_insert_system had WITH CHECK (true) allowing any authenticated
-- user to insert notifications for ANY user. Since trigger functions use
-- SECURITY DEFINER (bypassing RLS), trigger-based inserts still work.
-- No Flutter code inserts into notifications directly, so we can safely
-- restrict to own notifications only.
--
-- NOTE: majors_insert_authenticated is intentionally WITH CHECK (true) — users
-- create new major entries during profile edit. Acceptable risk, left as-is.
-- ============================================================================

DROP POLICY IF EXISTS "notifications_insert_system" ON public.notifications;
CREATE POLICY "notifications_insert_system" ON public.notifications
  FOR INSERT TO authenticated
  WITH CHECK (user_id = (SELECT id FROM public.users WHERE auth_id = auth.uid()));


-- ============================================================================
-- SECTION 3: FIX public_bucket_allows_listing (3 storage buckets)
-- ============================================================================
-- For public buckets, individual file access via direct URL works without any
-- SELECT policy. The SELECT policy only controls the list() API which exposes
-- the full file inventory. Restricting to authenticated prevents anonymous
-- enumeration while preserving direct URL access for public content.
-- ============================================================================

-- --------------------------------------------------------------------------
-- 3.1 avatars: change from anon+authenticated to authenticated only
-- --------------------------------------------------------------------------
DROP POLICY IF EXISTS "avatars_select_public" ON storage.objects;
CREATE POLICY "avatars_select_authenticated" ON storage.objects
  FOR SELECT TO authenticated
  USING (bucket_id = 'avatars');

-- --------------------------------------------------------------------------
-- 3.2 board-attachments: change from anon+authenticated to authenticated only
-- --------------------------------------------------------------------------
DROP POLICY IF EXISTS "board_attachments_select_public" ON storage.objects;
CREATE POLICY "board_attachments_select_authenticated" ON storage.objects
  FOR SELECT TO authenticated
  USING (bucket_id = 'board-attachments');

-- --------------------------------------------------------------------------
-- 3.3 chat-images: already authenticated only, no change needed
--     (included here as documentation that it was reviewed)
-- --------------------------------------------------------------------------
-- chat_images_select_authenticated is already TO authenticated — no action needed.


-- ============================================================================
-- MIGRATION COMPLETE
-- ============================================================================
