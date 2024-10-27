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

public class UpdateCommentController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String commentId = request.getParameter("commentid");
        String newContent = request.getParameter("newContent");
        String topicId = request.getParameter("topicid");

        // Input validation
        if (commentId == null || commentId.trim().isEmpty() || newContent == null || newContent.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Comment ID and new content are required.");
            return;
        }

        // Get MongoDB client and initialize CommentDAO
     
        CommentDAO commentDAO = new CommentDAO();

        try {
            // Update the comment
            commentDAO.updateComment(commentId, newContent);
            // Redirect after successful update
            response.sendRedirect("forum-detail-after-login-member.jsp?topicId=" + topicId);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error updating comment: " + e.getMessage());
        }
    }
}
