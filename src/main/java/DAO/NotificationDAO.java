package DAO;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import java.util.ArrayList;
import java.util.List;
import org.bson.Document;
import org.bson.types.ObjectId;
import utils.MongoDBConnectionManager;

public class NotificationDAO {
    private final MongoCollection<Document> notificationsCollection;

    public NotificationDAO() {
        MongoClient mongoClient = MongoDBConnectionManager.getLocalMongoClient();
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        this.notificationsCollection = database.getCollection("notifications");
    }

    public void saveNotification(String userEmail, String postId, String adminId, String dateRelease) {
        Document notification = new Document("userEmail", userEmail)
                .append("postId", postId)
                .append("adminId", adminId)
                .append("dateRelease", dateRelease);
        notificationsCollection.insertOne(notification);
    }
      public List<Document> getNotificationsByDate(String dateRelease) {
        List<Document> notifications = new ArrayList<>();
        try (MongoCursor<Document> cursor = notificationsCollection.find(Filters.eq("dateRelease", dateRelease)).iterator()) {
            while (cursor.hasNext()) {
                notifications.add(cursor.next());
            }
        }
        return notifications;
    }

    // Method to delete a notification by its ID
    public void deleteNotificationById(ObjectId id) {
        notificationsCollection.deleteOne(Filters.eq("_id", id));
    }
}
