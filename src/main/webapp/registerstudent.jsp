<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            min-height: 100vh;
            background: white;
            font-family: Arial, sans-serif;
            display: flex;
        }
        .illustration-side {
            display: none;
            width: 50%;
            position: relative;
            background: #f9fafb;
        }
        @media (min-width: 768px) {
            .illustration-side {
                display: block;
            }
        }
        .form-side {
            width: 100%;
            padding: 2rem;
            display: flex;
            flex-direction: column;
        }
        @media (min-width: 768px) {
            .form-side {
                width: 50%;
            }
        }
        .header {
            text-align: center;
            margin-bottom: 3rem;
        }
        .title {
            font-size: 1.5rem;
            font-weight: bold;
        }
        .yellow-line {
            width: 3rem;
            height: 0.25rem;
            background: #fbbf24;
            margin: 0.5rem auto;
        }
        .form-grid {
            display: grid;
            grid-template-columns: repeat(1, 1fr);
            gap: 1.5rem;
        }
        @media (min-width: 640px) {
            .form-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-label {
            display: block;
            font-weight: 500;
            margin-bottom: 0.5rem;
        }
        .input-field {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid #e5e7eb;
            border-radius: 9999px;
            background: white;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }
        .radio-group {
            display: flex;
            gap: 1rem;
            margin-top: 0.5rem;
        }
        .radio-option {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .error-message {
            color: #ef4444;
            margin-top: 1rem;
        }
        .submit-button {
            width: 100%;
            padding: 1.5rem;
            background: #3b82f6;
            color: white;
            border: none;
            border-radius: 9999px;
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            margin-top: 3rem;
        }
        .submit-button:hover {
            background: #2563eb;
        }
    </style>
</head>
<body>
    <div class="illustration-side">
        <img src="${pageContext.request.contextPath}/images/registration-illustration.svg" 
             alt="Registration" 
             style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);"
             width="500" height="500">
    </div>

    <div class="form-side">
        <div class="header">
            <h1 class="title">REGISTRATION</h1>
            <div class="yellow-line"></div>
        </div>

        <form action="${pageContext.request.contextPath}/register" method="POST">
            <div class="form-grid">
                <div class="form-group">
                    <label class="form-label">Username</label>
                    <input type="text" name="userName" class="input-field" placeholder="Type here..." required>
                </div>

                <div class="form-group">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="input-field" placeholder="Type here..." required>
                </div>

                <div class="form-group">
                    <label class="form-label">Class</label>
                    <input type="text" name="classRoom" class="input-field" placeholder="Type here..." required>
                </div>

                <div class="form-group">
                    <label class="form-label">Phone Number</label>
                    <input type="tel" name="phoneNumber" class="input-field" placeholder="Type here..." required>
                </div>

                <div class="form-group">
                    <label class="form-label">Set Password</label>
                    <input type="password" name="password" class="input-field" placeholder="Type here..." required>
                </div>

                <div class="form-group">
                    <label class="form-label">Confirm Password</label>
                    <input type="password" name="confirmPassword" class="input-field" placeholder="Type here..." required>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Gender</label>
                <div class="radio-group">
                    <div class="radio-option">
                        <input type="radio" name="gender" value="male" id="male" checked>
                        <label for="male">Male</label>
                    </div>
                    <div class="radio-option">
                        <input type="radio" name="gender" value="female" id="female">
                        <label for="female">Female</label>
                    </div>
                    <div class="radio-option">
                        <input type="radio" name="gender" value="other" id="other">
                        <label for="other">Rather not say</label>
                    </div>
                </div>
            </div>

            <% if(request.getAttribute("error") != null) { %>
                <div class="error-message">${error}</div>
            <% } %>

            <button type="submit" class="submit-button">
                Finish
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M9 18l6-6-6-6"/>
                </svg>
            </button>
        </form>
    </div>
</body>
</html>