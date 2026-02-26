-- Fix RLS Policy để user có thể update profile của chính mình
-- Chạy script này trong Supabase SQL Editor

-- Drop existing policy if exists
DROP POLICY IF EXISTS "Users can update own profile" ON users;

-- Create new policy allowing users to update their own profile
CREATE POLICY "Users can update own profile"
ON users
FOR UPDATE
USING (auth.uid()::text = id::text)
WITH CHECK (auth.uid()::text = id::text);

-- Hoặc nếu không dùng Supabase Auth, dùng cách đơn giản hơn:
-- Cho phép tất cả user update (không khuyến nghị cho production)
-- DROP POLICY IF EXISTS "Allow all updates" ON users;
-- CREATE POLICY "Allow all updates" ON users FOR UPDATE USING (true) WITH CHECK (true);

-- Kiểm tra RLS policies hiện tại
SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual, with_check
FROM pg_policies
WHERE tablename = 'users';
