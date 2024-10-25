package Controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.commons.io.IOUtils;
import org.bson.Document;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import java.util.Date;

import utils.MongoDBConnectionManager1;

@MultipartConfig
public class TopicCreateAdmin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Get the logged-in user's ID
        String userId = (String) session.getAttribute("adminId");

        // Retrieve form inputs
        String topicTitle = request.getParameter("topicTitle");
        String topicContent = request.getParameter("topicContent");
        String adminId = (String) request.getSession().getAttribute("adminId");
        // Handle file upload
        Part filePart = request.getPart("topicImage");

        // Validate form inputs
        if (topicTitle == null || topicTitle.trim().isEmpty() || topicContent == null || topicContent.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Title and Content are required fields.");
            request.getRequestDispatcher("forum-after-login.jsp").forward(request, response);
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

        // Get MongoDB database and collection
        MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("topic");

        // Create the document for the new topic
        Document topicDocument = new Document("Title", topicTitle)
                .append("Description", topicContent)
                .append("ImageData", fileDataBase64 != null ? fileDataBase64 : null)
                .append("UserId", userId) // Ensure userId is properly added
                .append("CreatedAt", new Date());

        // Insert the document into the collection
        collection.insertOne(topicDocument);

        // Redirect to the forum page after successful insertion
        response.sendRedirect("ReadTopicAdmin?userId=" + adminId);
    }

}
