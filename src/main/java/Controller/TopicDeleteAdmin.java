package Controller;

import DAO.TopicDAO;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import utils.MongoDBConnectionManager1;

public class TopicDeleteAdmin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the action and topicId from the form submission
        String action = request.getParameter("action");
        String topicId = request.getParameter("topicId");

        if ("delete".equals(action)) {
            deleteTopic(request, response, topicId);
        }
    }

    private void deleteTopic(HttpServletRequest request, HttpServletResponse response, String topicId)
            throws ServletException, IOException {
        // Check if the user is logged in
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("ReadGameHomeController"); 
            return;
        }

        String userId = (String) session.getAttribute("adminId");
        
        // Get MongoDB database and create DAO
     
        TopicDAO topicDAO = new TopicDAO();

        // Delete the topic
        topicDAO.deleteTopic(topicId);

        // Redirect to the appropriate page after deletion
        response.sendRedirect("ReadTopicAdmin?userId=" + userId);
    }
}
