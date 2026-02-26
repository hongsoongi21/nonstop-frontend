-- Allow authenticated users to insert semesters for their university
-- The UNIQUE constraint (university_id, year, type) prevents duplicates

CREATE POLICY "semesters_insert_authenticated"
  ON semesters FOR INSERT
  TO authenticated
  WITH CHECK (
    university_id IN (
      SELECT u.university_id FROM users u
      WHERE u.auth_id = auth.uid()
      AND u.university_id IS NOT NULL
    )
  );
