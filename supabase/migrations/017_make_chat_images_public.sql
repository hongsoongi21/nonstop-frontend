-- Make chat-images bucket public so that getPublicUrl() works
-- CachedNetworkImage cannot send auth headers, so the bucket must be public
-- Images are stored under user-specific folders with random names, so URLs are not guessable

UPDATE storage.buckets
SET public = true
WHERE id = 'chat-images';
