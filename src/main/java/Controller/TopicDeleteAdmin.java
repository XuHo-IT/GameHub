package Controller;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import org.bson.Document;
import org.bson.types.ObjectId;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import javax.servlet.http.HttpSession;
import utils.MongoDBConnectionManager1;

public class TopicDeleteAdmin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the action and topicId from the form submission
        String action = request.getParameter("action");
        String topicId = request.getParameter("topicId");

        if ("delete".equals(action)) {
            deleteTopic(request, response, topicId);
        }
    }

    private void deleteTopic(HttpServletRequest request, HttpServletResponse response, String topicId)
            throws ServletException, IOException {

        // Check if the user is logged in
        HttpSession session = request.getSession(false);
        String userId = (String) session.getAttribute("adminId");

        // Get MongoDB database and collection
        MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("topic");

        // Delete the topic
        collection.deleteOne(Filters.eq("_id", new ObjectId(topicId)));

        // Redirect to the appropriate page after deletion
        response.sendRedirect("ReadTopicAdmin?userId" + userId);
    }
}
