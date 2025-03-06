package org.app.submission.scholary.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.app.submission.scholary.models.Instructor;
import org.app.submission.scholary.services.InstructorDAO;

import java.io.IOException;

public class InstructorSignupServlet extends HttpServlet {
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
        Instructor instructor = new Instructor(0, userName, email, password, gender, phoneNumber);

        // Save the instructor to the database
        InstructorDAO.saveInstructor(instructor);

        // Redirect to a confirmation page or login page
        response.sendRedirect("login.jsp"); // Redirect to login page
    }
}
