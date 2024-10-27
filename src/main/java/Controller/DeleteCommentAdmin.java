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

public class DeleteCommentAdmin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String commentId = request.getParameter("commentId");
        String topicId = request.getParameter("topicId");

        // Validate input
        if (commentId == null || commentId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid comment ID.");
            return;
        }

        // Get MongoDB client and initialize CommentDAO

        CommentDAO commentDAO = new CommentDAO();

        // Delete the comment
        commentDAO.deleteComment(commentId);

        // Redirect back to the forum detail page
        response.sendRedirect("forum-detail-after-login.jsp?id=" + topicId);

    }
}
