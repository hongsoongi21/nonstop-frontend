-- ============================================================================
-- AUTO-CREATE UNIVERSITY COMMUNITIES
-- ============================================================================
-- 새로운 대학교가 추가되면 자동으로 해당 대학교의 Community 생성

-- Function: 대학교 커뮤니티 자동 생성
CREATE OR REPLACE FUNCTION create_university_community()
RETURNS TRIGGER
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql
AS $$
BEGIN
  -- 해당 대학교의 커뮤니티가 없으면 생성
  INSERT INTO communities (
    name,
    description,
    is_global,
    university_id,
    sort_order
  )
  VALUES (
    NEW.name,
    'Community for ' || NEW.name || ' students',
    FALSE,
    NEW.id,
    100  -- 대학교 커뮤니티는 sort_order 100부터 시작
  )
  ON CONFLICT DO NOTHING;

  RETURN NEW;
END;
$$;

-- Trigger: 대학교 생성 시 커뮤니티 자동 생성
DROP TRIGGER IF EXISTS trigger_create_university_community ON universities;
CREATE TRIGGER trigger_create_university_community
  AFTER INSERT ON universities
  FOR EACH ROW
  EXECUTE FUNCTION create_university_community();

-- 기존 대학교들에 대해 커뮤니티 생성 (이미 있으면 스킵)
INSERT INTO communities (name, description, is_global, university_id, sort_order)
SELECT
  u.name,
  'Community for ' || u.name || ' students',
  FALSE,
  u.id,
  100 + u.id
FROM universities u
WHERE NOT EXISTS (
  SELECT 1 FROM communities c
  WHERE c.university_id = u.id
)
ON CONFLICT DO NOTHING;
