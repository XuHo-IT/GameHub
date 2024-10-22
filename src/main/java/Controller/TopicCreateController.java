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
import utils.MongoDBConnectionManager1;

@MultipartConfig
public class TopicCreateController extends HttpServlet {

  
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
            MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();
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
}
