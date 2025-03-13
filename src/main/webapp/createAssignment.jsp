<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Assignment - Scholarly</title>
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
            justify-content: center;
            align-items: center;
        }

        .modal {
            background: white;
            border-radius: 1rem;
            width: 90%;
            max-width: 800px;
            padding: 2rem;
            position: relative;
            display: flex;
            gap: 2rem;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .modal-title {
            font-size: 1.5rem;
            color: #202124;
            font-weight: 500;
        }

        .close-btn {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: #5f6368;
            padding: 0.5rem;
        }

        .form-section {
            flex: 1;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            color: #202124;
            font-weight: 500;
        }

        .form-input {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid #e0e0e0;
            border-radius: 0.5rem;
            font-size: 1rem;
            color: #202124;
            background: white;
            transition: border-color 0.2s;
        }

        .form-input:focus {
            outline: none;
            border-color: #1a73e8;
        }

        .form-input::placeholder {
            color: #9aa0a6;
        }

        .date-input {
            position: relative;
        }

        .date-input i {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #5f6368;
            pointer-events: none;
        }

        .file-upload {
            border: 2px dashed #e0e0e0;
            border-radius: 0.5rem;
            padding: 2rem;
            text-align: center;
            cursor: pointer;
            transition: border-color 0.2s;
        }

        .file-upload:hover {
            border-color: #1a73e8;
        }

        .file-upload p {
            color: #5f6368;
            margin-bottom: 1rem;
        }

        .browse-btn {
            background: #ffd700;
            color: #202124;
            padding: 0.5rem 1.5rem;
            border-radius: 1.5rem;
            border: none;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .browse-btn:hover {
            background: #ffc700;
        }

        .illustration-section {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .illustration {
            max-width: 100%;
            height: auto;
        }

        .submit-btn {
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

        .submit-btn:hover {
            background: #1557b0;
        }

        @media (max-width: 768px) {
            .modal {
                flex-direction: column;
                padding: 1.5rem;
            }

            .illustration-section {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="modal">
        <div class="form-section">
            <div class="modal-header">
                <h2 class="modal-title">Create an assignment</h2>
                <button class="close-btn" onclick="closeModal()">×</button>
            </div>

            <form id="assignmentForm" action="/assignment"  method="POST">
                <div class="form-group">
                    <label class="form-label">Assignment name</label>
                    <input type="text" class="form-input" name="assignment" placeholder="Type here..." required>
                </div>

                <div class="form-group">
                    <label class="form-label">Course</label>
                    <input type="text" class="form-input" name="course"  placeholder="Type here..." required>
                </div>

                <div class="form-group">
                    <label class="form-label">Deadline</label>
                    <div class="date-input">
                        <input type="date" class="form-input" name="deadline" required>
                        <i>📅</i>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Assignment description</label>
                    <div class="file-upload" onclick="triggerFileInput()">
                        <p>Drag your file here</p>
                        <button type="button" class="browse-btn">Browse</button>
                        <input type="file" id="fileInput" style="display: none;" accept=".pdf,.doc,.docx">
                    </div>
                </div>

                <button type="submit" class="submit-btn">Submit</button>
            </form>
        </div>

        <div class="illustration-section">
            <img src="${pageContext.request.contextPath}/resources/public/assignment-illustration.svg" 
                 alt="Create Assignment" 
                 class="illustration">
        </div>
    </div>

    <script>
        function closeModal() {
            window.location.href = 'assignments.jsp';
        }

        function triggerFileInput() {
            document.getElementById('fileInput').click();
        }

        function submitForm(event) {
            event.preventDefault();
            // Here you would typically handle the form submission
            // For now, we'll just redirect back to the assignments page
            window.location.href = 'assignments.jsp';
        }

        // File drag and drop functionality
        const dropZone = document.querySelector('.file-upload');
        
        dropZone.addEventListener('dragover', (e) => {
            e.preventDefault();
            dropZone.style.borderColor = '#1a73e8';
        });

        dropZone.addEventListener('dragleave', (e) => {
            e.preventDefault();
            dropZone.style.borderColor = '#e0e0e0';
        });

        dropZone.addEventListener('drop', (e) => {
            e.preventDefault();
            dropZone.style.borderColor = '#e0e0e0';
            const files = e.dataTransfer.files;
            if (files.length) {
                document.getElementById('fileInput').files = files;
                // Update UI to show selected file
                const fileName = files[0].name;
                dropZone.querySelector('p').textContent = `Selected file: ${fileName}`;
            }
        });

        // Handle file input change
        document.getElementById('fileInput').addEventListener('change', (e) => {
            if (e.target.files.length) {
                const fileName = e.target.files[0].name;
                dropZone.querySelector('p').textContent = `Selected file: ${fileName}`;
            }
        });
    </script>
</body>
</html> 