/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.GoogleAccount;
import Model.GoogleLoginHandler;
import Model.UserModel;
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
public class GoogleLoginController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String code = request.getParameter("code");
            String accessToken = GoogleLoginHandler.getToken(code);
            GoogleAccount acc = GoogleLoginHandler.getUserInfo(accessToken);
            MongoConectUser mgcn = new MongoConectUser();
            if(mgcn.emailExists(acc.getEmail())) {
                UserModel user = mgcn.getUserByEmail(acc.getEmail());
                if(user.getRole().equals("0")) response.sendRedirect("ReadGameHomeMemberController?id=" + user.getId());
                else response.sendRedirect("ReadGameHomeAdminController?id=" + user.getId());
            }else {
                if (mgcn.generateGoogleAccount(acc.getEmail(), acc.getName())) {
                    UserModel user = user = mgcn.getUserByEmail(acc.getEmail());
                    if(user.getRole().equals("0")) response.sendRedirect("ReadGameHomeMemberController?id=" + user.getId());
                    else response.sendRedirect("ReadGameHomeAdminController?id=" + user.getId());
                }else out.print("Error while sign up account");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
