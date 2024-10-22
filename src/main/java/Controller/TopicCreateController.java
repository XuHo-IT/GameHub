package Controller;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.apache.commons.io.IOUtils;
import org.bson.Document;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;
import java.util.Date;
import javax.servlet.http.HttpSession;

@MultipartConfig
public class TopicCreateController extends HttpServlet {

    private MongoClient mongoClient;

    @Override
    public void init() throws ServletException {
        // Connect to MongoDB
        mongoClient = MongoClients.create("mongodb+srv://LoliHunter:Loli_slayer_123@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if the user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            // Redirect to login page if not logged in
            response.sendRedirect("index.jsp");
            return;
        }

        // Get the logged-in user's ID
        String userId = (String) session.getAttribute("userId");

        // Retrieve form inputs
        String topicTitle = request.getParameter("topicTitle");
        String topicContent = request.getParameter("topicContent");
        Part filePart = request.getPart("topicImage");

        // Validate form inputs
        if (topicTitle == null || topicTitle.trim().isEmpty() || topicContent == null || topicContent.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Title and Content are required fields.");
            request.getRequestDispatcher("forum-after-login-member.jsp").forward(request, response);
            return;
        }

        // Process the image file (optional)
        String fileDataBase64 = null;
        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream fileContent = filePart.getInputStream()) {
                byte[] fileDataBytes = IOUtils.toByteArray(fileContent);
                fileDataBase64 = Base64.getEncoder().encodeToString(fileDataBytes);
            }
        }

        // Insert the new topic into the 'topic' collection
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("topic");

        // Create the document for the new topic
        Document topicDocument = new Document("Title", topicTitle)
                .append("Description", topicContent)
                .append("ImageData", fileDataBase64 != null ? fileDataBase64 : "")
                .append("UserId", userId) // Ensure userId is properly added
                .append("CreatedAt", new Date());

        // Insert the document into the collection
        collection.insertOne(topicDocument);

        // Redirect to the topic listing page
        response.sendRedirect("ReadTopicMemberController");
    }

    @Override
    public void destroy() {
        // Close the MongoDB client when the servlet is destroyed
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}
