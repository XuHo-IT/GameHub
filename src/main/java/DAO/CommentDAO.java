package DAO;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Indexes;
import org.bson.Document;
import org.bson.types.ObjectId;
import utils.MongoDBConnectionManager1;

import java.time.LocalDateTime;

public class CommentDAO {
    private final MongoDatabase database;
    private final MongoCollection<Document> commentCollection;

    public CommentDAO() {
        MongoClient mongoClient = MongoDBConnectionManager1.getLocalMongoClient();
        this.database = mongoClient.getDatabase("GameHub");
        this.commentCollection = database.getCollection("comment"); // Retrieve collection from database
        createCommentIndexes();
    }

    private void createCommentIndexes() {
        commentCollection.createIndex(Indexes.ascending("TopicId"));
        commentCollection.createIndex(Indexes.ascending("UserId"));
        commentCollection.createIndex(Indexes.ascending("Date"));
    }

    public void addComment(String topicId, String userId, String content) {
        Document comment = new Document("TopicId", topicId)
                .append("UserId", userId)
                .append("Content", content)
                .append("Status", "unedited")
                .append("Date", LocalDateTime.now());
        commentCollection.insertOne(comment);
    }

    public void deleteComment(String commentId) {
        Document query = new Document("_id", new ObjectId(commentId));
        commentCollection.deleteOne(query);
    }

    public void updateComment(String commentId, String newContent) {
        Document query = new Document("_id", new ObjectId(commentId));
        Document update = new Document("$set", new Document("Content", newContent).append("Status", "edited"));
        commentCollection.updateOne(query, update);
    }
}
