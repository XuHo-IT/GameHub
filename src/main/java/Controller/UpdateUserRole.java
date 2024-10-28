package Controller;

import DAO.UserDAO;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.MongoDBConnectionManager;
import java.io.IOException;

public class UpdateUserRole extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the user ID and the new role from the request
        String userId = request.getParameter("userId");
        String newRole = request.getParameter("role");
        String adminId = request.getParameter("adminId");

        // Input validation
        if (userId == null || userId.trim().isEmpty() || newRole == null || newRole.trim().isEmpty()) {
            response.sendRedirect("chart/list-user.jsp?error=User ID and Role are required?adminId="+adminId);
            return;
        }
        UserDAO userDAO = new UserDAO();

        try {
            // Update the user's role
            boolean isUpdated = userDAO.updateUserRole(userId, newRole);
            if (isUpdated) {
                // Redirect back to the user management page with a success message
                response.sendRedirect("chart/list-user.jsp?success=Role updated successfully?adminId="+adminId);
            } else {
                // Handle the case where the user was not found
                response.sendRedirect("chart/list-user.jsp?error=User not found?adminId="+adminId);
            }
        } catch (Exception e) {
            response.sendRedirect("chart/list-user.jsp?error=Error updating role: " + e.getMessage());
        }
    }
}
