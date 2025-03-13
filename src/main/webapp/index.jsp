<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scholarly - Submission Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
        }

        body {
            background-color: #ffffff;
            background-image:
                radial-gradient(#f0f0f0 1px, transparent 1px),
                radial-gradient(#f0f0f0 1px, transparent 1px);
            background-size: 20px 20px;
            background-position: 0 0, 10px 10px;
        }

        .navbar {
            display: flex;
            justify-content: flex-end;
            padding: 1rem 2rem;
            align-items: center;
            gap: 1rem;
        }

        .language-switch {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            background-color: #f0f0f0;
            padding: 0.25rem 0.5rem;
            border-radius: 1rem;
        }

        .login-btn {
            background-color: #1a73e8;
            color: white;
            padding: 0.5rem 1.5rem;
            border-radius: 2rem;
            text-decoration: none;
            font-weight: 500;
        }

        .main-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 80vh;
            text-align: center;
            padding: 2rem;
        }

        .logo {
            width: 60px;
            margin-bottom: 2rem;
        }

        h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        h1 span {
            color: #1a73e8;
        }

        .subtitle {
            font-size: 1.25rem;
            color: #5f6368;
            margin-bottom: 2rem;
        }

        .get-started-btn {
            background-color: #1a73e8;
            color: white;
            padding: 1rem 2rem;
            border-radius: 2rem;
            text-decoration: none;
            font-size: 1.25rem;
            font-weight: 500;
            transition: background-color 0.3s;
        }

        .get-started-btn:hover {
            background-color: #1557b0;
        }

        .globe-icon {
            width: 20px;
            height: 20px;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <a href="#" class="login-btn">Login</a>
    </nav>

    <main class="main-content">
        <img src="${pageContext.request.contextPath}/resources/public/penguin-logo.png" alt="Scholarly Logo" class="logo">
        <h1>Welcome to <span>Scholarly</span></h1>
        <p class="subtitle">Submission management system for scholars and teachers</p>
        <a href="./registration.jsp" class="get-started-btn">Get Started</a>
    </main>
</body>
</html>