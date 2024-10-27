package Controller;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import org.bson.Document;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.MongoDBConnectionManager1;
import java.io.IOException;
import java.util.Properties;
import java.util.UUID;

public class ForgotPasswordController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("emailForgot");

        // Connect to the database and collection
        MongoClient mongoClient = MongoDBConnectionManager1.getLocalMongoClient();
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("superadmin");

        // Check if the email exists in the database
        Document user = collection.find(Filters.eq("Email", email)).first();
        if (user != null) {
            // Email exists, send the password
            String password = user.getString("Password"); // Ideally, you should retrieve a password reset link instead
            sendEmail(email, password); // Send email with the password
            request.setAttribute("successMessage", "An email with your password has been sent to " + email);
        } else {
            // Email does not exist
            request.setAttribute("errorMessage", "No account registered with this email address.");
        }
        response.sendRedirect("ReadGameHomeController"); // Redirect back to the main page
    }

    private void sendEmail(String toEmail, String password) {
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("gamehubtalk@gmail.com", "vqgf zhra oqfr drlg"); // Use App Password
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("ygamehubtalk@gmail.com"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Password Recovery");
            message.setText("Your password is: " + password);
            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
