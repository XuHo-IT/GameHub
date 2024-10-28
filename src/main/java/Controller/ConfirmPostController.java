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
import utils.MongoDBConnectionManager;

public class ConfirmPostController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String postId = request.getParameter("postId");

        // Get the MongoDB database and collections
        MongoClient mongoClient = MongoDBConnectionManager.getLocalMongoClient();
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> postGameMemberCollection = database.getCollection("postGameMember");
        MongoCollection<Document> postGameCollection = database.getCollection("postGame");

        // Find the post in postGameMember by ID
        Document post = postGameMemberCollection.find(new Document("_id", new ObjectId(postId))).first();

        if (post != null) {
            // Insert the post into postGame collection
            postGameCollection.insertOne(post);

            // Remove the post from postGameMember collection
            postGameMemberCollection.deleteOne(new Document("_id", new ObjectId(postId)));
        }
        // Redirect back to the member page (or wherever appropriate)
        response.sendRedirect("ReadGameHomeAdmin");
    }
}
