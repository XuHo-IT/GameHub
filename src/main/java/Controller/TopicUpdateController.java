package Controller;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
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
import javax.servlet.http.HttpSession;

@MultipartConfig
public class TopicUpdateController extends HttpServlet {

    private MongoClient mongoClient;

    @Override
    public void init() throws ServletException {
        mongoClient = MongoClients.create("mongodb+srv://LoliHunter:Loli_slayer_123@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
        // Initialize MongoDB client
        mongoClient = MongoClients.create("mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if the user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("Unauthorized: You must be logged in to update a topic.");
            return;
        }

        // Get the logged-in user's ID
        String userId = (String) session.getAttribute("userId");

        // Retrieve form data
        String topicId = request.getParameter("topicId");
        String topicTitle = request.getParameter("topicTitle");
        String topicContent = request.getParameter("topicContent");

        Part filePart = request.getPart("topicImage");
        String fileDataBase64 = null;
        if (filePart != null && filePart.getSize() > 0) {
            InputStream fileContent = filePart.getInputStream();
            byte[] fileDataBytes = IOUtils.toByteArray(fileContent);
            fileDataBase64 = Base64.getEncoder().encodeToString(fileDataBytes);
        }

        // Get the 'topic' collection
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("topic");

        // Verify that the topic exists and belongs to the logged-in user
        Document existingTopic = collection.find(Filters.eq("_id", new ObjectId(topicId))).first();
        if (existingTopic == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("Topic not found.");
            return;
        }

        if (!existingTopic.getString("UserId").equals(userId)) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.getWriter().write("Forbidden: You do not have permission to update this topic.");
            return;
        }

        // Prepare fields for updating
        Document updateFields = new Document("Title", topicTitle)
                .append("Description", topicContent); // 'Description' is the assumed field for 'Content'

        if (fileDataBase64 != null) {
            updateFields.append("ImageData", fileDataBase64);
        }

        // Update the topic in the collection
        collection.updateOne(Filters.eq("_id", new ObjectId(topicId)), new Document("$set", updateFields));

        // Respond with success
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write("Topic updated successfully");
    }

    @Override
    public void destroy() {
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}
