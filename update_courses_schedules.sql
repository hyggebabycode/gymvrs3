-- =====================================================
-- Thêm lịch học cho các khóa học hiện có
-- =====================================================

-- Thêm lịch học cho khóa "Yoga cơ bản"
INSERT INTO schedules (course_id, coach_id, title, description, day_of_week, start_time, end_time, location, room_number, max_capacity)
SELECT 
    c.id,
    c.coach_id,
    'Lớp Yoga buổi sáng',
    'Luyện tập yoga cơ bản, thư giãn cơ thể',
    2, -- Thứ 3
    '06:00:00',
    '07:30:00',
    'Khu A',
    'Phòng Yoga 1',
    20
FROM courses c WHERE c.course_name LIKE '%Yoga%' LIMIT 1;

INSERT INTO schedules (course_id, coach_id, title, description, day_of_week, start_time, end_time, location, room_number, max_capacity)
SELECT 
    c.id,
    c.coach_id,
    'Lớp Yoga buổi tối',
    'Luyện tập yoga cơ bản, thư giãn cơ thể',
    4, -- Thứ 5
    '18:00:00',
    '19:30:00',
    'Khu A',
    'Phòng Yoga 1',
    20
FROM courses c WHERE c.course_name LIKE '%Yoga%' LIMIT 1;

-- Thêm lịch học cho khóa "Gym tăng cơ"
INSERT INTO schedules (course_id, coach_id, title, description, day_of_week, start_time, end_time, location, room_number, max_capacity)
SELECT 
    c.id,
    c.coach_id,
    'Tập tăng cơ cường độ cao',
    'Luyện tập với tạ, máy tập chuyên nghiệp',
    1, -- Thứ 2
    '17:00:00',
    '19:00:00',
    'Khu B',
    'Phòng tập Gym',
    15
FROM courses c WHERE c.course_name LIKE '%tăng cơ%' LIMIT 1;

INSERT INTO schedules (course_id, coach_id, title, description, day_of_week, start_time, end_time, location, room_number, max_capacity)
SELECT 
    c.id,
    c.coach_id,
    'Tập tăng cơ cường độ cao',
    'Luyện tập với tạ, máy tập chuyên nghiệp',
    3, -- Thứ 4
    '17:00:00',
    '19:00:00',
    'Khu B',
    'Phòng tập Gym',
    15
FROM courses c WHERE c.course_name LIKE '%tăng cơ%' LIMIT 1;

INSERT INTO schedules (course_id, coach_id, title, description, day_of_week, start_time, end_time, location, room_number, max_capacity)
SELECT 
    c.id,
    c.coach_id,
    'Tập tăng cơ cuối tuần',
    'Luyện tập với tạ, máy tập chuyên nghiệp',
    6, -- Thứ 7
    '08:00:00',
    '10:00:00',
    'Khu B',
    'Phòng tập Gym',
    15
FROM courses c WHERE c.course_name LIKE '%tăng cơ%' LIMIT 1;

-- Thêm lịch học cho khóa "Cardio giảm cân"
INSERT INTO schedules (course_id, coach_id, title, description, day_of_week, start_time, end_time, location, room_number, max_capacity)
SELECT 
    c.id,
    c.coach_id,
    'Cardio buổi sáng',
    'Đốt cháy calo, giảm mỡ hiệu quả',
    1, -- Thứ 2
    '06:00:00',
    '07:00:00',
    'Khu C',
    'Phòng Cardio',
    25
FROM courses c WHERE c.course_name LIKE '%Cardio%' LIMIT 1;

INSERT INTO schedules (course_id, coach_id, title, description, day_of_week, start_time, end_time, location, room_number, max_capacity)
SELECT 
    c.id,
    c.coach_id,
    'Cardio buổi chiều',
    'Đốt cháy calo, giảm mỡ hiệu quả',
    3, -- Thứ 4
    '17:30:00',
    '18:30:00',
    'Khu C',
    'Phòng Cardio',
    25
FROM courses c WHERE c.course_name LIKE '%Cardio%' LIMIT 1;

INSERT INTO schedules (course_id, coach_id, title, description, day_of_week, start_time, end_time, location, room_number, max_capacity)
SELECT 
    c.id,
    c.coach_id,
    'Cardio buổi tối',
    'Đốt cháy calo, giảm mỡ hiệu quả',
    5, -- Thứ 6
    '18:00:00',
    '19:00:00',
    'Khu C',
    'Phòng Cardio',
    25
FROM courses c WHERE c.course_name LIKE '%Cardio%' LIMIT 1;
