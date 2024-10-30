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

public class ConfirmPost extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String postId = request.getParameter("postId");
        String actionType = request.getParameter("actionType");

        // Get the MongoDB database and collection
        MongoClient mongoClient = MongoDBConnectionManager.getLocalMongoClient();
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> postGameMemberCollection = database.getCollection("postGameMember");

        // Find the post in postGameMember by ID
        Document post = postGameMemberCollection.find(new Document("_id", new ObjectId(postId))).first();

        if (post != null) {
            switch (actionType) {
                case "confirm":
                    // Insert the post into postGame collection and remove from postGameMember
                    MongoCollection<Document> postGameCollection = database.getCollection("postGame");
                    postGameCollection.insertOne(post);
                    postGameMemberCollection.deleteOne(new Document("_id", new ObjectId(postId)));
                    break;
                case "deny":
                    // Update the status field to denied
                    postGameMemberCollection.updateOne(new Document("_id", new ObjectId(postId)),
                            new Document("$set", new Document("status", "denied")));
                    break;
                case "re-deny":
                    // Update the status field to re-denied
                    postGameMemberCollection.updateOne(new Document("_id", new ObjectId(postId)),
                            new Document("$set", new Document("status", "re-denied")));
                    break;
            }
        }
        // Redirect back to the member page (or wherever appropriate)
        response.sendRedirect("ReadGameUploadByMember?adminId=<%= request.getSession().getAttribute(\"adminId\")%>\"");
    }
}
