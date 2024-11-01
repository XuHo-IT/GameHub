package Controller;

import DAO.GamePostDAO;
import DAO.NotificationDAO;
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
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.Properties;
import utils.MongoDBConnectionManager;

public class GameReleaseNotificationMember extends HttpServlet {

    private final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

  @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userEmail = request.getParameter("userEmail");
        String postId = request.getParameter("postId");
        String adminId = request.getParameter("adminId");
        String dateRelease = request.getParameter("dateRelease");

        if (userEmail == null || userEmail.isEmpty()) {
            response.getWriter().write("Invalid email address");
            return;
        }

        // Debugging output
        System.out.println("User Email: " + userEmail);
        System.out.println("Post ID: " + postId);
        System.out.println("Admin ID: " + adminId);

        GamePostDAO gamePostDAO = new GamePostDAO();
        NotificationDAO notificationDAO = new NotificationDAO();
      
        String today = dateFormat.format(new Date());
        boolean emailSent = false;

        if (dateRelease != null) {
            if (dateRelease.equals(today)) {
                String gameTitle = gamePostDAO.getGameTitleByReleaseDate(dateRelease);
                if (gameTitle != null) {
                    emailSent = sendEmailNotification(gameTitle, postId, adminId, userEmail);
                }
            } else {
                notificationDAO.saveNotification(userEmail, postId, adminId, dateRelease);
                System.out.println("Notification saved for future date: " + dateRelease);
            }
        }

        request.setAttribute("postId", postId);
        request.setAttribute("adminId", adminId);
        String redirectUrl = "register_mail_success.jsp?postId=" + postId + "&memberId=" + adminId;
        response.sendRedirect(redirectUrl);
    }


    private boolean sendEmailNotification(String gameTitle, String postId, String adminId, String memberEmail) {
        String subject = "Game Release Notification";
        String gameLink = "http://localhost:8080/Web_Trading_Game/cart-buy.jsp?id=" + postId + "&adminId=" + adminId;
        String body = "Dear Member, the game '" + gameTitle + "' is releasing today! "
                + "Here’s the link to the game: " + gameLink;

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
