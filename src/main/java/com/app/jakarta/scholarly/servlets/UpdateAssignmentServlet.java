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

@WebServlet(name = "UpdateAssignmentServlet", value = "/update-assignment")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class UpdateAssignmentServlet extends HttpServlet {
    
    private static final String UPLOAD_DIR = "uploads/assignments";
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
            String assignmentId = request.getParameter("id");
            if (assignmentId == null) {
                throw new ServletException("Assignment ID is required");
            }

            EntityManager em = emf.createEntityManager();
            Assignment assignment = em.find(Assignment.class, Long.parseLong(assignmentId));
            em.close();

            if (assignment == null) {
                throw new ServletException("Assignment not found");
            }

            // Display update form with existing values
            out.println("<html><body>");
            out.println("<h1>Update Assignment</h1>");
            out.println("<form method='post' enctype='multipart/form-data'>");
            out.println("<input type='hidden' name='id' value='" + assignment.getId() + "'>");
            out.println("Title: <input type='text' name='title' value='" + assignment.getTitle() + "'><br>");
            out.println("Description: <textarea name='description'>" + 
                (assignment.getDescription() != null ? assignment.getDescription() : "") + 
                "</textarea><br>");
            out.println("Due Date: <input type='datetime-local' name='dueDate' value='" + 
                assignment.getDueDate().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME) + "'><br>");
            out.println("Classroom ID: <input type='number' name='classroomId' value='" + 
                assignment.getClassroom().getId() + "'><br>");
            out.println("New File (optional): <input type='file' name='assignmentFile'><br>");
            out.println("<input type='submit' value='Update'>");
            out.println("</form>");
            out.println("</body></html>");

        } catch (Exception e) {
            out.println("<h1>Error loading assignment</h1>");
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
            String assignmentId = request.getParameter("id");
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String dueDateStr = request.getParameter("dueDate");
            String classroomId = request.getParameter("classroomId");

            // Convert due date string to LocalDateTime
            DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
            LocalDateTime dueDate = LocalDateTime.parse(dueDateStr, formatter);

            // Get teacher from session
            HttpSession session = request.getSession();
            Teacher teacher = (Teacher) session.getAttribute("loggedInTeacher");
            if (teacher == null) {
                throw new ServletException("Teacher not logged in");
            }

            EntityManager em = emf.createEntityManager();
            em.getTransaction().begin();

            // Find existing assignment
            Assignment assignment = em.find(Assignment.class, Long.parseLong(assignmentId));
            if (assignment == null) {
                throw new ServletException("Assignment not found");
            }

            // Verify teacher owns this assignment
            if (!assignment.getTeacher().getId().equals(teacher.getId())) {
                throw new ServletException("Unauthorized to update this assignment");
            }

            // Update assignment fields
            assignment.setTitle(title);
            assignment.setDescription(description);
            assignment.setDueDate(dueDate);

            // Update classroom if changed
            Classroom classroom = em.find(Classroom.class, Long.parseLong(classroomId));
            if (classroom == null) {
                throw new ServletException("Invalid classroom ID");
            }
            assignment.setClassroom(classroom);

            // Handle file upload if provided
            Part filePart = request.getPart("assignmentFile");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = extractFileName(filePart);
                String applicationPath = request.getServletContext().getRealPath("");
                String uploadPath = applicationPath + File.separator + UPLOAD_DIR;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);
                
                // Update description with new file name
                assignment.setDescription(description + "\nFile: " + fileName);
            }

            em.merge(assignment);
            em.getTransaction().commit();
            em.close();

            out.println("<h1>Assignment updated successfully!</h1>");
            out.println("<p>Title: " + title + "</p>");

        } catch (Exception e) {
            out.println("<h1>Error updating assignment</h1>");
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
