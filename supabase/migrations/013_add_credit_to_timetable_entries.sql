-- Add credit column for GPA calculation
ALTER TABLE time_table_entries ADD COLUMN IF NOT EXISTS credit INTEGER;
