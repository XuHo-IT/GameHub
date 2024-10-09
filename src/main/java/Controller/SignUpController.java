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
    String role = request.getParameter("Role");
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

    // Create a SuperAdmin object
    SuperAdmin superAdmin = new SuperAdmin(0, name, dob, email, phoneNumber, address, password, photoUrl);

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
            .append("Status", "Active");

    // Insert the document into the MongoDB collection
    collection.insertOne(user);
    ObjectId adminId = user.getObjectId("_id");

    // Store the adminId in session
    request.getSession().setAttribute("adminId", adminId.toHexString());

    // Redirect to admin-after-login.jsp
    response.sendRedirect("admin-after-login.jsp");
}
    @Override
    public void destroy() {
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}
