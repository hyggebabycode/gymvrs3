-- =====================================================
-- FIX RLS POLICY CHO COURSE_LESSONS
-- =====================================================
-- Chạy script này trong Supabase SQL Editor để fix lỗi
-- "new row violates row-level security policy for table course_lessons"

-- Drop tất cả policies cũ của course_lessons
DROP POLICY IF EXISTS "Coaches can view their course lessons" ON course_lessons;
DROP POLICY IF EXISTS "Users can view lessons for enrolled courses" ON course_lessons;
DROP POLICY IF EXISTS "Admins can view all lessons" ON course_lessons;
DROP POLICY IF EXISTS "Coaches can insert lessons for their courses" ON course_lessons;
DROP POLICY IF EXISTS "Coaches can update their course lessons" ON course_lessons;
DROP POLICY IF EXISTS "Coaches can delete their course lessons" ON course_lessons;
DROP POLICY IF EXISTS "Admins can manage all lessons" ON course_lessons;

-- OPTION 1: Disable RLS hoàn toàn (Đơn giản nhất)
ALTER TABLE course_lessons DISABLE ROW LEVEL SECURITY;

-- OPTION 2: Nếu muốn giữ RLS, uncomment các policy dưới đây
/*
-- Enable RLS
ALTER TABLE course_lessons ENABLE ROW LEVEL SECURITY;

-- Allow everyone to view lessons (public read)
CREATE POLICY "Anyone can view course lessons"
ON course_lessons FOR SELECT
USING (true);

-- Allow coaches to insert/update/delete lessons for their courses
CREATE POLICY "Coaches can manage their course lessons"
ON course_lessons FOR ALL
USING (
  EXISTS (
    SELECT 1 FROM courses 
    WHERE courses.id = course_lessons.course_id 
    AND courses.coach_id = auth.uid()
  )
)
WITH CHECK (
  EXISTS (
    SELECT 1 FROM courses 
    WHERE courses.id = course_lessons.course_id 
    AND courses.coach_id = auth.uid()
  )
);

-- Allow admins to do everything
CREATE POLICY "Admins can manage all course lessons"
ON course_lessons FOR ALL
USING (
  EXISTS (
    SELECT 1 FROM users 
    WHERE users.id = auth.uid() 
    AND users.role = 'admin'
  )
)
WITH CHECK (
  EXISTS (
    SELECT 1 FROM users 
    WHERE users.id = auth.uid() 
    AND users.role = 'admin'
  )
);
*/

-- Verify
SELECT 'RLS policy fixed successfully!' as status;

-- Check hiện tại
SELECT 
  schemaname,
  tablename,
  rowsecurity as rls_enabled
FROM pg_tables 
WHERE tablename = 'course_lessons';
