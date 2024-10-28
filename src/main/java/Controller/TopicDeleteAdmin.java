package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.TopicDAO;
import DAO.CommentDAO;

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
        CommentDAO commentDAO = new CommentDAO();

        // Delete the topic
        topicDAO.deleteTopic(topicId);
        commentDAO.deleteManyComment(topicId);

        // Redirect to the appropriate page after deletion
        response.sendRedirect("ReadTopicAdmin?userId=" + userId);
    }
}
