# Hướng Dẫn Cấu Hình Google OAuth với Supabase

## Bước 1: Tạo Google OAuth Client

1. Truy cập [Google Cloud Console](https://console.cloud.google.com/)
2. Tạo project mới hoặc chọn project hiện có
3. Vào **APIs & Services** > **Credentials**
4. Click **Create Credentials** > **OAuth 2.0 Client ID**
5. Chọn Application type: **Web application**
6. Cấu hình:
   - **Name**: GymHeart Web App
   - **Authorized JavaScript origins**: 
     - `http://localhost:5500`
     - `http://127.0.0.1:5500`
     - URL production của bạn (nếu có)
   - **Authorized redirect URIs**:
     - `https://ytfudwxzvbaltgspbngi.supabase.co/auth/v1/callback`
     - (Thay `ytfudwxzvbaltgspbngi` bằng project ID Supabase của bạn)
7. Click **Create** và lưu lại:
   - **Client ID**
   - **Client Secret**

## Bước 2: Cấu Hình Google OAuth trong Supabase

1. Đăng nhập [Supabase Dashboard](https://app.supabase.com/)
2. Chọn project của bạn
3. Vào **Authentication** > **Providers**
4. Tìm và bật **Google**
5. Nhập thông tin từ Bước 1:
   - **Client ID (for OAuth)**: Paste Client ID từ Google
   - **Client Secret (for OAuth)**: Paste Client Secret từ Google
6. Click **Save**

## Bước 3: Kiểm Tra Cấu Hình

1. Mở file `auth.html` trong browser
2. Click nút "Đăng nhập với Google"
3. Chọn tài khoản Google của bạn
4. Cho phép quyền truy cập
5. Bạn sẽ được redirect về trang auth.html và tự động đăng nhập

## Lưu Ý Quan Trọng

### Site URL và Redirect URLs
Trong Supabase Dashboard > **Authentication** > **URL Configuration**, đảm bảo:
- **Site URL**: `http://localhost:5500` (hoặc URL production)
- **Redirect URLs**: 
  - `http://localhost:5500/auth.html`
  - `http://127.0.0.1:5500/auth.html`
  - URL production/auth.html (nếu có)

### Chạy với Live Server
- Phải sử dụng Live Server extension trong VS Code
- Không chạy trực tiếp file HTML (file://)
- OAuth không hoạt động với file:// protocol

### Debugging
Nếu gặp lỗi, kiểm tra:
1. Console log trong browser (F12)
2. Google Cloud Console > Credentials > OAuth 2.0 Client IDs
3. Supabase Dashboard > Authentication > Providers > Google
4. Redirect URI phải khớp chính xác

## Cấu Trúc Database

Khi đăng nhập bằng Google, hệ thống tự động:
1. Kiểm tra user đã tồn tại chưa (theo email)
2. Nếu chưa có, tạo user mới với:
   - `email`: Email từ Google
   - `full_name`: Tên từ Google
   - `avatar_url`: Avatar từ Google
   - `role`: 'user' (mặc định)
   - `password_hash`: 'oauth_user' (placeholder)
3. Lưu thông tin user vào localStorage
4. Redirect đến dashboard tương ứng với role

## FAQ

**Q: Tại sao nút Google không hoạt động?**
A: Kiểm tra Console log, có thể do:
- Chưa cấu hình Google OAuth trong Supabase
- Redirect URI không khớp
- Đang chạy bằng file:// thay vì http://

**Q: Làm sao để test trên localhost?**
A: 
- Sử dụng Live Server trong VS Code
- URL sẽ là http://localhost:5500 hoặc http://127.0.0.1:5500
- Thêm URL này vào Google OAuth và Supabase redirect URLs

**Q: User đăng nhập Google có thể đăng nhập bằng password không?**
A: Không, OAuth users có password_hash = 'oauth_user'. Họ chỉ có thể đăng nhập qua Google.

**Q: Làm thế nào để thay đổi role của user OAuth?**
A: Admin có thể thay đổi role trong admin dashboard như user thường.

## Hỗ Trợ

Nếu gặp vấn đề, tham khảo:
- [Supabase Auth Docs](https://supabase.com/docs/guides/auth/social-login/auth-google)
- [Google OAuth 2.0 Docs](https://developers.google.com/identity/protocols/oauth2)
