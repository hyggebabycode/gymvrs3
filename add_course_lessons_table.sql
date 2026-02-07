-- Create course_lessons table for course roadmap/curriculum
-- This table stores the learning roadmap for each course (approximately 5 lessons per course)
-- Each lesson represents one session/class in the course curriculum

CREATE TABLE IF NOT EXISTS course_lessons (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  course_id UUID REFERENCES courses(id) ON DELETE CASCADE NOT NULL,
  lesson_order INTEGER NOT NULL,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  objectives TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index for faster queries
CREATE INDEX idx_course_lessons_course_id ON course_lessons(course_id);
CREATE INDEX idx_course_lessons_order ON course_lessons(course_id, lesson_order);

-- Enable RLS
ALTER TABLE course_lessons ENABLE ROW LEVEL SECURITY;

-- ============================================
-- IMPORTANT: Ensure all courses have a coach
-- ============================================
-- Admin should assign a coach to each course
-- Coaches should be displayed in the course card
-- Run this to check courses without coaches:
-- SELECT id, course_name FROM courses WHERE coach_id IS NULL;

-- RLS Policies
-- Allow coaches to view lessons for their courses
CREATE POLICY "Coaches can view their course lessons"
ON course_lessons FOR SELECT
USING (
  EXISTS (
    SELECT 1 FROM courses 
    WHERE courses.id = course_lessons.course_id 
    AND courses.coach_id = auth.uid()
  )
);

-- Allow users to view lessons for courses they're enrolled in
CREATE POLICY "Users can view lessons for enrolled courses"
ON course_lessons FOR SELECT
USING (
  EXISTS (
    SELECT 1 FROM class_enrollments 
    WHERE class_enrollments.course_id = course_lessons.course_id 
    AND class_enrollments.user_id = auth.uid()
    AND class_enrollments.status = 'active'
  )
);

-- Allow admins to view all lessons
CREATE POLICY "Admins can view all lessons"
ON course_lessons FOR SELECT
USING (
  EXISTS (
    SELECT 1 FROM users 
    WHERE users.id = auth.uid() 
    AND users.role = 'admin'
  )
);

-- Allow coaches to insert lessons for their courses
CREATE POLICY "Coaches can insert lessons for their courses"
ON course_lessons FOR INSERT
WITH CHECK (
  EXISTS (
    SELECT 1 FROM courses 
    WHERE courses.id = course_lessons.course_id 
    AND courses.coach_id = auth.uid()
  )
);

-- Allow coaches to update lessons for their courses
CREATE POLICY "Coaches can update their course lessons"
ON course_lessons FOR UPDATE
USING (
  EXISTS (
    SELECT 1 FROM courses 
    WHERE courses.id = course_lessons.course_id 
    AND courses.coach_id = auth.uid()
  )
);

-- Allow coaches to delete lessons for their courses
CREATE POLICY "Coaches can delete their course lessons"
ON course_lessons FOR DELETE
USING (
  EXISTS (
    SELECT 1 FROM courses 
    WHERE courses.id = course_lessons.course_id 
    AND courses.coach_id = auth.uid()
  )
);

-- Allow admins to manage all lessons
CREATE POLICY "Admins can manage all lessons"
ON course_lessons FOR ALL
USING (
  EXISTS (
    SELECT 1 FROM users 
    WHERE users.id = auth.uid() 
    AND users.role = 'admin'
  )
);

-- Insert sample lessons for existing courses (optional)
-- You can run this to add sample data
/*
INSERT INTO course_lessons (course_id, lesson_order, title, content, objectives)
SELECT 
  id as course_id,
  1 as lesson_order,
  'Buổi 1: Giới thiệu và Khởi động' as title,
  'Làm quen với môi trường tập luyện, học các động tác cơ bản và khởi động đúng cách' as content,
  'Nắm vững kỹ thuật khởi động an toàn' as objectives
FROM courses
WHERE NOT EXISTS (
  SELECT 1 FROM course_lessons WHERE course_lessons.course_id = courses.id
)
LIMIT 5;
*/

-- Add some sample lessons for demonstration
-- Replace 'YOUR_COURSE_ID' with actual course IDs
/*
INSERT INTO course_lessons (course_id, lesson_order, title, content, objectives) VALUES
  ('YOUR_COURSE_ID', 1, 'Buổi 1: Giới thiệu khóa học', 'Làm quen với môi trường, thiết bị và các quy tắc an toàn', 'Hiểu rõ cấu trúc khóa học và chuẩn bị tinh thần'),
  ('YOUR_COURSE_ID', 2, 'Buổi 2: Kỹ thuật cơ bản', 'Học các động tác nền tảng, tư thế đúng và hơi thở', 'Thực hiện đúng tư thế cơ bản'),
  ('YOUR_COURSE_ID', 3, 'Buổi 3: Rèn luyện sức mạnh', 'Tập các bài tập sức mạnh cốt lõi và độ bền', 'Tăng cường sức mạnh cơ bản'),
  ('YOUR_COURSE_ID', 4, 'Buổi 4: Cardio và Stamina', 'Tập luyện tim mạch và tăng sức bền', 'Cải thiện thể lực tổng quát'),
  ('YOUR_COURSE_ID', 5, 'Buổi 5: Tổng kết và đánh giá', 'Ôn tập kiến thức, đánh giá kết quả và lập kế hoạch tiếp theo', 'Đạt mục tiêu khóa học cơ bản');
*/
