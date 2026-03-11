# ĐẶC TẢ YÊU CẦU PHẦN MỀM (SRS)

## Dự án: GymHeart Fitness – Hệ thống Quản lý Phòng Gym

| Thông tin               | Chi tiết                        |
| ----------------------- | ------------------------------- |
| **Phiên bản**           | 1.0                             |
| **Ngày tạo**            | 02/03/2026                      |
| **Trạng thái**          | Hoàn thành                      |
| **Giai đoạn Waterfall** | Giai đoạn 1 – Phân tích Yêu cầu |

---

## MỤC LỤC

1. [Giới thiệu](#1-giới-thiệu)
2. [Mô tả tổng quan hệ thống](#2-mô-tả-tổng-quan-hệ-thống)
3. [Yêu cầu chức năng](#3-yêu-cầu-chức-năng)
4. [Yêu cầu phi chức năng](#4-yêu-cầu-phi-chức-năng)
5. [Ràng buộc hệ thống](#5-ràng-buộc-hệ-thống)
6. [Người dùng và phân quyền](#6-người-dùng-và-phân-quyền)

---

## 1. GIỚI THIỆU

### 1.1 Mục đích

Tài liệu này mô tả các yêu cầu phần mềm cho hệ thống **GymHeart Fitness** – một ứng dụng web quản lý phòng gym hiện đại. Tài liệu phục vụ cho nhóm phát triển, kiểm thử và các bên liên quan.

### 1.2 Phạm vi

Hệ thống GymHeart Fitness bao gồm:

- Trang web giới thiệu phòng gym (Landing Page)
- Hệ thống xác thực người dùng (Đăng nhập / Đăng ký)
- Bảng điều khiển theo vai trò: **Admin**, **Coach**, **User**
- Quản lý khóa học, lịch học, huấn luyện viên, học viên

### 1.3 Định nghĩa và viết tắt

| Từ viết tắt | Ý nghĩa                                                       |
| ----------- | ------------------------------------------------------------- |
| Admin       | Quản trị viên hệ thống                                        |
| Coach       | Huấn luyện viên                                               |
| User        | Học viên / Người dùng thông thường                            |
| SRS         | Software Requirements Specification – Đặc tả yêu cầu phần mềm |
| UI          | User Interface – Giao diện người dùng                         |
| DB          | Database – Cơ sở dữ liệu                                      |
| RLS         | Row Level Security – Bảo mật cấp hàng (Supabase)              |

### 1.4 Công nghệ sử dụng

- **Frontend**: HTML5, CSS3, JavaScript (Vanilla)
- **Backend/Database**: Supabase (PostgreSQL)
- **Xác thực**: Supabase Auth + Custom Auth
- **Lưu trữ ảnh**: Supabase Storage

---

## 2. MÔ TẢ TỔNG QUAN HỆ THỐNG

### 2.1 Bối cảnh hệ thống

GymHeart Fitness là hệ thống quản lý phòng gym trực tuyến, cho phép:

- Khách hàng xem thông tin và đăng ký khóa học
- Học viên theo dõi lịch tập và tiến độ học tập
- Huấn luyện viên quản lý lớp học và giáo án
- Quản trị viên quản lý toàn bộ hệ thống

### 2.2 Các trang chính của hệ thống

| Trang           | File                   | Mô tả                             |
| --------------- | ---------------------- | --------------------------------- |
| Trang chủ       | `index.html`           | Landing page giới thiệu phòng gym |
| Cơ sở vật chất  | `facilities.html`      | Giới thiệu thiết bị, cơ sở        |
| Dịch vụ         | `services.html`        | Danh sách dịch vụ của phòng gym   |
| Huấn luyện viên | `coaches.html`         | Danh sách huấn luyện viên         |
| Xác thực        | `auth.html`            | Đăng nhập / Đăng ký               |
| Dashboard Admin | `admin-dashboard.html` | Quản lý toàn bộ hệ thống          |
| Dashboard Coach | `coach-dashboard.html` | Quản lý lớp học                   |
| Dashboard User  | `user-dashboard.html`  | Theo dõi học tập                  |

---

## 3. YÊU CẦU CHỨC NĂNG

### 3.1 Hệ thống Xác thực (Authentication)

| Mã YC     | Mô tả                                                                              | Độ ưu tiên |
| --------- | ---------------------------------------------------------------------------------- | ---------- |
| F-AUTH-01 | Người dùng có thể đăng ký tài khoản bằng email và mật khẩu                         | Cao        |
| F-AUTH-02 | Người dùng có thể đăng nhập bằng email và mật khẩu                                 | Cao        |
| F-AUTH-03 | Hệ thống tự động phân quyền và điều hướng đến dashboard phù hợp (Admin/Coach/User) | Cao        |
| F-AUTH-04 | Người dùng có thể đăng xuất                                                        | Cao        |
| F-AUTH-05 | Admin có thể đặt lại mật khẩu cho người dùng                                       | Trung bình |
| F-AUTH-06 | Hệ thống bảo vệ các trang yêu cầu đăng nhập                                        | Cao        |

### 3.2 Chức năng Admin

| Mã YC    | Mô tả                                                               | Độ ưu tiên |
| -------- | ------------------------------------------------------------------- | ---------- |
| F-ADM-01 | Xem tổng quan thống kê: tổng khóa học, tổng học viên, tổng thu nhập | Cao        |
| F-ADM-02 | Quản lý người dùng: xem, thêm, sửa, xóa, kích hoạt/vô hiệu hóa      | Cao        |
| F-ADM-03 | Quản lý khóa học: thêm, sửa, xóa, gán huấn luyện viên               | Cao        |
| F-ADM-04 | Quản lý huấn luyện viên: xem danh sách, xem hồ sơ                   | Trung bình |
| F-ADM-05 | Xem lịch sử đăng ký khóa học của học viên                           | Trung bình |
| F-ADM-06 | Xem lịch học tổng thể của toàn hệ thống                             | Thấp       |
| F-ADM-07 | Duyệt yêu cầu trở thành huấn luyện viên                             | Cao        |

### 3.3 Chức năng Coach (Huấn luyện viên)

| Mã YC    | Mô tả                                                            | Độ ưu tiên |
| -------- | ---------------------------------------------------------------- | ---------- |
| F-COA-01 | Xem danh sách học viên của các khóa mình phụ trách               | Cao        |
| F-COA-02 | Quản lý giáo án (bài học): thêm, sửa, xóa                        | Cao        |
| F-COA-03 | Xem lịch dạy                                                     | Cao        |
| F-COA-04 | Thêm/xóa học viên trong lớp                                      | Trung bình |
| F-COA-05 | Theo dõi tiến độ học viên                                        | Trung bình |
| F-COA-06 | Cập nhật thông tin cá nhân và chuyên môn                         | Cao        |
| F-COA-07 | Gửi yêu cầu trở thành huấn luyện viên (nếu chưa được phân quyền) | Trung bình |

### 3.4 Chức năng User (Học viên)

| Mã YC    | Mô tả                                                        | Độ ưu tiên |
| -------- | ------------------------------------------------------------ | ---------- |
| F-USR-01 | Xem danh sách các khóa học có sẵn                            | Cao        |
| F-USR-02 | Đăng ký tham gia khóa học                                    | Cao        |
| F-USR-03 | Hủy đăng ký khóa học                                         | Trung bình |
| F-USR-04 | Xem lịch tập theo từng khóa học                              | Cao        |
| F-USR-05 | Theo dõi tiến độ học tập (bài học đã hoàn thành)             | Trung bình |
| F-USR-06 | Cập nhật hồ sơ cá nhân (tên, số điện thoại, ảnh đại diện...) | Cao        |
| F-USR-07 | Xem thông tin chi tiết các khóa học đã đăng ký               | Trung bình |

### 3.5 Landing Page và Trang Thông tin

| Mã YC    | Mô tả                                       | Độ ưu tiên |
| -------- | ------------------------------------------- | ---------- |
| F-LND-01 | Hiển thị banner chào mừng, slogan phòng gym | Cao        |
| F-LND-02 | Hiển thị danh sách dịch vụ của phòng gym    | Cao        |
| F-LND-03 | Hiển thị hình ảnh cơ sở vật chất            | Trung bình |
| F-LND-04 | Hiển thị danh sách huấn luyện viên nổi bật  | Trung bình |
| F-LND-05 | Điều hướng đến trang đăng nhập/đăng ký      | Cao        |

---

## 4. YÊU CẦU PHI CHỨC NĂNG

### 4.1 Hiệu suất

- Trang web tải trong vòng **3 giây** với kết nối internet ổn định.
- Các truy vấn CSDL phản hồi trong vòng **1 giây** cho các thao tác thông thường.

### 4.2 Bảo mật

- Mật khẩu người dùng phải được **mã hóa** (không lưu dạng plaintext).
- Áp dụng **RLS (Row Level Security)** trên Supabase để kiểm soát quyền truy cập dữ liệu.
- Các trang dashboard phải yêu cầu **xác thực** trước khi truy cập.
- Người dùng chỉ có thể xem/sửa **dữ liệu của chính mình** (trừ Admin).

### 4.3 Khả năng sử dụng (Usability)

- Giao diện thân thiện, trực quan, sử dụng được trên cả máy tính lẫn điện thoại (responsive).
- Hỗ trợ ngôn ngữ **Tiếng Việt**.
- Thông báo lỗi/thành công rõ ràng, dễ hiểu.

### 4.4 Khả năng tương thích

- Hoạt động trên các trình duyệt hiện đại: Chrome, Firefox, Edge, Safari.
- Tương thích với màn hình có độ phân giải từ 375px (mobile) đến 1920px (desktop).

### 4.5 Độ tin cậy

- Tỷ lệ hoạt động (**uptime**) tối thiểu 99% (phụ thuộc vào Supabase SLA).
- Dữ liệu được lưu trữ an toàn trên Supabase Cloud.

---

## 5. RÀNG BUỘC HỆ THỐNG

- Hệ thống yêu cầu kết nối Internet để kết nối với Supabase.
- Không có backend server riêng – toàn bộ logic nghiệp vụ xử lý phía client và Supabase.
- Phải có tài khoản Supabase và cấu hình đúng `SUPABASE_URL` và `SUPABASE_ANON_KEY` trong `js/supabase-config.js`.
- Hệ thống cần chạy trên web server (không thể mở trực tiếp file HTML bằng `file://`).

---

## 6. NGƯỜI DÙNG VÀ PHÂN QUYỀN

### 6.1 Phân loại người dùng

| Vai trò   | Mô tả                                               |
| --------- | --------------------------------------------------- |
| **Admin** | Quản trị viên, có toàn quyền trên hệ thống          |
| **Coach** | Huấn luyện viên, quản lý các lớp học được phân công |
| **User**  | Học viên, đăng ký và tham gia khóa học              |

### 6.2 Ma trận phân quyền

| Chức năng                 | Admin |     Coach     | User |
| ------------------------- | :---: | :-----------: | :--: |
| Quản lý người dùng        |  ✅   |      ❌       |  ❌  |
| Quản lý khóa học          |  ✅   |      ❌       |  ❌  |
| Quản lý giáo án (bài học) |  ✅   | ✅ (lớp mình) |  ❌  |
| Xem danh sách học viên    |  ✅   | ✅ (lớp mình) |  ❌  |
| Đăng ký khóa học          |  ❌   |      ❌       |  ✅  |
| Xem lịch học của mình     |  ❌   |      ✅       |  ✅  |
| Xem thống kê hệ thống     |  ✅   |      ❌       |  ❌  |
| Cập nhật hồ sơ cá nhân    |  ✅   |      ✅       |  ✅  |
| Duyệt yêu cầu Coach       |  ✅   |      ❌       |  ❌  |
