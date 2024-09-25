package mogodb;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoCollection;
import org.bson.Document;

public class MongoConnect {
    public static void main(String[] args) {
        String connectionString = "mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub";

        try (MongoClient mongoClient = MongoClients.create(connectionString)) {
            MongoDatabase database = mongoClient.getDatabase("GameHub");
            MongoCollection<Document> collection = database.getCollection("superadmin");

            // Insert data
            Document SuperAdmin = new Document("AdminId", 1)
                .append("Name", "Admin")
                .append("DoB", "1989-12-31T17:00:00Z")
                .append("Email", "admin@gmail.com")
                .append("PhoneNumber", "1234567890")
                .append("Address", "123 Main St, City")
                .append("Password", "1")
                .append("PhotoUrl","1.png");

            collection.insertOne(SuperAdmin);
            System.out.println("SuperAdmin inserted: " + SuperAdmin.toJson());

            // Query to check inserted data
            Document admin = collection.find(new Document("AdminId", 1)).first();
            if (admin != null) {
                System.out.println("SuperAdmin found: " + admin.toJson());
            } else {
                System.out.println("SuperAdmin not found.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
