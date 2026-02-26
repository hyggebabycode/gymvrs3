// =====================================================
// SUPABASE CONFIGURATION
// =====================================================
// Cấu hình kết nối tới Supabase
// Thay đổi SUPABASE_URL và SUPABASE_ANON_KEY bằng thông tin của bạn

const SUPABASE_URL = "https://chfbdpcgstloqoairtrs.supabase.co";
const SUPABASE_ANON_KEY =
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNoZmJkcGNnc3Rsb3FvYWlydHJzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzAyODIwMDEsImV4cCI6MjA4NTg1ODAwMX0.AtpjoPgPFrcMWnt9X3yHmTvOMgXFtb3vNvxptPqJpsU";

// Log để debug
console.log("Initializing Supabase with URL:", SUPABASE_URL);

// Check if supabase library is loaded
if (typeof window.supabase === "undefined") {
  console.error(
    "❌ Supabase library not loaded! Check CDN link or internet connection.",
  );
  alert(
    "Lỗi: Không thể tải thư viện Supabase. Vui lòng:\n1. Kiểm tra kết nối internet\n2. Kiểm tra CDN link trong <head> của HTML\n3. Thử tải lại trang",
  );
  window.supabaseClient = null;
} else {
  try {
    // Khởi tạo Supabase client
    const supabase = window.supabase.createClient(
      SUPABASE_URL,
      SUPABASE_ANON_KEY,
    );

    // Export để sử dụng ở các file khác
    window.supabaseClient = supabase;

    console.log("✅ Supabase client initialized successfully");

    // Test connection
    supabase
      .from("users")
      .select("count", { count: "exact", head: true })
      .then(({ error }) => {
        if (error) {
          console.error("⚠️ Supabase connection test failed:", error.message);
          console.log(
            "Vui lòng kiểm tra:\n1. Supabase URL có đúng không\n2. API Key có đúng không\n3. RLS policies đã được set up chưa",
          );
        } else {
          console.log("✅ Supabase connection test successful");
        }
      });
  } catch (error) {
    console.error("❌ Error initializing Supabase:", error);
    alert("Lỗi khởi tạo Supabase: " + error.message);
    window.supabaseClient = null;
  }
}

// =====================================================
// HƯỚNG DẪN LẤY THÔNG TIN SUPABASE
// =====================================================
/*
1. Đăng nhập vào Supabase Dashboard: https://app.supabase.com
2. Chọn project của bạn
3. Vào Settings > API
4. Copy:
   - Project URL → thay vào SUPABASE_URL
   - anon/public key → thay vào SUPABASE_ANON_KEY
5. Save file này

VÍ DỤ:
const SUPABASE_URL = 'https://abcdefghijklmnop.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
*/
