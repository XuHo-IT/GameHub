package Controller;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.bson.types.ObjectId;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class EditPostController extends HttpServlet {

    private MongoClient mongoClient;

    @Override
    public void init() throws ServletException {
        mongoClient = MongoClients.create("mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String postId = request.getParameter("postId");

        if ("edit".equals(action)) {
            editPost(request, response, postId);
        } else if ("delete".equals(action)) {
            deletePost(request, response, postId);
        }
    }

    private void editPost(HttpServletRequest request, HttpServletResponse response, String postId)
            throws ServletException, IOException {
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("postGame");

        // Fetch new post data from the request
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String gamePlay = request.getParameter("gamePlay");
        String dateRelease = request.getParameter("dateRelease");
        String author = request.getParameter("author");
        String genre = request.getParameter("genre");
        String linkGame = request.getParameter("Link");
        String price = request.getParameter("Price");


        // Update the post document in MongoDB
        Document update = new Document("$set", new Document("Title", title)
                .append("Description", description)
                .append("GamePlay", gamePlay)
                .append("DateRelease", dateRelease)
                .append("Author", author)
                .append("Genre", genre)
                .append("LinkGame", linkGame)
                .append("Price", price));


        collection.updateOne(new Document("_id", new ObjectId(postId)), update);

        response.sendRedirect("ReadGameHomeAdminController");
    }

    private void deletePost(HttpServletRequest request, HttpServletResponse response, String postId)
            throws ServletException, IOException {
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("postGame");

        // Delete the post document from MongoDB
        collection.deleteOne(new Document("_id", new ObjectId(postId)));

        response.sendRedirect("ReadGameHomeAdminController");
    }

    @Override
    public void destroy() {
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}
