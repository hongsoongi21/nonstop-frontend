-- ============================================================================
-- MIGRATION 002: DB Triggers for Notifications + RPC Functions
-- ============================================================================
-- Creates:
--   1. increment_view_count() RPC function (atomic view count)
--   2. Notification triggers for: post likes, comment likes, comments,
--      replies, friend requests, friend accepts, chat messages
--   3. notify_via_edge_function() - calls Edge Function for FCM push
-- ============================================================================


-- ============================================================================
-- SECTION 1: RPC FUNCTIONS
-- ============================================================================

-- Atomic view count increment (prevents race conditions)
CREATE OR REPLACE FUNCTION increment_view_count(target_post_id BIGINT)
RETURNS void
LANGUAGE sql
SECURITY DEFINER
AS $$
  UPDATE posts
  SET view_count = view_count + 1
  WHERE id = target_post_id
    AND deleted_at IS NULL;
$$;


-- ============================================================================
-- SECTION 2: NOTIFICATION HELPER
-- ============================================================================

-- Enable pg_net extension for HTTP calls from triggers
CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;

-- Helper: Call send-notification Edge Function
CREATE OR REPLACE FUNCTION call_send_notification(
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

  -- Get Supabase URL from config (set via ALTER DATABASE ... SET)
  v_supabase_url := current_setting('app.settings.supabase_url', true);
  v_service_role_key := current_setting('app.settings.service_role_key', true);

  -- If settings not configured, insert notification row directly (FCM skipped)
  IF v_supabase_url IS NULL OR v_service_role_key IS NULL THEN
    -- Get actor nickname
    INSERT INTO notifications (user_id, actor_id, actor_nickname, type, post_id, comment_id, chat_room_id, message)
    SELECT
      p_receiver_id,
      p_actor_id,
      u.nickname,
      p_type::notification_type,
      p_post_id,
      p_comment_id,
      p_chat_room_id,
      p_message
    FROM users u
    WHERE u.id = p_actor_id;
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

  -- Call Edge Function via pg_net
  PERFORM extensions.http_post(
    url := v_supabase_url || '/functions/v1/send-notification',
    body := v_payload,
    headers := jsonb_build_object(
      'Content-Type', 'application/json',
      'Authorization', 'Bearer ' || v_service_role_key
    )
  );
END;
$$;


-- ============================================================================
-- SECTION 3: NOTIFICATION TRIGGERS
-- ============================================================================

-- --------------------------------------------------------------------------
-- 3a. Post Like → notify post author
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION trigger_notify_post_like()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_post_author_id BIGINT;
BEGIN
  SELECT user_id INTO v_post_author_id
  FROM posts WHERE id = NEW.post_id AND deleted_at IS NULL;

  IF v_post_author_id IS NOT NULL THEN
    PERFORM call_send_notification(
      'POST_LIKE', NEW.user_id, v_post_author_id,
      p_post_id := NEW.post_id
    );
  END IF;
  RETURN NEW;
END;
$$;

CREATE TRIGGER on_post_like_insert
  AFTER INSERT ON user_post_likes
  FOR EACH ROW
  WHEN (NEW.deleted_at IS NULL)
  EXECUTE FUNCTION trigger_notify_post_like();


-- --------------------------------------------------------------------------
-- 3b. Comment Like → notify comment author
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION trigger_notify_comment_like()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_comment_author_id BIGINT;
  v_post_id BIGINT;
BEGIN
  SELECT user_id, post_id INTO v_comment_author_id, v_post_id
  FROM comments WHERE id = NEW.comment_id AND deleted_at IS NULL;

  IF v_comment_author_id IS NOT NULL THEN
    PERFORM call_send_notification(
      'COMMENT_LIKE', NEW.user_id, v_comment_author_id,
      p_post_id := v_post_id,
      p_comment_id := NEW.comment_id
    );
  END IF;
  RETURN NEW;
END;
$$;

CREATE TRIGGER on_comment_like_insert
  AFTER INSERT ON user_comment_likes
  FOR EACH ROW
  WHEN (NEW.deleted_at IS NULL)
  EXECUTE FUNCTION trigger_notify_comment_like();


-- --------------------------------------------------------------------------
-- 3c. New Comment → notify post author
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION trigger_notify_new_comment()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_post_author_id BIGINT;
  v_parent_comment_author_id BIGINT;
BEGIN
  -- Notify post author
  SELECT user_id INTO v_post_author_id
  FROM posts WHERE id = NEW.post_id AND deleted_at IS NULL;

  IF v_post_author_id IS NOT NULL AND v_post_author_id != NEW.user_id THEN
    PERFORM call_send_notification(
      'NEW_COMMENT', NEW.user_id, v_post_author_id,
      p_post_id := NEW.post_id,
      p_comment_id := NEW.id
    );
  END IF;

  -- If this is a reply, also notify parent comment author
  IF NEW.upper_comment_id IS NOT NULL THEN
    SELECT user_id INTO v_parent_comment_author_id
    FROM comments WHERE id = NEW.upper_comment_id AND deleted_at IS NULL;

    IF v_parent_comment_author_id IS NOT NULL
       AND v_parent_comment_author_id != NEW.user_id
       AND v_parent_comment_author_id != v_post_author_id THEN
      PERFORM call_send_notification(
        'NEW_REPLY', NEW.user_id, v_parent_comment_author_id,
        p_post_id := NEW.post_id,
        p_comment_id := NEW.id
      );
    END IF;
  END IF;

  RETURN NEW;
END;
$$;

CREATE TRIGGER on_comment_insert
  AFTER INSERT ON comments
  FOR EACH ROW
  WHEN (NEW.deleted_at IS NULL)
  EXECUTE FUNCTION trigger_notify_new_comment();


-- --------------------------------------------------------------------------
-- 3d. Friend Request → notify receiver
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION trigger_notify_friend_request()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  IF NEW.status = 'WAITING' THEN
    PERFORM call_send_notification(
      'FRIEND_REQUEST', NEW.sender_id, NEW.receiver_id
    );
  END IF;
  RETURN NEW;
END;
$$;

CREATE TRIGGER on_friend_request_insert
  AFTER INSERT ON friends
  FOR EACH ROW
  EXECUTE FUNCTION trigger_notify_friend_request();


-- --------------------------------------------------------------------------
-- 3e. Friend Accept → notify sender
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION trigger_notify_friend_accept()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  IF OLD.status = 'WAITING' AND NEW.status = 'ACCEPTED' THEN
    PERFORM call_send_notification(
      'FRIEND_ACCEPT', NEW.receiver_id, NEW.sender_id
    );
  END IF;
  RETURN NEW;
END;
$$;

CREATE TRIGGER on_friend_accept_update
  AFTER UPDATE ON friends
  FOR EACH ROW
  EXECUTE FUNCTION trigger_notify_friend_accept();


-- --------------------------------------------------------------------------
-- 3f. Chat Message → notify room members (except sender)
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION trigger_notify_chat_message()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
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
    SELECT user_id FROM chat_room_members
    WHERE room_id = NEW.chat_room_id
      AND left_at IS NULL
      AND user_id != NEW.sender_id
  LOOP
    PERFORM call_send_notification(
      'CHAT_MESSAGE', NEW.sender_id, v_member.user_id,
      p_chat_room_id := NEW.chat_room_id,
      p_message := LEFT(NEW.content, 100)
    );
  END LOOP;

  RETURN NEW;
END;
$$;

CREATE TRIGGER on_message_insert
  AFTER INSERT ON messages
  FOR EACH ROW
  EXECUTE FUNCTION trigger_notify_chat_message();


-- ============================================================================
-- MIGRATION COMPLETE
-- ============================================================================
