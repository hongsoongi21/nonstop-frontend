-- ============================================================================
-- ADD is_global COLUMN TO communities
-- ============================================================================
-- Community를 "Container" 개념으로 확장
-- is_global = TRUE: 공용 커뮤니티 (모든 유저 접근 가능, 관리자만 생성)
-- is_global = FALSE: 대학교 커뮤니티 (해당 대학 유저만 접근, 자동 생성)

-- is_global 컬럼 추가
ALTER TABLE communities
ADD COLUMN IF NOT EXISTS is_global BOOLEAN NOT NULL DEFAULT FALSE;

-- 제약 조건: 공용이면 university_id는 NULL이어야 함
ALTER TABLE communities
ADD CONSTRAINT communities_global_check
CHECK (
  (is_global = TRUE AND university_id IS NULL) OR
  (is_global = FALSE AND university_id IS NOT NULL) OR
  (is_global = FALSE AND university_id IS NULL)  -- 임시로 허용 (마이그레이션 중)
);

-- 인덱스 추가
CREATE INDEX IF NOT EXISTS idx_communities_is_global
  ON communities (is_global);

CREATE INDEX IF NOT EXISTS idx_communities_university
  ON communities (university_id) WHERE university_id IS NOT NULL;
