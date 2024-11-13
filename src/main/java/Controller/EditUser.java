package Controller;


import DAO.UserDAO;
import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.bson.Document;
import utils.MongoDBConnectionManager;


public class EditUser extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("id");
        String name = request.getParameter("name");    
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        UserDAO user = new UserDAO();
        boolean isUpdated = user.updateUser(userId, name, email, phone, address);


        if (isUpdated) {
            response.sendRedirect("user-profile.jsp?userid=" + userId);
        } else {
            response.getWriter().println("Failed to update user profile.");
        }

    }
}


