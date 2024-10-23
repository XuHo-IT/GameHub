package Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.bson.Document;
import org.bson.types.Binary;
import org.bson.types.ObjectId;
import utils.MongoDBConnectionManager1;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import Model.Topic;

public class ReadTopicController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();
            MongoDatabase database = mongoClient.getDatabase("GameHub");
            MongoCollection<Document> collection = database.getCollection("topic");
            List<Topic> topicList = new ArrayList<>();

            MongoCollection<Document> usersCollection = mongoClient.getDatabase("GameHub").getCollection("superadmin");

            // Find all documents in the collection
            FindIterable<Document> topics = collection.find();
            // Map each document to a Topic object
            for (Document topicDocument : topics) {
                Object imageData = topicDocument.get("ImageData");
                String imageDataBase64;

                // Lấy thông tin người dùng từ collection "superadmin"
                Document user = usersCollection.find(Filters.eq("_id", new ObjectId(topicDocument.getString("UserId"))))
                        .first();
                String photoUrl = (user != null) ? user.getString("PhotoUrl") : "./img/t-rex.png";

                if (imageData instanceof Binary) {
                    Binary imageDataBinary = (Binary) imageData;
                    imageDataBase64 = Base64.getEncoder().encodeToString(imageDataBinary.getData());
                } else if (imageData instanceof String) {
                    imageDataBase64 = (String) imageData;
                } else {
                    // Nếu không có ImageData, sử dụng một hình ảnh mặc định
                    imageDataBase64 = ""; // hoặc gán URL của hình ảnh mặc định
                }

                String userName = (user != null) ? user.getString("UserName") : "Unknown User"; // Make sure the field exists
                Topic topic = new Topic(
                        topicDocument.getObjectId("_id").toString(),
                        topicDocument.getString("UserId"),
                        topicDocument.getString("Title"),
                        topicDocument.getString("Description"),
                        topicDocument.getString("ImageData"),
                        photoUrl,
                        user.getString("Name"));
                topicList.add(topic);
            }

            Collections.reverse(topicList);
            int itemsPerPage = 6;
            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                currentPage = Integer.parseInt(pageParam);
            }
            int totalItems = topicList.size();
            int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
            int startIndex = (currentPage - 1) * itemsPerPage;
            int endIndex = Math.min(startIndex + itemsPerPage, totalItems);
            // Sublist for current page
            List<Topic> topicsForCurrentPage = topicList.subList(startIndex, endIndex);

            request.setAttribute("topics", topicsForCurrentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);
            request.getRequestDispatcher("forum.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving topic.");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
    }
}
