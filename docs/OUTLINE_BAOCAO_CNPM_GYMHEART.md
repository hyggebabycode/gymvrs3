# MỤC LỤC BÁO CÁO CÔNG NGHỆ PHẦN MỀM

**(ĐỀ TÀI: ỨNG DỤNG MÔ HÌNH WATERFALL PHÁT TRIỂN WEBSITE QUẢN LÝ PHÒNG GYM)**

**LỜI CẢM ƠN**  
**BẢNG PHÂN CÔNG VÀ ĐÁNH GIÁ CÔNG VIỆC**  
**DANH MỤC BẢNG BIỂU**  
**DANH MỤC HÌNH ẢNH**  
**LỜI MỞ ĐẦU**

---

### **CHƯƠNG 1. TỔNG QUAN DỰ ÁN PHẦN MỀM**

**1.1. Phân tích thực trạng và khảo sát**  
&nbsp;&nbsp;&nbsp;&nbsp;1.1.1. Hiện trạng quản lý tại các phòng tập Gym quy mô vừa và nhỏ  
&nbsp;&nbsp;&nbsp;&nbsp;1.1.2. Khó khăn trong việc theo dõi lịch tập, đăng ký khóa học, quản lý giáo án  
**1.2. Xác định bài toán cần giải quyết**  
&nbsp;&nbsp;&nbsp;&nbsp;1.2.1. Nhu cầu đối với Hội viên (User)  
&nbsp;&nbsp;&nbsp;&nbsp;1.2.2. Nhu cầu đối với Huấn luyện viên (Coach)  
&nbsp;&nbsp;&nbsp;&nbsp;1.2.3. Nhu cầu đối với Quản trị hệ thống (Admin)  
**1.3. Tổng quan về hệ thống Website GymHeart**  
&nbsp;&nbsp;&nbsp;&nbsp;1.3.1. Mục tiêu hệ thống  
&nbsp;&nbsp;&nbsp;&nbsp;1.3.2. Phạm vi ứng dụng phần mềm

---

### **CHƯƠNG 2. QUẢN LÝ DỰ ÁN VÀ QUY TRÌNH PHÁT TRIỂN PHẦN MỀM**

**2.1. Phương pháp luận phát triển phần mềm**  
&nbsp;&nbsp;&nbsp;&nbsp;2.1.1. Khái niệm mô hình Thác nước (Waterfall)  
&nbsp;&nbsp;&nbsp;&nbsp;2.1.2. Đặc điểm nổi bật của mô hình Waterfall  
&nbsp;&nbsp;&nbsp;&nbsp;2.1.3. Ưu điểm và nhược điểm của mô hình Waterfall  
&nbsp;&nbsp;&nbsp;&nbsp;2.1.4. Lý do lựa chọn mô hình Waterfall cho dự án quản lý phòng Gym  
**2.2. Quản lý dự án theo các giai đoạn Waterfall**  
&nbsp;&nbsp;&nbsp;&nbsp;2.2.1. Ước lượng công việc và mốc thời gian (Milestones)  
&nbsp;&nbsp;&nbsp;&nbsp;2.2.2. Phân công công việc (Thiết kế, Code, Test)  
**2.3. Căn cứ và Nghiên cứu khả thi**  
&nbsp;&nbsp;&nbsp;&nbsp;2.3.1. Tính khả thi kỹ thuật (Kiến trúc Frontend tĩnh + BaaS)  
&nbsp;&nbsp;&nbsp;&nbsp;2.3.2. Tính khả thi vận hành

---

### **CHƯƠNG 3. ĐẶC TẢ PHẦN MỀM (REQUIREMENTS ANALYSIS)**

**3.1. Thu thập và đánh giá yêu cầu**  
&nbsp;&nbsp;&nbsp;&nbsp;3.1.1. Yêu cầu chức năng (Functional Requirements)  
&nbsp;&nbsp;&nbsp;&nbsp;3.1.2. Yêu cầu phi chức năng (Bảo mật số liệu, Hiệu năng)  
**3.2. Xác định tác nhân hệ thống (Actors)**  
&nbsp;&nbsp;&nbsp;&nbsp;3.2.1. Quản trị viên (Admin)  
&nbsp;&nbsp;&nbsp;&nbsp;3.2.2. Huấn luyện viên (Coach)  
&nbsp;&nbsp;&nbsp;&nbsp;3.2.3. Hội viên / Khách truy cập (User / Guest)  
**3.3. Mô hình hóa biểu đồ Ca sử dụng (Use Case Diagram)**  
&nbsp;&nbsp;&nbsp;&nbsp;3.3.1. Biểu đồ Use Case tổng quan hệ thống  
&nbsp;&nbsp;&nbsp;&nbsp;3.3.2. Cây Use Case Quản lý tài khoản (Authentication)  
&nbsp;&nbsp;&nbsp;&nbsp;3.3.3. Cây Use Case Quản lý khóa học và giáo án  
&nbsp;&nbsp;&nbsp;&nbsp;3.3.4. Cây Use Case Đăng ký lớp học và theo dõi lịch tập  
**3.4. Đặc tả chi tiết các Use Case cốt lõi**  
&nbsp;&nbsp;&nbsp;&nbsp;3.4.1. Đặc tả luồng sự kiện Use Case Phân quyền đăng nhập  
&nbsp;&nbsp;&nbsp;&nbsp;3.4.2. Đặc tả luồng sự kiện Use Case Học viên đăng ký khóa học

---

### **CHƯƠNG 4. THIẾT KẾ PHẦN MỀM (SYSTEM DESIGN)**

**4.1. Thiết kế kiến trúc tổng quan**  
&nbsp;&nbsp;&nbsp;&nbsp;4.1.1. Mô hình Client - Server thông qua API (JAMstack)  
&nbsp;&nbsp;&nbsp;&nbsp;4.1.2. Phân lớp thành phần hệ thống (Presentation, Logic, Data Layer)  
**4.2. Thiết kế dữ liệu (Database Design)**  
&nbsp;&nbsp;&nbsp;&nbsp;4.2.1. Sơ đồ thực thể liên kết (ER Diagram)  
&nbsp;&nbsp;&nbsp;&nbsp;4.2.2. Đặc tả các danh mục bảng cơ sở dữ liệu (`users`, `courses`, `class_enrollments`, `schedules`, `lesson_plans`, `coach_requests`)  
**4.3. Mô hình hóa xử lý bằng UML**  
&nbsp;&nbsp;&nbsp;&nbsp;4.3.1. Biểu đồ hoạt động (Activity Diagram: Quản trị viên xử lý duyệt cấp quyền Coach)  
&nbsp;&nbsp;&nbsp;&nbsp;4.3.2. Biểu đồ tuần tự (Sequence Diagram: Luồng Hội viên thanh toán/ghi danh khóa học)  
**4.4. Thiết kế giao diện phần mềm (UI)**  
&nbsp;&nbsp;&nbsp;&nbsp;4.4.1. Khung giao diện Front-end khách hàng (`index.html`, `facilities.html`, `services.html`, `coaches.html`)  
&nbsp;&nbsp;&nbsp;&nbsp;4.4.2. Khung giao diện Quản trị / Các cấp độ tài khoản (`admin-dashboard.html`, `coach-dashboard.html`, `user-dashboard.html`)  
&nbsp;&nbsp;&nbsp;&nbsp;4.4.3. Khung giao diện xác thực (`auth.html`)

---

### **CHƯƠNG 5. XÂY DỰNG VÀ LẬP TRÌNH (IMPLEMENTATION)**

**5.1. Công nghệ và Công cụ sử dụng**  
&nbsp;&nbsp;&nbsp;&nbsp;5.1.1. Frontend (HTML5, Tailwind CSS, Vanilla JavaScript)  
&nbsp;&nbsp;&nbsp;&nbsp;5.1.2. Backend & Dịch vụ đám mây (Supabase, PostgreSQL)  
**5.2. Xây dựng cấu trúc Cơ sở dữ liệu và Bảo mật**  
&nbsp;&nbsp;&nbsp;&nbsp;5.2.1. Triển khai script thiết lập Schema DB  
&nbsp;&nbsp;&nbsp;&nbsp;5.2.2. Áp dụng quy tắc bảo mật cấp độ dòng (Row Level Security - RLS)  
**5.3. Xây dựng và tích hợp hệ thống Frontend**  
&nbsp;&nbsp;&nbsp;&nbsp;5.3.1. Cấu trúc tổ chức thư mục mã nguồn  
&nbsp;&nbsp;&nbsp;&nbsp;5.3.2. Tích hợp module xử lý đăng nhập & kết nối Supabase API (`js/auth.js`, `js/supabase-config.js`)  
**5.4. Hiện thực các chức năng chính**  
&nbsp;&nbsp;&nbsp;&nbsp;5.4.1. Phân hệ Định danh cá nhân và phân quyền Role-based  
&nbsp;&nbsp;&nbsp;&nbsp;5.4.2. Phân hệ Quản trị (Duyệt Coach, tạo Khóa học, v.v...)  
&nbsp;&nbsp;&nbsp;&nbsp;5.4.3. Phân hệ Huấn luyện viên (Lịch dạy, tạo Giáo án - Lesson Plans)  
&nbsp;&nbsp;&nbsp;&nbsp;5.4.4. Phân hệ Học viên (Ghi danh Class Enrollments, Xem lịch học)

---

### **CHƯƠNG 6. CÀI ĐẶT VÀ KIỂM THỬ PHẦN MỀM (TESTING & DEPLOYMENT)**

**6.1. Mục tiêu và Môi trường thiết lập**  
&nbsp;&nbsp;&nbsp;&nbsp;6.1.1. Mục tiêu của giai đoạn kiểm thử phần mềm  
&nbsp;&nbsp;&nbsp;&nbsp;6.1.2. Cấu trúc và môi trường triển khai thực tế  
**6.2. Quy trình kiểm thử phần mềm**  
&nbsp;&nbsp;&nbsp;&nbsp;6.2.1. Xây dựng dữ liệu mẫu kiểm thử  
&nbsp;&nbsp;&nbsp;&nbsp;6.2.2. Kịch bản kiểm thử chức năng (UAT) cho các file Dashboard  
&nbsp;&nbsp;&nbsp;&nbsp;6.2.3. Kịch bản kiểm thử bảo mật quyền truy cập (Dựa vào auth.js check)  
**6.3. Đánh giá hệ thống sau kiểm thử**  
&nbsp;&nbsp;&nbsp;&nbsp;6.3.1. Tổng hợp các lỗi (Bug) phát hiện thuộc quy trình Waterfall  
&nbsp;&nbsp;&nbsp;&nbsp;6.3.2. Phương án sửa lỗi đã áp dụng trên mã nguồn

---

### **KẾT LUẬN**

1. Tổng kết và đóng góp của đề tài
2. Đánh giá tính hiệu quả khi tích hợp Supabase vào quản trị Waterfall
3. Những hạn chế tồn đọng
4. Hướng phát triển mở rộng trong tương lai

**TÀI LIỆU THAM KHẢO**  
**PHỤ LỤC: Script SQL khởi tạo**
