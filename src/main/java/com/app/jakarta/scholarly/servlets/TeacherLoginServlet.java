package com.app.jakarta.scholarly.servlets;

import java.io.*;

import com.app.jakarta.scholarly.models.Teacher;
import com.app.jakarta.scholarly.services.TeacherDAO;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet(name = "TeacherLoginServletServlet", value = "/TeacherLoginServlet-servlet")
public class TeacherLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TeacherDAO instructorService; // Use InstructorService instead of StudentService

    public void init(){
        instructorService = new TeacherDAO(); // Initialize InstructorService
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        authenticate(req, res);
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
        res.sendRedirect("/signin.jsp");
    }

    private void authenticate(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (areFieldsMissing(email, password)) {
            res.sendRedirect("signin.jsp?error=MissingFields");
            return;
        }

        Teacher instructor = instructorService.getTeacherByEmail(email); // Fetch Instructor by email

        if (instructor == null || !BCrypt.checkpw(password, instructor.getPassword())) {
            res.sendRedirect("signin.jsp?error=InvalidCredentials");
            return;
        }

        HttpSession session = req.getSession();
        session.setAttribute("instructor", instructor); // Store the instructor object in session
        session.setMaxInactiveInterval(30 * 60); // Session timeout of 30 minutes
        res.sendRedirect("/instructorDashboard"); // Redirect to instructor dashboard
    }

    private Boolean areFieldsMissing(String... fields) {
        for (String field : fields) {
            if (field == null || field.isEmpty()) {
                return true;
            }
        }
        return false;
    }
}