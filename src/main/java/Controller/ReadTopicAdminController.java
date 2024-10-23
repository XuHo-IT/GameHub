package Controller;

import Model.Topic;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.FindIterable;
import com.mongodb.client.model.Filters;
import org.bson.Document;
import org.bson.types.Binary;
import org.bson.types.ObjectId;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.List;

import utils.MongoDBConnectionManager1;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ReadTopicAdminController extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(ReadTopicAdminController.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MongoClient mongoClient = null;
        try {
            HttpSession session = request.getSession();
            mongoClient = MongoDBConnectionManager1.getMongoClient();

            // Start the scheduler with the mongoClient and HttpSession
            GameReleaseNotificationAdminController.startScheduler(mongoClient, session);

            // Check if the logout action is triggered
            String action = request.getParameter("action");
            if ("logout".equals(action)) {
                // Logout functionality: remove current user session
                request.getSession().removeAttribute("currentUser");
                request.getSession().setAttribute("succMsg", "Logout Successfully");
                response.sendRedirect("ReadGameHomeController");
                return;
            }

            MongoDatabase database = mongoClient.getDatabase("GameHub");
            MongoCollection<Document> collection = database.getCollection("topic");
            List<Topic> topicList = new ArrayList<>();

            MongoCollection<Document> usersCollection = database.getCollection("superadmin");

            // Find all documents in the collection
            FindIterable<Document> topics = collection.find();

            // Map each document to a Topic object
            for (Document topicDocument : topics) {
                Object imageData = topicDocument.get("ImageData");
                String imageDataBase64;

                // Retrieve user information from the "superadmin" collection
                Document user = usersCollection.find(Filters.eq("_id", new ObjectId(topicDocument.getString("UserId")))).first();
                String photoUrl = (user != null) ? user.getString("PhotoUrl") : "./img/t-rex.png";

                if (imageData instanceof Binary) {
                    Binary imageDataBinary = (Binary) imageData;
                    imageDataBase64 = Base64.getEncoder().encodeToString(imageDataBinary.getData());
                } else if (imageData instanceof String) {
                    imageDataBase64 = (String) imageData;
                } else {
                    // If there is no ImageData, use a default image
                    imageDataBase64 = ""; // or assign a URL of a default image
                }

                String userName = (user != null) ? user.getString("UserName") : "Unknown User";

                Topic topic = new Topic(
                        topicDocument.getObjectId("_id").toString(),
                        topicDocument.getString("UserId"),
                        topicDocument.getString("Title"),
                        topicDocument.getString("Description"),
                        imageDataBase64,
                        photoUrl,
                        userName
                );
                topicList.add(topic);
            }

            Collections.reverse(topicList);

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
            List<Topic> topicsForCurrentPage = topicList.subList(startIndex, endIndex);

            request.setAttribute("topics", topicsForCurrentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);
            
            request.getRequestDispatcher("forum-after-login.jsp").forward(request, response);
        } catch (Exception e) {
            logger.error("Error retrieving topics: ", e); // Log the error
            request.setAttribute("errorMessage", "Error retrieving topics.");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        } finally {
            if (mongoClient != null) {
                mongoClient.close(); // Close the MongoDB client connection
            }
        }
    }
}
