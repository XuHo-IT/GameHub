package Controller;

import DAO.TopicDAO;
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
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;
import utils.MongoDBConnectionManager;

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

        // Validate form inputs
        if (topicTitle == null || topicTitle.trim().isEmpty() || topicContent == null || topicContent.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Title and Content are required fields.");
            request.getRequestDispatcher("forum-after-login-member.jsp").forward(request, response);
            return;
        }

        // Handle file upload
        String fileDataBase64 = null;
        Part filePart = request.getPart("topicImage");
        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream fileContent = filePart.getInputStream()) {
                byte[] fileDataBytes = IOUtils.toByteArray(fileContent);
                fileDataBase64 = Base64.getEncoder().encodeToString(fileDataBytes);
            }
        }

        // Get MongoDB database and create DAO
     
        TopicDAO topicDAO = new TopicDAO();

        // Create the topic in the database
        topicDAO.createTopic(topicTitle, topicContent, fileDataBase64, userId);

        // Redirect to the forum page after successful insertion
        response.sendRedirect("ReadTopicAdmin?adminId=" + userId);
    }
}
