-- Seed default policies
INSERT INTO policies (type, title, content, is_mandatory, version) VALUES
('TERMS_OF_SERVICE', '서비스 이용약관', 'Nonstop 서비스 이용약관입니다.', TRUE, 1),
('PRIVACY_POLICY', '개인정보 처리방침', 'Nonstop 개인정보 처리방침입니다.', TRUE, 1),
('MARKETING', '마케팅 정보 수신 동의', '프로모션 및 이벤트 안내를 받으실 수 있습니다.', FALSE, 1)
ON CONFLICT DO NOTHING;
