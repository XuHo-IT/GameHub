package Controller;

import DAO.TopicDAO;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;
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
import utils.MongoDBConnectionManager;

@MultipartConfig
public class TopicUpdateAdmin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String topicId = request.getParameter("topicId");

        if ("update".equals(action)) {
            updateTopic(request, response, topicId);
        }
    }

    private void updateTopic(HttpServletRequest request, HttpServletResponse response, String topicId)
            throws ServletException, IOException {
        // Check if the user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("Unauthorized: You must be logged in to update a topic.");
            return;
        }

        // Validate topicId
        if (!isValidObjectId(topicId)) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid topic ID.");
            return;
        }

        String userId = (String) session.getAttribute("adminId");
      
        TopicDAO topicDAO = new TopicDAO();

        // Retrieve form data
        String topicTitle = request.getParameter("topicTitle");
        String topicContent = request.getParameter("topicContent");
        Part filePart = request.getPart("topicImage");
        String fileDataBase64 = null;

        if (filePart != null && filePart.getSize() > 0) {
            InputStream fileContent = filePart.getInputStream();
            byte[] fileDataBytes = IOUtils.toByteArray(fileContent);
            fileDataBase64 = Base64.getEncoder().encodeToString(fileDataBytes);
        }

        // Call the update method from the DAO
        topicDAO.updateTopic(topicId, topicTitle, topicContent, fileDataBase64);

        // Redirect to the topic reading page
        response.sendRedirect("ReadTopicAdmin?adminId=" + userId);
    }

    private boolean isValidObjectId(String id) {
        return id != null && id.length() == 24 && id.matches("[0-9a-fA-F]+");
    }
}
