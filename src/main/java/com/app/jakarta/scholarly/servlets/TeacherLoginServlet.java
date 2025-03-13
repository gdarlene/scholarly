package com.app.jakarta.scholarly.servlets;

import java.io.IOException;
import com.app.jakarta.scholarly.models.Teacher;
import com.app.jakarta.scholarly.services.TeacherDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet(name = "TeacherRegisterServlet", value = "/teacher-register")
public class TeacherRegisterServlet extends HttpServlet {
    private EntityManagerFactory emf;
    private TeacherDAO teacherDAO;

    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("ScholarlyPU"); // Adjust persistence unit name
        teacherDAO = new TeacherDAO(emf); // Assuming TeacherDAO accepts EntityManagerFactory
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Display the registration form
        request.getRequestDispatcher("/teacherRegistration.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get the form data from the request
        String userName = request.getParameter("userName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String gender = request.getParameter("gender");
        String phoneNumber = request.getParameter("phoneNumber");

        // Validate input
        if (userName == null || userName.trim().isEmpty() || email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() || confirmPassword == null || 
            confirmPassword.trim().isEmpty() || gender == null || phoneNumber == null) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/teacherRegistration.jsp").forward(request, response);
            return;
        }

        // Validate email format (basic check)
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("error", "Invalid email format.");
            request.getRequestDispatcher("/teacherRegistration.jsp").forward(request, response);
            return;
        }

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/teacherRegistration.jsp").forward(request, response);
            return;
        }

        // Hash the password (using SHA-256 as an example; consider BCrypt for production)
        String hashedPassword = hashPassword(password);

        // Create a new Teacher object
        Teacher teacher = new Teacher(0, userName, email, hashedPassword, gender, phoneNumber);

        try {
            // Check if username or email already exists
            if (teacherDAO.findByUsername(userName) != null || teacherDAO.findByEmail(email) != null) {
                request.setAttribute("error", "Username or email already exists.");
                request.getRequestDispatcher("/teacherRegistration.jsp").forward(request, response);
                return;
            }

            // Save the teacher to the database
            teacherDAO.saveTeacher(teacher);

            // Redirect to a confirmation page or login page
            response.sendRedirect("teacherlogin.jsp");
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred during registration: " + e.getMessage());
            request.getRequestDispatcher("/teacherRegistration.jsp").forward(request, response);
        }
    }

    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }

    @Override
    public void destroy() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
