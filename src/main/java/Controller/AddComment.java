package Controller;

import java.io.IOException;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.Document;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import utils.MongoDBConnectionManager1;

public class AddComment extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the form parameters
        String comment = request.getParameter("comment");
        String memberId = request.getParameter("memberId");
        String topicId = request.getParameter("topicId");

        LocalDateTime currentDateTime = LocalDateTime.now();

        MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("comment");

        Document comments = new Document("TopicId", topicId)
                .append("UserId", memberId)
                .append("Content", comment)
                .append("Status", "unedited")
                .append("Date", currentDateTime);
        collection.insertOne(comments);
        response.sendRedirect("forum-detail-after-login-member.jsp");
    }

}
