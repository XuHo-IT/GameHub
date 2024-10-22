package Controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

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
public class SuspendUserController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("id");
        MongoConectUser mgcn = new MongoConectUser();

        // Assuming you have a method in your MongoConectUser class to suspend a user
        boolean suspended = mgcn.suspendUser(userId);

        if (suspended) {

            response.sendRedirect("chart/list-user.jsp");
        } else {
            response.sendRedirect("chart/list-user.jsp?error=Could not suspend user");

        }
    }
}
