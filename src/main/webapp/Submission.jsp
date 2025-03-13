<!-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submissions - Scholarly</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
        }

        body {

            min-height: 100vh;
        }

        /* Navigation */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
            background: white;

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

        }

        .create-category {
            background: #f8f9fa;
            border-radius: 0.5rem;
            padding: 1rem;
            margin-bottom: 2rem;
            cursor: pointer;
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

        /* Table Styles */
        .submissions-table {
            width: 100%;
            background: white;
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .submissions-table table {
            width: 100%;
            border-collapse: collapse;
        }

        .submissions-table th {
            background:#D9D9D91e;
            padding: 0.5rem;
            text-align:left;
            color: #000;
            font-weight: 500px;
            width: 1186px;
            height: 36px;
        }

        .submissions-table  td {
            padding: 1rem;
            border-bottom: 1px solid #e0e0e0;
            color:#000;


        }

        .submissions-table tr:last-child td {
            border-bottom: none;
        }

        .submissions-table tr:hover {
            background: #f8f9fa;
        }
        .table-head{
            font-size: 16px;
            font-weight: 100px;


        }
        .studentName{
            font-weight:bold;
        }

        .Deadline{
            color: #2C7BE5BD;
        }


        /* Status Badges */
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 1rem;
            font-size: 0.875rem;
            font-weight: 500;
            display: inline-block;
        }

        .status-submitted {
            background: #e8f0fe;
            color: #1a73e8;
        }

        .status-not-submitted {
            background: #fff3e0;
            color: #f57c00;
        }

        /* Action Buttons */
        .action-btn {
            padding: 0.5rem 1.5rem;
            border-radius: 2rem;
            font-weight: 500;
            border: none;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .btn-mark {
            background: #1a73e8;
            color: white;
        }

        .btn-mark:hover {
            background: #1557b0;
        }

        .btn-marked {
            background: #e8f0fe;
            color: #1a73e8;
            cursor: default;
        }

        .class-title {
            font-size: 1.25rem;
            color: #202124;
            margin: 2rem 0 1rem;
            font-weight: 500;
        }

        /* Upgrade Banner */
        .upgrade-banner {
            width: 224px;
            display: flex;
            flex-direction: column;
            gap:1px;
            align-items: center;
            height: 182px;
            position: fixed;
            bottom: 2rem;
            left: 12px;
            background:#F6F6F6;
            border-radius: 1rem;
            display: flex;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .upgrade-text {
            color: #5f6368;
            font-size: 0.9rem;
        }
        .upgrade-btn {
            background: #1a73e8;
            color: white;
            padding: 0.5rem 0.5rem;
            border-radius: 2rem;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.9rem;
            width: 133px;
            height: 36px;
            text-align: center;
            font-weight:bold;
        }



    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar">
    <img src="${pageContext.request.contextPath}/resources/public/scholarly-logo.png" alt="Scholarly" class="logo">
    <div class="nav-right">

        <div class="teacher-profile">
            <div class="profile-initial">LM</div>
            <span class="teacher-name">Teacher name</span>
            <i class="notification-bell">🔔</i>
        </div>
    </div>
</nav>

<div class="layout-container">
    <!-- Sidebar -->
    <aside class="sidebar">

        <nav class="nav-items">
            <a href="TeacherDashboard.jsp" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/public/Vector.png" alt="Scholarly" >
                <span>Dashboard</span>
            </a>
            <a href="assignments.jsp" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/public/rectangle-list-solid 1.png" alt="Scholarly" >
                <span>Assignments</span>
            </a>
            <a href="#" class="nav-item active">
                <img src="${pageContext.request.contextPath}/resources/public/boxes-packing-solid 1.png" alt="Scholarly" >
                <span>Class Management</span>
            </a>
            <a href="#" class="nav-item">
                <i>⚙️</i>
                <span>Settings</span>
            </a>
        </nav>
        <div class="upgrade-banner">
            <img src="${pageContext.request.contextPath}/resources/public/upgrade-illustration.svg" alt="Upgrade" width="100">

            <p class="upgrade-text">Upgrade to our new version Scholarly G-Plus</p>
            <a href="#" class="upgrade-btn">Upgrade</a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <div class="page-header">
            <h1 class="page-title">Submissions</h1>
            <span class="date">Monday, 03 March 2025</span>
        </div>

        <h2 class="class-title">Class A</h2>

        <div class="submissions-table">
            <table>
                <thead>
                <tr>
                    <th class="table-head">Student name</th>
                    <th class="table-head">Assignment Name</th>
                    <th class="table-head">Description</th>
                    <th class="table-head">Deadline</th>
                    <th class="table-head">Submission state</th>
                    <th class="table-head">Marking state</th>
                </tr>
                </thead>
                <tbody id="submissionsTableBody">
                <!-- Table content will be dynamically populated -->
                </tbody>
            </table>
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
    // Sample data structure (this would typically come from your backend)
    const submissionsData = [
        {
            studentName: "Louis Calton",
            assignmentName: "DSA Assignment on stacks",
            description: "A text editor implements an 'undo' feature using a stack. Every time a user types a character, it is pushed onto the stack.",
            deadline: "23 March 2025",
            submissionState: "submitted",
            markingState: "unmarked"
        },
        {
            studentName: "Chloe Kampe",
            assignmentName: "DSA Assignment on queues",
            description: "Implement a Priority Queue using a linked list or heap to handle the following operations efficiently.",
            deadline: "29 March 2025",
            submissionState: "not-submitted",
            markingState: "unmarked"
        },
        {
            studentName: "John Doe",
            assignmentName: "DSA Assignment on queues",
            description: "Implement a Priority Queue using a linked list or heap to handle the following operations efficiently.",
            deadline: "23 March 2025",
            submissionState: "submitted",
            markingState: "marked"
        }
        // Add more sample data as needed
    ];


    function fetchSubmissions(){

        fetch(servletUrl)
            .then(Response=>Response.json())
            .then(submissions =>{
                const tableContainer = document.getElementById("submissionsTableBody");
                tableContainer.innerHTML="";
                submissions.forEach(submission =>{
                    const table = `
             <td class="studentName">${submission.studentName}</td>
                    <td>${submission.assignmentName}</td>
                    <td >${submission.description}</td>
                    <td class="Deadline">Deadline: ${submission.deadline}</td>
                    <td>
                        <span class="status-badge status-${submission.submissionState}">
                            ${submission.submissionState === 'submitted' ? 'Submitted' : 'Not submitted'}
                        </span>
                    </td>
                    <td>
                        ${submission.markingState === 'marked'
                            ? '<button class="action-btn btn-marked">Marked</button>'
                            : '<button class="action-btn btn-mark" onclick="markSubmission(this)">Mark</button>'
                        }
                    </td>
            `
                    tableBody.appendChild(row);
                })
                    .catch(error => console.error('Error fetching assignments:', error));

            })
    }

    // Function to render the submissions table
    function renderSubmissionsTable() {
        const tableBody = document.getElementById('submissionsTableBody');
        tableBody.innerHTML = '';

        submissionsData.forEach(submission => {
            const row = document.createElement('tr');
            row.innerHTML = `
                    <td class="studentName">${submission.studentName}</td>
                    <td>${submission.assignmentName}</td>
                    <td>${submission.description}</td>
                    <td class="Deadline">Deadline: ${submission.deadline}</td>
                    <td>
                        <span class="status-badge status-${submission.submissionState}">
                            ${submission.submissionState === 'submitted' ? 'Submitted' : 'Not submitted'}
                        </span>
                    </td>
                    <td>
                        ${submission.markingState === 'marked'
                            ? '<button class="action-btn btn-marked">Marked</button>'
                            : '<button class="action-btn btn-mark" onclick="markSubmission(this)">Mark</button>'
                        }
                    </td>
                `;
            tableBody.appendChild(row);
        });
    }

    // Function to handle marking a submission
    function markSubmission(button) {
        // Here you would typically make an API call to update the marking state
        button.classList.remove('btn-mark');
        button.classList.add('btn-marked');
        button.textContent = 'Marked';
        button.onclick = null;
    }

    // Initialize the table
    renderSubmissionsTable();

    // Update current date
    const now = new Date();
    const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    document.querySelector('.date').textContent =
        `${days[now.getDay()]}, ${String(now.getDate()).padStart(2, '0')} ${months[now.getMonth()]} ${now.getFullYear()}`;

    // In a real application, you would fetch data from the backend like this:
    /*
    async function fetchSubmissions() {
        try {
            const response = await fetch('/api/submissions');
            const data = await response.json();
            submissionsData = data;
            renderSubmissionsTable();
        } catch (error) {
            console.error('Error fetching submissions:', error);
        }
    }

    // Fetch submissions when the page loads
    fetchSubmissions();
    */
</script>
</body>
</html>