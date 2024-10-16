package Controller;

import Model.SuperAdmin;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.bson.types.ObjectId;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author OS
 */
public class SignUpController extends HttpServlet {

    private MongoClient mongoClient;

    @Override
    public void init() throws ServletException {
        mongoClient = MongoClients.create("mongodb+srv://LoliHunter:Loli_slayer_123@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the parameters from the request
        String name = request.getParameter("Name");
        String email = request.getParameter("Email");
        String phoneNumber = request.getParameter("Phone");
        String dateOfBirth = request.getParameter("Dob");
        String address = request.getParameter("Address");
        String password = request.getParameter("Password");
        String photoUrl = request.getParameter("PhotoUrl");

        String role = "0";
        String status = "Active";// Set default role to "0" (regular user)

        // Convert the dateOfBirth string to a Date object (you can use SimpleDateFormat)
        Date dob = null;
        try {
            dob = new SimpleDateFormat("yyyy-MM-dd").parse(dateOfBirth);
        } catch (ParseException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Invalid date format.");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
            return;
        }

        // Create a SuperAdmin object (you don't need to pass 0 for adminId)
        SuperAdmin superAdmin = new SuperAdmin(
                null, // AdminId will be auto-generated by MongoDB
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

        // Get MongoDB database and collection
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("superadmin");

        // Create a MongoDB Document from the SuperAdmin object
        Document user = new Document("Email", superAdmin.getEmail())
                .append("PhoneNumber", superAdmin.getPhone())
                .append("DateOfBirth", new SimpleDateFormat("yyyy-MM-dd").format(superAdmin.getDob())) // Convert Date to String
                .append("Address", superAdmin.getAddress())
                .append("Password", superAdmin.getPassWord())
                .append("Name", superAdmin.getName())
                .append("PhotoUrl", superAdmin.getPhotoUrl())
                .append("Role", role)
                .append("Status", status);

        // Insert the document into the MongoDB collection
        collection.insertOne(user);

        // Retrieve the auto-generated ObjectId for the SuperAdmin document
        ObjectId adminId = user.getObjectId("_id");

        // Store the adminId in the session
        HttpSession session = request.getSession();
        session.setAttribute("currentUser",user);

        // Set the adminId and adminEmail in the session
        session.setAttribute("adminId", user.getObjectId("_id").toString());
        session.setAttribute("adminName", user.getString("Name"));
        session.setAttribute("adminEmail", user.getString("Email"));

        // Redirect to the admin home page
        response.sendRedirect("ReadGameHomeMemberController");
    }

    @Override
    public void destroy() {
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}
