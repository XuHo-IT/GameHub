package Controller;

import Model.SuperAdmin;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import org.bson.Document;
import org.bson.types.ObjectId;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import utils.MongoDBConnectionManager1;

public class SignUpController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get user registration details
        String name = request.getParameter("Name");
        String email = request.getParameter("Email");
        String phoneNumber = request.getParameter("Phone");
        String dateOfBirth = request.getParameter("Dob");
        String address = request.getParameter("Address");
        String password = request.getParameter("Password");
        String photoUrl = request.getParameter("PhotoUrl");

        String role = "0";  // Default role for regular user
        String status = "Active";  // Set status to active

        // Parse the Date of Birth
        Date dob = null;
        try {
            dob = new SimpleDateFormat("yyyy-MM-dd").parse(dateOfBirth);
        } catch (ParseException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Invalid date format.");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
            return;
        }

        // Create a SuperAdmin object
        SuperAdmin superAdmin = new SuperAdmin(
                null, // MongoDB will auto-generate the Admin ID
                name,
                dob,
                email,
                phoneNumber,
                address,
                password,
                photoUrl,
                role,
                status
        );

        // Connect to MongoDB
        MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("superadmin");

        // Check if the email already exists
        Document existingUser = collection.find(Filters.eq("Email", email)).first();

        if (existingUser != null) {
            // Email already exists, handle duplicate
            request.setAttribute("errorMessage", "This email is already registered.");
            request.getRequestDispatcher("ReadGameHomeController").forward(request, response);
        } else {
            // Email doesn't exist, proceed with registration
            Document user = new Document("Name", superAdmin.getName())
                    .append("Email", superAdmin.getEmail())
                    .append("PhoneNumber", superAdmin.getPhone())
                    .append("DateOfBirth", new SimpleDateFormat("yyyy-MM-dd").format(superAdmin.getDob()))
                    .append("Address", superAdmin.getAddress())
                    .append("Password", superAdmin.getPassWord()) // Ideally, you should hash the password
                    .append("PhotoUrl", superAdmin.getPhotoUrl())
                    .append("Role", superAdmin.getRole())
                    .append("Status", superAdmin.getStatus());

            // Insert the user into MongoDB
            collection.insertOne(user);

            // Get the generated user ID
            ObjectId adminId = user.getObjectId("_id");

            // Store user info in session
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            session.setAttribute("adminId", adminId.toString());
            session.setAttribute("adminName", superAdmin.getName());
            session.setAttribute("adminEmail", superAdmin.getEmail());

            // Redirect to the home controller or success page
            response.sendRedirect("ReadGameHomeMemberController");
        }
    }
}
