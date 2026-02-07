// =====================================================
// SUPABASE CONFIGURATION
// =====================================================
// Cấu hình kết nối tới Supabase
// Thay đổi SUPABASE_URL và SUPABASE_ANON_KEY bằng thông tin của bạn

const SUPABASE_URL = "https://ytfudwxzvbaltgspbngi.supabase.co";
const SUPABASE_ANON_KEY =
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl0ZnVkd3h6dmJhbHRnc3BibmdpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzAyODQxNjEsImV4cCI6MjA4NTg2MDE2MX0.bkrppG190FxNDd_ZTNAWQNPzDJHKmkgMx1c9VhIzzcg";

// Log để debug
console.log("Initializing Supabase with URL:", SUPABASE_URL);

// Check if supabase library is loaded
if (typeof window.supabase === "undefined") {
  console.error("Supabase library not loaded! Check CDN link.");
} else {
  // Khởi tạo Supabase client
  const supabase = window.supabase.createClient(
    SUPABASE_URL,
    SUPABASE_ANON_KEY,
  );

  // Export để sử dụng ở các file khác
  window.supabaseClient = supabase;

  console.log("Supabase client initialized successfully:", supabase);
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
