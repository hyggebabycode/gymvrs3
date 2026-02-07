// =====================================================
// AUTHENTICATION HANDLERS
// =====================================================

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
// GOOGLE LOGIN HANDLER
// =====================================================
async function loginWithGoogle() {
  const btnText = document.getElementById("google-btn-text");
  if (btnText) btnText.textContent = "Đang kết nối với Google...";

  try {
    const { data, error } = await supabaseClient.auth.signInWithOAuth({
      provider: 'google',
      options: {
        redirectTo: window.location.origin + '/auth.html',
        queryParams: {
          access_type: 'offline',
          prompt: 'consent',
        },
      },
    });

    if (error) throw error;
  } catch (error) {
    console.error('Google login error:', error);
    showAlert('Lỗi khi đăng nhập với Google: ' + error.message, 'error');
    if (btnText) btnText.textContent = "Đăng nhập với Google";
  }
}

// Handle OAuth callback
async function handleOAuthCallback() {
  try {
    const { data: { session }, error } = await supabaseClient.auth.getSession();
    
    if (error) throw error;
    
    if (session) {
      const oauthUser = session.user;
      
      // Check if user exists in our database
      const { data: existingUser, error: queryError } = await supabaseClient
        .from('users')
        .select('*')
        .eq('email', oauthUser.email)
        .single();

      let userData;

      if (existingUser) {
        // User exists, use existing data
        userData = existingUser;
        
        // Update last login
        await supabaseClient
          .from('users')
          .update({ updated_at: new Date().toISOString() })
          .eq('id', existingUser.id);
      } else {
        // Create new user from Google data
        const newUserData = {
          email: oauthUser.email,
          full_name: oauthUser.user_metadata.full_name || oauthUser.user_metadata.name || 'User',
          avatar_url: oauthUser.user_metadata.avatar_url || oauthUser.user_metadata.picture || null,
          role: 'user',
          is_active: true,
          password_hash: 'oauth_user', // Placeholder for OAuth users
        };

        const { data: newUser, error: insertError } = await supabaseClient
          .from('users')
          .insert([newUserData])
          .select()
          .single();

        if (insertError) throw insertError;
        userData = newUser;
      }

      // Store user info in localStorage
      localStorage.setItem('gymheart_user', JSON.stringify(userData));
      localStorage.setItem('gymheart_token', 'oauth_token_' + userData.id);

      showAlert('Đăng nhập thành công! Đang chuyển hướng...', 'success');

      // Redirect based on role
      setTimeout(() => {
        switch (userData.role) {
          case 'admin':
            window.location.href = 'admin-dashboard.html';
            break;
          case 'coach':
            window.location.href = 'coach-dashboard.html';
            break;
          case 'user':
            window.location.href = 'user-dashboard.html';
            break;
          default:
            window.location.href = 'index.html';
        }
      }, 1500);
    }
  } catch (error) {
    console.error('OAuth callback error:', error);
    showAlert('Lỗi xác thực: ' + error.message, 'error');
  }
}

// Check for OAuth callback on page load
if (window.location.pathname.includes('auth.html')) {
  supabaseClient.auth.getSession().then(({ data: { session } }) => {
    if (session) {
      handleOAuthCallback();
    }
  });
}

// Export Google login function
window.loginWithGoogle = loginWithGoogle;

// =====================================================
// LOGIN HANDLER
// =====================================================
document.getElementById("login-form")?.addEventListener("submit", async (e) => {
  e.preventDefault();

  const email = document.getElementById("login-email").value;
  const password = document.getElementById("login-password").value;
  const btnText = document.getElementById("login-btn-text");

  // Show loading
  btnText.textContent = "Đang đăng nhập...";

  try {
    // Query user from database
    const { data: users, error } = await supabaseClient
      .from("users")
      .select("*")
      .eq("email", email)
      .eq("is_active", true)
      .single();

    console.log("Query result:", { users, error }); // Debug log

    if (error) {
      console.error("Database error:", error);
      showAlert("Lỗi kết nối database: " + error.message, "error");
      btnText.textContent = "Đăng nhập";
      return;
    }

    if (!users) {
      showAlert("Email hoặc mật khẩu không đúng!", "error");
      btnText.textContent = "Đăng nhập";
      return;
    }

    // Check password (plaintext comparison for demo)
    if (users.password_hash !== password) {
      showAlert("Email hoặc mật khẩu không đúng!", "error");
      btnText.textContent = "Đăng nhập";
      return;
    }

    // Store user info in localStorage
    localStorage.setItem("gymheart_user", JSON.stringify(users));
    localStorage.setItem("gymheart_token", "demo_token_" + users.id);

    showAlert("Đăng nhập thành công! Đang chuyển hướng...", "success");

    // Redirect based on role
    setTimeout(() => {
      switch (users.role) {
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

      // Insert new user (plaintext password for demo)
      const userData = {
        email: email,
        password_hash: password, // Lưu plaintext cho đơn giản
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
  });
} else {
  clearOldSessionOnAuthPage();
}

// Export functions
window.checkAuth = checkAuth;
window.requireAuth = requireAuth;
window.logout = logout;
window.showAlert = showAlert;
