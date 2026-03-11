# TÀI LIỆU THIẾT KẾ HỆ THỐNG (SDD)

## Dự án: GymHeart Fitness – Hệ thống Quản lý Phòng Gym

| Thông tin               | Chi tiết                        |
| ----------------------- | ------------------------------- |
| **Phiên bản**           | 1.0                             |
| **Ngày tạo**            | 02/03/2026                      |
| **Trạng thái**          | Hoàn thành                      |
| **Giai đoạn Waterfall** | Giai đoạn 2 – Thiết kế Hệ thống |

---

## MỤC LỤC

1. [Kiến trúc hệ thống](#1-kiến-trúc-hệ-thống)
2. [Thiết kế cơ sở dữ liệu](#2-thiết-kế-cơ-sở-dữ-liệu)
3. [Thiết kế giao diện người dùng](#3-thiết-kế-giao-diện-người-dùng)
4. [Thiết kế module](#4-thiết-kế-module)
5. [Luồng xử lý chính](#5-luồng-xử-lý-chính)
6. [Bảo mật hệ thống](#6-bảo-mật-hệ-thống)

---

## 1. KIẾN TRÚC HỆ THỐNG

### 1.1 Mô hình tổng thể

Hệ thống GymHeart Fitness sử dụng mô hình **JAMstack** (JavaScript + API + Markup):

```
┌─────────────────────────────────────────────┐
│              NGƯỜI DÙNG (Browser)            │
└──────────────────────┬──────────────────────┘
                       │ HTTP/HTTPS
┌──────────────────────▼──────────────────────┐
│           FRONTEND (Static HTML/JS/CSS)      │
│  index.html | auth.html | *-dashboard.html   │
│  js/supabase-config.js | js/auth.js          │
└──────────────────────┬──────────────────────┘
                       │ Supabase JS SDK
┌──────────────────────▼──────────────────────┐
│           SUPABASE (Backend-as-a-Service)    │
│  ┌──────────────┐  ┌────────────────────┐   │
│  │  Auth Module │  │  Database (PostSQL) │   │
│  └──────────────┘  └────────────────────┘   │
│  ┌──────────────┐  ┌────────────────────┐   │
│  │   Storage    │  │   Row Level Sec.   │   │
│  └──────────────┘  └────────────────────┘   │
└─────────────────────────────────────────────┘
```

### 1.2 Công nghệ sử dụng

| Lớp          | Công nghệ                    | Mô tả                         |
| ------------ | ---------------------------- | ----------------------------- |
| Frontend     | HTML5, CSS3, JavaScript ES6+ | Giao diện người dùng          |
| UI Framework | Bootstrap 5 / Custom CSS     | Thiết kế giao diện responsive |
| Icon         | Font Awesome / Unicode Emoji | Biểu tượng giao diện          |
| Backend      | Supabase (PostgreSQL)        | Cơ sở dữ liệu và API          |
| Auth         | Supabase Auth                | Xác thực người dùng           |
| Storage      | Supabase Storage             | Lưu trữ ảnh đại diện          |
| Hosting      | Live Server / Static Hosting | Chạy ứng dụng                 |

---

## 2. THIẾT KẾ CƠ SỞ DỮ LIỆU

### 2.1 Danh sách bảng

| Tên bảng            | Mô tả                                     |
| ------------------- | ----------------------------------------- |
| `users`             | Thông tin người dùng (Admin, Coach, User) |
| `courses`           | Thông tin khóa học                        |
| `schedules`         | Lịch học của từng khóa                    |
| `class_enrollments` | Đăng ký khóa học của học viên             |
| `lesson_plans`      | Giáo án / bài học trong khóa              |
| `coach_requests`    | Yêu cầu trở thành huấn luyện viên         |

### 2.2 Sơ đồ quan hệ bảng (ERD)

```
users (id, email, full_name, role, ...)
  │
  ├──[coach_id]── courses (id, course_name, price, level, coach_id, ...)
  │                   │
  │                   ├── schedules (id, course_id, day_of_week, start_time, ...)
  │                   │
  │                   └── lesson_plans (id, course_id, lesson_title, ...)
  │
  └──[user_id]──── class_enrollments (id, user_id, course_id, status, payment_amount, ...)

users ──[user_id]── coach_requests (id, user_id, status, reason, ...)
```

### 2.3 Chi tiết các bảng

#### Bảng `users`

| Cột                 | Kiểu dữ liệu | Mô tả                          |
| ------------------- | ------------ | ------------------------------ |
| id                  | UUID (PK)    | Định danh duy nhất             |
| email               | VARCHAR(255) | Email đăng nhập (unique)       |
| password_hash       | VARCHAR(255) | Mật khẩu đã mã hóa             |
| full_name           | VARCHAR(255) | Họ và tên                      |
| phone               | VARCHAR(20)  | Số điện thoại                  |
| avatar_url          | TEXT         | Đường dẫn ảnh đại diện         |
| role                | ENUM         | Vai trò: admin / coach / user  |
| is_active           | BOOLEAN      | Trạng thái tài khoản           |
| specialization      | TEXT         | Chuyên môn (chỉ Coach)         |
| years_of_experience | INTEGER      | Số năm kinh nghiệm (chỉ Coach) |
| certification       | TEXT         | Chứng chỉ (chỉ Coach)          |
| created_at          | TIMESTAMP    | Thời điểm tạo                  |

#### Bảng `courses`

| Cột              | Kiểu dữ liệu  | Mô tả                                             |
| ---------------- | ------------- | ------------------------------------------------- |
| id               | UUID (PK)     | Định danh duy nhất                                |
| course_name      | VARCHAR(255)  | Tên khóa học                                      |
| description      | TEXT          | Mô tả khóa học                                    |
| price            | DECIMAL(10,2) | Học phí                                           |
| duration_weeks   | INTEGER       | Thời lượng (tuần)                                 |
| level            | ENUM          | Cấp độ: beginner/intermediate/advanced/all_levels |
| max_students     | INTEGER       | Số học viên tối đa                                |
| current_students | INTEGER       | Số học viên hiện tại                              |
| coach_id         | UUID (FK)     | Huấn luyện viên phụ trách                         |
| is_active        | BOOLEAN       | Trạng thái hoạt động                              |

#### Bảng `class_enrollments`

| Cột            | Kiểu dữ liệu  | Mô tả                                          |
| -------------- | ------------- | ---------------------------------------------- |
| id             | UUID (PK)     | Định danh duy nhất                             |
| user_id        | UUID (FK)     | Học viên                                       |
| course_id      | UUID (FK)     | Khóa học                                       |
| status         | ENUM          | Trạng thái: pending/active/completed/cancelled |
| payment_amount | DECIMAL(10,2) | Số tiền đã thanh toán                          |
| payment_method | VARCHAR(50)   | Phương thức thanh toán                         |
| enrolled_at    | TIMESTAMP     | Thời điểm đăng ký                              |

#### Bảng `lesson_plans`

| Cột                | Kiểu dữ liệu | Mô tả              |
| ------------------ | ------------ | ------------------ |
| id                 | UUID (PK)    | Định danh duy nhất |
| course_id          | UUID (FK)    | Khóa học           |
| lesson_title       | VARCHAR(255) | Tiêu đề bài học    |
| lesson_description | TEXT         | Nội dung bài học   |
| lesson_order       | INTEGER      | Thứ tự bài học     |
| duration_minutes   | INTEGER      | Thời lượng (phút)  |

---

## 3. THIẾT KẾ GIAO DIỆN NGƯỜI DÙNG

### 3.1 Nguyên tắc thiết kế

- **Màu sắc chủ đạo**: Hồng đậm (`#f42559`), trắng, xám nhạt
- **Font chữ**: Hệ thống font mặc định của trình duyệt
- **Layout**: Responsive, hỗ trợ mobile-first
- **Phong cách**: Hiện đại, năng động, phù hợp với phòng gym

### 3.2 Cấu trúc điều hướng

```
Trang chủ (index.html)
├── Cơ sở vật chất (facilities.html)
├── Dịch vụ (services.html)
├── Huấn luyện viên (coaches.html)
└── Đăng nhập/Đăng ký (auth.html)
    ├── [Admin] → admin-dashboard.html
    ├── [Coach] → coach-dashboard.html
    └── [User]  → user-dashboard.html
```

### 3.3 Cấu trúc Dashboard

Mỗi dashboard gồm:

- **Sidebar**: Menu điều hướng theo vai trò
- **Header**: Thông tin người dùng, nút đăng xuất
- **Main Content**: Nội dung thay đổi theo menu được chọn
- **Modal**: Popup thêm/sửa dữ liệu

---

## 4. THIẾT KẾ MODULE

### 4.1 Module xác thực (`js/auth.js`)

| Hàm                      | Chức năng                         |
| ------------------------ | --------------------------------- |
| `login(email, password)` | Đăng nhập và điều hướng theo role |
| `register(data)`         | Đăng ký tài khoản mới             |
| `logout()`               | Đăng xuất                         |
| `checkAuth()`            | Kiểm tra trạng thái đăng nhập     |
| `getCurrentUser()`       | Lấy thông tin người dùng hiện tại |

### 4.2 Module cấu hình Supabase (`js/supabase-config.js`)

| Thành phần              | Mô tả                               |
| ----------------------- | ----------------------------------- |
| `SUPABASE_URL`          | URL endpoint của Supabase project   |
| `SUPABASE_ANON_KEY`     | API key công khai                   |
| `window.supabaseClient` | Instance Supabase client dùng chung |

### 4.3 Module Admin Dashboard

| Chức năng       | Mô tả                     |
| --------------- | ------------------------- |
| Quản lý Users   | CRUD người dùng           |
| Quản lý Courses | CRUD khóa học, gán Coach  |
| Thống kê        | Biểu đồ, số liệu tổng hợp |
| Yêu cầu Coach   | Duyệt/từ chối yêu cầu     |

### 4.4 Module Coach Dashboard

| Chức năng       | Mô tả                        |
| --------------- | ---------------------------- |
| Lớp học của tôi | Danh sách khóa học phụ trách |
| Học viên        | Quản lý học viên trong lớp   |
| Giáo án         | Thêm/sửa/xóa bài học         |
| Lịch dạy        | Xem lịch theo tuần           |

### 4.5 Module User Dashboard

| Chức năng        | Mô tả                        |
| ---------------- | ---------------------------- |
| Khóa học của tôi | Danh sách khóa đã đăng ký    |
| Khám phá         | Tìm kiếm và đăng ký khóa mới |
| Lịch tập         | Xem lịch học theo tuần       |
| Hồ sơ            | Cập nhật thông tin cá nhân   |

---

## 5. LUỒNG XỬ LÝ CHÍNH

### 5.1 Luồng Đăng nhập

```
Người dùng nhập email/password
        ↓
Gọi Supabase: query bảng users với email + password
        ↓
   Tìm thấy?
   NO → Hiện thông báo lỗi → Kết thúc
   YES ↓
Kiểm tra is_active
   FALSE → Hiện "Tài khoản bị khóa" → Kết thúc
   TRUE ↓
Lưu thông tin vào localStorage
        ↓
Kiểm tra role
   admin  → Điều hướng admin-dashboard.html
   coach  → Điều hướng coach-dashboard.html
   user   → Điều hướng user-dashboard.html
```

### 5.2 Luồng Đăng ký Khóa học (User)

```
User chọn khóa học → Click "Đăng ký"
        ↓
Kiểm tra đã đăng ký chưa?
   Rồi → Hiện "Đã đăng ký" → Kết thúc
   Chưa ↓
Kiểm tra còn chỗ không?
   Hết → Hiện "Hết chỗ" → Kết thúc
   Còn ↓
Insert vào class_enrollments (status: active)
Update current_students += 1 trong courses
        ↓
Hiện thông báo "Đăng ký thành công"
```

### 5.3 Luồng Duyệt Yêu cầu Coach

```
User gửi yêu cầu → Insert coach_requests (status: pending)
        ↓
Admin vào trang "Yêu cầu Coach"
        ↓
Admin click "Duyệt" hoặc "Từ chối"
   Từ chối → Update coach_requests.status = 'rejected'
   Duyệt ↓
Update coach_requests.status = 'approved'
Update users.role = 'coach'
        ↓
User được nâng cấp thành Coach
```

---

## 6. BẢO MẬT HỆ THỐNG

### 6.1 Row Level Security (RLS) – Supabase

| Bảng                | Chính sách                                                |
| ------------------- | --------------------------------------------------------- |
| `users`             | User chỉ đọc/sửa hồ sơ của mình; Admin đọc tất cả         |
| `courses`           | Mọi người đọc; Chỉ Admin thêm/sửa/xóa                     |
| `class_enrollments` | User chỉ xem đăng ký của mình; Coach xem lớp của mình     |
| `lesson_plans`      | Mọi người đọc; Coach sửa trong lớp mình; Admin toàn quyền |
| `coach_requests`    | User xem yêu cầu của mình; Admin xem tất cả               |

### 6.2 Bảo vệ trang Dashboard

- Mỗi trang dashboard kiểm tra `localStorage` cho thông tin người dùng khi load.
- Nếu chưa đăng nhập → tự động redirect về `auth.html`.
- Nếu sai role → redirect về dashboard phù hợp.

### 6.3 Mã hóa mật khẩu

- Mật khẩu được mã hóa bằng **bcrypt** (thông qua Supabase) trước khi lưu vào CSDL.
- Không bao giờ lưu mật khẩu dạng plaintext.
