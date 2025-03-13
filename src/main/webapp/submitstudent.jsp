<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Submit Assignment</title>
    <style>
        .modal-overlay {
            position: fixed;
            inset: 0;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 50;
        }
        .modal-content {
            background: white;
            border-radius: 0.5rem;
            width: 100%;
            max-width: 48rem;
            padding: 2rem;
            position: relative;
        }
        .close-button {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: none;
            border: none;
            cursor: pointer;
        }
        .modal-title {
            font-size: 1.25rem;
            font-weight: bold;
            margin-bottom: 1.5rem;
        }
        .form-grid {
            display: grid;
            grid-template-columns: repeat(1, 1fr);
            gap: 1.5rem;
        }
        @media (min-width: 768px) {
            .form-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        .form-group {
            margin-bottom: 1rem;
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
        .upload-area {
            border: 2px dashed #e5e7eb;
            border-radius: 0.5rem;
            padding: 2rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            position: relative;
            margin-top: 1.5rem;
        }
        .upload-text {
            color: #9ca3af;
            margin-bottom: 1rem;
        }
        .browse-button {
            padding: 0.5rem 1rem;
            background: #fbbf24;
            color: black;
            border: 1px solid transparent;
            border-radius: 0.25rem;
            font-weight: 500;
            cursor: pointer;
        }
        .browse-button:hover {
            background: #f59e0b;
        }
        .submit-button {
            display: block;
            width: auto;
            padding: 0.75rem 3rem;
            background: #3b82f6;
            color: white;
            border: none;
            border-radius: 9999px;
            font-weight: 500;
            cursor: pointer;
            margin: 2rem auto 0;
        }
        .submit-button:hover {
            background: #2563eb;
        }
    </style>
</head>
<body>
    <div class="modal-overlay">
        <div class="modal-content">
            <button class="close-button" onclick="window.history.back()">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M18 6L6 18M6 6l12 12"/>
                </svg>
            </button>

            <h2 class="modal-title">Submit your assignment</h2>

            <form action="${pageContext.request.contextPath}/submit-assignment" method="POST" enctype="multipart/form-data">
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label">Student Name</label>
                        <input type="text" name="studentName" class="input-field" placeholder="Type here..." required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Class</label>
                        <input type="text" name="class" class="input-field" placeholder="Type here..." required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="input-field" placeholder="Type here..." required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Short description</label>
                        <input type="text" name="description" class="input-field" placeholder="Type here..." required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Course</label>
                        <input type="text" name="course" class="input-field" placeholder="Type here..." required>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Upload your assignment</label>
                    <div class="upload-area">
                        <p class="upload-text">Drag your file here</p>
                        <input type="file" name="assignment" id="assignment" style="display: none;" required>
                        <label for="assignment" class="browse-button">Browse</label>
                        
                        <img src="${pageContext.request.contextPath}/images/upload-illustration.svg" 
                             alt="Upload" 
                             style="position: absolute; right: 0; bottom: 0;"
                             width="200" height="150">
                    </div>
                </div>

                <button type="submit" class="submit-button">Submit</button>
            </form>
        </div>
    </div>
</body>
</html>