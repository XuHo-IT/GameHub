package Controller;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import org.apache.commons.io.IOUtils;
import org.bson.Document;
import org.bson.types.ObjectId;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;

@MultipartConfig
public class TopicDeleteController extends HttpServlet {

    private MongoClient mongoClient;

    @Override
    public void init() throws ServletException {
        // Initialize MongoDB client
        mongoClient = MongoClients.create("mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
    }

    // Delete Topic
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve topic ID from the request
        String topicId = request.getParameter("topicId");

        // Get MongoDB database and collection
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("forumTopics");

        // Delete document from MongoDB
        collection.deleteOne(Filters.eq("_id", new ObjectId(topicId)));

        // Respond with success message
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write("Topic deleted successfully");
    }

    @Override
    public void destroy() {
        // Close the MongoDB client
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}
