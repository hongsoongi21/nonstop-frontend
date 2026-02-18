-- ============================================================================
-- Migration 012: Fix infinite recursion in chat_room_members RLS policies
-- ============================================================================
-- Problem: chat_room_members SELECT policy references chat_room_members itself,
-- causing infinite recursion (PostgreSQL error 42P17).
-- This also cascades to chat_rooms, messages policies that reference chat_room_members.
--
-- Fix: Create a SECURITY DEFINER function that bypasses RLS for membership checks,
-- then update all affected policies to use it.
-- ============================================================================

-- 1. Create SECURITY DEFINER function for membership check (bypasses RLS)
CREATE OR REPLACE FUNCTION is_chat_room_member(p_room_id BIGINT, p_user_id BIGINT)
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1 FROM chat_room_members
    WHERE room_id = p_room_id
      AND user_id = p_user_id
      AND left_at IS NULL
  );
$$;

-- 2. Fix chat_room_members policies (self-referencing → use SECURITY DEFINER function)
DROP POLICY IF EXISTS "chat_room_members_select_member" ON chat_room_members;
CREATE POLICY "chat_room_members_select_member"
  ON chat_room_members FOR SELECT
  TO authenticated
  USING (is_chat_room_member(room_id, get_current_user_id()));

DROP POLICY IF EXISTS "chat_room_members_insert_member" ON chat_room_members;
CREATE POLICY "chat_room_members_insert_member"
  ON chat_room_members FOR INSERT
  TO authenticated
  WITH CHECK (
    user_id = get_current_user_id()
    OR is_chat_room_member(room_id, get_current_user_id())
  );

-- 3. Fix chat_rooms policies (referenced chat_room_members which triggered recursion)
DROP POLICY IF EXISTS "chat_rooms_select_member" ON chat_rooms;
CREATE POLICY "chat_rooms_select_member"
  ON chat_rooms FOR SELECT
  TO authenticated
  USING (
    creator_id = get_current_user_id()
    OR is_chat_room_member(id, get_current_user_id())
  );

DROP POLICY IF EXISTS "chat_rooms_update_member" ON chat_rooms;
CREATE POLICY "chat_rooms_update_member"
  ON chat_rooms FOR UPDATE
  TO authenticated
  USING (is_chat_room_member(id, get_current_user_id()));

-- 4. Fix messages policies (also referenced chat_room_members)
DROP POLICY IF EXISTS "messages_select_member" ON messages;
CREATE POLICY "messages_select_member"
  ON messages FOR SELECT
  TO authenticated
  USING (is_chat_room_member(chat_room_id, get_current_user_id()));

DROP POLICY IF EXISTS "messages_insert_member" ON messages;
CREATE POLICY "messages_insert_member"
  ON messages FOR INSERT
  TO authenticated
  WITH CHECK (
    sender_id = get_current_user_id()
    AND is_chat_room_member(chat_room_id, get_current_user_id())
  );
