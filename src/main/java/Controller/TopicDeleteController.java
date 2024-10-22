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

public class TopicDeleteController extends HttpServlet {

    private MongoClient mongoClient;

    @Override
    public void init() throws ServletException {
        mongoClient = MongoClients.create("mongodb+srv://LoliHunter:Loli_slayer_123@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
        // Initialize MongoDB client
        mongoClient = MongoClients.create("mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
    }

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

        // Access the MongoDB database and collection
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

    @Override
    public void destroy() {
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}
