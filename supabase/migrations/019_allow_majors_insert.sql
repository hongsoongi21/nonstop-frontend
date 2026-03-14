-- Allow authenticated users to insert new majors
-- Needed for profile edit: user types a major name, app looks up or creates it

CREATE POLICY "majors_insert_authenticated"
  ON public.majors FOR INSERT
  TO authenticated
  WITH CHECK (true);
