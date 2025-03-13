<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assignments - Scholarly</title>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            fetchAssignments();
        });

        function fetchAssignments() {
            const option = document.getElementById("assignmentType").value;
            let servletUrl = "";

            // Assign different servlets for different options
            if (option === "homework") {
                servletUrl = 'HomeworkServlet';
            } else if (option === "project") {
                servletUrl = 'ProjectServlet';
            } else if (option === "exam") {
                servletUrl = 'ExamServlet';
            } else {
                servletUrl = 'AssignmentServlet'; // Default servlet
            }

            fetch(servletUrl)
                .then(response => response.json())
                .then(assignments => {
                    const listContainer = document.getElementById("assignmentsList");
                    listContainer.innerHTML = ""; // Clear previous content
                    assignments.forEach(assignment => {
                        const card = `
                            <div class="assignment-card">
                                <div class="assignment-info">
                                    <img src="resources/public/book.png" class="assignment-book">
                                    <div class="assignment-details">
                                        <h3>${assignment.title}</h3>
                                        <p>${assignment.description}</p>
                                        <p><strong>Due:</strong> ${assignment.dueDate}</p>
                                    </div>
                                </div>
                                <a href="#" class="view-more-btn">View More</a>
                            </div>`;
                        listContainer.innerHTML += card;
                    });
                })
                .catch(error => console.error('Error fetching assignments:', error));
        }
    </script>
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

        /* Layout */
        .layout-container {
            display: flex;
            min-height: calc(100vh - 72px);
        }

        /* Sidebar */
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
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .create-category:hover {
            background: #e8e8e8;
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

        /* Main Content */
        .main-content {
            flex: 1;
            padding: 2rem;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 1.5rem;
            color: #202124;
        }

        .date {
            color: #5f6368;
        }

        .actions-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .new-assignment-btn {
            background: #f1f3f4;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 2rem;
            color: #202124;
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: background-color 0.2s;
        }

        .new-assignment-btn:hover {
            background: #e8e8e8;
        }

        .filters {
            display: flex;
            gap: 1rem;
        }

        .filter-dropdown {
            position: relative;
        }

        .filter-btn {
            background: white;
            border: 1px solid #e0e0e0;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            color: #202124;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .filter-menu {
            position: absolute;
            top: 100%;
            right: 0;
            background: white;
            border-radius: 0.5rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            min-width: 150px;
            display: none;
            z-index: 1000;
        }

        .filter-menu.active {
            display: block;
        }

        .filter-item {
            padding: 0.75rem 1rem;
            color: #202124;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .filter-item:hover {
            background-color: #f8f9fa;
        }

        /* Assignments List */
        .assignments-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .assignment-card {
            background: white;
            border-radius: 1rem;
            padding: 1.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            transition: transform 0.2s;
        }

        .assignment-card:hover {
            transform: translateY(-2px);
        }

        .assignment-info {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .assignment-book {
            width: 80px;
            height: 100px;
            object-fit: cover;
            border-radius: 0.5rem;
        }

        .assignment-details h3 {
            color: #1a73e8;
            margin-bottom: 0.5rem;
            font-size: 1.1rem;
        }

        .assignment-details p {
            color: #5f6368;
            font-size: 0.9rem;
            margin-bottom: 0.25rem;
            line-height: 1.4;
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

        .section-title {
            font-size: 1.5rem;
            color: #202124;
            margin-bottom: 1.5rem;
            font-weight: 500;
        }

        .upgrade-banner {
            position: fixed;
            bottom: 2rem;
            left: 275px;
            background: white;
            border-radius: 1rem;
            padding: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .upgrade-text {
            color: #5f6368;
            font-size: 0.9rem;
        }

        .upgrade-btn {
            background: #1a73e8;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 2rem;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.9rem;
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
                <button onclick="toggleDropdown('profileDropdown')" class="dropdown-toggle">▼</button>
                <div id="profileDropdown" class="dropdown-menu">
                    <a href="#" class="dropdown-item">
                        <i>📚</i>
                        <span>Course</span>
                    </a>
                    <a href="#" class="dropdown-item">
                        <i>👤</i>
                        <span>Profile</span>
                    </a>
                    <a href="#" class="dropdown-item">
                        <i>⚙️</i>
                        <span>Settings</span>
                    </a>
                    <a href="#" class="dropdown-item">
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
            <nav class="nav-items">
                <a href="./TeacherDashboard.jsp" class="nav-item">
                    <img src="${pageContext.request.contextPath}/resources/public/Vector.png">
                    <span>Dashboard</span>
                </a>
                <a href="./assignments.jsp" class="nav-item active">
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
            <div class="page-header">
                <h1 class="page-title">Assignments</h1>

            </div>

            <div class="actions-bar">
                <button class="new-assignment-btn" onclick="createNewAssignment()">
                    <span>+</span>
                    <span>Create New Assignment</span>
                </button>
                <div class="filters">
                    <div class="filter-dropdown">
                        <button class="filter-btn" onclick="toggleDropdown('allFilter')">
                            All
                            <span>▼</span>
                        </button>

                    </div>
                    <div class="filter-dropdown">
                        <button class="filter-btn" onclick="toggleDropdown('timelineFilter')">
                            Filter by timeline
                            <span>▼</span>
                        </button>
                        <div id="timelineFilter" class="filter-menu">
                            <div class="filter-item" onclick="filterByTimeline('this-week')">This week</div>
                            <div class="filter-item" onclick="filterByTimeline('next-week')">Next week</div>
                            <div class="filter-item" onclick="filterByTimeline('this-month')">This month</div>
                        </div>
                    </div>
                    <div class="filter-dropdown">
                        <button class="filter-btn" onclick="toggleDropdown('courseFilter')">
                            Filter by course
                            <span>▼</span>
                        </button>
                        <div id="courseFilter" class="filter-menu">
                            <div class="filter-item" onclick="filterByCourse('dsa')">DSA</div>
                            <div class="filter-item" onclick="filterByCourse('math')">Mathematics</div>
                            <div class="filter-item" onclick="filterByCourse('db')">Database</div>
                        </div>
                    </div>
                </div>
            </div>

            <h2 class="section-title" id="assignmentListTitle">Given Assignments:</h2>
            
            <div class="assignments-list" id="assignmentsList">
                <!-- Assignment cards will be dynamically populated here -->
            </div>

            <!-- Upgrade Banner -->
            <div class="upgrade-banner">
                <img src="${pageContext.request.contextPath}/resources/public/upgrade-illustration.svg" alt="Upgrade" width="100">
                <div>
                    <p class="upgrade-text">Upgrade to our new version Scholarly G-Plus</p>
                    <a href="#" class="upgrade-btn">Upgrade</a>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Sample assignment data
        const assignments = {
            'given': [
                {
                    title: 'DSA Assignment on stacks',
                    description: 'A text editor implements an "undo" feature using a stack. Every time a user types a character, it is pushed onto the stack. When the user presses UNDO, the last entered character...',
                    deadline: '23 March 2025',
                    course: 'dsa',
                    image: 'dsa-book.jpg'
                },
                {
                    title: 'DSA Assignment on queues',
                    description: 'Implement a Priority Queue using a linked list or heap to handle the following operations efficiently: 1. enqueue(name, type) – Add a customer to the queue......',
                    deadline: '29 March 2025',
                    course: 'dsa',
                    image: 'dsa-book.jpg'
                },
                {
                    title: 'DSA Assignment on linked lists',
                    description: 'You are developing a student record management system that stores student names and their IDs using a singly linked list. The system should.....',
                    deadline: '29 March 2025',
                    course: 'dsa',
                    image: 'dsa-book.jpg'
                },
                {
                    title: 'DSA Assignment on pointers',
                    description: 'You are given an array of integers, and your task is to implement a function using pointers to reverse the array in-place without using extra memory.....',
                    deadline: '31 March 2025',
                    course: 'dsa',
                    image: 'dsa-book.jpg'
                }
            ],
            'this-week': [
                {
                    title: 'DSA Assignment on stacks',
                    description: 'A text editor implements an "undo" feature using a stack. Every time a user types a character, it is pushed onto the stack. When the user presses UNDO, the last entered character...',
                    deadline: '23 March 2025',
                    course: 'dsa',
                    image: 'dsa-book.jpg'
                },
                {
                    title: 'Maths Assignment on queues',
                    description: 'A scientist is studying the growth rate of a bacteria colony over time. The number of bacteria at time t (in hours) is given by the function....',
                    deadline: '29 March 2025',
                    course: 'math',
                    image: 'math-book.jpg'
                },
                {
                    title: 'Advanced DB assignment on functions',
                    description: 'You are designing a student grading system using PostgreSQL/MySQL. Each student has multiple assignments.....',
                    deadline: '29 March 2025',
                    course: 'db',
                    image: 'db-book.jpg'
                },
                {
                    title: 'Math Assignment on limits',
                    description: 'A scientist is studying the growth rate of a bacteria colony over time. The number of bacteria at time ttt (in hours) is given by the function....',
                    deadline: '01 April 2025',
                    course: 'math',
                    image: 'math-book.jpg'
                }
            ]
        };

        // Function to render assignment cards
        function renderAssignments(assignmentList) {
            const container = document.getElementById('assignmentsList');
            container.innerHTML = '';

            assignmentList.forEach(assignment => {
                const card = `
                    <div class="assignment-card">
                        <div class="assignment-info">
                            <img src="${pageContext.request.contextPath}/resources/public/${assignment.image}" 
                                 alt="${assignment.title}" 
                                 class="assignment-book">
                            <div class="assignment-details">
                                <h3>${assignment.title}</h3>
                                <p>${assignment.description}</p>
                                <p>Deadline: ${assignment.deadline}</p>
                            </div>
                        </div>
                        <a href="#" class="view-more-btn">View more ›</a>
                    </div>
                `;
                container.innerHTML += card;
            });
        }

        // Initialize with given assignments
        renderAssignments(assignments['given']);

        // Dropdown functionality
        function toggleDropdown(id) {
            const dropdown = document.getElementById(id);
            const allDropdowns = document.querySelectorAll('.dropdown-menu, .filter-menu');
            
            allDropdowns.forEach(menu => {
                if (menu.id !== id) {
                    menu.classList.remove('active');
                }
            });
            
            dropdown.classList.toggle('active');
        }

        // Close dropdowns when clicking outside
        window.addEventListener('click', function(e) {
            if (!e.target.closest('.teacher-profile') && !e.target.closest('.filter-dropdown')) {
                const allDropdowns = document.querySelectorAll('.dropdown-menu, .filter-menu');
                allDropdowns.forEach(menu => menu.classList.remove('active'));
            }
        });

        // Filter functions
        function filterByTimeline(timeline) {
            document.getElementById('assignmentListTitle').textContent = timeline === 'this-week' ? 'This week' : 'Given Assignments:';
            renderAssignments(assignments[timeline] || assignments['given']);
            toggleDropdown('timelineFilter');
        }

        function filterByCourse(course) {
            const filteredAssignments = assignments['given'].filter(assignment => assignment.course === course);
            document.getElementById('assignmentListTitle').textContent = `${course.toUpperCase()} Assignments:`;
            renderAssignments(filteredAssignments);
            toggleDropdown('courseFilter');
        }

        function filterAssignments(filter) {
            // You can implement additional filtering logic here
            document.getElementById('assignmentListTitle').textContent = 
                filter === 'all' ? 'Given Assignments:' : 
                filter === 'active' ? 'Active Assignments:' : 
                'Completed Assignments:';
            toggleDropdown('allFilter');
        }

        function createNewAssignment() {
            // Implement new assignment creation logic
            alert('Create new assignment functionality will be implemented here');
        }

        // Update current date
        const now = new Date();
        const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
        const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
        document.querySelector('.date').textContent = 
            `${days[now.getDay()]}, ${String(now.getDate()).padStart(2, '0')} ${months[now.getMonth()]} ${now.getFullYear()}`;
    </script>
</body>
</html> 