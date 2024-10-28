/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



public class RemoveUser extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         String userId = request.getParameter("id"); // Get user ID from request
         String adminId = request.getParameter("adminId");
         UserDAO userDAO = new UserDAO();
        boolean isDeleted = userDAO.deleteUserById(userId); // Delete user from database

        if (isDeleted) {
            response.sendRedirect("chart/list-user.jsp?message=User deleted successfully?adminid="+adminId); // Redirect to user list with success message
        } else {
            response.sendRedirect("chart/list-user.jsp?error=User deletion failed?adminid="+adminId); // Redirect with error message
        }
    }
    
}
