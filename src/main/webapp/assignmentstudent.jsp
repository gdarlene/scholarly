<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Assignments</title>
    <style>
        .container {
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }
        .heading {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 2rem;
        }
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
        }
        .card {
            background: white;
            border-radius: 0.5rem;
            padding: 1.5rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            position: relative;
        }
        .download-icon {
            position: absolute;
            top: 1rem;
            right: 1rem;
            color: #3b82f6;
        }
        .subject-icon {
            background: #dbeafe;
            padding: 0.5rem;
            border-radius: 0.5rem;
            margin-right: 1rem;
        }
        .card-header {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
        }
        .card-title {
            font-weight: 500;
        }
        .card-description {
            font-size: 0.875rem;
            color: #6b7280;
            margin-bottom: 1rem;
        }
        .card-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .deadline {
            font-size: 0.75rem;
            color: #9ca3af;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="heading">This Week</h1>
        
        <div class="grid">
            <c:forEach items="${assignments}" var="assignment">
                <div class="card">
                    <div class="download-icon">
                        <img src="${pageContext.request.contextPath}/images/download.svg" alt="Download" width="16" height="16">
                    </div>
                    
                    <div class="card-header">
                        <div class="subject-icon">
                            <img src="${pageContext.request.contextPath}/images/${assignment.icon}" 
                                 alt="${assignment.subject}" 
                                 width="30" 
                                 height="30">
                        </div>
                        <h3 class="card-title">${assignment.title}</h3>
                    </div>
                    
                    <p class="card-description">${assignment.description}</p>
                    
                    <div class="card-footer">
                        <div class="deadline">
                            Deadline: ${assignment.deadline}
                        </div>
                        <button onclick="window.location.href='${pageContext.request.contextPath}/assignment/${assignment.id}'">
                            →
                        </button>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <h1 class="heading" style="margin-top: 2rem;">Next Week</h1>
        <div class="grid">
            <!-- Next week assignments will be populated here -->
            <c:if test="${empty nextWeekAssignments}">
                <p style="color: #6b7280;">No new assignments yet.</p>
            </c:if>
        </div>
    </div>
</body>
</html>