-- ============================================================================
-- FIX: handle_new_user() trigger
-- ============================================================================
-- Root cause: SECURITY DEFINER function without SET search_path cannot resolve
-- custom enum types (auth_provider) defined in the public schema.
-- Also adds: robust nickname generation, exception logging, full_name fallback.
-- ============================================================================

-- Step 1: Drop existing trigger (safe to re-run)
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

-- Step 2: Replace the function with fixed version
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public          -- ← THIS IS THE KEY FIX
AS $$
DECLARE
  _nickname TEXT;
  _provider TEXT;
BEGIN
  -- Determine auth provider
  _provider := COALESCE(NEW.raw_app_meta_data->>'provider', 'email');

  -- Generate nickname: try metadata fields, then email prefix, then fallback
  _nickname := COALESCE(
    NULLIF(TRIM(NEW.raw_user_meta_data->>'nickname'), ''),
    NULLIF(TRIM(NEW.raw_user_meta_data->>'name'), ''),
    NULLIF(TRIM(NEW.raw_user_meta_data->>'full_name'), ''),
    NULLIF(TRIM(split_part(COALESCE(NEW.email, ''), '@', 1)), ''),
    'user_' || substr(NEW.id::text, 1, 8)
  );

  -- Truncate to 30 chars (nickname column limit)
  _nickname := substr(_nickname, 1, 30);

  -- Handle nickname uniqueness conflict
  IF EXISTS (SELECT 1 FROM public.users WHERE nickname = _nickname AND deleted_at IS NULL) THEN
    _nickname := substr(_nickname, 1, 24) || '_' || substr(md5(random()::text), 1, 5);
  END IF;

  INSERT INTO public.users (auth_id, email, auth_provider, nickname, is_email_verified)
  VALUES (
    NEW.id,
    NEW.email,
    CASE
      WHEN _provider = 'google' THEN 'GOOGLE'::public.auth_provider
      WHEN _provider = 'apple'  THEN 'APPLE'::public.auth_provider
      ELSE 'EMAIL'::public.auth_provider
    END,
    _nickname,
    (NEW.email_confirmed_at IS NOT NULL)
  );

  RETURN NEW;

EXCEPTION WHEN OTHERS THEN
  -- Log the actual error for debugging (visible in Supabase Dashboard → Logs → Postgres)
  RAISE LOG 'handle_new_user() FAILED: % (SQLSTATE: %)', SQLERRM, SQLSTATE;
  RAISE LOG 'handle_new_user() context: id=%, email=%, provider=%, raw_app_meta=%, raw_user_meta=%',
    NEW.id, NEW.email, _provider,
    NEW.raw_app_meta_data::text,
    NEW.raw_user_meta_data::text;
  -- Re-raise so Supabase Auth knows the insert failed
  RAISE;
END;
$$;

-- Step 3: Recreate the trigger
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();
