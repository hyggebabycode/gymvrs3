// =====================================================
// AUTHENTICATION HANDLERS
// =====================================================

// Get supabase client
const supabaseClient = window.supabaseClient;

// Check if Supabase is initialized
if (!supabaseClient) {
  console.error("Supabase client not initialized!");
  alert(
    "Lỗi: Không thể kết nối đến server. Vui lòng kiểm tra kết nối internet và thử lại.",
  );
}

// Show alert message
function showAlert(message, type = "error") {
  const alertDiv = document.getElementById("alert-message");
  if (!alertDiv) return;

  alertDiv.classList.remove(
    "hidden",
    "bg-red-100",
    "bg-green-100",
    "bg-blue-100",
    "text-red-700",
    "text-green-700",
    "text-blue-700",
  );

  if (type === "success") {
    alertDiv.classList.add("bg-green-100", "text-green-700");
  } else if (type === "info") {
    alertDiv.classList.add("bg-blue-100", "text-blue-700");
  } else {
    alertDiv.classList.add("bg-red-100", "text-red-700");
  }

  alertDiv.innerHTML = `
        <div class="flex items-center gap-2">
            <span class="material-symbols-outlined">${type === "success" ? "check_circle" : type === "info" ? "info" : "error"}</span>
            <span>${message}</span>
        </div>
    `;
  alertDiv.classList.remove("hidden");

  // Auto hide after 5 seconds
  setTimeout(() => {
    alertDiv.classList.add("hidden");
  }, 5000);
}

// Hash password (simple version - in production use backend hashing)
async function hashPassword(password) {
  // For demo, we'll use a simple hash
  // In production, use bcrypt on backend
  const encoder = new TextEncoder();
  const data = encoder.encode(password);
  const hash = await crypto.subtle.digest("SHA-256", data);
  return Array.from(new Uint8Array(hash))
    .map((b) => b.toString(16).padStart(2, "0"))
    .join("");
}

// =====================================================
// LOGIN HANDLER
// =====================================================
document.getElementById("login-form")?.addEventListener("submit", async (e) => {
  e.preventDefault();

  const email = document.getElementById("login-email").value;
  const password = document.getElementById("login-password").value;
  const btnText = document.getElementById("login-btn-text");

  // Check if supabaseClient exists
  if (!supabaseClient) {
    showAlert(
      "Lỗi: Không thể kết nối đến server. Vui lòng kiểm tra kết nối internet.",
      "error",
    );
    return;
  }

  // Show loading
  btnText.textContent = "Đang đăng nhập...";

  try {
    // Query user from database
    const { data: users, error } = await supabaseClient
      .from("users")
      .select("*")
      .eq("email", email)
      .eq("is_active", true);

    console.log("Query result:", { users, error }); // Debug log

    if (error) {
      console.error("Database error:", error);
      showAlert("Lỗi kết nối database: " + error.message, "error");
      btnText.textContent = "Đăng nhập";
      return;
    }

    if (!users || users.length === 0) {
      showAlert("Email hoặc mật khẩu không đúng!", "error");
      btnText.textContent = "Đăng nhập";
      return;
    }

    const user = users[0];

    // Check password with bcrypt or plaintext
    let passwordMatch = false;

    try {
      // Check if password is a bcrypt hash
      if (
        user.password_hash.startsWith("$2a$") ||
        user.password_hash.startsWith("$2b$")
      ) {
        // It's a bcrypt hash - check if bcrypt is available
        if (typeof bcrypt !== "undefined" && bcrypt && bcrypt.compare) {
          passwordMatch = await bcrypt.compare(password, user.password_hash);
          console.log("✅ Used bcrypt comparison");
        } else {
          console.warn(
            "⚠️ Bcrypt not available, cannot verify hashed password",
          );
          showAlert(
            "Lỗi hệ thống: Không thể xác thực mật khẩu được mã hóa. Vui lòng thử lại sau.",
            "error",
          );
          btnText.textContent = "Đăng nhập";
          return;
        }
      } else {
        // It's plaintext (for backward compatibility)
        passwordMatch = user.password_hash === password;
        console.log("✅ Used plaintext comparison");
      }
    } catch (error) {
      console.error("Password comparison error:", error);
      // Fallback to plaintext comparison
      passwordMatch = user.password_hash === password;
      console.log("⚠️ Fallback to plaintext comparison");
    }

    if (!passwordMatch) {
      showAlert("Email hoặc mật khẩu không đúng!", "error");
      btnText.textContent = "Đăng nhập";
      return;
    }

    // Store user info in localStorage
    localStorage.setItem("gymheart_user", JSON.stringify(user));
    localStorage.setItem("gymheart_token", "demo_token_" + user.id);

    showAlert("Đăng nhập thành công! Đang chuyển hướng...", "success");

    // Redirect based on role
    setTimeout(() => {
      switch (user.role) {
        case "admin":
          window.location.href = "admin-dashboard.html";
          break;
        case "coach":
          window.location.href = "coach-dashboard.html";
          break;
        case "user":
          window.location.href = "user-dashboard.html";
          break;
        default:
          window.location.href = "index.html";
      }
    }, 1500);
  } catch (error) {
    console.error("Login error:", error);
    showAlert("Đã xảy ra lỗi! Vui lòng thử lại.", "error");
    btnText.textContent = "Đăng nhập";
  }
});

// =====================================================
// SIGNUP HANDLER
// =====================================================
document
  .getElementById("signup-form")
  ?.addEventListener("submit", async (e) => {
    e.preventDefault();

    const fullname = document.getElementById("signup-fullname").value;
    const email = document.getElementById("signup-email").value;
    const phone = document.getElementById("signup-phone").value;
    const password = document.getElementById("signup-password").value;
    const roleSelection = document.querySelector(
      'input[name="signup-role"]:checked',
    ).value;
    const btnText = document.getElementById("signup-btn-text");

    // Check if supabaseClient exists
    if (!supabaseClient) {
      showAlert(
        "Lỗi: Không thể kết nối đến server. Vui lòng kiểm tra kết nối internet.",
        "error",
      );
      return;
    }

    // Validate
    if (password.length < 6) {
      showAlert("Mật khẩu phải có ít nhất 6 ký tự!", "error");
      return;
    }

    // Show loading
    btnText.textContent = "Đang đăng ký...";

    try {
      // Check if email exists
      const { data: existingUser } = await supabaseClient
        .from("users")
        .select("id")
        .eq("email", email)
        .single();

      if (existingUser) {
        showAlert("Email đã được sử dụng!", "error");
        btnText.textContent = "Đăng ký";
        return;
      }

      // Hash password with bcrypt
      const hashedPassword = await bcrypt.hash(password, 10);

      // Insert new user with hashed password
      const userData = {
        email: email,
        password_hash: hashedPassword, // Lưu bcrypt hash
        full_name: fullname,
        phone: phone,
        role: "user",
        is_active: true,
        avatar_url: `https://ui-avatars.com/api/?name=${encodeURIComponent(fullname)}&background=f42559&color=fff&size=200`,
      };

      // Chỉ thêm requested_role nếu chọn coach
      if (roleSelection === "coach") {
        userData.requested_role = "coach";
      }

      const { data: newUser, error } = await supabaseClient
        .from("users")
        .insert([userData])
        .select()
        .single();

      if (error) {
        console.error("Signup error:", error);
        if (error.message && error.message.includes("requested_role")) {
          showAlert(
            "Lỗi: Vui lòng chạy SQL script add_coach_requests.sql trước! Xem file COACH_REQUEST_GUIDE.md",
            "error",
          );
        } else {
          showAlert("Đăng ký thất bại! " + error.message, "error");
        }
        btnText.textContent = "Đăng ký";
        return;
      }

      // Success message based on role selection
      if (roleSelection === "coach") {
        showAlert(
          "Đăng ký thành công! Yêu cầu làm PT đã được gửi tới Admin. Vui lòng đợi phê duyệt.",
          "success",
        );
      } else {
        showAlert("Đăng ký thành công! Vui lòng đăng nhập.", "success");
      }

      // Reset form
      document.getElementById("signup-form").reset();

      // Switch to login tab after 2 seconds
      setTimeout(() => {
        switchTab("login");
        // Pre-fill email
        document.getElementById("login-email").value = email;
      }, 2000);
    } catch (error) {
      console.error("Signup error:", error);
      showAlert("Đã xảy ra lỗi! Vui lòng thử lại.", "error");
      btnText.textContent = "Đăng ký";
    }
  });

// =====================================================
// CHECK AUTHENTICATION
// =====================================================
function checkAuth() {
  const token = localStorage.getItem("gymheart_token");
  const user = localStorage.getItem("gymheart_user");

  if (!token || !user) {
    return null;
  }

  return JSON.parse(user);
}

// Clear old session when on auth page
function clearOldSessionOnAuthPage() {
  // If we're on auth.html and user manually navigated here, clear old session
  if (window.location.pathname.includes("auth.html")) {
    // Check if there's a stored user
    const oldUser = checkAuth();
    if (oldUser) {
      // Clear the old session to allow fresh login
      localStorage.removeItem("gymheart_token");
      localStorage.removeItem("gymheart_user");
      console.log("Cleared old session for fresh login");
    }
  }
}

// Redirect if already logged in
function redirectIfAuthenticated() {
  const user = checkAuth();
  if (user && window.location.pathname.includes("auth.html")) {
    switch (user.role) {
      case "admin":
        window.location.href = "admin-dashboard.html";
        break;
      case "coach":
        window.location.href = "coach-dashboard.html";
        break;
      case "user":
        window.location.href = "user-dashboard.html";
        break;
    }
  }
}

// Require authentication for dashboard pages
function requireAuth() {
  const user = checkAuth();
  if (!user) {
    window.location.href = "auth.html";
    return null;
  }
  return user;
}

// Logout function
function logout() {
  localStorage.removeItem("gymheart_token");
  localStorage.removeItem("gymheart_user");
  window.location.href = "index.html";
}

// Run on page load
if (document.readyState === "loading") {
  document.addEventListener("DOMContentLoaded", () => {
    clearOldSessionOnAuthPage();
    checkSupabaseConnection();
  });
} else {
  clearOldSessionOnAuthPage();
  checkSupabaseConnection();
}

// Check Supabase connection on page load
function checkSupabaseConnection() {
  setTimeout(() => {
    if (!window.supabaseClient) {
      showAlert(
        "⚠️ Không thể kết nối đến server. Vui lòng kiểm tra:\n1. Kết nối internet\n2. Mở DevTools (F12) để xem chi tiết lỗi\n3. Thử reload lại trang",
        "error",
      );
    }
  }, 1000);
}

// Export functions
window.checkAuth = checkAuth;
window.requireAuth = requireAuth;
window.logout = logout;
window.showAlert = showAlert;
