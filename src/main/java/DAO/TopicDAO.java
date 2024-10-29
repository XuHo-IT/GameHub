package DAO;

import Model.TopicTemp;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Indexes;
import org.bson.Document;
import org.bson.types.Binary;
import org.bson.types.ObjectId;

import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import utils.MongoDBConnectionManager;

public class TopicDAO {

    private final MongoDatabase database;
    private final MongoCollection<Document> topicCollection;
    private final MongoCollection<Document> commentCollection;
    private final MongoCollection<Document> usersCollection;

    public TopicDAO() {
        MongoClient mongoClient = MongoDBConnectionManager.getLocalMongoClient();
        this.database = mongoClient.getDatabase("GameHub"); // Initialize the database
        this.topicCollection = database.getCollection("topic");
        this.commentCollection = database.getCollection("comment");
        this.usersCollection = database.getCollection("superadmin");
        createTopicIndexes();
    }

    private void createTopicIndexes() {
        topicCollection.createIndex(Indexes.ascending("UserId"));
        topicCollection.createIndex(Indexes.ascending("CreatedAt"));
        topicCollection.createIndex(Indexes.text("Title"));
    }

    public List<TopicTemp> fetchTopics() {
        List<TopicTemp> topicList = new ArrayList<>();
        FindIterable<Document> topics = topicCollection.find();

        for (Document topicDocument : topics) {
            String userIdStr = topicDocument.getString("UserId");
            Document user = null;

            // Fetch user information from the "superadmin" collection
            if (userIdStr != null && ObjectId.isValid(userIdStr)) {
                user = usersCollection.find(Filters.eq("_id", new ObjectId(userIdStr))).first();
            }

            // Handle missing or null user
            String photoUrl = (user != null) ? user.getString("PhotoUrl") : "./img/t-rex.png";
            String userName = (user != null) ? user.getString("Name") : "Unknown User";

            // Handle image data, convert to Base64 if Binary type
            Object imageData = topicDocument.get("ImageData");
            String imageDataBase64 = "";

            if (imageData instanceof Binary) {
                Binary imageDataBinary = (Binary) imageData;
                imageDataBase64 = Base64.getEncoder().encodeToString(imageDataBinary.getData());
            } else if (imageData instanceof String) {
                imageDataBase64 = (String) imageData;  // Use if already a string
            } else {
                imageDataBase64 = ""; // Default or placeholder image
            }

            // Get the TopicId and count the comments related to this topic
            ObjectId topicId = topicDocument.getObjectId("_id");
            long commentCount = commentCollection.countDocuments(Filters.eq("TopicId", topicId.toString()));

            // Create Topic object and add to the list
            TopicTemp topic = new TopicTemp(
                    topicId.toString(),
                    topicDocument.getString("UserId"),
                    topicDocument.getString("Title"),
                    topicDocument.getString("Description"),
                    imageDataBase64, // Only use Base64 encoded image data
                    photoUrl,
                    userName, // User's name, or "Unknown User" if not found
                    topicDocument.getDate("CreatedAt"),
                    commentCount // Pass the comment count
            );
            topicList.add(topic);
        }

        return topicList;
    }

    public void createTopic(String title, String description, String imageData, String userId) {
        Document topicDocument = new Document("Title", title)
                .append("Description", description)
                .append("ImageData", imageData)
                .append("UserId", userId)
                .append("CreatedAt", new Date());

        topicCollection.insertOne(topicDocument);
    }

    public void deleteTopic(String topicId) {
        topicCollection.deleteOne(Filters.eq("_id", new ObjectId(topicId)));
    }

    public void updateTopic(String topicId, String title, String description, String imageData) {
        Document updateFields = new Document("$set", new Document("Title", title)
                .append("Description", description));
        if (imageData != null) {
            updateFields.get("$set", Document.class).append("ImageData", imageData);
        }
        topicCollection.updateOne(Filters.eq("_id", new ObjectId(topicId)), updateFields);
    }
}
