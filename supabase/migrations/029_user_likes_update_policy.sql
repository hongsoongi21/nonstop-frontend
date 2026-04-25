-- ============================================================================
-- Migration 029: Add UPDATE RLS policies for user_post_likes / user_comment_likes
-- ============================================================================
-- Symptom: tapping the heart on an already-liked post or comment to *unlike*
-- it briefly reflects in the UI (optimistic update) but on the next fetch
-- the like is back. The PATCH request to `user_post_likes` returns 200 OK
-- with an empty body, so the client never realizes the write failed.
--
-- Root cause: the original schema (001) declared only SELECT, INSERT, and
-- DELETE policies on `user_post_likes` and `user_comment_likes`. The toggle
-- logic in board_remote_data_source.dart uses a soft-delete pattern
-- (`UPDATE ... SET deleted_at = now() / NULL`), which falls under UPDATE —
-- and with no UPDATE policy in place, RLS denies all updates. PostgREST
-- responds with 200 OK and zero rows affected, masquerading as success.
--
-- Fix: add the missing UPDATE policies, scoped to the row owner. Soft-delete
-- toggling now works for the owner and remains blocked for other users.
-- ============================================================================

CREATE POLICY "user_post_likes_update_own"
  ON user_post_likes FOR UPDATE
  TO authenticated
  USING      (user_id = get_current_user_id())
  WITH CHECK (user_id = get_current_user_id());

CREATE POLICY "user_comment_likes_update_own"
  ON user_comment_likes FOR UPDATE
  TO authenticated
  USING      (user_id = get_current_user_id())
  WITH CHECK (user_id = get_current_user_id());
