package Controller;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.MongoDBConnectionManager1;
import java.io.IOException;

public class UpdateUserRole extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the user ID and the new role from the request
        String userId = request.getParameter("userId");
        String newRole = request.getParameter("role");

        // Get the MongoDB database and collection
        MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("superadmin"); 

        // Update the user's role
        Document query = new Document("_id", new org.bson.types.ObjectId(userId));
        Document update = new Document("$set", new Document("Role", newRole));
        collection.updateOne(query, update);

        // Redirect back to the user management page with a success message
        response.sendRedirect("chart/list-user.jsp?success=Role updated successfully");
    }
}
