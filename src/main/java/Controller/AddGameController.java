package Controller;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.FindOneAndUpdateOptions;
import com.mongodb.client.model.ReturnDocument;
import com.mongodb.client.model.Updates;
import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.commons.io.IOUtils;
import org.bson.Document;
import org.bson.types.Binary;

@MultipartConfig 
public class AddGameController extends HttpServlet {

    private MongoClient mongoClient;

    @Override
    public void init() throws ServletException {
        mongoClient = MongoClients.create("mongodb+srv://LoliHunter:Loli_slayer_123@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("Title");
        String gamePlay = request.getParameter("Gameplay");
        String description = request.getParameter("Description");
        String dateRelease = request.getParameter("DateRelease");
        String status = request.getParameter("Status");
        String author = request.getParameter("Author");
        String genre = request.getParameter("Genre");

        // Get the admin's ID from the session
        String adminId = (String) request.getSession().getAttribute("adminId");

        // Handle file upload
        Part filePart = request.getPart("file");
        String fileName = filePart.getSubmittedFileName();
        InputStream fileContent = filePart.getInputStream();

        // Convert the file content to a binary object for MongoDB
        Binary fileData = new Binary(IOUtils.toByteArray(fileContent));

        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("postGame");

    

        Document postGame = new Document("Title", title)
                .append("GamePlay", gamePlay)
                .append("Description", description)
                .append("DateRelease", dateRelease)
                .append("Status", status)
                .append("Author", author)
                .append("Genre", genre)
                .append("AdminId", adminId) // Add admin ID to the post
                .append("FileName", fileName)
                .append("FileData", fileData); // Save the file data

        collection.insertOne(postGame);
           response.sendRedirect("admin-after-login.jsp");

    }

    @Override
    public void destroy() {
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}
