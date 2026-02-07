-- =====================================================
-- CẬP NHẬT PASSWORD THÀNH PLAINTEXT (123456)
-- =====================================================
-- Chạy script này trong Supabase SQL Editor

UPDATE users 
SET password_hash = '123456' 
WHERE email IN ('admin@gymheart.com', 'coach@gymheart.com', 'user@gymheart.com');

-- Verify
SELECT email, password_hash, role FROM users;
