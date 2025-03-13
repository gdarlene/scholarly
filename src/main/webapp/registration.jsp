<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration - Scholarly</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
        }

        body {
            background-color: rgba(0, 0, 0, 0.5);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .modal {
            background: white;
            border-radius: 1rem;
            padding: 3rem;
            width: 90%;
            max-width: 500px;
            position: relative;
        }

        .close-btn {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: #202124;
        }

        .modal-title {
            font-size: 2rem;
            color: #202124;
            text-align: center;
            margin-bottom: 2rem;
        }

        .role-options {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .role-option {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            border: 2px solid #e0e0e0;
            border-radius: 0.5rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .role-option:hover {
            border-color: #1a73e8;
            background-color: #f8f9fa;
        }

        .role-option input[type="radio"] {
            width: 20px;
            height: 20px;
            accent-color: #1a73e8;
        }

        .role-option label {
            font-size: 1.25rem;
            color: #202124;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="modal">
        <button class="close-btn" onclick="closeModal()">×</button>
        <h2 class="modal-title">What's your role?</h2>
        <form id="roleForm">
            <div class="role-options">
                <div class="role-option" onclick="selectRole('teacher')">
                    <input type="radio" id="teacher" name="role" value="teacher">
                    <label for="teacher">Teacher</label>
                </div>
                <div class="role-option" onclick="selectRole('student')">
                    <input type="radio" id="student" name="role" value="student">
                    <label for="student">Student</label>
                </div>
            </div>
        </form>
    </div>

    <script>
        function closeModal() {
            // You can implement close behavior here
            window.location.href = 'login.jsp';
        }

        function selectRole(role) {
            document.getElementById(role).checked = true;
            // Redirect to appropriate registration page
            if (role === 'teacher') {
                window.location.href = 'teacherRegistration.jsp';
            } else {
                window.location.href = 'studentRegistration.jsp';
            }
        }
    </script>
</body>
</html> 