-- 021_chat_rooms_is_anonymous.sql
-- Add a proper boolean flag for anonymous chat rooms, replacing the
-- display-string sentinel ('익명') that was previously stored in chat_rooms.name.

-- 1. Add column (idempotent)
ALTER TABLE chat_rooms
  ADD COLUMN IF NOT EXISTS is_anonymous BOOLEAN NOT NULL DEFAULT FALSE;

-- 2. Backfill: any legacy rooms that used '익명' as a display-string sentinel
UPDATE chat_rooms
SET is_anonymous = TRUE
WHERE name = '익명' OR name LIKE '익명(%';

-- 3. Clear the sentinel names so the UI can fall back to the localized label
UPDATE chat_rooms
SET name = NULL
WHERE is_anonymous = TRUE
  AND (name = '익명' OR name LIKE '익명(%');
