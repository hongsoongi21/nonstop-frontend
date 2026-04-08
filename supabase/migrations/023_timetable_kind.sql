-- Migration 023: Replace display-string-based timetable type with typed `timetable_kind` column.
-- See GitHub issue #2.

-- Add timetable_kind column with CHECK constraint
ALTER TABLE time_tables
  ADD COLUMN IF NOT EXISTS timetable_kind VARCHAR(10) NOT NULL DEFAULT 'backup';

ALTER TABLE time_tables
  DROP CONSTRAINT IF EXISTS chk_timetable_kind;

ALTER TABLE time_tables
  ADD CONSTRAINT chk_timetable_kind
  CHECK (timetable_kind IN ('main', 'backup'));

-- Backfill: 'Asosiy jadval' was the main sentinel
UPDATE time_tables
  SET timetable_kind = 'main'
  WHERE title = 'Asosiy jadval';

-- Clear sentinel titles so UI falls back to localized labels
UPDATE time_tables
  SET title = NULL
  WHERE title = 'Asosiy jadval' OR title LIKE '예비%';

-- Partial unique index: enforce at most one 'main' per (user, semester)
DROP INDEX IF EXISTS idx_one_main_per_semester;
CREATE UNIQUE INDEX idx_one_main_per_semester
  ON time_tables (user_id, semester_id)
  WHERE timetable_kind = 'main';
