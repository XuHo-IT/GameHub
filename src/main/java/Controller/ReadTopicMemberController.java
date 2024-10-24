package Controller;

import Model.Topic;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.bson.Document;
import org.bson.types.Binary;
import org.bson.types.ObjectId;
import utils.MongoDBConnectionManager2;

public class ReadTopicMemberController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if the request is for logging out
        String action = request.getParameter("action");
        String userId = request.getParameter("userId");
        if ("logout".equalsIgnoreCase(action)) {
            // Logout: remove session attributes and redirect
            HttpSession session = request.getSession();
            session.removeAttribute("currentUser"); // Remove the current user session
            HttpSession session2 = request.getSession();
            session2.setAttribute("succMsg", "Logout Successfully"); // Success message for logout
            response.sendRedirect("ReadGameHomeController"); // Redirect to home
            return; // Exit from the method
        }
        try {
            MongoClient mongoClient = MongoDBConnectionManager2.getMongoClient();
            MongoDatabase database = mongoClient.getDatabase("GameHub");
            MongoCollection<Document> collection = database.getCollection("topic");
            List<Topic> topicList = new ArrayList<>();

            MongoCollection<Document> usersCollection = mongoClient.getDatabase("GameHub").getCollection("superadmin");

            // Find all documents in the collection
            FindIterable<Document> topics = collection.find();

            // Map each document to a Topic object
            if (topics != null) {
                for (Document topicDocument : topics) {
                    Object imageData = topicDocument.get("ImageData");
                    String imageDataBase64;

                    // Lấy thông tin người dùng từ collection "superadmin"
                    String userIdTopic = topicDocument.getString("UserId");

                    Document user = null;
                    if (userIdTopic != null && ObjectId.isValid(userIdTopic)) {
                        user = usersCollection.find(Filters.eq("_id", new ObjectId(userIdTopic))).first();
                    }

                    String photoUrl = (user != null) ? user.getString("PhotoUrl") : "./img/t-rex.png";

                    if (imageData != null) {
                        if (imageData instanceof Binary) {
                            Binary fileDataBinary = (Binary) imageData;
                            byte[] data = fileDataBinary.getData();
                            if (data != null && data.length > 0) {
                                imageDataBase64 = Base64.getEncoder().encodeToString(data);
                            } else {
                                imageDataBase64 = ""; // Gán giá trị mặc định nếu không có dữ liệu
                            }
                        } else if (imageData instanceof String) {
                            imageDataBase64 = (String) imageData;
                        } else {
                            imageDataBase64 = ""; // Gán giá trị mặc định nếu không phải là Binary hoặc String
                        }
                    } else {
                        imageDataBase64 = ""; // Gán giá trị mặc định nếu imageData là null
                    }

                    String userName = (user != null && user.containsKey("User Name")) ? user.getString("User Name") : "Unknown User";

                    Topic topic = new Topic(
                            topicDocument.getObjectId("_id").toString(),
                            topicDocument.getString("UserId"),
                            topicDocument.getString("Title"),
                            topicDocument.getString("Description"),
                            imageDataBase64, // Sử dụng imageDataBase64 đã được mã hóa
                            photoUrl,
                            (user != null && user.containsKey("Name")) ? user.getString("Name") : "Unknown Name",
                            topicDocument.getDate("CreatedAt")
                    );
                    topicList.add(topic);
                }
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

            request.getRequestDispatcher("forum-after-login-member.jsp?userId="+userId).forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving topic." + e.getMessage());
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
    }
}
