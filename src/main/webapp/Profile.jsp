<!-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - Scholarly</title>
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
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Profile Section */
        .profile-section {
            display: flex;
            gap: 3rem;
            margin-bottom: 2rem;
        }

        .profile-image {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
        }

        .profile-info {
            flex: 1;
        }

        .profile-name {
            font-size: 3rem;
            color: #202124;
            margin-bottom: 0.5rem;
        }

        .profile-email {
            color: #5f6368;
            font-size: 2rem;
        }

        /* Form Styles */
        .form-container {
            background: white;
            border-radius: 1rem;
            padding: 2rem;

        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            color: #202124;
            font-weight: bold;

        }

        .form-input {
            width: 253px;
            padding: 0.75rem 1rem;
            border: 1px solid #e0e0e0;
            border-radius: 5rem;
            font-size: 1rem;
            color: #202124;
            background: white;
            transition: border-color 0.2s;

        }

        .form-input:focus {
            outline: none;
            border-color: #1a73e8;
        }

        .form-input:disabled {
            background: #f8f9fa;
            cursor: not-allowed;
        }

        /* Course Tags */
        .course-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            margin-top: 0.5rem;
        }

        .course-tag {
            background: #e8f0fe;
            color: #1a73e8;
            padding: 0.5rem 1rem;
            border-radius: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .remove-tag {
            cursor: pointer;
            font-weight: bold;
        }

        /* Save Button */
        .save-btn {
            background: #1a73e8;
            color: white;
            padding: 0.75rem 2rem;
            border-radius: 2rem;
            border: none;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s;
            margin-top: 1rem;
        }

        .save-btn:hover {
            background: #1557b0;
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

        .inputsContainer{
            display: flex;
            gap:5rem;
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar">
    <img src="${pageContext.request.contextPath}/resources/public/scholarly-logo.png" alt="Scholarly" class="logo">
    <div class="nav-right">
        <div class="teacher-profile">
            <div class="profile-initial">JD</div>
            <span class="teacher-name">Jean D.</span>
            <i class="notification-bell">🔔</i>
        </div>
    </div>
</nav>

<div class="layout-container">
    <!-- Sidebar -->
    <aside class="sidebar">

        <nav class="nav-items">
            <a href="TeacherDashboard.jsp" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/public/Vector.png">
                <span>Dashboard</span>
            </a>
            <a href="assignments.jsp" class="nav-item">
                <i>📝</i>
                <span>Assignments</span>
            </a>
            <a href="Submission.jsp" class="nav-item">
                <i>👥</i>
                <span>Class Management</span>
            </a>
            <a href="#" class="nav-item active">
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
        <div class="profile-section">
            <img src="${pageContext.request.contextPath}/resources/public/profile-image.jpg"
                 alt="Profile"
                 class="profile-image"
                 id="profileImage">
            <div class="profile-info">
                <h1 class="profile-name" id="profileName">Jean de Dieu</h1>
                <p class="profile-email" id="profileEmail">jeandd@gmail.com</p>
            </div>
        </div>

        <div class="form-container">
            <form id="profileForm" onsubmit="saveProfile(event)">
                <div class="inputsContainer">
                    <div class="form-group">
                        <label class="form-label">Username</label>
                        <input type="text" class="form-input" id="username" value="Jean D." required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-input" id="email" value="jeandd@gmail.com" required>
                    </div>
                </div>

                <div class="inputsContainer">
                    <div class="form-group">
                        <label class="form-label">Course</label>
                        <div class="course-tags" id="courseTags">
                            <div class="course-tag">
                                DSA <span class="remove-tag" onclick="removeCourse(this)">×</span>
                            </div>
                            <div class="course-tag">
                                Java <span class="remove-tag" onclick="removeCourse(this)">×</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Gender</label>
                        <input type="text" class="form-input" id="gender" value="Male" required>
                    </div>
                </div>

                <div class="inputsContainer">
                    <div class="form-group">
                        <label class="form-label">Phone Number</label>
                        <input type="tel" class="form-input" id="phone" value="+250788346750" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <input type="password" class="form-input" id="password" value="********">
                    </div>
                </div>

                <button type="submit" class="save-btn">Save</button>
            </form>
        </div>

        <!-- Upgrade Banner -->

    </main>
</div>

<script>
    // Function to fetch profile data from backend
    async function fetchProfileData() {
        try {
            const response = await fetch('/api/profile');
            const data = await response.json();
            populateProfile(data);
        } catch (error) {
            console.error('Error fetching profile:', error);
        }
    }

    // Function to populate profile data
    function populateProfile(data) {
        document.getElementById('profileName').textContent = data.name;
        document.getElementById('profileEmail').textContent = data.email;
        document.getElementById('username').value = data.username;
        document.getElementById('email').value = data.email;
        document.getElementById('gender').value = data.gender;
        document.getElementById('phone').value = data.phone;

        // Update profile image if available
        if (data.profileImage) {
            document.getElementById('profileImage').src = data.profileImage;
        }

        // Update course tags
        const courseTagsContainer = document.getElementById('courseTags');
        courseTagsContainer.innerHTML = '';
        data.courses.forEach(course => {
            courseTagsContainer.innerHTML += `
                    <div class="course-tag">
                        ${course} <span class="remove-tag" onclick="removeCourse(this)">×</span>
                    </div>
                `;
        });
    }

    // Function to remove course tag
    function removeCourse(element) {
        element.parentElement.remove();
    }


    // Function to save profile changes
    async function saveProfile(event) {
        event.preventDefault();

        const formData = {
            username: document.getElementById('username').value,
            email: document.getElementById('email').value,
            gender: document.getElementById('gender').value,
            phone: document.getElementById('phone').value,
            password: document.getElementById('password').value,
            courses: Array.from(document.querySelectorAll('.course-tag'))
                .map(tag => tag.textContent.trim().replace('×', ''))
        };

        try {
            const response = await fetch('/api/profile/update', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(formData)
            });

            if (response.ok) {
                alert('Profile updated successfully!');
                // Refresh profile data
                fetchProfileData();
            } else {
                alert('Failed to update profile. Please try again.');
            }
        } catch (error) {
            console.error('Error updating profile:', error);
            alert('An error occurred while updating the profile.');
        }
    }

    // Update current date
    const now = new Date();
    const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

    // Initialize profile data
    // In a real application, you would uncomment this:
    // fetchProfileData();
</script>
</body>
</html>