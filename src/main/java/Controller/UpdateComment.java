package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.CommentDAO;

public class UpdateComment extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String commentId = request.getParameter("commentid");
        String newContent = request.getParameter("newContent");
        String topicId = request.getParameter("topicid");
        String userId = request.getParameter("memberId");

        // Kết nối MongoDB
        CommentDAO commentDAO = new CommentDAO();

        // Add the comment
        commentDAO.updateComment(commentId, newContent);

        response.sendRedirect("forum-detail-after-login-member.jsp?topicId=" + topicId + "&userId=" + userId);
    }

}
