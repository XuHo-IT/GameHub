package Controller;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class GameReleaseNotificationAdminController {

    static void startScheduler(MongoClient mongoClient) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    private MongoClient mongoClient;
    private final String adminEmail = "gamehubtalk@gmail.com"; // Admin email

    public GameReleaseNotificationAdminController(MongoClient mongoClient) {
        this.mongoClient = mongoClient;
    }

    // Function to send the confirmation email after a game is added to wishlist
    public void sendWishlistConfirmationEmail(String userEmail, String gameTitle, String postId) {
        String subject = "Game Wishlist Confirmation";
        
        // Link to the game after adding to the wishlist
        String gameLink = "http://localhost:8080/Web_Trading_Game/game-single-after-login.jsp?id=" + postId + "&postId=" + postId;
        
        // Email body content
        String body = "You have successfully added the game '" + gameTitle + "' to your wishlist.\n"
                + "Click here to view the game: " + gameLink;

        // Set up email properties
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        String fromEmail = "ngotranxuanhoa09062004@gmail.com"; // Sender email
        String emailPassword = "lkai bcsp rtna hrcn"; // Sender email password

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
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(userEmail));
            message.setSubject(subject);
            message.setText(body);

            // Send the email
            Transport.send(message);
            System.out.println("Email sent successfully to: " + userEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
