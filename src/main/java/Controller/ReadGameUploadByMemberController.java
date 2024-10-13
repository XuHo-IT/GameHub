package Controller;

import Model.GamePost;
import Model.Genre;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
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

public class ReadGameUploadByMemberController extends HttpServlet {
    private MongoClient mongoClient;

    @Override
    public void init() throws ServletException {
        mongoClient = MongoClients.create("mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        try {
            MongoDatabase database = mongoClient.getDatabase("GameHub");
            MongoCollection<Document> collection = database.getCollection("postGameMember");
            List<GamePost> postList = new ArrayList<>();

            // Fetch genres from MongoDB
            MongoCollection<Document> genreCollection = database.getCollection("Genre");
            List<Document> genreDocuments = genreCollection.find().into(new ArrayList<>());
            List<Genre> genres = new ArrayList<>();
            for (Document doc : genreDocuments) {
                Genre genre = new Genre();
                genre.setGenreId(doc.getObjectId("_id").toString());
                genre.setGenre(doc.getString("Genre"));
                genres.add(genre);
            }
            request.setAttribute("genres", genres);

            // Retrieve the genre parameter from the request, if it exists
            String selectedGenreId = request.getParameter("genre");

            // Fetch game posts from MongoDB
            FindIterable<Document> posts;
            if (selectedGenreId != null && !selectedGenreId.isEmpty()) {
                // Filter posts by genre
                posts = collection.find(new Document("Genre", selectedGenreId));
            } else {
                // Retrieve all posts if no genre is selected
                posts = collection.find();
            }

            // Map each document to a GamePost object
            for (Document post : posts) {
                Object fileData = post.get("FileData");
                String fileDataBase64;
                if (fileData instanceof Binary) {
                    Binary fileDataBinary = (Binary) fileData;
                    fileDataBase64 = Base64.getEncoder().encodeToString(fileDataBinary.getData());
                } else if (fileData instanceof String) {
                    fileDataBase64 = (String) fileData;
                } else {
                    fileDataBase64 = null;
                }
                GamePost gamePost = new GamePost(
                    post.getObjectId("_id").toString(),
                    post.getString("Title"),
                    post.getString("GamePlay"),
                    post.getString("Description"),
                    post.getString("DateRelease"),
                    post.getString("Author"),
                    post.getString("Genre"),
                    post.getString("AdminId"),
                    post.getString("FileName"),
                    fileDataBase64
                );
                postList.add(gamePost);
            }

            Collections.reverse(postList);

            request.setAttribute("postsMember", postList);
            request.setAttribute("posts", postList); // Combine this attribute

            // Forward the request to the appropriate JSP page
            String role = request.getParameter("role");
            if (role.equals("admin")) {
                request.getRequestDispatcher("admin-after-login.jsp?id=" + id).forward(request, response);
            } else {
                request.getRequestDispatcher("censor.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving game posts.");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
    }

    @Override
    public void destroy() {
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}

