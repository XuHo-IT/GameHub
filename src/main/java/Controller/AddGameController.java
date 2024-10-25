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
import java.util.ArrayList;
import java.util.List;
import utils.MongoDBConnectionManager1;

@MultipartConfig
public class AddGameController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Existing form parameters
        String title = request.getParameter("Title");
        String gamePlay = request.getParameter("Gameplay");
        String description = request.getParameter("Description");
        String dateRelease = request.getParameter("DateRelease");
        String author = request.getParameter("Author");
        String genre = request.getParameter("Genre");
        String price = "";
        String adminId = (String) request.getSession().getAttribute("adminId");

        // Primary cover image
        Part filePart = request.getPart("file");
        String fileName = filePart.getSubmittedFileName();
        InputStream fileContent = filePart.getInputStream();
        byte[] fileDataBytes = IOUtils.toByteArray(fileContent);
        String fileDataBase64 = Base64.getEncoder().encodeToString(fileDataBytes);

        Part linkGame = null;
        // Game action images
        List<String> actionImagesBase64 = new ArrayList<>();
        for (Part actionFilePart : request.getParts()) {
            if (actionFilePart.getName().equals("actionFiles")) {
                InputStream actionFileContent = actionFilePart.getInputStream();
                byte[] actionFileDataBytes = IOUtils.toByteArray(actionFileContent);
                String actionFileDataBase64 = Base64.getEncoder().encodeToString(actionFileDataBytes);
                actionImagesBase64.add(actionFileDataBase64);
            }
        }

        // Create a GamePost object
        GamePost gamePost = new GamePost(
                null, title, gamePlay, description, dateRelease, author, genre,
                adminId, fileName, fileDataBase64);

        // Insert the game into MongoDB
        MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();
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
                .append("Link of the game", linkGame)
                .append("ActionImages", actionImagesBase64) // Store action images list
                .append("Price", price);

        collection.insertOne(postGame);

        // Redirect to the admin page
        String memberId = (String) request.getSession().getAttribute("memberid");
        response.sendRedirect("ReadGameHomeAdmin?adminid=" + memberId);
    }
}
