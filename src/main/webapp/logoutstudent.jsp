<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logged Out</title>
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
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
            position: relative;
            min-height: calc(100vh - 4rem);
        }
        .logout-card {
            background: white;
            border-radius: 0.5rem;
            padding: 2rem;
            width: 100%;
            max-width: 28rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            text-align: center;
        }
        .card-header {
            margin-bottom: 1.5rem;
        }
        .card-title {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 1rem;
        }
        .login-button {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            background: #3b82f6;
            color: white;
            text-decoration: none;
            border-radius: 9999px;
            font-weight: 500;
        }
        .login-button:hover {
            background: #2563eb;
        }
        .decorative-element {
            position: absolute;
        }
        .balloon {
            left: 5rem;
            top: 5rem;
        }
        .map-pin {
            right: 10rem;
            top: 10rem;
        }
        .signpost {
            left: 10rem;
            bottom: 10rem;
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="logo">Scholarly</div>
        <div class="header-right">
            <img src="${pageContext.request.contextPath}/images/globe.svg" alt="Language" width="20" height="20">
            <a href="${pageContext.request.contextPath}/register" class="login-button">Sign up</a>
        </div>
    </header>

    <main class="main-content">
        <!-- Decorative elements -->
        <div class="decorative-element balloon">
            <img src="${pageContext.request.contextPath}/images/hot-air-balloon.svg" 
                 alt="Hot air balloon" 
                 width="120" height="120">
        </div>

        <div class="decorative-element map-pin">
            <img src="${pageContext.request.contextPath}/images/map-pin.svg" 
                 alt="Map pin" 
                 width="80" height="80">
        </div>

        <div class="decorative-element signpost">
            <img src="${pageContext.request.contextPath}/images/signpost.svg" 
                 alt="Signpost" 
                 width="100" height="100">
        </div>

        <!-- Logout card -->
        <div class="logout-card">
            <div class="card-header">
                <h1 class="card-title">You have been logged out</h1>
                <img src="${pageContext.request.contextPath}/images/penguin-logo.svg" 
                     alt="Scholarly Logo" 
                     width="40" height="40">
            </div>

            <a href="${pageContext.request.contextPath}/login" class="login-button">Login Again</a>
        </div>
    </main>
</body>
</html>