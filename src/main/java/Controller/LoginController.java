package Controller;

import Model.SuperAdmin;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;

public class LoginController extends HttpServlet {

    private MongoClient mongoClient;

    @Override
    public void init() throws ServletException {
        mongoClient = MongoClients.create("mongodb+srv://LoliHunter:Loli_slayer_123@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the email and password from the request
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Get the MongoDB database and collection
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("superadmin");

        // Create a query document to find the user by email
        Document query = new Document("Email", email);
        Document userDoc = collection.find(query).first();

        // Check if the user exists and the password matches
        if (userDoc != null && userDoc.getString("Password").equals(password)) {
            try {
                // Convert the MongoDB Document into a SuperAdmin object
                SuperAdmin superAdmin = new SuperAdmin(
                        userDoc.getObjectId("_id").toString(), // Assuming _id is being used as adminId
                        userDoc.getString("Name"),
                        new SimpleDateFormat("yyyy-MM-dd").parse(userDoc.getString("DateOfBirth")),
                        userDoc.getString("Email"),
                        userDoc.getString("PhoneNumber"),
                        userDoc.getString("Address"),
                        userDoc.getString("Password"),
                        userDoc.getString("PhotoUrl"),
                        userDoc.getString("Role"),
                        userDoc.getString("Status")
                        );

                // Set the current user session attribute
                HttpSession session = request.getSession();
                session.setAttribute("currentUser", superAdmin);

                // Set the adminId and adminEmail in the session
                session.setAttribute("adminId", userDoc.getObjectId("_id").toString());
                session.setAttribute("adminEmail", userDoc.getString("Email")); // Insert adminEmail in session

                // Redirect based on the user's role
                String role = userDoc.getString("Role");
                if ("0".equals(role)) {
                    // For role 0 (regular user)
                    response.sendRedirect("ReadGameHomeMemberController");
                } else if ("1".equals(role)) {
                    // For role 1 (admin)
                    response.sendRedirect("ReadGameHomeAdminController");
                }

            } catch (ParseException ex) {
                Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
            }

        } else {
            // If authentication fails, set an error message
            request.setAttribute("errorMessage", "Invalid email or password");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    @Override
    public void destroy() {
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}
