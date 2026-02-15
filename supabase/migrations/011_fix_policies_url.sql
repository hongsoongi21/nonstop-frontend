-- Fix policies: add URL values for existing rows
UPDATE policies SET url = 'https://nonstop-app.com/terms' WHERE type = 'TERMS_OF_SERVICE';
UPDATE policies SET url = 'https://nonstop-app.com/privacy' WHERE type = 'PRIVACY_POLICY';
UPDATE policies SET url = 'https://nonstop-app.com/marketing' WHERE type = 'MARKETING';
