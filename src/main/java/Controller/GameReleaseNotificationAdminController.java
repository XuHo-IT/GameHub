package Controller;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.Timer;
import java.util.TimerTask;

public class GameReleaseNotificationAdminController extends TimerTask {

    private MongoClient mongoClient;
    private final String adminEmail = "tungntde180205@fpt.edu.vn"; // Change this to admin's email
    private final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    public GameReleaseNotificationAdminController(MongoClient mongoClient) {
        this.mongoClient = mongoClient;
    }

    @Override
    public void run() {
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("postGame");

        // Get the current date as a string
        String today = dateFormat.format(new Date());

        // Query for games that are released today
        Document query = new Document("DateRelease", today);
        try (MongoCursor<Document> cursor = collection.find(query).iterator()) {
            while (cursor.hasNext()) {
                Document gamePost = cursor.next();
                String gameTitle = gamePost.getString("Title");
                  String postId = gamePost.getObjectId("_id").toString();
                               

                sendEmailNotification(gameTitle,postId, adminEmail);
            }
        }
    }

    private void sendEmailNotification(String gameTitle,String postId, String adminEmail) {
        String subject = "Game Release Notification";
      
      
   String gameLink = "http://localhost:8080/Web_Trading_Game/game-single-after-login.jsp?id=" + postId+"&postId="+postId;
String body = 
             "The game '" + gameTitle + "' is releasing today!"
            + "Link to the game to upload link: " + gameLink ;
          


        // Set up email properties
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        String fromEmail = "ngotranxuanhoa09062004@gmail.com"; // Change to your email
        String emailPassword = "lkai bcsp rtna hrcn"; // Change to your email password

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
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(adminEmail));
            message.setSubject(subject);
            message.setText(body);

            // Send the email
            Transport.send(message);
            System.out.println("Email sent successfully to: " + adminEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    // Start the scheduled task
    public static void startScheduler(MongoClient mongoClient) {
        Timer timer = new Timer();
        // Schedule the task to run once a day
        timer.scheduleAtFixedRate(new GameReleaseNotificationAdminController(mongoClient), 0, 24 * 60 * 60 * 1000);
    }
}

