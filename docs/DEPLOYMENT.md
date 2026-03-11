# TÀI LIỆU TRIỂN KHAI (DEPLOYMENT GUIDE)

## Dự án: GymHeart Fitness – Hệ thống Quản lý Phòng Gym

| Thông tin               | Chi tiết                 |
| ----------------------- | ------------------------ |
| **Phiên bản**           | 1.0                      |
| **Ngày tạo**            | 02/03/2026               |
| **Trạng thái**          | Hoàn thành               |
| **Giai đoạn Waterfall** | Giai đoạn 5 – Triển khai |

---

## MỤC LỤC

1. [Yêu cầu hệ thống](#1-yêu-cầu-hệ-thống)
2. [Cài đặt môi trường](#2-cài-đặt-môi-trường)
3. [Cấu hình Supabase](#3-cấu-hình-supabase)
4. [Triển khai cơ sở dữ liệu](#4-triển-khai-cơ-sở-dữ-liệu)
5. [Chạy ứng dụng](#5-chạy-ứng-dụng)
6. [Kiểm tra sau triển khai](#6-kiểm-tra-sau-triển-khai)
7. [Tài khoản mẫu](#7-tài-khoản-mẫu)

---

## 1. YÊU CẦU HỆ THỐNG

### 1.1 Phần cứng tối thiểu (máy phát triển)

| Thành phần   | Yêu cầu                 |
| ------------ | ----------------------- |
| CPU          | 2 nhân, 2.0 GHz trở lên |
| RAM          | 4 GB trở lên            |
| Ổ cứng       | 500 MB trống            |
| Kết nối mạng | Internet ổn định        |

### 1.2 Phần mềm cần thiết

| Phần mềm              | Phiên bản   | Mục đích                  |
| --------------------- | ----------- | ------------------------- |
| Trình duyệt web       | Chrome 100+ | Chạy và kiểm tra ứng dụng |
| VS Code               | 1.80+       | Chỉnh sửa code            |
| Extension Live Server | 5.7+        | Chạy web server local     |
| Git _(tùy chọn)_      | 2.30+       | Quản lý phiên bản         |

### 1.3 Dịch vụ bên ngoài

| Dịch vụ                         | Mục đích                         |
| ------------------------------- | -------------------------------- |
| Supabase (https://supabase.com) | Backend, Cơ sở dữ liệu, Xác thực |

---

## 2. CÀI ĐẶT MÔI TRƯỜNG

### Bước 1: Lấy source code

```bash
# Cách 1: Clone từ Git
git clone <repository-url>
cd webgymvs3

# Cách 2: Giải nén từ file ZIP
# Giải nén file zip → mở thư mục webgymvs3 bằng VS Code
```

### Bước 2: Cài extension Live Server trong VS Code

1. Mở VS Code
2. Nhấn `Ctrl + Shift + X` để mở Extensions
3. Tìm kiếm **"Live Server"** (tác giả: Ritwick Dey)
4. Nhấn **Install**

---

## 3. CẤU HÌNH SUPABASE

### Bước 1: Tạo tài khoản và project Supabase

1. Truy cập https://supabase.com
2. Đăng ký tài khoản miễn phí
3. Tạo project mới:
   - **Name**: GymHeart hoặc tên tùy chọn
   - **Database Password**: Đặt mật khẩu mạnh
   - **Region**: Chọn vùng gần nhất (Singapore cho Việt Nam)
4. Chờ project khởi tạo (~2 phút)

### Bước 2: Lấy thông tin kết nối

1. Vào **Settings** → **API**
2. Sao chép:
   - **Project URL** (ví dụ: `https://xxxxx.supabase.co`)
   - **anon public key** (ví dụ: `eyJ...`)

### Bước 3: Cập nhật file cấu hình

Mở file `js/supabase-config.js` và thay thế:

```javascript
const SUPABASE_URL = "https://YOUR_PROJECT_URL.supabase.co";
const SUPABASE_ANON_KEY = "YOUR_ANON_KEY_HERE";
```

---

## 4. TRIỂN KHAI CƠ SỞ DỮ LIỆU

### Bước 1: Chạy script tạo bảng chính

1. Vào Supabase Dashboard → **SQL Editor**
2. Chọn **New Query**
3. Sao chép toàn bộ nội dung file `database_setup.sql`
4. Dán vào SQL Editor và nhấn **Run**

### Bước 2: Chạy các script bổ sung (theo thứ tự)

Chạy lần lượt các file sau:

```
1. fix_rls.sql                     → Cấu hình Row Level Security
2. add_payment_amount_column.sql   → Thêm cột thanh toán
3. add_payment_method_column.sql   → Thêm cột phương thức thanh toán
4. add_coach_requests.sql          → Tạo bảng yêu cầu Coach
5. add_course_lessons_table.sql    → Tạo bảng bài học
6. fix_course_lessons_rls.sql      → Fix RLS cho bài học
7. fix_user_profile_update.sql     → Fix cập nhật hồ sơ
8. enable_admin_password_reset.sql → Cho phép Admin reset mật khẩu
9. update_courses_schedules.sql    → Cập nhật lịch học
10. add_schedules_4_courses.sql    → Thêm dữ liệu lịch mẫu
```

> **Lưu ý**: Chạy đúng thứ tự, chờ mỗi script hoàn thành trước khi chạy tiếp.

### Bước 3: Tạo tài khoản Admin đầu tiên

Chạy đoạn SQL sau (thay thông tin phù hợp):

```sql
INSERT INTO users (email, password_hash, full_name, role, is_active)
VALUES (
  'admin@gymheart.com',
  '123456',   -- Thay bằng mật khẩu thực
  'Quản trị viên',
  'admin',
  true
);
```

> **Bảo mật**: Đổi mật khẩu ngay sau lần đăng nhập đầu tiên!

---

## 5. CHẠY ỨNG DỤNG

### Cách 1: Dùng Live Server (Khuyến nghị)

1. Mở VS Code, mở thư mục dự án
2. Click chuột phải vào file `index.html`
3. Chọn **"Open with Live Server"**
4. Trình duyệt tự động mở tại `http://127.0.0.1:5500`

### Cách 2: Dùng Python HTTP Server

```bash
# Python 3
python -m http.server 8080

# Mở trình duyệt: http://localhost:8080
```

### Cách 3: Triển khai lên hosting tĩnh

Tải toàn bộ file HTML/CSS/JS lên:

- **Netlify**: Kéo thả thư mục vào netlify.com
- **GitHub Pages**: Push code lên GitHub, bật Pages
- **Vercel**: Kết nối repo GitHub

> ⚠️ **Quan trọng**: Không mở file HTML trực tiếp bằng `file://` – ứng dụng sẽ không hoạt động do hạn chế CORS.

---

## 6. KIỂM TRA SAU TRIỂN KHAI

Sau khi triển khai, kiểm tra các mục sau:

| STT | Kiểm tra                       | Kết quả mong đợi                |
| --- | ------------------------------ | ------------------------------- |
| 1   | Mở trang chủ                   | Hiển thị landing page đầy đủ    |
| 2   | Click "Đăng nhập"              | Chuyển đến trang auth.html      |
| 3   | Đăng nhập bằng tài khoản Admin | Chuyển đến admin-dashboard.html |
| 4   | Kiểm tra console (F12)         | Không có lỗi CORS hay kết nối   |
| 5   | Vào tab Quản lý Người dùng     | Hiển thị danh sách từ Supabase  |
| 6   | Thêm 1 khóa học thử            | Khóa học lưu thành công         |
| 7   | Đăng nhập tài khoản User       | Chuyển đến user-dashboard.html  |
| 8   | Đăng ký 1 khóa học             | Đăng ký thành công              |

---

## 7. TÀI KHOẢN MẪU

Sau khi chạy `QUICK_SETUP.sql` hoặc tạo thủ công, hệ thống có các tài khoản test:

| Vai trò | Email               | Mật khẩu |
| ------- | ------------------- | -------- |
| Admin   | admin@gymheart.com  | 123456   |
| Coach   | coach1@gymheart.com | 123456   |
| Coach   | coach2@gymheart.com | 123456   |
| User    | user1@gymheart.com  | 123456   |
| User    | user2@gymheart.com  | 123456   |

> ⚠️ **Lưu ý bảo mật**: Đổi mật khẩu mặc định khi triển khai thực tế.
