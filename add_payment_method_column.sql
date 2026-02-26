-- =====================================================
-- ADD PAYMENT_METHOD COLUMN TO CLASS_ENROLLMENTS
-- =====================================================
-- Thêm cột payment_method vào bảng class_enrollments

-- Thêm cột payment_method
ALTER TABLE class_enrollments 
ADD COLUMN IF NOT EXISTS payment_method VARCHAR(50) DEFAULT 'cash';

-- Update giá trị mặc định cho các bản ghi hiện có
UPDATE class_enrollments 
SET payment_method = CASE 
    WHEN payment_status = 'paid' THEN 'cash'
    ELSE 'pending'
END
WHERE payment_method IS NULL;

-- Kiểm tra kết quả
SELECT 
    COUNT(*) as total,
    payment_method,
    payment_status
FROM class_enrollments
GROUP BY payment_method, payment_status;

-- Hiển thị schema của bảng
SELECT 
    column_name, 
    data_type, 
    column_default,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'class_enrollments'
ORDER BY ordinal_position;
