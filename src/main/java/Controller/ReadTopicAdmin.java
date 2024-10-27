package Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.Document;
import org.bson.types.Binary;
import org.bson.types.ObjectId;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

import Model.TopicTemp;
import javax.servlet.http.HttpSession;
import utils.MongoDBConnectionManager1;

public class ReadTopicAdmin extends HttpServlet {

    private static final Logger logger = LoggerFactory.getLogger(ReadTopicAdmin.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();
            MongoDatabase database = mongoClient.getDatabase("GameHub");

            // Collection for topics and comments
            MongoCollection<Document> topicCollection = database.getCollection("topic");
            MongoCollection<Document> commentCollection = database.getCollection("comment");
            MongoCollection<Document> usersCollection = database.getCollection("superadmin");

            List<TopicTemp> topicList = new ArrayList<>();
            
            // Find all documents in the topic collection
            FindIterable<Document> topics = topicCollection.find();
            Object topicId = "";

            // Map each document to a Topic object
            for (Document topicDocument : topics) {
                String userIdStr = topicDocument.getString("UserId");
                Document user = null;

                // Fetch user information from the "superadmin" collection
                if (userIdStr != null && ObjectId.isValid(userIdStr)) {
                    user = usersCollection.find(Filters.eq("_id", new ObjectId(userIdStr))).first();
                }

                // Handle missing or null user
                String photoUrl = (user != null) ? user.getString("PhotoUrl") : "./img/t-rex.png";
                String userName = (user != null) ? user.getString("Name") : "Unknown User";

                // Handle image data, convert to Base64 if Binary type
                Object imageData = topicDocument.get("ImageData");
                String imageDataBase64 = "";

                if (imageData instanceof Binary) {
                    Binary imageDataBinary = (Binary) imageData;
                    imageDataBase64 = Base64.getEncoder().encodeToString(imageDataBinary.getData());
                } else if (imageData instanceof String) {
                    imageDataBase64 = (String) imageData; // Use if already a string
                } else {
                    imageDataBase64 = ""; // Default or placeholder image
                }

                // Get the TopicId and count the comments related to this topic
                topicId = topicDocument.getObjectId("_id");
                long commentCount = commentCollection.countDocuments(Filters.eq("TopicId", topicId.toString()));

                // Create Topic object and add to the list
                TopicTemp topic = new TopicTemp(
                        topicId.toString(),
                        topicDocument.getString("UserId"),
                        topicDocument.getString("Title"),
                        topicDocument.getString("Description"),
                        imageDataBase64, // Only use Base64 encoded image data
                        photoUrl,
                        userName, // User's name, or "Unknown User" if not found
                        topicDocument.getDate("CreatedAt"),
                        commentCount // Pass the comment count
                );
                topicList.add(topic);
            }

            // Reverse the list for displaying the latest topics first
            Collections.reverse(topicList);

            // Pagination logic
            int itemsPerPage = 6;
            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                currentPage = Integer.parseInt(pageParam);
            }
            int totalItems = topicList.size();
            int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
            int startIndex = (currentPage - 1) * itemsPerPage;
            int endIndex = Math.min(startIndex + itemsPerPage, totalItems);

            // Sublist for current page
            List<TopicTemp> topicsForCurrentPage = topicList.subList(startIndex, endIndex);
            
            // Set attributes for JSP
            HttpSession session = request.getSession();
            session.setAttribute("topicId", topicId.toString());
            
            request.setAttribute("topics", topicsForCurrentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);

            // Forward to the forum page
            request.getRequestDispatcher("forum-after-login.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving topics.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}
