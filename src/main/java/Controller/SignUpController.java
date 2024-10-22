package Controller;

import Model.SuperAdmin;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import org.bson.Document;
import org.bson.types.ObjectId;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.UUID;
import utils.MongoDBConnectionManager1;

/**
 * Combined SignUpController with email verification functionality
 */
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
        String status = "Pending";  // Set status to "Pending" until email is verified

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

        // Insert user into MongoDB
        MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("superadmin");

        // Convert SuperAdmin to MongoDB Document and insert into the database
        Document user = new Document("Name", superAdmin.getName())
                .append("Email", superAdmin.getEmail())
                .append("PhoneNumber", superAdmin.getPhone())
                .append("DateOfBirth", new SimpleDateFormat("yyyy-MM-dd").format(superAdmin.getDob()))
                .append("Address", superAdmin.getAddress())
                .append("Password", superAdmin.getPassWord()) // Ideally, you should hash the password
                .append("PhotoUrl", superAdmin.getPhotoUrl())
                .append("Role", superAdmin.getRole())
                .append("Status", superAdmin.getStatus());

        // Check if the email already exists
        Document existingUser = collection.find(Filters.eq("email", email)).first();

        if (existingUser != null) {
            // Email already exists, handle duplicate
            request.setAttribute("errorMessage", "This email is already registered.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else {
            // Email doesn't exist, proceed with registration
            collection.insertOne(user);
            // Redirect to success page or perform other actions
        }

        // Get the generated user ID
        ObjectId adminId = user.getObjectId("_id");

        // Store user info in session
        HttpSession session = request.getSession();
        session.setAttribute("currentUser", user);
        session.setAttribute("adminId", adminId.toString());
        session.setAttribute("adminName", superAdmin.getName());
        session.setAttribute("adminEmail", superAdmin.getEmail());

        // Generate the verification key (UUID)
        String verificationKey = UUID.randomUUID().toString();

        // Insert the verification key into the VerifiedEmail collection
        MongoCollection<Document> verifiedEmailCollection = database.getCollection("VerifiedEmail");
        Document verificationDoc = new Document("email", superAdmin.getEmail())
                .append("verificationKey", verificationKey)
                .append("createdAt", new Date())
                .append("verified", false);  // Set initial status to false
        verifiedEmailCollection.insertOne(verificationDoc);

        // Send verification email
        boolean emailSent = sendEmailVerification(superAdmin.getEmail(), verificationKey);

        if (emailSent) {
            response.sendRedirect("ReadGameHomeMemberController.java");
        } else {
            response.getWriter().write("Failed to send verification email. Please try again.");
        }
    }

    private boolean sendEmailVerification(String memberEmail, String verificationKey) {
        String subject = "GameHub: Email Verification";
        String body = "Hello, <br/><br/>"
                + "Please <a href='http://localhost:8080/Game_Trading_Web/VerifyEmailHandler?key=" + verificationKey + "&email=" + memberEmail + "'>click here</a> to verify your email address.";

        // Set up email properties for Gmail
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        String fromEmail = "gamehubtalk@gmail.com";  // Replace with your email
        String emailPassword = "vqgf zhra oqfr drlg";  // Replace with your email app password

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, emailPassword);
            }
        });

        try {
            // Compose the email
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(memberEmail));
            message.setSubject(subject);
            message.setContent(body, "text/html; charset=utf-8");

            // Send the email
            Transport.send(message);
            System.out.println("Verification email sent successfully to: " + memberEmail);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
