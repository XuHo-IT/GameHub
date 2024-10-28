package Controller;

import DAO.CommentDAO;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.MongoDBConnectionManager1;

import java.io.IOException;

public class AddCommentAdmin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the form parameters
        String comment = request.getParameter("comment");
        String userId = request.getParameter("adminid");
        String topicId = request.getParameter("topicid");

        // Validate input (optional)
        if (comment == null || comment.trim().isEmpty()) {
            response.sendRedirect("forum-detail-after-login-member.jsp?topicId=" + topicId + "&error=Comment cannot be empty");
            return;
        }

        // Get MongoDB client and initialize CommentDAO
      
        CommentDAO commentDAO = new CommentDAO();

        // Add the comment
        commentDAO.addComment(topicId, userId, comment);

        // Redirect to the forum detail page
        response.sendRedirect("forum-detail-after-login.jsp?topicId=" + topicId + "&adminid=" + userId);
    }
}
