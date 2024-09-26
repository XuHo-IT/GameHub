package Controller;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.bson.types.ObjectId;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author OS
 */
public class SignUpController extends HttpServlet {

    private MongoClient mongoClient;

    @Override
    public void init() throws ServletException {
        mongoClient = MongoClients.create("mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("Name");
        String email = request.getParameter("Email");
        String phoneNumber = request.getParameter("Phone");
        String dateOfBirth = request.getParameter("Dob");
        String address = request.getParameter("Address");
        String password = request.getParameter("Password");
        String photoUrl = request.getParameter("PhotoUrl");

        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("superadmin");

        // Create a new document for the super admin user
        Document user = new Document("Email", email)
                .append("PhoneNumber", phoneNumber)
                .append("DateOfBirth", dateOfBirth)
                .append("Address", address)
                .append("Password", password)
                .append("Name", name)
                .append("PhotoUrl", photoUrl);

        collection.insertOne(user);
        ObjectId adminId = user.getObjectId("_id");  

        // Store the admin ID in the session or pass it as a request attribute
        request.getSession().setAttribute("adminId", adminId.toHexString());

        // Redirect to the admin dashboard or next page
        response.sendRedirect("admin-after-login.jsp");
    }

    @Override
    public void destroy() {
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}
