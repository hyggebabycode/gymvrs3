-- =============================================
-- Migration: Add payment_amount column to class_enrollments
-- =============================================

-- Thêm cột payment_amount vào bảng class_enrollments
ALTER TABLE class_enrollments 
ADD COLUMN IF NOT EXISTS payment_amount DECIMAL(10, 2);

-- Cập nhật payment_amount cho các bản ghi đã có từ giá khóa học
UPDATE class_enrollments ce
SET payment_amount = c.price
FROM courses c
WHERE ce.course_id = c.id 
  AND ce.payment_amount IS NULL;

-- Hiển thị kết quả
SELECT 
    'Migration completed!' as status,
    COUNT(*) as total_enrollments,
    COUNT(payment_amount) as enrollments_with_amount
FROM class_enrollments;
