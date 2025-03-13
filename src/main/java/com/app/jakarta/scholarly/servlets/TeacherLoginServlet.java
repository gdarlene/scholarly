package com.app.jakarta.scholarly.servlets;

import java.io.IOException;
import com.app.jakarta.scholarly.models.Teacher;
import com.app.jakarta.scholarly.services.TeacherDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

@WebServlet(name = "TeacherLoginServlet", value = "/teacher-login")
public class TeacherLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TeacherDAO teacherDAO;
    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("ScholarlyPU"); // Adjust persistence unit name
        teacherDAO = new TeacherDAO(emf); // Pass EntityManagerFactory
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/signin.jsp").forward(request, response); // Forward instead of redirect
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        authenticate(request, response);
    }

    private void authenticate(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (areFieldsMissing(email, password)) {
            request.setAttribute("error", "Missing email or password.");
            request.getRequestDispatcher("/signin.jsp").forward(request, response);
            return;
        }

        Teacher teacher = null;
        try {
            teacher = teacherDAO.getTeacherByEmail(email); // Fetch Teacher by email
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred during login.");
            request.getRequestDispatcher("/signin.jsp").forward(request, response);
            return;
        }

        if (teacher == null || !org.mindrot.jbcrypt.BCrypt.checkpw(password, teacher.getPassword())) {
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("/signin.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("loggedInTeacher", teacher); // Consistent session attribute name
        session.setMaxInactiveInterval(30 * 60); // Session timeout of 30 minutes
        response.sendRedirect("/teacher-dashboard"); // Adjusted redirect
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
