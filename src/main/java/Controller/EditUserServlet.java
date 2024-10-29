package Controller;


import java.io.IOException;
import mongodb.MongoConectUser;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.bson.Document;
import utils.MongoDBConnectionManager;


@WebServlet("/EditUserController")
public class EditUserServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String name = request.getParameter("name");    
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        MongoConectUser mongoConectUser = new MongoConectUser();
        boolean isUpdated = mongoConectUser.updateUser(userId, name, email, phone, address);
        if (isUpdated) {
            response.sendRedirect("user-profile.jsp");
        } else {
            response.getWriter().println("Failed to update user profile.");
        }

    }
}


