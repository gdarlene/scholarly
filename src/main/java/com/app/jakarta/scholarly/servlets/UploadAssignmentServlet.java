package com.app.jakarta.scholarly.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.app.jakarta.scholarly.models.Assignment;
import com.app.jakarta.scholarly.models.Teacher;
import com.app.jakarta.scholarly.models.Classroom;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "UploadAssignmentServlet", value = "/upload-assignment")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class UploadAssignmentServlet extends HttpServlet {
    
    private static final String UPLOAD_DIR = "uploads/assignments";
    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("ScholarlyPU"); // Adjust persistence unit name
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Display upload form
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>Upload Assignment</h1>");
        out.println("<form method='post' enctype='multipart/form-data'>");
        out.println("Title: <input type='text' name='title'><br>");
        out.println("Description: <textarea name='description'></textarea><br>");
        out.println("Due Date: <input type='datetime-local' name='dueDate'><br>");
        out.println("Classroom ID: <input type='number' name='classroomId'><br>");
        out.println("File: <input type='file' name='assignmentFile'><br>");
        out.println("<input type='submit' value='Upload'>");
        out.println("</form>");
        out.println("</body></html>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            // Get form parameters
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String dueDateStr = request.getParameter("dueDate");
            String classroomId = request.getParameter("classroomId");
            
            // Convert due date string to LocalDateTime
            DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
            LocalDateTime dueDate = LocalDateTime.parse(dueDateStr, formatter);

            // Get teacher from session (assuming teacher is logged in)
            HttpSession session = request.getSession();
            Teacher teacher = (Teacher) session.getAttribute("loggedInTeacher");
            if (teacher == null) {
                throw new ServletException("Teacher not logged in");
            }

            // Get file part
            Part filePart = request.getPart("assignmentFile");
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

            // Create and persist assignment
            EntityManager em = emf.createEntityManager();
            em.getTransaction().begin();

            Classroom classroom = em.find(Classroom.class, Long.parseLong(classroomId));
            if (classroom == null) {
                throw new ServletException("Invalid classroom ID");
            }

            Assignment assignment = new Assignment(
                title,
                description + "\nFile: " + fileName,
                dueDate,
                classroom,
                teacher
            );

            em.persist(assignment);
            em.getTransaction().commit();
            em.close();

            out.println("<h1>Assignment uploaded successfully!</h1>");
            out.println("<p>Title: " + title + "</p>");
            out.println("<p>File: " + fileName + "</p>");

        } catch (Exception e) {
            out.println("<h1>Error uploading assignment</h1>");
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
