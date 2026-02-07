-- =====================================================
-- THÊM LỊCH HỌC CHO 4 KHÓA CÒN THIẾU
-- =====================================================
-- Copy toàn bộ và paste vào Supabase SQL Editor → Run

-- Xóa lịch cũ trước (nếu có)
DELETE FROM schedules WHERE course_id IN (
  'c0000004-0000-0000-0000-000000000004',
  'c0000005-0000-0000-0000-000000000005',
  'c0000006-0000-0000-0000-000000000006'
);

-- Thêm lịch học mới cho 4 khóa
INSERT INTO schedules (course_id, coach_id, title, description, day_of_week, start_time, end_time, location, room_number, max_capacity) VALUES
-- HIIT Training - T2, T5
('c0000004-0000-0000-0000-000000000004', '22222222-2222-2222-2222-222222222222', 'HIIT buổi sáng', 'Đốt mỡ cực mạnh', 1, '06:00:00', '07:00:00', 'Khu C', 'Phòng Cardio', 15),
('c0000004-0000-0000-0000-000000000004', '22222222-2222-2222-2222-222222222222', 'HIIT buổi sáng', 'Đốt mỡ cực mạnh', 4, '06:00:00', '07:00:00', 'Khu C', 'Phòng Cardio', 15),
-- Pilates - T3, T6
('c0000005-0000-0000-0000-000000000005', '22222222-2222-2222-2222-222222222222', 'Pilates Core', 'Tăng cường vùng core', 2, '18:30:00', '19:30:00', 'Khu A', 'Phòng Yoga', 18),
('c0000005-0000-0000-0000-000000000005', '22222222-2222-2222-2222-222222222222', 'Pilates Core', 'Tăng cường vùng core', 5, '18:30:00', '19:30:00', 'Khu A', 'Phòng Yoga', 18),
-- CrossFit - T2, T4, T6
('c0000006-0000-0000-0000-000000000006', '22222222-2222-2222-2222-222222222222', 'CrossFit Extreme', 'Training chuyên sâu', 1, '17:00:00', '18:30:00', 'Khu B', 'Phòng CrossFit', 10),
('c0000006-0000-0000-0000-000000000006', '22222222-2222-2222-2222-222222222222', 'CrossFit Extreme', 'Training chuyên sâu', 3, '17:00:00', '18:30:00', 'Khu B', 'Phòng CrossFit', 10),
('c0000006-0000-0000-0000-000000000006', '22222222-2222-2222-2222-222222222222', 'CrossFit Extreme', 'Training chuyên sâu', 5, '17:00:00', '18:30:00', 'Khu B', 'Phòng CrossFit', 10);

-- Verify
SELECT 'Đã thêm lịch học thành công!' as status;
SELECT c.course_name, COUNT(s.id) as total_schedules
FROM courses c
LEFT JOIN schedules s ON c.id = s.course_id
GROUP BY c.course_name
ORDER BY c.course_name;
