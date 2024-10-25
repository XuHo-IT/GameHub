package Controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.io.IOUtils;
import org.bson.Document;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import Model.Comment;
import java.time.LocalDateTime;
import utils.MongoDBConnectionManager1;

public class AddCommentAdmin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the form parameters
        String comment = request.getParameter("comment");
        String userId = request.getParameter("userid");
        String topicId = request.getParameter("topicid");

        LocalDateTime currentDateTime = LocalDateTime.now();

        MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("comment");

        Document comments = new Document("TopicId", topicId)
                .append("UserId", userId)
                .append("Content", comment)
                .append("Status", "unedited")
                .append("Date", currentDateTime);
        collection.insertOne(comments);
        
        String adminId = (String) request.getSession().getAttribute("adminid");
        
        response.sendRedirect("forum-detail-after-login.jsp?adminid=" + adminId);
    }

}
