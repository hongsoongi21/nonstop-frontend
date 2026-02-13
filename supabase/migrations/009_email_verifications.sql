-- Email verification codes table (for Resend-based email verification)
CREATE TABLE IF NOT EXISTS email_verifications (
  id BIGSERIAL PRIMARY KEY,
  email VARCHAR(255) NOT NULL,
  code VARCHAR(6) NOT NULL,
  expires_at TIMESTAMPTZ NOT NULL DEFAULT (NOW() + INTERVAL '5 minutes'),
  used BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Index for quick lookups
CREATE INDEX idx_email_verifications_email_code ON email_verifications(email, code);

-- Auto-cleanup old verification codes (older than 1 hour)
CREATE OR REPLACE FUNCTION cleanup_old_verifications()
RETURNS TRIGGER AS $$
BEGIN
  DELETE FROM email_verifications WHERE expires_at < NOW() - INTERVAL '1 hour';
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_cleanup_verifications
AFTER INSERT ON email_verifications
FOR EACH STATEMENT
EXECUTE FUNCTION cleanup_old_verifications();

-- RLS: Allow Edge Functions (service_role) full access
ALTER TABLE email_verifications ENABLE ROW LEVEL SECURITY;
