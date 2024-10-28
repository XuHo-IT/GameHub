/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mongodb.MongoConectUser;



/**
 *
 * @author Admin
 */
@WebServlet(name = "UnSuspendUser", urlPatterns = {"/UnSuspendUser"})
public class UnSuspendUser extends HttpServlet {

 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("id");

        String adminId = request.getParameter("adminId");
         UserDAO userDAO = new UserDAO();
        boolean isUnsuspended = userDAO.unsuspendUser(userId); 

        if (isUnsuspended) {

            response.sendRedirect("chart/list-user.jsp?success=User unsuspended successfully?adminid="+adminId);
        } else {
            response.sendRedirect("chart/list-user.jsp?error=Failed to unsuspend user?adminid="+adminId);

        }
    }

}
