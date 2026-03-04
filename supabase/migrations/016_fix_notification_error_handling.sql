-- ============================================================================
-- MIGRATION 016: Fix notification error handling
-- ============================================================================
-- Problem: call_send_notification() crashes if pg_net extension is not
-- installed, causing the main operation (friend add, chat send, etc.) to fail.
-- Fix: Wrap the http_post call in EXCEPTION block so notification failure
-- doesn't roll back the triggering transaction.
-- ============================================================================

-- Ensure pg_net extension exists (no-op if already installed)
CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;

-- Replace call_send_notification with fault-tolerant version
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

  -- Always insert notification row first (so in-app notifications work even if push fails)
  BEGIN
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
