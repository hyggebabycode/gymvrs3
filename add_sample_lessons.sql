-- =====================================================
-- THÊM LỘ TRÌNH HỌC MẪU CHO TẤT CẢ KHÓA HỌC
-- =====================================================
-- Script này thêm course_lessons (lộ trình học) cho 6 khóa học hiện có
-- Mỗi khóa học có 5-6 buổi học với nội dung chi tiết

-- Xóa lessons cũ (nếu có)
DELETE FROM course_lessons WHERE course_id IN (
    'c0000001-0000-0000-0000-000000000001',
    'c0000002-0000-0000-0000-000000000002',
    'c0000003-0000-0000-0000-000000000003',
    'c0000004-0000-0000-0000-000000000004',
    'c0000005-0000-0000-0000-000000000005',
    'c0000006-0000-0000-0000-000000000006'
);

-- =====================================================
-- KHÓA 1: GIẢM CÂN THẦN TỐC 30 NGÀY
-- =====================================================
INSERT INTO course_lessons (course_id, lesson_order, title, content, objectives) VALUES
('c0000001-0000-0000-0000-000000000001', 1, 'Buổi 1: Khởi động và Đánh giá thể trạng', 
'Làm quen với chương trình, đo lường chỉ số cơ thể (cân nặng, BMI, vòng eo), học các bài tập khởi động an toàn. Giới thiệu về dinh dưỡng giảm cân khoa học.',
'Hiểu rõ cơ chế giảm cân, biết cách đo lường tiến độ, nắm vững kỹ thuật khởi động đúng cách'),

('c0000001-0000-0000-0000-000000000001', 2, 'Buổi 2: Cardio cơ bản và Đi bộ nhanh', 
'Học các bài tập cardio cơ bản: đi bộ nhanh, chạy bộ nhẹ, đạp xe mini. Tập luyện với cường độ vừa phải trong 30-40 phút. Hướng dẫn nhịp tim mục tiêu.',
'Xây dựng nền tảng cardio, tăng cường sức bền tim mạch, đốt cháy 300-400 kcal'),

('c0000001-0000-0000-0000-000000000001', 3, 'Buổi 3: Circuit Training - Đốt cháy tối đa', 
'Kết hợp nhiều bài tập liên tục: jumping jacks, burpees, mountain climbers, high knees. Mỗi động tác 30 giây, nghỉ 15 giây. Tập 4-5 vòng.',
'Đốt cháy calo tối đa (500-600 kcal), tăng tốc độ trao đổi chất, rèn luyện sức bền'),

('c0000001-0000-0000-0000-000000000001', 4, 'Buổi 4: Strength Training - Tăng cơ giảm mỡ', 
'Tập các bài tập tăng cơ nhẹ với tạ nhỏ hoặc trọng lượng cơ thể: squat, lunge, push-up, plank. Mỗi động tác 3 sets x 12-15 reps.',
'Tăng khối lượng cơ nạc, nâng cao tỷ lệ đốt cháy calo khi nghỉ ngơi'),

('c0000001-0000-0000-0000-000000000001', 5, 'Buổi 5: HIIT và Cardio nâng cao', 
'High Intensity Interval Training: chạy sprint 30 giây + đi bộ 60 giây, lặp lại 10-12 lần. Kết hợp với jumping rope và box jumps.',
'Đốt cháy mỡ tối đa trong thời gian ngắn, tăng cường sức mạnh bùng nổ'),

('c0000001-0000-0000-0000-000000000001', 6, 'Buổi 6: Tổng kết và Đo lường kết quả', 
'Test thể lực cuối khóa, đo lường các chỉ số cơ thể, đánh giá tiến bộ. Lập kế hoạch duy trì kết quả sau khóa học. Tư vấn dinh dưỡng dài hạn.',
'Đánh giá kết quả giảm cân (2-4kg), xây dựng lộ trình duy trì lâu dài');

-- =====================================================
-- KHÓA 2: TĂNG CƠ BẮP CHUYÊN NGHIỆP
-- =====================================================
INSERT INTO course_lessons (course_id, lesson_order, title, content, objectives) VALUES
('c0000002-0000-0000-0000-000000000002', 1, 'Tuần 1-2: Nền tảng Compound Exercises', 
'Học 5 động tác nền tảng: Squat, Deadlift, Bench Press, Overhead Press, Barbell Row. Tập kỹ thuật đúng với tạ nhẹ, từ từ tăng trọng lượng. 4 sets x 8-10 reps.',
'Nắm vững kỹ thuật compound exercises, xây dựng sức mạnh tổng quát, tránh chấn thương'),

('c0000002-0000-0000-0000-000000000002', 2, 'Tuần 3-4: Upper Body Focus (Ngực, Vai, Lưng)', 
'Tập trung phát triển phần thân trên: Incline Bench Press, Dumbbell Flyes, Lateral Raises, Face Pulls, Pull-ups. Progressive overload: tăng 2.5-5kg mỗi tuần.',
'Phát triển cơ ngực, vai, lưng cân đối, tăng 15-20% sức mạnh đẩy'),

('c0000002-0000-0000-0000-000000000002', 3, 'Tuần 5-6: Lower Body Focus (Chân, Mông)', 
'Squat variations: Front Squat, Bulgarian Split Squat, Romanian Deadlift, Leg Press, Calf Raises. Tăng trọng lượng với rep range 6-12.',
'Xây dựng cơ chân to khỏe, tăng sức mạnh tổng thể, phát triển cơ mông chắc khỏe'),

('c0000002-0000-0000-0000-000000000002', 4, 'Tuần 7-8: Isolation Exercises (Cô lập cơ)', 
'Tập cô lập từng nhóm cơ: Bicep Curls, Tricep Extensions, Leg Extensions, Leg Curls, Cable Flyes. Higher reps (12-15) để pump cơ tối đa.',
'Tạo form cơ bắp đẹp, phát triển chi tiết từng nhóm cơ, tăng độ bền cơ'),

('c0000002-0000-0000-0000-000000000002', 5, 'Tuần 9-11: Advanced Training Techniques', 
'Áp dụng kỹ thuật nâng cao: Drop sets, Super sets, Rest-pause sets, Pyramid training. Tăng cường intensity và volume.',
'Vượt qua plateau, kích thích tăng trưởng cơ tối đa, tăng 10-15% khối lượng cơ'),

('c0000002-0000-0000-0000-000000000002', 6, 'Tuần 12: Deload và Tổng kết', 
'Giảm cường độ tập 50% để cơ thể phục hồi. Đo lường kết quả: tăng bao nhiêu kg lean mass, test 1RM các động tác chính. Lập kế hoạch tiếp theo.',
'Phục hồi toàn diện, đánh giá kết quả (tăng 3-5kg cơ), xây dựng chương trình dài hạn');

-- =====================================================
-- KHÓA 3: YOGA VÀ FLEXIBILITY
-- =====================================================
INSERT INTO course_lessons (course_id, lesson_order, title, content, objectives) VALUES
('c0000003-0000-0000-0000-000000000003', 1, 'Buổi 1: Giới thiệu Yoga cơ bản', 
'Học về triết lý Yoga, kỹ thuật hít thở (Pranayama), các tư thế nền tảng: Mountain Pose, Child Pose, Cat-Cow, Downward Dog. Tập thở bụng 10 phút.',
'Hiểu về Yoga, học cách thở đúng, nắm vững 10 tư thế cơ bản'),

('c0000003-0000-0000-0000-000000000003', 2, 'Buổi 2: Sun Salutation (Chào mặt trời)', 
'Học chuỗi động tác Surya Namaskar A và B - 12 động tác liên tiếp. Tập 5-10 vòng liên tục. Kết hợp hơi thở với chuyển động.',
'Làm nóng cơ thể hiệu quả, tăng sự linh hoạt, cải thiện tuần hoàn máu'),

('c0000003-0000-0000-0000-000000000003', 3, 'Buổi 3: Standing Poses (Tư thế đứng)', 
'Warrior I, II, III, Triangle Pose, Extended Side Angle, Tree Pose. Giữ mỗi tư thế 30-60 giây. Tập cân bằng và sức mạnh chân.',
'Tăng sức mạnh chân, cải thiện cân bằng, xây dựng nền tảng ổn định'),

('c0000003-0000-0000-0000-000000000003', 4, 'Buổi 4: Hip Openers & Backbends (Mở hông & Uốn lưng)', 
'Pigeon Pose, Lizard Pose, Butterfly Pose, Cobra Pose, Upward Dog, Camel Pose. Focus giải phóng căng thẳng vùng hông và lưng.',
'Tăng độ linh hoạt hông 40-50%, giảm đau lưng, cải thiện tư thế ngồi'),

('c0000003-0000-0000-0000-000000000003', 5, 'Buổi 5: Advanced Poses & Arm Balances', 
'Crow Pose, Side Crow, Headstand prep, Forearm stand prep, Wheel Pose. Tập sức mạnh cánh tay và core.',
'Nâng cao sức mạnh toàn thân, chinh phục tư thế khó, tăng sự tự tin'),

('c0000003-0000-0000-0000-000000000003', 6, 'Buổi 6: Restorative Yoga & Meditation', 
'Các tư thế thư giãn sâu: Legs up the wall, Supported child pose, Savasana. Thiền 15 phút, Yoga Nidra (giấc ngủ Yoga).',
'Thư giãn sâu, giảm stress 70-80%, cải thiện giấc ngủ, cân bằng tinh thần');

-- =====================================================
-- KHÓA 4: HIIT TRAINING - ĐỐT MỠ CỰC MẠNH
-- =====================================================
INSERT INTO course_lessons (course_id, lesson_order, title, content, objectives) VALUES
('c0000004-0000-0000-0000-000000000004', 1, 'Tuần 1: HIIT Fundamentals', 
'Học cơ chế HIIT: 20 giây max effort + 40 giây rest. Các động tác: Burpees, Jump Squats, Mountain Climbers, High Knees. Tập 8 rounds.',
'Hiểu về HIIT, xây dựng nền tảng cardio, đốt cháy 400-500 kcal/buổi'),

('c0000004-0000-0000-0000-000000000004', 2, 'Tuần 2: Tabata Protocol', 
'Cường độ cao hơn: 20s work + 10s rest x 8 rounds. Sprint, Box Jumps, Kettlebell Swings, Battle Ropes. Tổng 4 phút mỗi bài tập.',
'Tăng VO2 max, đốt cháy 500-600 kcal, cải thiện sức bền anaerobic'),

('c0000004-0000-0000-0000-000000000004', 3, 'Tuần 3-4: Bodyweight HIIT Circuits', 
'Tập circuit không dụng cụ: Push-ups, Jump Lunges, Plank Jacks, Tuck Jumps. 30s work + 15s rest, 5 rounds. Tăng intensity mỗi tuần.',
'Tăng sức mạnh cơ thể, giảm 2-3% body fat, cải thiện power'),

('c0000004-0000-0000-0000-000000000004', 4, 'Tuần 5: Weighted HIIT', 
'Thêm dumbbells/kettlebells: Thrusters, Dumbbell Snatches, Renegade Rows, Goblet Squats. 40s work + 20s rest.',
'Kết hợp cardio và strength, đốt cháy 700+ kcal, tăng lean muscle mass'),

('c0000004-0000-0000-0000-000000000004', 5, 'Tuần 6: EMOM (Every Minute On Minute)', 
'Mỗi phút thực hiện 1 động tác, nghỉ hết phút còn lại. 10 phút: Burpees, Rowing, Box Jumps, Wall Balls, Double Unders (nếu có).',
'Nâng cao work capacity, cải thiện recovery time, mental toughness'),

('c0000004-0000-0000-0000-000000000004', 6, 'Tuần 7: Tổng kết và Challenge Test', 
'Test cuối khóa: Hoàn thành circuit trong thời gian ngắn nhất. So sánh với buổi đầu. Đo chỉ số body composition. Tặng chương trình maintain.',
'Đánh giá tiến bộ (giảm 3-5% body fat, tăng 20-30% endurance)');

-- =====================================================
-- KHÓA 5: PILATES CORE STRENGTH
-- =====================================================
INSERT INTO course_lessons (course_id, lesson_order, title, content, objectives) VALUES
('c0000005-0000-0000-0000-000000000005', 1, 'Buổi 1: Pilates Principles & Breathing', 
'Học 6 nguyên tắc Pilates: Centering, Concentration, Control, Precision, Breath, Flow. Core breathing techniques. The Hundred, Roll Up, Single Leg Circle.',
'Nắm vững nguyên tắc Pilates, học cách kích hoạt transverse abdominis'),

('c0000005-0000-0000-0000-000000000005', 2, 'Buổi 2: Mat Pilates - Core Focus', 
'The Series of Five: Single Leg Stretch, Double Leg Stretch, Straight Leg Stretch, Criss-Cross, Scissors. 10 reps mỗi động tác.',
'Tăng sức mạnh core 30-40%, cải thiện stability, giảm vòng eo 2-3cm'),

('c0000005-0000-0000-0000-000000000005', 3, 'Buổi 3: Spinal Articulation', 
'Roll Up, Roll Over, Spine Stretch Forward, Saw, Swan Dive. Focus vào từng đốt sống, tăng flexibility cột sống.',
'Cải thiện linh hoạt cột sống, giảm đau lưng, tăng chiều cao tư thế'),

('c0000005-0000-0000-0000-000000000005', 4, 'Buổi 4: Side-lying Series', 
'Side Kicks, Inner Thigh Lifts, Clam Shells, Side Plank variations. Tăng cường cơ obliques và hips.',
'Tạo vòng eo săn chắc, tăng sức mạnh hông, cải thiện cân bằng'),

('c0000005-0000-0000-0000-000000000005', 5, 'Buổi 5: Advanced Mat Work', 
'Teaser, Shoulder Bridge, Swimming, Leg Pull Front/Back, Control Balance. Động tác nâng cao thử thách.',
'Nâng cao sức mạnh toàn thân, chinh phục động tác khó, tăng kiểm soát cơ thể'),

('c0000005-0000-0000-0000-000000000005', 6, 'Buổi 6: Full Body Flow & Integration', 
'Kết hợp tất cả động tác đã học thành chuỗi liên tục. Full body Pilates routine 40 phút. Cool down và stretching.',
'Thành thạo Pilates flow, duy trì core strength lâu dài, cải thiện posture 60-70%');

-- =====================================================
-- KHÓA 6: CROSSFIT EXTREME
-- =====================================================
INSERT INTO course_lessons (course_id, lesson_order, title, content, objectives) VALUES
('c0000006-0000-0000-0000-000000000006', 1, 'Tuần 1-2: CrossFit Fundamentals & Olympic Lifts Basics', 
'Học 9 foundational movements: Air Squat, Front Squat, Overhead Squat, Shoulder Press, Push Press, Push Jerk. Kỹ thuật Olympic lifts: Snatch, Clean & Jerk với PVC pipe.',
'Master kỹ thuật cơ bản, xây dựng nền tảng an toàn cho advanced training'),

('c0000006-0000-0000-0000-000000000006', 2, 'Tuần 3-4: Weightlifting Focus', 
'Tập Snatch và Clean & Jerk với barbell. Progressive loading: tăng từ 40% đến 70% 1RM. Phụ trợ: Hang Snatch, Power Clean, Front Squat. 5x5 protocol.',
'Tăng 15-20% sức mạnh Olympic lifts, cải thiện power và explosive strength'),

('c0000006-0000-0000-0000-000000000006', 3, 'Tuần 5-6: MetCons (Metabolic Conditioning)', 
'WODs nổi tiếng: Fran (21-15-9 Thrusters + Pull-ups), Cindy (AMRAP 20min: 5 Pull-ups, 10 Push-ups, 15 Squats), Grace (30 Clean & Jerks for time).',
'Tăng work capacity, cải thiện cardio trong khi maintain strength'),

('c0000006-0000-0000-0000-000000000006', 4, 'Tuần 7-8: Gymnastics & Bodyweight Skills', 
'Strict Pull-ups, Toes-to-Bar, Muscle-ups (progression), Handstand Push-ups, Pistol Squats. Skill work 20 phút/ngày.',
'Chinh phục gymnastics movements, tăng relative strength'),

('c0000006-0000-0000-0000-000000000006', 5, 'Tuần 9-10: Hero WODs & Endurance', 
'Các WODs khó khăn: Murph (1 mile run + 100 pull-ups + 200 push-ups + 300 squats + 1 mile run), DT, Diane. Chipmunk WOD.',
'Mental toughness, work capacity cực cao, spiritual growth'),

('c0000006-0000-0000-0000-000000000006', 6, 'Tuần 11-12: Competition Prep & Testing', 
'Mô phỏng CrossFit competition: 3 WODs trong 1 ngày. Test 1RM các lift chính. Assessment toàn diện: benchmark WODs, body comp, photos.',
'Đánh giá kết quả (tăng 20-30% overall strength, giảm 5-8% body fat), chuẩn bị competitions');

-- =====================================================
-- VERIFY
-- =====================================================
SELECT 'Đã thêm lộ trình học thành công!' as status;

SELECT 
    c.course_name, 
    COUNT(cl.id) as total_lessons 
FROM courses c
LEFT JOIN course_lessons cl ON c.id = cl.course_id
WHERE c.id IN (
    'c0000001-0000-0000-0000-000000000001',
    'c0000002-0000-0000-0000-000000000002',
    'c0000003-0000-0000-0000-000000000003',
    'c0000004-0000-0000-0000-000000000004',
    'c0000005-0000-0000-0000-000000000005',
    'c0000006-0000-0000-0000-000000000006'
)
GROUP BY c.course_name
ORDER BY c.course_name;
