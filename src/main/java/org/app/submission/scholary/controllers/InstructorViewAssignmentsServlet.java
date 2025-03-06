package org.app.submission.scholary.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.app.submission.scholary.models.Assignment;
import org.app.submission.scholary.services.InstructorDAO;

import java.io.IOException;
import java.util.List;

public class InstructorViewAssignmentsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve filter parameters from the request
        String filter = request.getParameter("filter");  // Added filter parameter
        String classIdStr = request.getParameter("classId");
        String weekStr = request.getParameter("week");
        String viewAll = request.getParameter("viewAll");

        List<Assignment> assignments;

        try {
            // Handle the 'viewAll' parameter to fetch all assignments
            if (viewAll != null && viewAll.equals("true")) {
                assignments = InstructorDAO.getAllAssignments();
            } else if (filter != null && !filter.isEmpty()) {
                // Handle filter-based fetching, like 'Class A', 'Class B', 'This week', etc.
                if (filter.equals("This week") && weekStr != null && !weekStr.isEmpty()) {
                    int week = Integer.parseInt(weekStr);
                    assignments = InstructorDAO.getAssignmentsByWeek(week);
                } else if (filter.equals("Class A") || filter.equals("Class B") || filter.equals("Class C") || filter.equals("Class D")) {
                    // Handle filtering by class
                    int classId = Integer.parseInt(classIdStr);
                    assignments = InstructorDAO.getAssignmentsByClass(classId);
                } else {
                    // Default fallback for any unhandled filters (could be 'Course assignments' or 'Timeline')
                    assignments = InstructorDAO.getAllAssignments();
                }
            } else {
                // Default: Show all assignments if no filters are applied
                assignments = InstructorDAO.getAllAssignments();
            }

            // Set assignments as a request attribute and forward to the view
            request.setAttribute("assignments", assignments);
            request.getRequestDispatcher("/viewAssignments.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            // Redirect in case of invalid number format for class or week parameters
            response.sendRedirect("errorPage.jsp");
        }
    }
}
