# BÁO CÁO MÔN CÔNG NGHỆ PHẦN MỀM

## Đề tài: Áp dụng mô hình Waterfall cho hệ thống quản lý phòng gym WebGymVS3

---

## 1. Thông tin chung

- Môn học: Công nghệ phần mềm
- Đề tài: Xây dựng website quản lý phòng gym
- Mô hình phát triển: Waterfall (Thác nước)
- Sản phẩm: WebGymVS3 (GymHeart Fitness)
- Phiên bản báo cáo: 1.0
- Ngày hoàn thành: 09/04/2026

Ghi chú điền thông tin nhóm trước khi nộp:

- Nhóm: ..................................
- Lớp: ...................................
- Giảng viên hướng dẫn: ...................
- Thành viên 1: ...........................
- Thành viên 2: ...........................
- Thành viên 3: ...........................

---

## 2. Tóm tắt dự án

WebGymVS3 là hệ thống quản lý phòng gym theo kiến trúc frontend tĩnh kết hợp Supabase (CSDL, xác thực và phân quyền). Hệ thống phục vụ 3 vai trò chính:

- Admin: quản lý người dùng, khóa học, huấn luyện viên, yêu cầu coach.
- Coach: quản lý học viên lớp phụ trách, giáo án, lịch dạy.
- User: đăng ký khóa học, theo dõi lịch tập và tiến độ.

Các thành phần tiêu biểu của dự án:

- Giao diện: index.html, auth.html, admin-dashboard.html, coach-dashboard.html, user-dashboard.html.
- Logic phía client: js/auth.js, js/supabase-config.js.
- CSDL: sql/database_setup.sql và các script cập nhật schema.
- Tài liệu quy trình: docs/SRS.md, docs/SDD.md, docs/TEST_PLAN.md, docs/DEPLOYMENT.md, docs/MAINTENANCE.md.

---

## 3. Lý do chọn mô hình Waterfall

Nhóm chọn Waterfall vì các lý do sau:

1. Phạm vi đề tài học phần tương đối rõ ràng ngay từ đầu (quản lý gym với 3 vai trò cố định).
2. Cần sản phẩm có tài liệu đầy đủ theo chuẩn môn CNPM (SRS, SDD, Test Plan, Deployment, Maintenance).
3. Nhóm sinh viên dễ quản lý tiến độ theo từng mốc tuần tự.
4. Phù hợp khi thay đổi yêu cầu không quá thường xuyên trong học kỳ.

Waterfall giúp nhóm kiểm soát tốt đầu ra mỗi giai đoạn, thuận lợi cho chấm điểm theo tiêu chí quy trình.

---

## 4. Áp dụng Waterfall vào dự án WebGymVS3

### 4.1 Giai đoạn 1: Phân tích yêu cầu (Requirements Analysis)

Mục tiêu:

- Xác định chính xác hệ thống cần làm gì.
- Xác định vai trò người dùng, phạm vi chức năng và ràng buộc kỹ thuật.

Công việc đã thực hiện:

- Thu thập yêu cầu chức năng cho Admin, Coach, User.
- Định nghĩa yêu cầu phi chức năng: hiệu suất, bảo mật, khả năng dùng, tương thích.
- Xác định ràng buộc công nghệ: frontend thuần + Supabase.

Sản phẩm đầu ra:

- Tài liệu SRS: docs/SRS.md.
- Danh sách yêu cầu chức năng được mã hóa theo nhóm (F-AUTH, F-ADM, F-COA, F-USR, F-LND).

Kết quả:

- Phạm vi hệ thống rõ ràng, làm nền cho thiết kế và triển khai.

### 4.2 Giai đoạn 2: Thiết kế hệ thống (System Design)

Mục tiêu:

- Chuyển yêu cầu thành bản thiết kế có thể lập trình.

Công việc đã thực hiện:

- Thiết kế kiến trúc JAMstack: giao diện tĩnh + Supabase API.
- Thiết kế CSDL gồm các bảng chính: users, courses, schedules, class_enrollments, lesson_plans, coach_requests.
- Thiết kế module chức năng theo vai trò và luồng nghiệp vụ.
- Thiết kế điều hướng trang và cấu trúc dashboard.

Sản phẩm đầu ra:

- Tài liệu SDD: docs/SDD.md.
- Sơ đồ quan hệ dữ liệu và mô tả module.

Kết quả:

- Giảm rủi ro khi code do có bản thiết kế tương đối chi tiết.

### 4.3 Giai đoạn 3: Triển khai (Implementation)

Mục tiêu:

- Hiện thực thiết kế thành hệ thống chạy được.

Công việc đã thực hiện:

- Xây dựng các trang giao diện chính và dashboard theo vai trò.
- Tích hợp Supabase cho xác thực, truy vấn dữ liệu và phân quyền.
- Viết logic đăng nhập/đăng ký/đăng xuất, điều hướng theo role.
- Xây dựng các chức năng quản lý khóa học, đăng ký khóa học, quản lý giáo án.
- Thiết lập cơ sở dữ liệu và script nâng cấp schema.

Minh chứng từ mã nguồn:

- auth.html và js/auth.js: luồng xác thực và điều hướng role.
- admin-dashboard.html: module quản trị tổng thể.
- coach-dashboard.html: module huấn luyện viên.
- user-dashboard.html: module học viên.
- sql/database_setup.sql và thư mục sql: khởi tạo, vá lỗi và mở rộng schema.

Kết quả:

- Hoàn thiện phiên bản chức năng chính của hệ thống WebGymVS3.

### 4.4 Giai đoạn 4: Kiểm thử (Testing)

Mục tiêu:

- Đảm bảo hệ thống hoạt động đúng yêu cầu và ổn định.

Công việc đã thực hiện:

- Thiết kế và chạy bộ test chức năng theo module.
- Kiểm thử phân quyền giữa các vai trò.
- Kiểm thử giao diện responsive trên nhiều kích thước màn hình.
- Kiểm thử bảo mật liên quan xác thực và RLS.

Sản phẩm đầu ra:

- Tài liệu Test Plan: docs/TEST_PLAN.md.
- 36 test case với tỷ lệ pass 100% theo tài liệu hiện có.
- Danh sách lỗi đã phát hiện và xử lý bằng script SQL bổ sung.

Kết quả:

- Các chức năng cốt lõi vận hành đúng, lỗi chính đã được khắc phục.

### 4.5 Giai đoạn 5: Triển khai thực tế (Deployment)

Mục tiêu:

- Đưa hệ thống vào môi trường sử dụng.

Công việc đã thực hiện:

- Cấu hình Supabase URL và Anon Key.
- Chạy script tạo dữ liệu nền và script nâng cấp.
- Thiết lập chạy local bằng Live Server hoặc HTTP server.
- Chuẩn bị khả năng triển khai static hosting (Netlify, GitHub Pages, Vercel).

Sản phẩm đầu ra:

- Tài liệu triển khai: docs/DEPLOYMENT.md.
- Quy trình checklist sau triển khai.

Kết quả:

- Hệ thống có thể chạy ổn định trên môi trường demo.

### 4.6 Giai đoạn 6: Bảo trì (Maintenance)

Mục tiêu:

- Duy trì độ ổn định và mở rộng hệ thống sau bàn giao.

Công việc đã thực hiện:

- Xây dựng lịch bảo trì tuần/tháng/quý.
- Đề xuất quy trình xử lý sự cố thường gặp (kết nối Supabase, RLS, đăng nhập, ảnh).
- Quy định backup dữ liệu và cập nhật thư viện.

Sản phẩm đầu ra:

- Tài liệu bảo trì: docs/MAINTENANCE.md.

Kết quả:

- Có kế hoạch hậu triển khai rõ ràng, dễ chuyển giao vận hành.

---

## 5. Tiến độ thực hiện theo Waterfall

Bảng tiến độ đề xuất (có thể chỉnh theo lịch thực tế của nhóm):

| Giai đoạn | Nội dung chính      | Thời lượng dự kiến | Đầu ra                   |
| --------- | ------------------- | ------------------ | ------------------------ |
| 1         | Phân tích yêu cầu   | 1-2 tuần           | SRS                      |
| 2         | Thiết kế hệ thống   | 1-2 tuần           | SDD, thiết kế DB/UI      |
| 3         | Triển khai mã nguồn | 3-4 tuần           | Source code chạy được    |
| 4         | Kiểm thử            | 1-2 tuần           | Test Plan, biên bản lỗi  |
| 5         | Triển khai          | 1 tuần             | Hệ thống demo/production |
| 6         | Bảo trì             | Liên tục           | Maintenance log          |

---

## 6. Đánh giá hiệu quả áp dụng Waterfall

### 6.1 Ưu điểm đạt được

1. Quản lý công việc dễ theo dõi do chia giai đoạn rõ ràng.
2. Tài liệu đầy đủ, đáp ứng yêu cầu học phần CNPM.
3. Dễ phân công thành viên theo đầu việc của từng pha.
4. Thuận lợi cho nghiệm thu vì có tiêu chí đầu ra cụ thể.

### 6.2 Hạn chế gặp phải

1. Khi phát sinh thay đổi yêu cầu ở cuối kỳ, việc quay lại cập nhật tài liệu tốn thời gian.
2. Một số lỗi chỉ phát hiện rõ ở giai đoạn kiểm thử/tích hợp.
3. Tính linh hoạt thấp hơn mô hình lặp (iterative/agile).

### 6.3 Bài học kinh nghiệm

1. Cần đầu tư kỹ giai đoạn phân tích yêu cầu để giảm sửa về sau.
2. Nên tạo mốc kiểm thử sớm trong lúc triển khai, không chờ đến cuối.
3. Tài liệu phải cập nhật đồng bộ với code để tránh lệch thực tế.

---

## 7. Rủi ro và biện pháp giảm thiểu

| Rủi ro                         | Mức độ     | Biện pháp                                              |
| ------------------------------ | ---------- | ------------------------------------------------------ |
| Yêu cầu thay đổi muộn          | Trung bình | Chốt phạm vi sớm, có quy trình quản lý thay đổi        |
| Lỗi phân quyền dữ liệu         | Cao        | Kiểm thử role-based và rà soát RLS định kỳ             |
| Sai khác giữa tài liệu và code | Trung bình | Review chéo mỗi cuối giai đoạn                         |
| Phụ thuộc dịch vụ Supabase     | Trung bình | Theo dõi trạng thái dịch vụ, chuẩn bị kịch bản sao lưu |
| Trễ tiến độ triển khai         | Trung bình | Tách nhiệm vụ nhỏ, theo dõi tiến độ hàng tuần          |

---

## 8. Kết luận

Việc áp dụng mô hình Waterfall cho dự án WebGymVS3 là phù hợp trong bối cảnh đồ án môn học có phạm vi tương đối ổn định và yêu cầu tài liệu rõ ràng. Dự án đã triển khai đầy đủ 6 giai đoạn của Waterfall với các đầu ra cụ thể: SRS, SDD, mã nguồn, kế hoạch kiểm thử, tài liệu triển khai và tài liệu bảo trì.

Kết quả cho thấy mô hình giúp nhóm tổ chức công việc có hệ thống, dễ theo dõi tiến độ và thuận lợi cho đánh giá học phần. Trong các phiên bản tiếp theo, nhóm có thể kết hợp thêm thực hành kiểm thử sớm và cơ chế thay đổi linh hoạt hơn để giảm tác động của nhược điểm Waterfall.

---

## 9. Phụ lục tham chiếu tài liệu dự án

- docs/WATERFALL_PROCESS.md: tổng quan quy trình Waterfall của dự án.
- docs/SRS.md: đặc tả yêu cầu phần mềm.
- docs/SDD.md: thiết kế hệ thống.
- docs/TEST_PLAN.md: kế hoạch và kết quả kiểm thử.
- docs/DEPLOYMENT.md: hướng dẫn triển khai.
- docs/MAINTENANCE.md: hướng dẫn bảo trì.
- README.md: tổng quan hệ thống và hướng dẫn chạy nhanh.
