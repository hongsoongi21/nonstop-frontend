-- Fix policy URLs to point to actual GitHub Pages site
UPDATE policies SET url = 'https://hongdroid94.github.io/nonstop-pages/terms.html' WHERE type = 'TERMS_OF_SERVICE';
UPDATE policies SET url = 'https://hongdroid94.github.io/nonstop-pages/privacy.html' WHERE type = 'PRIVACY_POLICY';
UPDATE policies SET url = 'https://hongdroid94.github.io/nonstop-pages/marketing.html' WHERE type = 'MARKETING';
