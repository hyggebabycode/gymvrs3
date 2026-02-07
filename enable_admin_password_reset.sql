-- =============================================
-- Enable Admin Password Reset Function
-- =============================================
-- Chạy script này trong Supabase SQL Editor để cho phép admin reset password

-- Tạo function reset password (chỉ admin được dùng)
CREATE OR REPLACE FUNCTION admin_reset_user_password(
  target_user_id UUID,
  new_password TEXT
)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER -- Chạy với quyền của hàm (bypass RLS)
AS $$
DECLARE
  result JSON;
BEGIN
  -- Kiểm tra user hiện tại có phải admin không
  IF NOT EXISTS (
    SELECT 1 FROM public.users 
    WHERE id = auth.uid() AND role = 'admin'
  ) THEN
    RAISE EXCEPTION 'Chỉ admin mới có quyền reset password';
  END IF;

  -- Kiểm tra target user có tồn tại không
  IF NOT EXISTS (
    SELECT 1 FROM auth.users WHERE id = target_user_id
  ) THEN
    RAISE EXCEPTION 'Không tìm thấy user';
  END IF;

  -- Update password trong auth.users
  -- Note: Cần enable pg_crypto extension
  UPDATE auth.users
  SET 
    encrypted_password = crypt(new_password, gen_salt('bf')),
    updated_at = NOW()
  WHERE id = target_user_id;

  result := json_build_object(
    'success', true,
    'message', 'Password đã được reset thành công'
  );

  RETURN result;
END;
$$;

-- Grant execute permission
GRANT EXECUTE ON FUNCTION admin_reset_user_password(UUID, TEXT) TO authenticated;

-- Thông báo hoàn thành
SELECT 'Admin password reset function created successfully!' as status;

-- =============================================
-- HƯỚNG DẪN SỬ DỤNG:
-- =============================================
-- Sau khi chạy script này, function resetUserPassword trong admin dashboard sẽ hoạt động
-- Admin có thể đặt lại mật khẩu cho bất kỳ user nào
-- Mật khẩu mới sẽ được mã hóa tự động
