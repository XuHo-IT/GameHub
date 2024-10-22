package Controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.io.IOUtils;
import org.bson.Document;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import Model.GamePost;

@MultipartConfig
public class AddGameController extends HttpServlet {

    private MongoClient mongoClient;

    @Override
    public void init() throws ServletException {
        mongoClient = MongoClients.create(
                "mongodb+srv://LoliHunter:Loli_slayer_123@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
        // Start the daily scheduler to check for game releases
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form parameters
        String title = request.getParameter("Title");
        String gamePlay = request.getParameter("Gameplay");
        String description = request.getParameter("Description");
        String dateRelease = request.getParameter("DateRelease");
        String author = request.getParameter("Author");
        String genre = request.getParameter("Genre");
        String price = "";

       
        // Get admin ID
        String adminId = (String) request.getSession().getAttribute("adminId");

        // Handle file upload
        Part filePart = request.getPart("file");
        String fileName = filePart.getSubmittedFileName();
        InputStream fileContent = filePart.getInputStream();
        byte[] fileDataBytes = IOUtils.toByteArray(fileContent);
        String fileDataBase64 = Base64.getEncoder().encodeToString(fileDataBytes);

        Part linkGame = null;

        // Create a GamePost object
        GamePost gamePost = new GamePost(
                null, title, gamePlay, description, dateRelease, author, genre,
                adminId, fileName, fileDataBase64);

        // Insert the game into MongoDB
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("postGame");
        Document postGame = new Document("Title", gamePost.getTitle())
                .append("GamePlay", gamePost.getGamePlay())
                .append("Description", gamePost.getDescription())
                .append("DateRelease", gamePost.getDateRelease())
                .append("Author", gamePost.getAuthor())
                .append("Genre", gamePost.getGenre())
                .append("AdminId", gamePost.getAdminId())
                .append("FileName", gamePost.getFileName())
                .append("FileData", fileDataBase64)
                .append("LinkGame", linkGame)
                .append("Price", price);

        collection.insertOne(postGame);

        // Redirect to the admin page
        response.sendRedirect("ReadGameHomeAdminController");
    }

    @Override
    public void destroy() {
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}