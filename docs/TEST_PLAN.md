# KẾ HOẠCH KIỂM THỬ (TEST PLAN)

## Dự án: GymHeart Fitness – Hệ thống Quản lý Phòng Gym

| Thông tin               | Chi tiết               |
| ----------------------- | ---------------------- |
| **Phiên bản**           | 1.0                    |
| **Ngày tạo**            | 02/03/2026             |
| **Trạng thái**          | Hoàn thành             |
| **Giai đoạn Waterfall** | Giai đoạn 4 – Kiểm thử |

---

## MỤC LỤC

1. [Phạm vi kiểm thử](#1-phạm-vi-kiểm-thử)
2. [Môi trường kiểm thử](#2-môi-trường-kiểm-thử)
3. [Các trường hợp kiểm thử (Test Cases)](#3-các-trường-hợp-kiểm-thử)
4. [Kiểm thử giao diện (UI Testing)](#4-kiểm-thử-giao-diện)
5. [Kiểm thử bảo mật](#5-kiểm-thử-bảo-mật)
6. [Kết quả kiểm thử](#6-kết-quả-kiểm-thử)

---

## 1. PHẠM VI KIỂM THỬ

### 1.1 Các module được kiểm thử

- ✅ Hệ thống xác thực (Đăng nhập, Đăng ký, Đăng xuất)
- ✅ Dashboard Admin
- ✅ Dashboard Coach
- ✅ Dashboard User
- ✅ Landing Page và các trang thông tin
- ✅ Phân quyền và bảo mật

### 1.2 Các loại kiểm thử

| Loại kiểm thử           | Mô tả                                                       |
| ----------------------- | ----------------------------------------------------------- |
| **Kiểm thử chức năng**  | Kiểm tra từng tính năng có hoạt động đúng yêu cầu           |
| **Kiểm thử giao diện**  | Kiểm tra giao diện hiển thị đúng trên các trình duyệt       |
| **Kiểm thử tích hợp**   | Kiểm tra kết nối giữa frontend và Supabase                  |
| **Kiểm thử bảo mật**    | Kiểm tra quyền truy cập, RLS, xác thực                      |
| **Kiểm thử phân quyền** | Kiểm tra mỗi vai trò chỉ truy cập được tính năng đúng quyền |

---

## 2. MÔI TRƯỜNG KIỂM THỬ

| Thành phần       | Thông tin                                                              |
| ---------------- | ---------------------------------------------------------------------- |
| **Trình duyệt**  | Google Chrome (v120+), Mozilla Firefox (v121+), Microsoft Edge (v120+) |
| **Hệ điều hành** | Windows 10/11                                                          |
| **Màn hình**     | Desktop (1920x1080), Tablet (768x1024), Mobile (375x667)               |
| **Kết nối**      | Internet ổn định để kết nối Supabase                                   |
| **Web Server**   | VS Code Live Server, hoặc HTTP server local                            |
| **Database**     | Supabase project test                                                  |

---

## 3. CÁC TRƯỜNG HỢP KIỂM THỬ

### 3.1 Module Xác thực

| Mã TC      | Mô tả                                    | Đầu vào                     | Kết quả mong đợi                         | Kết quả thực tế    | Trạng thái |
| ---------- | ---------------------------------------- | --------------------------- | ---------------------------------------- | ------------------ | ---------- |
| TC-AUTH-01 | Đăng nhập thành công với tài khoản Admin | email/pass admin hợp lệ     | Chuyển đến admin-dashboard.html          | Chuyển đúng        | ✅ PASS    |
| TC-AUTH-02 | Đăng nhập thành công với tài khoản Coach | email/pass coach hợp lệ     | Chuyển đến coach-dashboard.html          | Chuyển đúng        | ✅ PASS    |
| TC-AUTH-03 | Đăng nhập thành công với tài khoản User  | email/pass user hợp lệ      | Chuyển đến user-dashboard.html           | Chuyển đúng        | ✅ PASS    |
| TC-AUTH-04 | Đăng nhập với mật khẩu sai               | email đúng, pass sai        | Hiển thị thông báo lỗi                   | Hiện thông báo lỗi | ✅ PASS    |
| TC-AUTH-05 | Đăng nhập với email không tồn tại        | email giả, pass bất kỳ      | Hiển thị thông báo lỗi                   | Hiện thông báo lỗi | ✅ PASS    |
| TC-AUTH-06 | Đăng nhập với trường rỗng                | Bỏ trống email và pass      | Hiển thị thông báo yêu cầu nhập          | Hiện thông báo     | ✅ PASS    |
| TC-AUTH-07 | Đăng ký tài khoản mới thành công         | Thông tin hợp lệ đầy đủ     | Tạo tài khoản, chuyển đến user-dashboard | Thành công         | ✅ PASS    |
| TC-AUTH-08 | Đăng ký với email đã tồn tại             | email đã dùng               | Hiển thị thông báo email đã tồn tại      | Hiện thông báo     | ✅ PASS    |
| TC-AUTH-09 | Đăng xuất                                | Click nút Đăng xuất         | Xóa session, chuyển về auth.html         | Chuyển đúng        | ✅ PASS    |
| TC-AUTH-10 | Truy cập dashboard khi chưa đăng nhập    | Vào URL dashboard trực tiếp | Redirect về auth.html                    | Redirect đúng      | ✅ PASS    |

### 3.2 Module Admin – Quản lý Người dùng

| Mã TC     | Mô tả                         | Đầu vào                  | Kết quả mong đợi            | Kết quả thực tế | Trạng thái |
| --------- | ----------------------------- | ------------------------ | --------------------------- | --------------- | ---------- |
| TC-ADM-01 | Xem danh sách người dùng      | Vào tab Người dùng       | Hiển thị danh sách đầy đủ   | Hiển thị đúng   | ✅ PASS    |
| TC-ADM-02 | Tìm kiếm người dùng theo tên  | Nhập tên vào ô tìm kiếm  | Lọc danh sách theo tên      | Lọc đúng        | ✅ PASS    |
| TC-ADM-03 | Vô hiệu hóa tài khoản         | Click nút Khóa           | Tài khoản is_active = false | Cập nhật đúng   | ✅ PASS    |
| TC-ADM-04 | Xem chi tiết hồ sơ người dùng | Click vào tên người dùng | Hiển thị modal chi tiết     | Hiển thị đúng   | ✅ PASS    |

### 3.3 Module Admin – Quản lý Khóa học

| Mã TC     | Mô tả                                  | Đầu vào                 | Kết quả mong đợi                   | Kết quả thực tế | Trạng thái |
| --------- | -------------------------------------- | ----------------------- | ---------------------------------- | --------------- | ---------- |
| TC-CRS-01 | Thêm khóa học mới                      | Điền đầy đủ form        | Khóa học xuất hiện trong danh sách | Thêm thành công | ✅ PASS    |
| TC-CRS-02 | Thêm khóa học không chọn Coach         | Bỏ trống trường Coach   | Hiển thị lỗi, không lưu            | Hiển thị lỗi    | ✅ PASS    |
| TC-CRS-03 | Sửa thông tin khóa học                 | Sửa tên, giá, mô tả     | Thông tin cập nhật trong DB        | Cập nhật đúng   | ✅ PASS    |
| TC-CRS-04 | Xóa khóa học                           | Click nút Xóa, xác nhận | Xóa khỏi danh sách                 | Xóa thành công  | ✅ PASS    |
| TC-CRS-05 | Thêm khóa học thiếu thông tin bắt buộc | Bỏ trống tên hoặc giá   | Hiển thị thông báo lỗi             | Hiển thị lỗi    | ✅ PASS    |

### 3.4 Module Coach – Quản lý Lớp học

| Mã TC     | Mô tả                                 | Đầu vào              | Kết quả mong đợi                 | Kết quả thực tế      | Trạng thái |
| --------- | ------------------------------------- | -------------------- | -------------------------------- | -------------------- | ---------- |
| TC-COA-01 | Xem danh sách khóa học mình phụ trách | Đăng nhập coach      | Chỉ hiển thị khóa của mình       | Đúng                 | ✅ PASS    |
| TC-COA-02 | Xem danh sách học viên                | Vào tab Học viên     | Hiển thị học viên trong lớp mình | Đúng                 | ✅ PASS    |
| TC-COA-03 | Thêm bài học mới                      | Điền form bài học    | Bài học lưu vào lesson_plans     | Thành công           | ✅ PASS    |
| TC-COA-04 | Sửa bài học                           | Chỉnh sửa nội dung   | Dữ liệu cập nhật                 | Thành công           | ✅ PASS    |
| TC-COA-05 | Xóa bài học                           | Click Xóa, xác nhận  | Bài học bị xóa                   | Thành công           | ✅ PASS    |
| TC-COA-06 | Coach không thấy lớp của Coach khác   | Đăng nhập coach khác | Không hiển thị lớp của coach kia | Đúng (phân quyền OK) | ✅ PASS    |

### 3.5 Module User – Đăng ký Khóa học

| Mã TC     | Mô tả                         | Đầu vào                  | Kết quả mong đợi                      | Kết quả thực tế | Trạng thái |
| --------- | ----------------------------- | ------------------------ | ------------------------------------- | --------------- | ---------- |
| TC-USR-01 | Xem danh sách khóa học có sẵn | Vào tab Khám phá         | Hiển thị tất cả khóa học active       | Đúng            | ✅ PASS    |
| TC-USR-02 | Đăng ký khóa học mới          | Click Đăng ký → Xác nhận | Tạo enrollment, current_students +1   | Thành công      | ✅ PASS    |
| TC-USR-03 | Đăng ký khóa đã đăng ký rồi   | Thử đăng ký lại          | Hiển thị thông báo đã đăng ký         | Hiển thị đúng   | ✅ PASS    |
| TC-USR-04 | Xem lịch tập                  | Vào tab Lịch tập         | Hiển thị lịch của các khóa đã đăng ký | Đúng            | ✅ PASS    |
| TC-USR-05 | Cập nhật hồ sơ cá nhân        | Sửa tên, SDT, ảnh        | Thông tin cập nhật trên DB            | Thành công      | ✅ PASS    |
| TC-USR-06 | Hủy đăng ký khóa học          | Click Hủy đăng ký        | enrollment status = cancelled         | Thành công      | ✅ PASS    |

---

## 4. KIỂM THỬ GIAO DIỆN

### 4.1 Kiểm thử Responsive

| Màn hình          | Trang        | Kết quả                      |
| ----------------- | ------------ | ---------------------------- |
| Desktop 1920x1080 | Tất cả trang | ✅ Hiển thị đúng             |
| Laptop 1366x768   | Tất cả trang | ✅ Hiển thị đúng             |
| Tablet 768x1024   | Landing page | ✅ Menu thu gọn, layout đúng |
| Mobile 375x667    | Landing page | ✅ Responsive hoạt động      |

### 4.2 Kiểm thử Trình duyệt

| Trình duyệt  | Kết quả             |
| ------------ | ------------------- |
| Chrome 120+  | ✅ Hoạt động đầy đủ |
| Firefox 121+ | ✅ Hoạt động đầy đủ |
| Edge 120+    | ✅ Hoạt động đầy đủ |
| Safari (Mac) | ✅ Cơ bản hoạt động |

---

## 5. KIỂM THỬ BẢO MẬT

| Mã TC     | Mô tả                                      | Kết quả                        |
| --------- | ------------------------------------------ | ------------------------------ |
| TC-SEC-01 | User cố truy cập admin-dashboard trực tiếp | ✅ Redirect về auth.html       |
| TC-SEC-02 | Coach cố xem dữ liệu của lớp Coach khác    | ✅ RLS chặn, không trả dữ liệu |
| TC-SEC-03 | User cố sửa hồ sơ của người khác           | ✅ RLS chặn                    |
| TC-SEC-04 | Kiểm tra mật khẩu không lưu plaintext      | ✅ Lưu dạng hash trong DB      |
| TC-SEC-05 | Truy cập trang dashboard sau khi đăng xuất | ✅ Redirect về auth.html       |

---

## 6. KẾT QUẢ KIỂM THỬ

### 6.1 Tổng kết

| Tổng test cases | PASS | FAIL | Tỷ lệ thành công |
| --------------- | ---- | ---- | ---------------- |
| 36              | 36   | 0    | **100%**         |

### 6.2 Lỗi đã phát hiện và xử lý

| Mã lỗi | Mô tả lỗi                           | Trạng thái                                  |
| ------ | ----------------------------------- | ------------------------------------------- |
| BUG-01 | RLS chưa đúng cho bảng lesson_plans | ✅ Đã fix (fix_course_lessons_rls.sql)      |
| BUG-02 | Cột payment_amount bị thiếu         | ✅ Đã thêm (add_payment_amount_column.sql)  |
| BUG-03 | Cột payment_method bị thiếu         | ✅ Đã thêm (add_payment_method_column.sql)  |
| BUG-04 | Lỗi cập nhật hồ sơ User             | ✅ Đã fix (fix_user_profile_update.sql)     |
| BUG-05 | Admin chưa thể đặt lại mật khẩu     | ✅ Đã fix (enable_admin_password_reset.sql) |

### 6.3 Kết luận

Hệ thống đã qua kiểm thử đầy đủ và đáp ứng tất cả yêu cầu chức năng đề ra. Các lỗi phát sinh trong quá trình phát triển đã được phát hiện và xử lý. Hệ thống sẵn sàng triển khai.
