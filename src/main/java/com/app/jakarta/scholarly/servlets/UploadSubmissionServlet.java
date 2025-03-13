package com.app.jakarta.scholarly.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.app.jakarta.scholarly.models.Submission;
import com.app.jakarta.scholarly.models.Assignment;
import com.app.jakarta.scholarly.models.Student;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.io.*;
import java.time.LocalDateTime;

@WebServlet(name = "UploadSubmissionServlet", value = "/upload-submission")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class UploadSubmissionServlet extends HttpServlet {
    
    private static final String UPLOAD_DIR = "uploads/submissions";
    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("ScholarlyPU"); // Adjust persistence unit name
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            // Expect an assignment ID to know which assignment the student is submitting for
            String assignmentId = request.getParameter("assignmentId");
            if (assignmentId == null) {
                throw new ServletException("Assignment ID is required");
            }

            // Get the logged-in student from session
            HttpSession session = request.getSession();
            Student student = (Student) session.getAttribute("loggedInStudent");
            if (student == null) {
                throw new ServletException("Student not logged in");
            }

            // Load the assignment to prefill some fields
            EntityManager em = emf.createEntityManager();
            Assignment assignment = em.find(Assignment.class, Long.parseLong(assignmentId));
            em.close();

            if (assignment == null) {
                throw new ServletException("Assignment not found");
            }

            // Display the submission form matching the UI, adjusted for the Submission class
            out.println("<html><body>");
            out.println("<style>");
            out.println("body { font-family: Arial, sans-serif; margin: 20px; }");
            out.println(".container { max-width: 600px; margin: auto; padding: 20px; border: 1px solid #ccc; border-radius: 10px; }");
            out.println("input[type=text], textarea { width: 100%; padding: 10px; margin: 5px 0; border: 1px solid #ccc; border-radius: 5px; }");
            out.println("input[type=file] { margin: 10px 0; }");
            out.println("input[type=submit] { background-color: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; }");
            out.println("input[type=submit]:hover { background-color: #0056b3; }");
            out.println("</style>");
            out.println("<div class='container'>");
            out.println("<h2>Submit your assignment</h2>");
            out.println("<form method='post' enctype='multipart/form-data'>");
            out.println("<input type='hidden' name='assignmentId' value='" + assignmentId + "'>");
            out.println("<label>Student Name</label><br>");
            out.println("<input type='text' name='studentName' value='" + student.getUserName() + "' readonly><br>");
            out.println("<label>Class</label><br>");
            out.println("<input type='text' name='className' value='" + assignment.getClassroom().getId() + "' readonly><br>");
            out.println("<label>Email</label><br>");
            out.println("<input type='text' name='email' value='" + student.getEmail() + "' readonly><br>");
            out.println("<label>Short description</label><br>");
            out.println("<textarea name='description' placeholder='Type here...'></textarea><br>");
            out.println("<label>Course</label><br>");
            out.println("<input type='text' name='course' placeholder='Type here...' value='" + 
                (assignment.getClassroom() != null ? assignment.getClassroom().getId() : "") + "' readonly><br>");
            out.println("<label>Upload your assignment</label><br>");
            out.println("<input type='file' name='submissionFile' required><br>");
            out.println("<input type='submit' value='Submit'>");
            out.println("</form>");
            out.println("</div>");
            out.println("</body></html>");

        } catch (Exception e) {
            out.println("<h1>Error loading submission form</h1>");
            out.println("<p>" + e.getMessage() + "</p>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            // Get form parameters
            String assignmentId = request.getParameter("assignmentId");

            // Get the logged-in student from session
            HttpSession session = request.getSession();
            Student student = (Student) session.getAttribute("loggedInStudent");
            if (student == null) {
                throw new ServletException("Student not logged in");
            }

            // Get file part
            Part filePart = request.getPart("submissionFile");
            String fileName = extractFileName(filePart);
            
            // Save file to server
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadPath = applicationPath + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);

            // Create and persist submission
            EntityManager em = emf.createEntityManager();
            em.getTransaction().begin();

            Assignment assignment = em.find(Assignment.class, Long.parseLong(assignmentId));
            if (assignment == null) {
                throw new ServletException("Assignment not found");
            }

            // Check if the assignment is still open (due date not passed)
            if (LocalDateTime.now().isAfter(assignment.getDueDate())) {
                throw new ServletException("Assignment submission is closed. Due date has passed.");
            }

            // Check if the student has already submitted this assignment
            Submission existingSubmission = em.createQuery(
                "SELECT s FROM Submission s WHERE s.student.id = :studentId AND s.assignment.id = :assignmentId", 
                Submission.class)
                .setParameter("studentId", student.getId())
                .setParameter("assignmentId", Long.parseLong(assignmentId))
                .getResultStream()
                .findFirst()
                .orElse(null);

            if (existingSubmission != null) {
                throw new ServletException("You have already submitted this assignment.");
            }

            Submission submission = new Submission(
                assignment,
                student,
                LocalDateTime.now(),
                filePath
            );

            em.persist(submission);
            em.getTransaction().commit();
            em.close();

            out.println("<h1>Submission uploaded successfully!</h1>");
            out.println("<p>Student: " + student.getUserName() + "</p>");
            out.println("<p>File: " + fileName + "</p>");

        } catch (Exception e) {
            out.println("<h1>Error uploading submission</h1>");
            out.println("<p>" + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    @Override
    public void destroy() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
