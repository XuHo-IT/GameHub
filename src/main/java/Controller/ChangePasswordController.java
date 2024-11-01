package Controller;

import DAO.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mongodb.MongoConectUser;

@WebServlet("/changePassword")
public class ChangePasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("id"); 
        String oldPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            response.getWriter().println("New password and confirm password do not match.");
            return;
        }

        UserDAO mgcn = new UserDAO();
        boolean isPasswordChanged = mgcn.changePassword(userId, oldPassword, newPassword);

        if (isPasswordChanged) {
            response.getWriter().write("Password changed successfully!");
        } else {
            response.getWriter().write("Current password is incorrect or user not found.");
        }
    }
}
