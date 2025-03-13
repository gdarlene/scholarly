<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Dashboard - Scholarly</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
        }

        body {
            background-color: #f8f9fa;
            min-height: 100vh;
        }

        /* Navigation */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
            background: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .logo {
            height: 40px;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .language-switch {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            background-color: #f0f0f0;
            padding: 0.25rem 0.5rem;
            border-radius: 1rem;
            cursor: pointer;
        }

        .teacher-profile {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            position: relative;
        }

        .profile-initial {
            width: 35px;
            height: 35px;
            background: #e8f0fe;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #1a73e8;
            font-weight: 500;
        }

        .notification-bell {
            color: #5f6368;
            font-size: 1.25rem;
            cursor: pointer;
        }

        /* Dropdown Menu */
        .dropdown-menu {
            position: absolute;
            top: 100%;
            right: 0;
            background: white;
            border-radius: 0.5rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            min-width: 200px;
            display: none;
            z-index: 1000;
        }

        .dropdown-menu.active {
            display: block;
        }

        .dropdown-item {
            padding: 0.75rem 1rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            color: #202124;
            text-decoration: none;
            transition: background-color 0.2s;
        }

        .dropdown-item:hover {
            background-color: #f8f9fa;
        }

        .dropdown-item i {
            color: #5f6368;
            width: 20px;
        }

        /* Sidebar */
        .layout-container {
            display: flex;
            min-height: calc(100vh - 72px);
        }

        .sidebar {
            width: 250px;
            background: white;
            padding: 2rem 1rem;
            border-right: 1px solid #e0e0e0;
        }

        .create-category {
            background: #f8f9fa;
            border-radius: 0.5rem;
            padding: 1rem;
            margin-bottom: 2rem;
        }

        .create-btn {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #202124;
            text-decoration: none;
            font-weight: 500;
        }

        .nav-items {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem;
            border-radius: 0.5rem;
            color: #5f6368;
            text-decoration: none;
            transition: background-color 0.2s;
        }

        .nav-item.active {
            background: #e8f0fe;
            color: #1a73e8;
        }

        .nav-item:hover {
            background: #f8f9fa;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            padding: 2rem;
        }

        .welcome-section {
            background: #e8f0fe;
            border-radius: 1rem;
            padding: 2rem;
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .welcome-text h1 {
            font-size: 2rem;
            color: #202124;
            margin-bottom: 0.5rem;
        }

        .welcome-text p {
            color: #5f6368;
        }

        .teacher-illustration {
            width: 200px;
            height: auto;
        }

        /* Statistics Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: 1rem;
            padding: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .yellow-bg {
            background: #ffd700;
        }

        .purple-bg {
            background: #9c27b0;
        }

        .gray-bg {
            background: #757575;
        }

        .stat-info h3 {
            font-size: 2rem;
            color: #202124;
            margin-bottom: 0.25rem;
        }

        .stat-info p {
            color: #5f6368;
            font-size: 0.9rem;
        }

        /* Assignments Section */
        .assignments-section h2 {
            font-size: 1.5rem;
            color: #202124;
            margin-bottom: 1.5rem;
        }

        .assignment-card {
            background: white;
            border-radius: 1rem;
            padding: 1.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1rem;
        }

        .assignment-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .assignment-book {
            width: 60px;
            height: 80px;
            object-fit: cover;
            border-radius: 0.5rem;
        }

        .assignment-details h3 {
            color: #202124;
            margin-bottom: 0.5rem;
        }

        .assignment-details p {
            color: #5f6368;
            font-size: 0.9rem;
        }

        .view-more-btn {
            background: #1a73e8;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 2rem;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.2s;
        }

        .view-more-btn:hover {
            background: #1557b0;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <img src="${pageContext.request.contextPath}/resources/public/scholarly-logo.png" alt="Scholarly" class="logo">
        <div class="nav-right">
            <div class="language-switch">
                <img src="${pageContext.request.contextPath}/resources/public/globe.png" alt="Language" width="20">
                <span>ENG</span>
            </div>
            <div class="teacher-profile">
                <div class="profile-initial">LM</div>
                <span class="teacher-name">Teacher name</span>
                <i class="notification-bell">🔔</i>
                <button onclick="toggleDropdown()" class="dropdown-toggle">▼</button>
                <div id="profileDropdown" class="dropdown-menu">

                    <a href="./Profile.jsp" class="dropdown-item">
                        <i>👤</i>
                        <span>Profile</span>
                    </a>
                    <a href="./index.jsp" class="dropdown-item">
                        <i>🚪</i>
                        <span>Logout</span>
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <div class="layout-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="create-category">
                <a href="#" class="create-btn">
                    <span>+</span>
                    <span>Create New Category</span>
                </a>
            </div>
            <nav class="nav-items">
                <a href="./TeacherDashboard.jsp" class="nav-item active">
                    <img src="${pageContext.request.contextPath}/resources/public/Vector.png">
                    <span>Dashboard</span>
                </a>
                <a href="./assignments.jsp" class="nav-item">
                   <img src="${pageContext.request.contextPath}/resources/public/rectangle-list-solid 1.png">
                    <span>Assignments</span>
                </a>
                <a href="./Submission.jsp" class="nav-item">
                    <img src="${pageContext.request.contextPath}/resources/public/boxes-packing-solid 1.png">
                    <span>Class Management</span>
                </a>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <section class="welcome-section">
                <div class="welcome-text">
                    <h1>Hi, Emmanuel</h1>
                    <p>Ready to create assignments or correct any submitted assignments?</p>
                </div>
                <img src="${pageContext.request.contextPath}/resources/public/teacher-dashboard.svg" alt="Teacher" class="teacher-illustration">
            </section>

            <section class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon yellow-bg">📊</div>
                    <div class="stat-info">
                        <h3>54%</h3>
                        <p>Graded Assignments</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon purple-bg">📚</div>
                    <div class="stat-info">
                        <h3>20</h3>
                        <p>Student Progress</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon gray-bg">✏️</div>
                    <div class="stat-info">
                        <h3>67</h3>
                        <p>Submissions count</p>
                    </div>
                </div>
            </section>

            <section class="assignments-section">
                <h2>Overview</h2>
                <div class="assignment-card">
                    <div class="assignment-info">
                        <img src="${pageContext.request.contextPath}/resources/public/dsa-book.jpg" alt="DSA Book" class="assignment-book">
                        <div class="assignment-details">
                            <h3>DSA Assignment on stacks</h3>
                            <p>Deadline: 23 March 2025</p>
                        </div>
                    </div>
                    <a href="./assignments.jsp" class="view-more-btn">View more ›</a>
                </div>
                <div class="assignment-card">
                    <div class="assignment-info">
                        <img src="${pageContext.request.contextPath}/resources/public/dsa-book.jpg" alt="DSA Book" class="assignment-book">
                        <div class="assignment-details">
                            <h3>DSA Assignment on queue</h3>
                            <p>Deadline: 01 April 2025</p>
                        </div>
                    </div>
                    <a href="./assignments.jsp" class="view-more-btn">View more ›</a>
                </div>
            </section>
        </main>
    </div>

    <script>
        // Dropdown functionality
        function toggleDropdown() {
            const dropdown = document.getElementById('profileDropdown');
            dropdown.classList.toggle('active');
        }

        // Close dropdown when clicking outside
        window.addEventListener('click', function(e) {
            const dropdown = document.getElementById('profileDropdown');
            const teacherProfile = document.querySelector('.teacher-profile');
            if (!teacherProfile.contains(e.target)) {
                dropdown.classList.remove('active');
            }
        });

        // Update current date
        const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
        const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
        const now = new Date();
        const dateString = `${days[now.getDay()]}, ${now.getDate()} ${months[now.getMonth()]} ${now.getFullYear()}`;
        document.querySelector('.date').textContent = dateString;
    </script>
</body>
</html> 