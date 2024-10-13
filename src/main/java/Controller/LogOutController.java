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
import javax.servlet.http.HttpSession;

public class LogOutController extends HttpServlet {

   @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         try{
          HttpSession session = request.getSession();
          session.removeAttribute("currentUser");
          HttpSession session2 = request.getSession();
          session2.setAttribute("succMsg", "Logout Successfully");
          response.sendRedirect("ReadGameHomeController");
       }catch(Exception e){
           e.printStackTrace();
       }
    } 

}
