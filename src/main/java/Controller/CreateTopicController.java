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
public class CreateTopicController extends HttpServlet {

    private MongoClient mongoClient;

    @Override
    public void init() throws ServletException {
        // Initialize MongoDB client
        mongoClient = MongoClients.create("mongodb+srv://LoliHunter:Loli_slayer_123@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve parameters from the form
        String topicTitle = request.getParameter("topicTitle");
        String topicContent = request.getParameter("topicContent");

        // Handle file upload
        Part filePart = request.getPart("topicImage");
        InputStream fileContent = filePart.getInputStream();
        byte[] fileDataBytes = IOUtils.toByteArray(fileContent);
        String fileDataBase64 = Base64.getEncoder().encodeToString(fileDataBytes);

        // Get MongoDB database and collection
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("forumTopics");

        // Create a Document for MongoDB
        Document topicDocument = new Document("Title", topicTitle)
                .append("Content", topicContent)
                .append("ImageData", fileDataBase64);

        // Insert the document into the collection
        collection.insertOne(topicDocument);

        // Redirect to the forum page after successful insertion
        response.sendRedirect("forum.jsp");
    }

    // Update Topic
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve parameters from the form
        String topicId = request.getParameter("topicId");
        String topicTitle = request.getParameter("topicTitle");
        String topicContent = request.getParameter("topicContent");

        // Handle file upload if a new image is provided
        Part filePart = request.getPart("topicImage");
        String fileDataBase64 = null;
        if (filePart != null && filePart.getSize() > 0) {
            InputStream fileContent = filePart.getInputStream();
            byte[] fileDataBytes = IOUtils.toByteArray(fileContent);
            fileDataBase64 = Base64.getEncoder().encodeToString(fileDataBytes);
        }

        // Get MongoDB database and collection
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("forumTopics");

        // Build update document
        Document updateFields = new Document("Title", topicTitle)
                .append("Content", topicContent);
        if (fileDataBase64 != null) {
            updateFields.append("ImageData", fileDataBase64);
        }

        // Update document in MongoDB
        collection.updateOne(Filters.eq("_id", new ObjectId(topicId)), new Document("$set", updateFields));

        // Respond with success message
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write("Topic updated successfully");
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



