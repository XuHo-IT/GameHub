package Controller;

import Model.SuperAdmin;
import Model.UserModel;
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
import mongodb.MongoConectUser;
import utils.MongoDBConnectionManager1;

public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the email and password from the request
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Get the MongoDB database and collection
        MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();
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
                        userDoc.getString("PhotoUrl"), // Get photoUrl from the user document
                        userDoc.getString("Role"),
                        userDoc.getString("Status")
                );
                String userId = userDoc.getObjectId("_id").toString();
                MongoConectUser mgcn = new MongoConectUser();
                UserModel currentUser = mgcn.getUserById(userId);
                // Set the current user session attribute
                HttpSession session = request.getSession();
                session.setAttribute("currentUser", superAdmin);
                
                // Set the adminId and adminEmail in the session
                session.setAttribute("adminId", userDoc.getObjectId("_id").toString());
                session.setAttribute("adminName", userDoc.getString("Name"));
                session.setAttribute("adminEmail", userDoc.getString("Email")); // Insert adminEmail in session
                session.setAttribute("photoUrl", userDoc.getString("PhotoUrl")); // Set photoUrl in session

                // Redirect based on the user's role
                String role = userDoc.getString("Role");
//                MongoConectUser mgcn = new MongoConectUser();
//                UserModel currentUser = mgcn.getUserById(superAdmin.getAdminId());
                
                if (currentUser.getStatus().equals("Suspend")) {
                    response.sendRedirect("user-profile.jsp?id=" + userId);
                } else {
                    if ("0".equals(role)) {
                        // For role 0 (regular user)
                    response.sendRedirect("ReadGameHomeMemberController");
                } else if ("1".equals(role)) {
                        // For role 1 (admin)
//                        response.sendRedirect("ReadGameHomeAdmin?adminid=" + id);
                    }
                }

            } catch (ParseException ex) {
                Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
            }

        } else {
            // If authentication fails, set an error message
            request.setAttribute("errorMessage", "Invalid email or password");
            request.getRequestDispatcher("ReadGameHomeController").forward(request, response);
        }
    }
}
