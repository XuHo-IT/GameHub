package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.CommentDAO;

public class AddComment extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the form parameters
        String comment = request.getParameter("comment");
        String userId = request.getParameter("memberid");
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
        response.sendRedirect("forum-detail-after-login-member.jsp?topicId=" + topicId + "&userId=" + userId);
    }
}
