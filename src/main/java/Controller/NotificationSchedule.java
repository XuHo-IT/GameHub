package Controller;

import DAO.NotificationDAO;
import DAO.GamePostDAO;
import utils.MongoDBConnectionManager;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.bson.Document;

public class NotificationSchedule {

    private static final ScheduledExecutorService scheduler = Executors.newSingleThreadScheduledExecutor();
    private static final NotificationDAO notificationDAO = new NotificationDAO();
    private static final GamePostDAO gamePostDAO = new GamePostDAO();
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    public static void start() {
        scheduler.scheduleAtFixedRate(NotificationSchedule::sendDailyNotifications, 0, 1, TimeUnit.DAYS);
    }

    private static void sendDailyNotifications() {
        String today = dateFormat.format(new Date());

        notificationDAO.getNotificationsByDate(today).forEach(notification -> {
            String userEmail = notification.getString("userEmail");
            String postId = notification.getString("postId");
            String adminId = notification.getString("adminId");

            // Fetch game title
            String gameTitle = gamePostDAO.getGameTitleById(postId);
            if (gameTitle != null) {
                // Send email and remove notification if successful
                boolean emailSent = sendEmailNotification(gameTitle, postId, adminId, userEmail);
                if (emailSent) {
                    notificationDAO.deleteNotificationById(notification.getObjectId("_id"));
                }
            }
        });
    }

    // Make this method static so it can be called from a static context
    private static boolean sendEmailNotification(String gameTitle, String postId, String adminId, String memberEmail) {
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
