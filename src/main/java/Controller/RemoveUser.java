/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import mongodb.MongoConectUser;

public class RemoveUser extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         String userId = request.getParameter("id"); // Get user ID from request

        MongoConectUser mongoConectUser = new MongoConectUser();
        boolean isDeleted = mongoConectUser.deleteUserById(userId); // Delete user from database

        if (isDeleted) {
            response.sendRedirect("chart/list-user.jsp?message=User deleted successfully."); // Redirect to user list with success message
        } else {
            response.sendRedirect("chart/list-user.jsp?error=User deletion failed."); // Redirect with error message
        }
    }
    
}
