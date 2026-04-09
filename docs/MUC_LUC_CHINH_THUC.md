# BÁO CÁO BÀI TẬP HỌC PHẦN CÔNG NGHỆ PHẦN MỀM

**ĐỀ TÀI: ÁP DỤNG MÔ HÌNH WATERFALL TRONG PHÁT TRIỂN HỆ THỐNG WEBSITE QUẢN LÝ PHÒNG GYM**

Giảng viên hướng dẫn: Nguyễn Đức Dư  
Nhóm thực hiện: [Tên Nhóm]

---

**LỜI CẢM ƠN**  
**LỜI CAM ĐOAN**  
**BẢNG PHÂN CÔNG VÀ ĐÁNH GIÁ**  
**MỤC LỤC**  
**DANH MỤC BẢNG BIỂU**  
**DANH MỤC HÌNH ẢNH**

---

### CHƯƠNG 1: GIỚI THIỆU

**1.1. Lý do chọn đề tài**  
 1.1.1. Bối cảnh thực tế hệ thống quản lý phòng Gym  
 1.1.2. Ý nghĩa học tập  
 1.1.3. Lý do lựa chọn mô hình Waterfall  
**1.2. Mục tiêu đề tài**  
 1.2.1. Mục tiêu chung  
 1.2.2. Mục tiêu cụ thể  
**1.3. Phạm vi đề tài**  
 1.3.1. Phạm vi chức năng đối với Admin, Coach, User  
 1.3.2. Ngoài phạm vi đề tài (Hệ thống thanh toán thật và Bảo trì dài hạn)  
 1.3.3. Tiêu chí hoàn thành hệ thống  
**1.4. Phương pháp nghiên cứu**  
 1.4.1. Nghiên cứu lý thuyết  
 1.4.2. Phân tích yêu cầu và thiết kế hệ thống theo từng giai đoạn Waterfall

### CHƯƠNG 2: TỔNG QUAN MÔ HÌNH WATERFALL

**2.1. Giới thiệu mô hình Waterfall**  
 2.1.1. Định nghĩa  
 2.1.2. Bản chất tuyến tính  
 2.1.3. Nguồn gốc, đặc điểm  
**2.2. Các giai đoạn của Waterfall áp dụng trong dự án**  
 2.2.1. Phân tích yêu cầu (Requirements Analysis)  
 2.2.2. Thiết kế hệ thống (System Design)  
 2.2.3. Cài đặt / Lập trình (Implementation)  
 2.2.4. Kiểm thử (Testing)  
 2.2.5. Triển khai (Deployment)  
 _(Đã loại bỏ giai đoạn Bảo trì theo yêu cầu)_
**2.3. Ưu điểm – Nhược điểm của mô hình Waterfall**

### CHƯƠNG 3: PHÂN TÍCH YÊU CẦU (PHASE 1)

**3.1. Tổng quan hệ thống GymHeart**  
**3.2. Các tác nhân (Actor)**  
 3.2.1. Đối với khách hàng/học viên (User)  
 3.2.2. Đối với huấn luyện viên (Coach)  
 3.2.3. Đối với quản trị viên (Admin)  
**3.3. Yêu cầu phi chức năng**  
 3.3.1. Bảo mật (Supabase RLS)  
 3.3.2. Hiệu năng  
 3.3.3. Giao diện (Responsive)  
**3.4. Use Case Diagram**  
 3.4.1. Use case quản lý khóa học và giáo án  
 3.4.2. Use case quản lý người dùng / tài khoản  
 3.4.3. Use case đăng ký tập và theo dõi lịch học

### CHƯƠNG 4: THIẾT KẾ HỆ THỐNG (PHASE 2)

**4.1. Thiết kế kiến trúc**  
 4.1.1. Tầng giao diện (Presentation Layer - HTML/JS/CSS)  
 4.1.2. Tầng dữ liệu và nghiệp vụ (Data & Logic Layer - Supabase)  
**4.2. Thiết kế cơ sở dữ liệu**  
 4.2.1. Danh sách bảng (`users`, `courses`, `class_enrollments`, `lesson_plans`...)  
 4.2.2. Mô tả chi tiết các trường trong bảng  
 4.2.3. Mối quan hệ ERD giữa các bảng  
**4.3. Thiết kế giao diện**  
 4.3.1. Trang chủ / Landing Page  
 4.3.2. Trang đăng ký / đăng nhập  
 4.3.3. Dashboard Học viên (User)  
 4.3.4. Dashboard Huấn luyện viên (Coach)  
 4.3.5. Dashboard Quản trị viên (Admin)  
**4.4. Biểu đồ Sequence Diagram / Activity Diagram cho các luồng chính**

### CHƯƠNG 5: CÀI ĐẶT / LẬP TRÌNH (PHASE 3)

**5.1. Công nghệ sử dụng**  
 5.1.1. Frontend (HTML5, JS, CSS)  
 5.1.2. Backend & Database (Supabase, PostgreSQL)  
**5.2. Mô tả Module nghiệp vụ**  
 5.2.1. Module Xác thực và Cấp quyền  
 5.2.2. Module Quản trị Admin (Duyệt Coach, thêm khóa học)  
 5.2.3. Module Huấn luyện viên (Tạo giáo án, quản lý lớp)  
 5.2.4. Module Học viên (Đăng ký học, xem lịch)

### CHƯƠNG 6: KIỂM THỬ VÀ TRIỂN KHAI (PHASE 4 & 5)

**6.1. Kiểm thử phần mềm**  
 6.1.1. Mục tiêu kiểm thử  
 6.1.2. Các kịch bản kiểm thử (Đăng nhập, Phân quyền RLS, Đăng ký khóa học)  
 6.1.3. Đánh giá kết quả kiểm thử  
**6.2. Triển khai phần mềm**  
 6.2.1. Yêu cầu môi trường triển khai thực tế  
 6.2.2. Cấu hình Supabase và Hosting

**KẾT LUẬN**

- Kết quả đạt được
- Đánh giá khả năng áp dụng mô hình Waterfall vào đồ án
- Hạn chế và hướng mở rộng tương lai

**TÀI LIỆU THAM KHẢO**
