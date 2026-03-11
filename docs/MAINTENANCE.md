# TÀI LIỆU BẢO TRÌ HỆ THỐNG (MAINTENANCE GUIDE)

## Dự án: GymHeart Fitness – Hệ thống Quản lý Phòng Gym

| Thông tin               | Chi tiết              |
| ----------------------- | --------------------- |
| **Phiên bản**           | 1.0                   |
| **Ngày tạo**            | 02/03/2026            |
| **Trạng thái**          | Đang hoạt động        |
| **Giai đoạn Waterfall** | Giai đoạn 6 – Bảo trì |

---

## MỤC LỤC

1. [Tổng quan bảo trì](#1-tổng-quan-bảo-trì)
2. [Lịch bảo trì định kỳ](#2-lịch-bảo-trì-định-kỳ)
3. [Xử lý sự cố thường gặp](#3-xử-lý-sự-cố-thường-gặp)
4. [Cập nhật và nâng cấp hệ thống](#4-cập-nhật-và-nâng-cấp-hệ-thống)
5. [Sao lưu dữ liệu](#5-sao-lưu-dữ-liệu)
6. [Nhật ký thay đổi (Changelog)](#6-nhật-ký-thay-đổi)

---

## 1. TỔNG QUAN BẢO TRÌ

### 1.1 Mục tiêu

- Đảm bảo hệ thống hoạt động ổn định 24/7
- Phát hiện và xử lý lỗi nhanh chóng
- Cập nhật tính năng theo phản hồi người dùng
- Bảo đảm an toàn dữ liệu

### 1.2 Các loại bảo trì

| Loại                   | Mô tả                                      |
| ---------------------- | ------------------------------------------ |
| **Bảo trì phòng ngừa** | Kiểm tra định kỳ, tối ưu hiệu suất         |
| **Bảo trì khắc phục**  | Sửa lỗi phát sinh trong quá trình sử dụng  |
| **Bảo trì hoàn thiện** | Thêm tính năng mới, cải thiện UX           |
| **Bảo trì thích nghi** | Cập nhật khi môi trường công nghệ thay đổi |

### 1.3 Thông tin liên lạc hỗ trợ

| Vai trò                | Trách nhiệm                          |
| ---------------------- | ------------------------------------ |
| Quản trị viên hệ thống | Quản lý tài khoản, dữ liệu, cấu hình |
| Nhà phát triển         | Sửa lỗi code, triển khai cập nhật    |

---

## 2. LỊCH BẢO TRÌ ĐỊNH KỲ

### 2.1 Hàng tuần

- [ ] Kiểm tra log lỗi trong Supabase Dashboard
- [ ] Xem lại các báo cáo hiệu suất query
- [ ] Kiểm tra dung lượng lưu trữ ảnh (Supabase Storage)
- [ ] Xem lại yêu cầu Coach chờ duyệt

### 2.2 Hàng tháng

- [ ] Xem xét và xóa tài khoản không hoạt động (> 6 tháng)
- [ ] Kiểm tra và cập nhật RLS policies nếu cần
- [ ] Rà soát các khóa học hết hạn, vô hiệu hóa nếu cần
- [ ] Backup toàn bộ cơ sở dữ liệu (xem mục 5)
- [ ] Kiểm tra tính hợp lệ của Supabase API keys

### 2.3 Hàng quý

- [ ] Đánh giá hiệu suất hệ thống tổng thể
- [ ] Cập nhật thư viện Supabase lên phiên bản mới nhất
- [ ] Rà soát và cập nhật tài liệu nếu có thay đổi
- [ ] Đánh giá phản hồi người dùng, lên kế hoạch cải tiến

---

## 3. XỬ LÝ SỰ CỐ THƯỜNG GẶP

### 3.1 Không kết nối được Supabase

**Triệu chứng**: Trang web load nhưng không lấy được dữ liệu, console báo lỗi kết nối.

**Nguyên nhân và cách xử lý**:
| Nguyên nhân | Cách xử lý |
|-------------|-----------|
| Supabase URL sai | Kiểm tra lại `SUPABASE_URL` trong `js/supabase-config.js` |
| API Key sai hoặc hết hạn | Vào Supabase → Settings → API → lấy key mới |
| Mất kết nối Internet | Kiểm tra mạng của người dùng |
| Supabase bảo trì | Vào https://status.supabase.com kiểm tra |

### 3.2 Không đăng nhập được

**Triệu chứng**: Nhập đúng email/mật khẩu nhưng đăng nhập thất bại.

```sql
-- Kiểm tra tài khoản trong DB
SELECT id, email, role, is_active FROM users WHERE email = 'user@example.com';
```

| Nguyên nhân                             | Cách xử lý                                              |
| --------------------------------------- | ------------------------------------------------------- |
| Tài khoản bị khóa (`is_active = false`) | `UPDATE users SET is_active = true WHERE email = '...'` |
| Sai mật khẩu                            | Admin dùng chức năng reset mật khẩu                     |
| Email không tồn tại                     | Kiểm tra lại email người dùng nhập                      |

### 3.3 Dữ liệu không hiển thị (RLS lỗi)

**Triệu chứng**: Đăng nhập thành công nhưng không thấy dữ liệu.

**Cách xử lý**:

1. Vào Supabase → Authentication → Policies
2. Kiểm tra các policy của bảng bị ảnh hưởng
3. Chạy lại `fix_rls.sql` nếu cần

```sql
-- Kiểm tra RLS có bật không
SELECT tablename, rowsecurity FROM pg_tables
WHERE schemaname = 'public';
```

### 3.4 Ảnh không hiển thị

**Triệu chứng**: Avatar hoặc ảnh khóa học bị vỡ.

| Nguyên nhân                      | Cách xử lý                                              |
| -------------------------------- | ------------------------------------------------------- |
| URL ảnh sai                      | Kiểm tra lại trường `avatar_url` / `image_url` trong DB |
| File không tồn tại trong Storage | Upload lại ảnh qua Supabase Storage                     |
| Link bên ngoài bị xóa            | Thay bằng ảnh mới hoặc ảnh mặc định                     |

### 3.5 Trang chậm tải

**Cách xử lý**:

1. Kiểm tra network tab trong DevTools (F12) để xác định request nào chậm
2. Xem lại query Supabase – thêm index nếu cần:

```sql
-- Ví dụ thêm index
CREATE INDEX idx_enrollments_user ON class_enrollments(user_id);
```

3. Tối ưu ảnh – giảm kích thước ảnh trước khi upload

---

## 4. CẬP NHẬT VÀ NÂNG CẤP HỆ THỐNG

### 4.1 Quy trình cập nhật code

1. **Backup** code hiện tại (commit Git hoặc copy thư mục)
2. Thực hiện thay đổi trên môi trường **test** (môi trường riêng)
3. Kiểm thử kỹ trước khi đẩy lên production
4. Backup database trước khi thay đổi schema SQL
5. Triển khai code mới
6. Kiểm tra hoạt động sau cập nhật

### 4.2 Cập nhật thư viện Supabase

Tìm dòng CDN trong các file HTML:

```html
<!-- Phiên bản hiện tại -->
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/dist/umd/supabase.min.js"></script>
```

Cập nhật số phiên bản `@2` lên phiên bản mới nhất khi cần.

### 4.3 Thêm tính năng mới

Theo quy trình Waterfall thu nhỏ:

1. Viết yêu cầu mới → cập nhật `SRS.md`
2. Thiết kế giải pháp → cập nhật `SDD.md`
3. Triển khai code
4. Kiểm thử → cập nhật `TEST_PLAN.md`
5. Triển khai
6. Cập nhật tài liệu bảo trì

---

## 5. SAO LƯU DỮ LIỆU

### 5.1 Backup bằng Supabase Dashboard

1. Vào Supabase Dashboard → **Database**
2. Chọn **Backups** (tính năng của gói Pro trở lên)
3. Hoặc dùng **pg_dump** thủ công:

```bash
pg_dump -h db.xxxxx.supabase.co -U postgres -d postgres > backup_$(date +%Y%m%d).sql
```

### 5.2 Export dữ liệu thủ công (gói Free)

```sql
-- Export bảng users
COPY users TO '/backup/users.csv' WITH CSV HEADER;

-- Export bảng courses
COPY courses TO '/backup/courses.csv' WITH CSV HEADER;

-- Export bảng enrollments
COPY class_enrollments TO '/backup/enrollments.csv' WITH CSV HEADER;
```

### 5.3 Tần suất backup khuyến nghị

| Loại dữ liệu             | Tần suất   |
| ------------------------ | ---------- |
| Toàn bộ database         | Hàng tuần  |
| Dữ liệu đăng ký khóa học | Hàng ngày  |
| Ảnh (Storage)            | Hàng tháng |

---

## 6. NHẬT KÝ THAY ĐỔI (CHANGELOG)

### Phiên bản 1.0 – 02/03/2026 (Phát hành lần đầu)

**Tính năng mới**:

- Hệ thống xác thực 3 vai trò: Admin, Coach, User
- Dashboard Admin: quản lý người dùng, khóa học, thống kê
- Dashboard Coach: quản lý lớp học, giáo án, học viên
- Dashboard User: đăng ký khóa học, xem lịch tập, cập nhật hồ sơ
- Landing page giới thiệu phòng gym
- Trang Cơ sở vật chất, Dịch vụ, Huấn luyện viên
- Hệ thống duyệt yêu cầu Coach
- Lịch học theo tuần cho từng khóa

**Lỗi đã sửa**:

- BUG-01: Fix RLS cho bảng lesson_plans
- BUG-02: Thêm cột payment_amount vào class_enrollments
- BUG-03: Thêm cột payment_method vào class_enrollments
- BUG-04: Fix lỗi cập nhật hồ sơ User
- BUG-05: Cho phép Admin đặt lại mật khẩu người dùng
