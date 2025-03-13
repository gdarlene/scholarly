package com.app.jakarta.scholarly.servlets;

import java.io.IOException;
import com.app.jakarta.scholarly.models.Student;
import com.app.jakarta.scholarly.services.StudentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

@WebServlet(name = "StudentRegisterServlet", value = "/student-register")
public class StudentRegisterServlet extends HttpServlet {
    private EntityManagerFactory emf;
    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("ScholarlyPU"); // Adjust persistence unit name
        studentDAO = new StudentDAO(emf); // Assuming StudentDAO accepts EntityManagerFactory
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Display the registration form
        request.getRequestDispatcher("/student-signup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get the form data from the request
        String userName = request.getParameter("userName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phoneNumber = request.getParameter("phoneNumber");
        String gender = request.getParameter("gender");
        String classRoom = request.getParameter("classRoom");

        // Validate input
        if (areFieldsMissing(userName, email, password, confirmPassword, phoneNumber, gender, classRoom)) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/student-signup.jsp").forward(request, response);
            return;
        }

        // Validate email format
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("error", "Invalid email format.");
            request.getRequestDispatcher("/student-signup.jsp").forward(request, response);
            return;
        }

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/student-signup.jsp").forward(request, response);
            return;
        }

        // Validate password length (6-20 characters as per @Size constraint)
        if (password.length() < 6 || password.length() > 20) {
            request.setAttribute("error", "Password must be between 6 and 20 characters.");
            request.getRequestDispatcher("/student-signup.jsp").forward(request, response);
            return;
        }

        // Validate phone number length (max 12 characters as per @Size constraint)
        if (phoneNumber.length() > 12) {
            request.setAttribute("error", "Phone number must not exceed 12 characters.");
            request.getRequestDispatcher("/student-signup.jsp").forward(request, response);
            return;
        }

        // Hash the password
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        // Create a new Student object
        Student student = new Student(userName, email, hashedPassword, phoneNumber, gender, classRoom);

        try {
            // Check if email already exists
            if (studentDAO.findByEmail(email) != null) {
                request.setAttribute("error", "Email already exists.");
                request.getRequestDispatcher("/student-signup.jsp").forward(request, response);
                return;
            }

            // Save the student to the database
            studentDAO.saveStudent(student);

            // Redirect to a confirmation page or login page
            response.sendRedirect("student-login.jsp");
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred during registration: " + e.getMessage());
            request.getRequestDispatcher("/student-signup.jsp").forward(request, response);
        }
    }

    private boolean areFieldsMissing(String... fields) {
        for (String field : fields) {
            if (field == null || field.trim().isEmpty()) {
                return true;
            }
        }
        return false;
    }

    @Override
    public void destroy() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
