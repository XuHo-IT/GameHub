package Controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import DAO.UserDAO;
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
public class SuspendUser extends HttpServlet {

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
         String adminId = request.getParameter("adminId");
         UserDAO userDAO = new UserDAO();
        boolean suspended = userDAO.suspendUser(userId); 
        


        if (suspended) {
            response.sendRedirect("chart/list-user.jsp?message=User suspend successfully?adminid="+adminId);
        } else {
            response.sendRedirect("chart/list-user.jsp?error=Could not suspend user?adminid="+adminId);
        }
    }
}
