/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

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
@WebServlet(name = "UnSuspendUserController", urlPatterns = {"/UnSuspendUserController"})
public class UnSuspendUserController extends HttpServlet {

    private MongoConectUser mgcn;

    @Override
    public void init() throws ServletException {
        mgcn = new MongoConectUser();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("id");

        // Call the unsuspendUser method
        boolean isUnsuspended = mgcn.unsuspendUser(userId);

        if (isUnsuspended) {
            response.sendRedirect("chart/list-user.jsp?success=User unsuspended successfully");
        } else {
            response.sendRedirect("chart/list-user.jsp?error=Failed to unsuspend user");
        }
    }

}
