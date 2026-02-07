-- =====================================================
-- FIX: XÓA TẤT CẢ RLS POLICIES VÀ DISABLE RLS
-- =====================================================
-- Chạy script này trong Supabase SQL Editor để fix lỗi infinite recursion

-- Drop tất cả policies hiện có
DROP POLICY IF EXISTS "Users can view their own data" ON users;
DROP POLICY IF EXISTS "Admin can do everything on users" ON users;
DROP POLICY IF EXISTS "Anyone can view active courses" ON courses;
DROP POLICY IF EXISTS "Admin can do everything on courses" ON courses;
DROP POLICY IF EXISTS "Coach can update their courses" ON courses;
DROP POLICY IF EXISTS "Users can view their own enrollments" ON class_enrollments;
DROP POLICY IF EXISTS "Users can create their own enrollments" ON class_enrollments;
DROP POLICY IF EXISTS "Admin can do everything on enrollments" ON class_enrollments;

-- Disable RLS cho tất cả các bảng
ALTER TABLE users DISABLE ROW LEVEL SECURITY;
ALTER TABLE courses DISABLE ROW LEVEL SECURITY;
ALTER TABLE class_enrollments DISABLE ROW LEVEL SECURITY;
ALTER TABLE schedules DISABLE ROW LEVEL SECURITY;
ALTER TABLE lesson_plans DISABLE ROW LEVEL SECURITY;

-- Verify
SELECT 'RLS disabled successfully!' as status;
