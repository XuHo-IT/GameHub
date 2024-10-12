package Controller;

import Model.GamePost;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.apache.commons.io.IOUtils;
import org.bson.Document;
import org.bson.types.Binary;
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
public class AddGameController extends HttpServlet {

    private MongoClient mongoClient;

    @Override
    public void init() throws ServletException {
        mongoClient = MongoClients.create("mongodb+srv://LoliHunter:Loli_slayer_123@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
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
        String price="";

        // Parse ratings
        double priceRating = parseDoubleSafe(request.getParameter("PriceRating"));
        double graphicRating = parseDoubleSafe(request.getParameter("GraphicRating"));
        double difficultyRating = parseDoubleSafe(request.getParameter("DifficultyRating"));
        double gameplayRating = parseDoubleSafe(request.getParameter("GameplayRating"));
        double averageRating = (priceRating + graphicRating + difficultyRating + gameplayRating) / 4;

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
                adminId, fileName, fileDataBase64
        );

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
                .append("PriceRating", priceRating)
                .append("GraphicRating", graphicRating)
                .append("DifficultyRating", difficultyRating)
                .append("GameplayRating", gameplayRating)
                .append("AverageRating", averageRating)
                .append("Link of the game", linkGame)
                .append("Price", price);

        collection.insertOne(postGame);

        // Redirect to the admin page
        response.sendRedirect("ReadGameHomeAdminController");
    }

    private double parseDoubleSafe(String parameterValue) {
        if (parameterValue != null && !parameterValue.trim().isEmpty()) {
            try {
                return Double.parseDouble(parameterValue);
            } catch (NumberFormatException e) {
                System.err.println("Invalid number format: " + parameterValue);
            }
        }
        return 0.0;
    }

    @Override
    public void destroy() {
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}

