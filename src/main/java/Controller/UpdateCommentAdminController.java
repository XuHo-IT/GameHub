                       package Controller;

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
import utils.MongoDBConnectionManager1;

public class UpdateCommentAdminController extends HttpServlet {

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String commentId = request.getParameter("commentid");
        String newContent = request.getParameter("newContent");
        String topicId = request.getParameter("topicid");

        // Kết nối MongoDB
            MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("comment");

        // Tạo truy vấn để tìm comment bằng _id
        Document query = new Document("_id", new ObjectId(commentId));

        // Tạo document mới chứa nội dung cập nhật
        Document update = new Document("$set", new Document("Content", newContent).append("Status", "edited"));

        try {
           collection.updateOne(query, update);
           destroy();
           response.sendRedirect("forum-detail-after-login.jsp?id=" + topicId);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error updating comment: " + e.getMessage());
        }
    }

}