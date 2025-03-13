package com.app.jakarta.scholarly.servlets;

import java.io.*;

import com.app.jakarta.scholarly.models.Teacher;
import com.app.jakarta.scholarly.services.TeacherDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "TeacherRegisterServletServlet", value = "/TeacherRegisterServlet-servlet")

public class TeacherRegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the form data from the request
        String userName = request.getParameter("userName");


        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String gender = request.getParameter("gender");
        String phoneNumber = request.getParameter("phoneNumber");

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/signup.jsp").forward(request, response); // Redirect back to signup page with an error
            return;
        }

        // Create a new Instructor object
        Teacher instructor = new Teacher(0, userName, email, password, gender, phoneNumber);

        // Save the instructor to the database
        TeacherDAO.saveTeacher(instructor);

        // Redirect to a confirmation page or login page
        response.sendRedirect("login.jsp"); // Redirect to login page
    }
}
