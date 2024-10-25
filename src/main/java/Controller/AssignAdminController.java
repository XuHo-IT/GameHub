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

/**
 *
 * @author Admin
 */
public class AssignAdminController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("id");
        MongoConectUser mgcn = new MongoConectUser();

        // Assuming you have a method in your MongoConectUser class to suspend a user
        boolean assign = mgcn.assignAdmin(userId);
        String adminId = (String) request.getSession().getAttribute("adminid");

        if (assign) {
            response.sendRedirect("list-user.jsp");
        } else {
            response.sendRedirect("list-user.jsp?adminid=" + adminId + "&error=Could not suspend user");
        }
    }

}
