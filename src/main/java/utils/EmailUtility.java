// EmailUtility.java
package utils;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailUtility {
    public static boolean sendEmailVerification(String recipientEmail, String verificationKey) {
        String subject = "GameHub: Email Verification";
        String body = "Hello, <br/><br/>"
                + "Please <a href='http://localhost:8080/Game_Trading_Web/VerifyEmailHandler?key=" + verificationKey + "&email=" + recipientEmail + "'>click here</a> to verify your email address.";

        String fromEmail = "gamehubtalk@gmail.com";
        String emailPassword = "vqgf zhra oqfr drlg"; // Store sensitive data securely!

        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, emailPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject(subject);
            message.setContent(body, "text/html; charset=utf-8");

            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
