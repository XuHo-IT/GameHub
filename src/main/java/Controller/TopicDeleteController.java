package Controller;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import org.bson.types.ObjectId;
import org.bson.Document;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import javax.servlet.http.HttpSession;
import utils.MongoDBConnectionManager1;

public class TopicDeleteController extends HttpServlet {

 

    // Delete Topic
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if the user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("Unauthorized: You must be logged in to delete a topic.");
            return;
        }

        // Get the logged-in user's ID
        String userId = (String) session.getAttribute("userId");

        // Get the topic ID from the request
        String topicId = request.getParameter("topicId");

        // Get MongoDB database and collection
            MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("forumTopics");

        // Find the topic by its ID
        Document topicDocument = collection.find(Filters.eq("_id", new ObjectId(topicId))).first();

        // Check if the topic exists
        if (topicDocument == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("Topic not found.");
            return;
        }

        // Verify if the logged-in user is the owner of the topic
        String topicOwnerId = topicDocument.getString("UserId");
        if (!topicOwnerId.equals(userId)) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.getWriter().write("Forbidden: You do not have permission to delete this topic.");
            return;
        }

        // Delete the topic
        collection.deleteOne(Filters.eq("_id", new ObjectId(topicId)));

        // Send success response
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write("Topic deleted successfully");
    }

   
}
