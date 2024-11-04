// LoginController.java
package Controller;

import DAO.UserDAO;
import Model.SuperAdmin;
import Model.UserModel;
import mongodb.MongoConectUser;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the email and password from the request
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Instantiate DAO and fetch SuperAdmin
        UserDAO superAdminDAO = new UserDAO();
        SuperAdmin superAdmin = superAdminDAO.findByEmail(email);

        // Check if the user exists and the password matches
        if (superAdmin != null && superAdmin.getPassWord().equals(password)) {
            try {
                // Check user status
                UserDAO mgcn = new UserDAO();
                UserModel currentUser = mgcn.getUserById(superAdmin.getAdminId());

                // Set session attributes
                HttpSession session = request.getSession();
                session.setAttribute("currentUser", superAdmin);
                session.setAttribute("adminId", superAdmin.getAdminId());
                session.setAttribute("adminName", superAdmin.getName());
                session.setAttribute("adminEmail", superAdmin.getEmail());
                session.setAttribute("photoUrl", superAdmin.getPhotoUrl());

                // Redirect based on the user's role
                String role = superAdmin.getRole();
                if (currentUser.getStatus().equals("Suspend")) {
                    response.sendRedirect("ban.jsp?id=" + superAdmin.getAdminId());
                } else {
                    switch (role) {
                        case "0": // Regular user
                            response.sendRedirect("ReadGameHomeMember?id=" + superAdmin.getAdminId());
                            break;
                        case "1": // Admin
                            response.sendRedirect("ReadGameHomeAdmin?adminid=" + superAdmin.getAdminId());
                            break;
                        default:
                            response.sendRedirect("error-page.jsp");
                            break;
                    }
                }
            } catch (Exception ex) {
                Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
                request.setAttribute("errorMessage", "Error processing date.");
                request.getRequestDispatcher("error-page.jsp").forward(request, response);
            }
        } else if (superAdmin != null && !superAdmin.getPassWord().equals(password)) {
            // If authentication fails, set an error message
            request.setAttribute("errorMessage", "Wrong password");
            request.getRequestDispatcher("wrong_password.jsp").forward(request, response);
        } else if(superAdmin == null){
            request.setAttribute("errorMessage", "Invalid email");
            request.getRequestDispatcher("wrong_password.jsp").forward(request, response);
        }
    }
}
