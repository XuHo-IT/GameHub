package Controller;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Properties;
import java.util.UUID;

public class ForgotPasswordController extends HttpServlet {

    private MongoClient mongoClient;

    @Override
    public void init() throws ServletException {
        // Initialize MongoDB client
        mongoClient = MongoClients.create("mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        // Connect to the database and collection
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> usersCollection = database.getCollection("superadmin");

        // Check if the user exists
        Document user = usersCollection.find(new Document("Email", email)).first();

        if (user != null) {
            // Check if the email is verified
            String isVerified = user.getString("isVerified");

            if ("true".equals(isVerified)) {
                // Proceed with password reset process
                // Generate a password reset token
                String resetToken = UUID.randomUUID().toString();

                // Save the reset token and the current time to the user's document
                Document updateDoc = new Document("$set", new Document("resetToken", resetToken)
                        .append("tokenCreationTime", System.currentTimeMillis()));
                usersCollection.updateOne(new Document("Email", email), updateDoc);

                // Send the password reset email
                boolean emailSent = sendPasswordResetEmail(email, resetToken);

                if (emailSent) {
                    request.setAttribute("message", "A password reset link has been sent to your email.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMessage", "Failed to send password reset email.");
                    request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
                }

            } else {
                // Email is not verified, show an error message
                request.setAttribute("errorMessage", "Your email is not verified. Please verify your email to reset your password.");
                request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            }

        } else {
            // No account found with the provided email
            request.setAttribute("errorMessage", "No account found with that email.");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
        }
    }

    private boolean sendPasswordResetEmail(String email, String resetToken) {
        String subject = "Password Reset Request";
        String body = "Click the following link to reset your password: "
                + "http://localhost:8080/Game_Trading_Web/ResetPasswordServlet?token=" + resetToken;

        // Set up email properties for Gmail
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        String fromEmail = "your-email@gmail.com";
        String emailPassword = "your-app-password";

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
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject(subject);
            message.setText(body);

            // Send the email
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public void destroy() {
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}
