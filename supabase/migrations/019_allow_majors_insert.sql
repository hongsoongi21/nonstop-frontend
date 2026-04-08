-- Allow authenticated users to insert new majors
-- Needed for profile edit: user types a major name, app looks up or creates it

DROP POLICY IF EXISTS "majors_insert_authenticated" ON public.majors;
CREATE POLICY "majors_insert_authenticated"
  ON public.majors FOR INSERT
  TO authenticated
  WITH CHECK (true);
