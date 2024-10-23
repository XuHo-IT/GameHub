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
public class TopicUpdateController extends HttpServlet {

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
        MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();
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
}
