<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin Login - Wonders of Wildlife</title>
  <link href="style1.css" rel="stylesheet">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Cormorant:ital,wght@0,300..700;1,300..700&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
  <style>
    .loginbg {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      z-index: -1;
      overflow: hidden;
    }

    .loginbg video {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    body.login {
      font-family: "Cormorant", serif;
      margin: 0;
      padding: 0;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
    }

    .login-main {
      width: 320px;
      padding: 40px;
      background-color: rgba(154, 205, 50, 0.92);
      border-radius: 14px;
      text-align: center;
      box-shadow: 0 10px 30px rgba(0,0,0,0.4);
      backdrop-filter: blur(4px);
    }

    .login-main h1 {
      color: #1e4620;
      font-size: 28px;
      margin-bottom: 8px;
    }

    .login-main p.subtitle {
      color: #2e5520;
      font-size: 16px;
      margin-bottom: 20px;
    }

    .login-main .field-label {
      display: block;
      text-align: left;
      font-weight: bold;
      color: #1e4620;
      margin-top: 12px;
      font-size: 17px;
    }

    .login-main input {
      width: 100%;
      padding: 10px 12px;
      margin: 6px 0 12px 0;
      color: black;
      border: 1px solid #7cb342;
      border-radius: 6px;
      box-sizing: border-box;
      font-size: 15px;
      background: white;
    }

    .login-btn {
      background-color: #2e7d32;
      color: white;
      border: none;
      padding: 11px 24px;
      margin-top: 15px;
      border-radius: 6px;
      cursor: pointer;
      font-size: 18px;
      font-weight: bold;
      width: 100%;
      transition: 0.3s;
    }

    .login-btn:hover {
      background-color: #1b5e20;
    }

    .back-link {
      display: inline-block;
      margin-top: 20px;
      color: #1e4620;
      font-weight: bold;
      text-decoration: none;
      font-size: 16px;
    }

    .back-link:hover {
      text-decoration: underline;
    }

    .error-box {
      background: #ffebee;
      color: #c62828;
      padding: 10px;
      border-radius: 6px;
      margin-bottom: 15px;
      font-size: 15px;
      border: 1px solid #ffcdd2;
    }

    .info-box {
      background: rgba(255, 255, 255, 0.7);
      padding: 8px;
      border-radius: 6px;
      margin-top: 15px;
      font-size: 13px;
      color: #333;
      font-family: 'Roboto', sans-serif;
    }
  </style>
</head>
<body class="login">

  <div class="loginbg">
    <video autoplay loop muted playsinline> 
      <source src="loginbg.mp4" type="video/mp4">
    </video>
  </div>

  <form class="login-main" action="admin-login" method="POST">
    <h1>Wildlife Portal</h1>
    <p class="subtitle">🔒 Administrator Access</p>

    <% if ("invalid".equals(request.getParameter("error"))) { %>
      <div class="error-box">❌ Invalid username or password! Please try again.</div>
    <% } else if ("logged_out".equals(request.getParameter("msg"))) { %>
      <div style="background:#e8f5e9; color:#2e7d32; padding:8px; border-radius:6px; margin-bottom:15px; font-size:14px;">
        👋 You have been safely logged out.
      </div>
    <% } %>

    <label class="field-label" for="uname">Username</label>
    <input type="text" id="uname" name="username" placeholder="Enter admin username" required>

    <label class="field-label" for="pass">Password</label>
    <input type="password" id="pass" name="password" placeholder="Enter admin password" required>

    <button type="submit" class="login-btn">Log In to Admin Panel</button>

    <div class="info-box">
      <strong>Credentials:</strong><br>
      User: <code>admin</code> / Pass: <code>admin123</code><br>
      (or <code>wildlife123</code> / <code>tiger123</code>)
    </div>

    <a href="home.jsp" class="back-link">← Return to Public Website</a>
  </form>

</body>
</html>
