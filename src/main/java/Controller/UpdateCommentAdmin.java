package Controller;

import DAO.CommentDAO;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.bson.types.ObjectId;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import utils.MongoDBConnectionManager;

public class UpdateCommentAdmin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String commentId = request.getParameter("commentid");
        String newContent = request.getParameter("newContent");
        String topicId = request.getParameter("topicid");
        String userId = request.getParameter("adminId");

        // Kết nối MongoDB
        CommentDAO commentDAO = new CommentDAO();

        // Add the comment
        commentDAO.updateComment(commentId, newContent);

        response.sendRedirect("forum-detail-after-login-member.jsp?topicId=" + topicId + "&userId=" + userId);
    }

}
