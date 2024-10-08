package Controller;

import Model.GamePost;
import Model.Genre;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.bson.types.Binary;
import com.mongodb.client.FindIterable;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class ReadGameHomeAdminController extends HttpServlet {

    private MongoClient mongoClient;

    @Override
    public void init() throws ServletException {
        mongoClient = MongoClients.create("mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            MongoDatabase database = mongoClient.getDatabase("GameHub");

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

            // Fetch game posts from MongoDB
            MongoCollection<Document> postCollection = database.getCollection("postGame");
            List<GamePost> postList = new ArrayList<>();
            FindIterable<Document> posts = postCollection.find();

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
            request.setAttribute("posts", postList);

            // Forward to the JSP page with both genres and posts
            request.getRequestDispatcher("admin-after-login.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving data.");
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
