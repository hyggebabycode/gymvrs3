    -- =====================================================
    -- MIGRATE AUTH.USERS TO PUBLIC.USERS
    -- =====================================================
    -- Script này migrate dữ liệu từ Supabase Auth (auth.users) 
    -- sang bảng custom users (public.users)

    -- Bước 1: Kiểm tra dữ liệu hiện có
    SELECT 
    'AUTH.USERS' as source,
    COUNT(*) as total_users,
    COUNT(CASE WHEN email_confirmed_at IS NOT NULL THEN 1 END) as confirmed_users
    FROM auth.users;

    SELECT 
    'PUBLIC.USERS' as source,
    COUNT(*) as total_users,
    COUNT(CASE WHEN is_active = true THEN 1 END) as active_users
    FROM users;

    -- Bước 2: Insert các user từ auth.users vào public.users
    -- Chỉ migrate những user chưa tồn tại trong public.users
    INSERT INTO users (
    id,
    email,
    password_hash,
    full_name,
    phone,
    role,
    is_active,
    avatar_url,
    created_at,
    updated_at
    )
    SELECT 
    au.id,
    au.email,
    au.encrypted_password, -- Đây là bcrypt hash từ Supabase Auth
    COALESCE(
        au.raw_user_meta_data->>'full_name',
        au.raw_user_meta_data->>'name',
        SPLIT_PART(au.email, '@', 1)
    ) as full_name,
    au.raw_user_meta_data->>'phone' as phone,
    COALESCE(au.raw_user_meta_data->>'role', 'user')::user_role as role,
    (au.email_confirmed_at IS NOT NULL) as is_active,
    COALESCE(
        au.raw_user_meta_data->>'avatar_url',
        'https://ui-avatars.com/api/?name=' || REPLACE(COALESCE(au.raw_user_meta_data->>'full_name', SPLIT_PART(au.email, '@', 1)), ' ', '+') || '&background=f42559&color=fff&size=200'
    ) as avatar_url,
    au.created_at,
    NOW() as updated_at
    FROM auth.users au
    WHERE NOT EXISTS (
    -- Không insert nếu email đã tồn tại trong public.users
    SELECT 1 FROM users u WHERE u.email = au.email
    )
    AND au.deleted_at IS NULL; -- Chỉ migrate user chưa bị xóa

    -- Bước 3: Kiểm tra kết quả sau khi migrate
    SELECT 
    'AFTER MIGRATION' as status,
    COUNT(*) as total_users,
    COUNT(CASE WHEN role = 'admin' THEN 1 END) as admins,
    COUNT(CASE WHEN role = 'coach' THEN 1 END) as coaches,
    COUNT(CASE WHEN role = 'user' THEN 1 END) as regular_users,
    COUNT(CASE WHEN is_active = true THEN 1 END) as active_users
    FROM users;

    -- Bước 4: Hiển thị danh sách users đã migrate
    SELECT 
    email,
    full_name,
    role,
    is_active,
    LEFT(password_hash, 15) || '...' as password_preview,
    created_at
    FROM users
    ORDER BY created_at DESC;

    -- =====================================================
    -- LƯU Ý QUAN TRỌNG
    -- =====================================================
    /*
    1. Password đã được migrate từ encrypted_password (Supabase Auth)
    - Đây là bcrypt hash, giống format $2a$ hoặc $2b$
    - Code auth.js hiện tại đã hỗ trợ bcrypt verification
    
    2. Nếu bcrypt.js vẫn chưa load được, chạy script này để convert về plaintext:
    
    UPDATE users 
    SET password_hash = '123456'
    WHERE password_hash LIKE '$2a$%' OR password_hash LIKE '$2b$%';

    3. Các user từ auth.users sẽ giữ nguyên ID để tránh conflict

    4. Nếu muốn set role cụ thể cho một số user:
    
    UPDATE users 
    SET role = 'coach' 
    WHERE email IN ('coach@example.com', 'trainer@example.com');
    
    UPDATE users 
    SET role = 'admin' 
    WHERE email = 'youradmin@example.com';

    5. Để kích hoạt các user chưa xác nhận email:
    
    UPDATE users 
    SET is_active = true 
    WHERE is_active = false;
    */
