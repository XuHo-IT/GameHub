package Controller;

import DAO.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ChangePassWord extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("id");
        String oldPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Check if newPassword and confirmPassword match
        if (!newPassword.equals(confirmPassword)) {
            response.getWriter().println("New password and confirm password do not match.");
            return;
        }

        UserDAO userDAO = new UserDAO();
        boolean isPasswordChanged = userDAO.changePassword(userId, oldPassword, newPassword);

        // If password changed successfully
        if (isPasswordChanged) {   
            // Determine home page based on role
            String role = userDAO.getUserById(userId).getRole();
            if ("1".equals(role)) {
                response.sendRedirect("Change_password_success_admin.jsp?userId="+userId);
            } else {
                response.sendRedirect("Change_password_success_member.jsp?userid="+userId);
            }
        } else {
            // Redirect to user profile if password change fails
            response.sendRedirect("user_profile.jsp");
        }
    }
}
