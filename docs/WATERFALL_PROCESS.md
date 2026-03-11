# QUY TRÌNH PHÁT TRIỂN THEO MÔ HÌNH WATERFALL

## Dự án: GymHeart Fitness – Hệ thống Quản lý Phòng Gym

| Thông tin              | Chi tiết              |
| ---------------------- | --------------------- |
| **Phiên bản**          | 1.0                   |
| **Ngày tạo**           | 02/03/2026            |
| **Mô hình phát triển** | Waterfall (Thác nước) |

---

## WATERFALL LÀ GÌ?

Mô hình **Waterfall** (Thác nước) là phương pháp phát triển phần mềm tuần tự, trong đó mỗi giai đoạn phải hoàn thành **trước khi** chuyển sang giai đoạn tiếp theo – giống như nước chảy xuống từng bậc thác.

```
┌─────────────────────────────────┐
│  1. PHÂN TÍCH YÊU CẦU           │ ← Xác định "cần làm gì"
└────────────────┬────────────────┘
                 ↓
┌─────────────────────────────────┐
│  2. THIẾT KẾ HỆ THỐNG           │ ← Xác định "làm như thế nào"
└────────────────┬────────────────┘
                 ↓
┌─────────────────────────────────┐
│  3. TRIỂN KHAI (CODE)           │ ← Viết code thực sự
└────────────────┬────────────────┘
                 ↓
┌─────────────────────────────────┐
│  4. KIỂM THỬ                    │ ← Kiểm tra lỗi
└────────────────┬────────────────┘
                 ↓
┌─────────────────────────────────┐
│  5. TRIỂN KHAI THỰC TẾ          │ ← Đưa ra người dùng
└────────────────┬────────────────┘
                 ↓
┌─────────────────────────────────┐
│  6. BẢO TRÌ                     │ ← Duy trì và cập nhật
└─────────────────────────────────┘
```

---

## CÁC GIAI ĐOẠN CỦA DỰ ÁN GYMHEART FITNESS

### GIAI ĐOẠN 1 – PHÂN TÍCH YÊU CẦU

**Câu hỏi trả lời**: Hệ thống cần làm gì?

**Đầu ra**:

- Xác định 3 loại người dùng: Admin, Coach, User
- Xác định các chức năng cần thiết cho từng vai trò
- Xác định yêu cầu phi chức năng: bảo mật, hiệu suất, giao diện
- Xác định ràng buộc công nghệ: HTML/JS/CSS + Supabase

**Tài liệu**: [`docs/SRS.md`](docs/SRS.md) – Đặc tả yêu cầu phần mềm

**Thời gian hoàn thành**: Trước khi bắt đầu code

---

### GIAI ĐOẠN 2 – THIẾT KẾ HỆ THỐNG

**Câu hỏi trả lời**: Hệ thống được xây dựng như thế nào?

**Đầu ra**:

- Kiến trúc hệ thống JAMstack (Frontend + Supabase)
- Thiết kế cơ sở dữ liệu (6 bảng chính: users, courses, schedules, class_enrollments, lesson_plans, coach_requests)
- Thiết kế giao diện: màu sắc hồng (#f42559), responsive, sidebar navigation
- Thiết kế luồng xử lý: đăng nhập, đăng ký khóa, duyệt Coach

**Tài liệu**: [`docs/SDD.md`](docs/SDD.md) – Tài liệu thiết kế hệ thống

**Thời gian hoàn thành**: Sau giai đoạn 1, trước khi code

---

### GIAI ĐOẠN 3 – TRIỂN KHAI (IMPLEMENTATION)

**Câu hỏi trả lời**: Code được viết như thế nào?

**Đầu ra**:

| File/Thư mục            | Mô tả                       |
| ----------------------- | --------------------------- |
| `index.html`            | Trang chủ landing page      |
| `auth.html`             | Giao diện đăng nhập/đăng ký |
| `admin-dashboard.html`  | Dashboard quản trị viên     |
| `coach-dashboard.html`  | Dashboard huấn luyện viên   |
| `user-dashboard.html`   | Dashboard học viên          |
| `facilities.html`       | Trang cơ sở vật chất        |
| `services.html`         | Trang dịch vụ               |
| `coaches.html`          | Trang huấn luyện viên       |
| `js/supabase-config.js` | Cấu hình kết nối Supabase   |
| `js/auth.js`            | Logic xác thực              |
| `database_setup.sql`    | Script tạo cơ sở dữ liệu    |
| Các file `.sql` bổ sung | Cập nhật/bổ sung schema DB  |

**Thứ tự triển khai**:

1. Thiết lập cơ sở dữ liệu Supabase
2. Xây dựng hệ thống xác thực
3. Xây dựng Landing Page
4. Xây dựng Admin Dashboard
5. Xây dựng Coach Dashboard
6. Xây dựng User Dashboard
7. Hoàn thiện giao diện và responsive

---

### GIAI ĐOẠN 4 – KIỂM THỬ (TESTING)

**Câu hỏi trả lời**: Hệ thống có hoạt động đúng không?

**Đầu ra**:

- 36 test cases bao phủ tất cả chức năng chính
- Phát hiện và ghi lại 5 lỗi (bugs)
- Kiểm thử phân quyền: đúng role mới truy cập được
- Kiểm thử bảo mật: RLS hoạt động đúng
- Kiểm thử giao diện: responsive trên desktop và mobile

**Lỗi phát hiện và đã sửa**:
| Lỗi | File xử lý |
|-----|-----------|
| RLS sai cho lesson_plans | `fix_course_lessons_rls.sql` |
| Thiếu cột payment_amount | `add_payment_amount_column.sql` |
| Thiếu cột payment_method | `add_payment_method_column.sql` |
| Lỗi cập nhật hồ sơ User | `fix_user_profile_update.sql` |
| Admin chưa reset được mật khẩu | `enable_admin_password_reset.sql` |

**Tài liệu**: [`docs/TEST_PLAN.md`](docs/TEST_PLAN.md) – Kế hoạch và kết quả kiểm thử

---

### GIAI ĐOẠN 5 – TRIỂN KHAI THỰC TẾ (DEPLOYMENT)

**Câu hỏi trả lời**: Làm thế nào để người dùng sử dụng được hệ thống?

**Đầu ra**:

- Hệ thống chạy ổn định trên web server
- Cơ sở dữ liệu Supabase đã khởi tạo đầy đủ
- Tài khoản admin đầu tiên đã tạo
- Dữ liệu mẫu (khóa học, lịch học, người dùng test) đã nạp

**Cách triển khai**:

- **Local**: VS Code Live Server / Python HTTP Server
- **Production**: Netlify / GitHub Pages / Vercel (static hosting)
- **Database**: Supabase Cloud (PostgreSQL)

**Tài liệu**: [`docs/DEPLOYMENT.md`](docs/DEPLOYMENT.md) – Hướng dẫn triển khai

---

### GIAI ĐOẠN 6 – BẢO TRÌ (MAINTENANCE)

**Câu hỏi trả lời**: Làm thế nào để duy trì hệ thống hoạt động tốt?

**Các hoạt động**:

- Kiểm tra log lỗi hàng tuần
- Backup dữ liệu định kỳ
- Sửa lỗi phát sinh từ người dùng
- Cập nhật tính năng mới theo phản hồi
- Cập nhật thư viện/phụ thuộc khi cần

**Tài liệu**: [`docs/MAINTENANCE.md`](docs/MAINTENANCE.md) – Tài liệu bảo trì

---

## TỔNG KẾT CẤU TRÚC TÀI LIỆU WATERFALL

```
webgymvs3/
├── docs/
│   ├── WATERFALL_PROCESS.md  ← File này: tổng quan quy trình
│   ├── SRS.md                ← Giai đoạn 1: Phân tích yêu cầu
│   ├── SDD.md                ← Giai đoạn 2: Thiết kế hệ thống
│   │                            (Giai đoạn 3 = toàn bộ code)
│   ├── TEST_PLAN.md          ← Giai đoạn 4: Kiểm thử
│   ├── DEPLOYMENT.md         ← Giai đoạn 5: Triển khai
│   └── MAINTENANCE.md        ← Giai đoạn 6: Bảo trì
├── index.html
├── auth.html
├── admin-dashboard.html
├── coach-dashboard.html
├── user-dashboard.html
├── database_setup.sql
├── js/
│   ├── supabase-config.js
│   └── auth.js
└── ...
```

---

## ƯU VÀ NHƯỢC ĐIỂM CỦA WATERFALL TRONG DỰ ÁN NÀY

### Ưu điểm đã được áp dụng

- **Tài liệu đầy đủ**: Mỗi giai đoạn đều có tài liệu rõ ràng
- **Rõ ràng về phạm vi**: Biết chính xác cần làm gì từ đầu
- **Dễ theo dõi tiến độ**: Biết đang ở giai đoạn nào
- **Dễ bàn giao**: Tài liệu đầy đủ giúp người khác tiếp quản dễ

### Nhược điểm cần lưu ý

- **Khó thay đổi giữa chừng**: Nếu yêu cầu thay đổi, cần cập nhật lại từ đầu
- **Phát hiện lỗi muộn**: Lỗi thường chỉ phát hiện ở giai đoạn kiểm thử
- **Không linh hoạt**: Không phù hợp nếu yêu cầu chưa rõ ràng từ đầu
