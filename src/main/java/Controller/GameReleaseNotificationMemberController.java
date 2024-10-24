package Controller;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import utils.MongoDBConnectionManager1;

public class GameReleaseNotificationMemberController extends HttpServlet {

  
    private final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

   

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get parameters from the form
        String userEmail = request.getParameter("userEmail");
        String postId = request.getParameter("postId");
        String adminId = request.getParameter("adminId");

        if (userEmail == null || userEmail.isEmpty()) {
            response.getWriter().write("Invalid email address");
            return;
        }
           MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient(); 
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("postGame");

        // Get the current date as a string
        String today = dateFormat.format(new Date());

        // Query for games that are released today
        Document query = new Document("DateRelease", today);
        boolean emailSent = false;

        try (MongoCursor<Document> cursor = collection.find(query).iterator()) {
            while (cursor.hasNext()) {
                Document gamePost = cursor.next();
                String postGameTitle = gamePost.getString("Title");
                emailSent = sendEmailNotification(postGameTitle, postId,adminId, userEmail);
            }
        }
        request.setAttribute(postId, "postId");
        request.setAttribute(adminId, "adminId");

        if (emailSent) {
            response.sendRedirect("ReadGameHomeMemberController");
        } else {
            response.sendRedirect("shopping-cart.jsp");
        }
    }

    private boolean sendEmailNotification(String gameTitle, String postId,String adminId, String memberEmail) {
        String subject = "Game Release Notification";
        String gameLink = "http://localhost:8080/Web_Trading_Game/cart-buy.jsp?id=" + postId + "&adminId=" +adminId ;
        String body = "Dear Member, the game '" + gameTitle + "' is releasing today! " +
                      "Here’s the link to the game: " + gameLink;

        // Set up email properties
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        String fromEmail = "gamehubtalk@gmail.com"; // Change to your email
        String emailPassword = "vqgf zhra oqfr drlg"; // Change to your email password

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
            message.setText(body);

            // Send the email
            Transport.send(message);
            System.out.println("Email sent successfully to: " + memberEmail);
            return true; // Email sent successfully
        } catch (MessagingException e) {
            e.printStackTrace();
            return false; // Email sending failed
        }
    }
}
