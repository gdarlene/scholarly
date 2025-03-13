<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            min-height: 100vh;
            background-color: #f9fafb;
            font-family: Arial, sans-serif;
        }
        .header {
            width: 100%;
            padding: 1rem 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .logo {
            font-size: 1.5rem;
            font-weight: bold;
        }
        .header-right {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        .main-content {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: calc(100vh - 4rem);
            padding: 1rem;
            position: relative;
        }
        .login-card {
            background: white;
            border-radius: 0.5rem;
            padding: 2rem;
            width: 100%;
            max-width: 28rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .card-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        .card-title {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 1rem;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .input-field {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid #e5e7eb;
            border-radius: 9999px;
            background: #f9fafb;
            outline: none;
        }
        .input-field:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.1);
        }
        .password-field {
            position: relative;
        }
        .eye-icon {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
        }
        .submit-button {
            width: 100%;
            padding: 0.75rem;
            background: #3b82f6;
            color: white;
            border: none;
            border-radius: 9999px;
            font-weight: 500;
            cursor: pointer;
        }
        .submit-button:hover {
            background: #2563eb;
        }
        .signup-text {
            text-align: center;
            margin-top: 1rem;
            font-size: 0.875rem;
        }
        .signup-link {
            color: #3b82f6;
            text-decoration: none;
        }
        .signup-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="logo">Scholarly</div>
        <div class="header-right">
            <img src="${pageContext.request.contextPath}/images/globe.svg" alt="Language" width="20" height="20">
            <a href="${pageContext.request.contextPath}/register" class="signup-link">Sign up</a>
        </div>
    </header>

    <main class="main-content">
        <div class="login-card">
            <div class="card-header">
                <h1 class="card-title">Login to your account</h1>
                <img src="${pageContext.request.contextPath}/images/penguin-logo.svg" alt="Scholarly Logo" width="40" height="40">
            </div>

            <form action="${pageContext.request.contextPath}/login" method="POST">
                <div class="form-group">
                    <input type="text" name="username" placeholder="Username or email" class="input-field" required>
                </div>

                <div class="form-group password-field">
                    <input type="password" name="password" placeholder="Password" class="input-field" required>
                    <img src="${pageContext.request.contextPath}/images/eye.svg" alt="Show password" class="eye-icon" width="20" height="20">
                </div>

                <button type="submit" class="submit-button">Login</button>
            </form>

            <div class="signup-text">
                Don't have an account? 
                <a href="${pageContext.request.contextPath}/register" class="signup-link">Sign up</a>
            </div>
        </div>
    </main>
</body>
</html>