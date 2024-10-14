package Controller;

import mogodb.MongoConectUser;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/EditUserController")
public class EditUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        MongoConectUser mongoConectUser = new MongoConectUser();
        boolean isUpdated = mongoConectUser.updateUser(userId, name, email, phone, address);

        if (isUpdated) {
            response.sendRedirect("user-profile.jsp?id=" + userId);
        } else {
            response.getWriter().println("Failed to update user profile.");
        }
    }
}
