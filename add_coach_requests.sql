-- Add requested_role column to users table for coach registration requests
-- Run this SQL in Supabase SQL Editor

-- Add requested_role column (allows null, coach, etc.)
ALTER TABLE users 
ADD COLUMN IF NOT EXISTS requested_role VARCHAR(20);

-- Add comment to explain the column
COMMENT ON COLUMN users.requested_role IS 'Role requested by user during signup (e.g., coach). Null means no special role requested. Admin approves by changing role field to requested_role value.';

-- Optional: Create index for faster queries when filtering pending coach requests
CREATE INDEX IF NOT EXISTS idx_users_requested_role ON users(requested_role) WHERE requested_role IS NOT NULL;

-- Test data: Create a user with coach request for testing
-- Uncomment the lines below to add test data
/*
INSERT INTO users (email, password_hash, full_name, phone, role, requested_role, is_active, avatar_url)
VALUES (
  'test.pt@gymheart.com',
  '123456',
  'Test PT User',
  '0901234567',
  'user',
  'coach',
  true,
  'https://ui-avatars.com/api/?name=Test%20PT&background=f42559&color=fff&size=200'
)
ON CONFLICT (email) DO NOTHING;
*/

-- Verify the column was added successfully
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'users' AND column_name = 'requested_role';

-- Check if there are any pending coach requests
SELECT id, full_name, email, role, requested_role 
FROM users 
WHERE requested_role = 'coach' AND role != 'coach';
