<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Registration - Scholarly</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
        }

        body {
            min-height: 100vh;
            display: flex;
            background-color: #ffffff;
        }

        .split-layout {
            display: flex;
            width: 100%;
        }

        /* Left side - Illustration */
        .illustration-side {
            flex: 1;
            background-color: #f8f9fa;
            padding: 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .illustration {
            max-width: 80%;
            height: auto;
        }

        /* Right side - Form */
        .form-side {
            flex: 1;
            padding: 3rem;
            display: flex;
            flex-direction: column;
        }

        .registration-header {
            margin-bottom: 2.5rem;
        }

        .registration-header h1 {
            font-size: 1.75rem;
            color: #202124;
            position: relative;
            display: inline-block;
        }

        .registration-header h1::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 0;
            width: 100%;
            height: 4px;
            background-color: #ffd700;
            border-radius: 2px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-group label {
            font-size: 0.9rem;
            color: #202124;
            margin-bottom: 0.5rem;
        }

        .form-group input {
            padding: 0.75rem;
            border: 1px solid #e0e0e0;
            border-radius: 0.5rem;
            font-size: 1rem;
            background-color: #ffffff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .form-group input:focus {
            outline: none;
            border-color: #1a73e8;
            box-shadow: 0 0 0 2px rgba(26, 115, 232, 0.1);
        }

        .form-group input::placeholder {
            color: #9aa0a6;
        }

        .gender-options {
            display: flex;
            gap: 2rem;
            margin-top: 0.5rem;
        }

        .gender-option {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .gender-option input[type="radio"] {
            width: 18px;
            height: 18px;
            accent-color: #1a73e8;
        }

        .gender-option label {
            margin: 0;
            font-size: 1rem;
            color: #5f6368;
        }

        .finish-btn {
            margin-top: 2rem;
            width: 100%;
            padding: 1rem;
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 2rem;
            font-size: 1.1rem;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .finish-btn:hover {
            background-color: #1557b0;
        }

        .form-group select {
            padding: 0.75rem;
            border: 1px solid #e0e0e0;
            border-radius: 0.5rem;
            font-size: 1rem;
            background-color: #ffffff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='%235f6368' viewBox='0 0 16 16'%3E%3Cpath d='M8 11L3 6h10l-5 5z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 1rem center;
            cursor: pointer;
        }

        .form-group select:focus {
            outline: none;
            border-color: #1a73e8;
            box-shadow: 0 0 0 2px rgba(26, 115, 232, 0.1);
        }

        @media (max-width: 768px) {
            .split-layout {
                flex-direction: column;
            }

            .illustration-side {
                display: none;
            }

            .form-side {
                padding: 1.5rem;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="split-layout">
    <!-- Left side - Illustration -->
    <div class="illustration-side">
        <img src="${pageContext.request.contextPath}/resources/public/teacher-illustration.svg" alt="Teacher Illustration" class="illustration">
    </div>

    <!-- Right side - Form -->
    <div class="form-side">
        <div class="registration-header">
            <h1>REGISTRATION</h1>
        </div>

        <form class="registration-form" action="/login" method="POST">

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="Type here..." required>
                </div>




                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Type here..." required>
                </div>


            <button type="submit" class="finish-btn">
                Finish <span>›</span>
            </button>
        </form>
    </div>
</div>


</body>
</html>