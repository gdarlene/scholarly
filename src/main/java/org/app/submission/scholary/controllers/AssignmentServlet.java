package org.app.submission.scholary.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.app.submission.scholary.models.Assignment;
import org.app.submission.scholary.services.AssignmentDAO;

import java.io.IOException;
import java.io.InputStream;

@MultipartConfig(maxFileSize = 16177215) // 16MB file limit
public class AssignmentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get assignment details
        String title = request.getParameter("assignment");  // Matches frontend 'name' attribute
        String course = request.getParameter("course");
        String deadline = request.getParameter("deadline");

        // Handle file upload
        Part filePart = request.getPart("fileContent"); // Matches frontend 'name' attribute
        InputStream fileContent = null;
        if (filePart != null && filePart.getSize() > 0) {
            fileContent = filePart.getInputStream();
        }

        // Create Assignment object
        Assignment assignment = new Assignment(0, title, course, deadline, fileContent);

        // Save to database
        AssignmentDAO.saveAssignment(assignment);

        // Redirect to assignments page
        response.sendRedirect("assignments.jsp");
    }
}
