package mogodb;

import Model.UserModel;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import org.bson.Document;
import org.bson.types.ObjectId;

import java.util.ArrayList;
import java.util.List;



public class MongoConectUser {
    private static final String CONNECTION_STRING = "mongodb+srv://han:Abc123@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub";
    private static final String DATABASE_NAME = "GameHub";
    private static final String COLLECTION_NAME = "superadmin";

    // Method to get all users from the database
    public List<UserModel> getAllUsers() {
        List<UserModel> userList = new ArrayList<>();
        try (MongoClient mongoClient = MongoClients.create(CONNECTION_STRING)) {
            MongoDatabase database = mongoClient.getDatabase(DATABASE_NAME);
            MongoCollection<Document> collection = database.getCollection(COLLECTION_NAME);
            
            for (Document doc : collection.find()) {
                UserModel user = new UserModel();
                user.setId(doc.getObjectId("_id").toString());
                user.setEmail(doc.getString("Email"));
                user.setPhone(doc.getString("PhoneNumber"));
                user.setDateOfBirth(doc.getString("DateOfBirth"));
                user.setAddress(doc.getString("Address"));
                user.setName(doc.getString("Name"));
                user.setPassword(doc.getString("Password"));
                user.setPhotoUrl(doc.getString("PhotoUrl"));
                user.setStatus(doc.getString("Status"));
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }

    // Method to delete a user by ID
    public boolean deleteUserById(String userId) {
        try (MongoClient mongoClient = MongoClients.create(CONNECTION_STRING)) {
            MongoDatabase database = mongoClient.getDatabase(DATABASE_NAME);
            MongoCollection<Document> collection = database.getCollection(COLLECTION_NAME);
            
            // Use ObjectId for the MongoDB _id field
            Document result = collection.findOneAndDelete(Filters.eq("_id", new ObjectId(userId)));
            return result != null; // Return true if a user was deleted
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Return false if an error occurred
        }
    }

    // Method to update a user in the database
    public boolean updateUser(UserModel user) {
        try (MongoClient mongoClient = MongoClients.create(CONNECTION_STRING)) {
            MongoDatabase database = mongoClient.getDatabase(DATABASE_NAME);
            MongoCollection<Document> collection = database.getCollection(COLLECTION_NAME);
            
            Document updatedUser = new Document("Email", user.getEmail())
                    .append("PhoneNumber", user.getPhone())
                    .append("DateOfBirth", user.getDateOfBirth())
                    .append("Address", user.getAddress())
                    .append("Name", user.getName())
                    .append("Password", user.getPassword())
                    .append("PhotoUrl", user.getPhotoUrl());
            
            // Use ObjectId for the MongoDB _id field
            long modifiedCount = collection.updateOne(Filters.eq("_id", new ObjectId(user.getId())), new Document("$set", updatedUser)).getModifiedCount();
            return modifiedCount > 0; // Return true if the user was updated
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Return false if an error occurred
        }
    }

    // Method to get a user by ID
    public UserModel getUserById(String userId) {
        try (MongoClient mongoClient = MongoClients.create(CONNECTION_STRING)) {
            MongoDatabase database = mongoClient.getDatabase(DATABASE_NAME);
            MongoCollection<Document> collection = database.getCollection(COLLECTION_NAME);
            
            Document doc = collection.find(Filters.eq("_id", new ObjectId(userId))).first();
            if (doc != null) {
                UserModel user = new UserModel();
                user.setId(doc.getObjectId("_id").toString());
                user.setEmail(doc.getString("Email"));
                user.setPhone(doc.getString("PhoneNumber"));
                user.setDateOfBirth(doc.getString("DateOfBirth"));
                user.setAddress(doc.getString("Address"));
                user.setName(doc.getString("Name"));
                user.setPassword(doc.getString("Password"));
                user.setPhotoUrl(doc.getString("PhotoUrl"));
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // Return null if user is not found
    }
    public boolean suspendUser(String userId) {
    try (MongoClient mongoClient = MongoClients.create(CONNECTION_STRING)) {
        MongoDatabase database = mongoClient.getDatabase(DATABASE_NAME);
        MongoCollection<Document> usersCollection = database.getCollection(COLLECTION_NAME);

        // Use ObjectId for the MongoDB _id field
        Document query = new Document("_id", new ObjectId(userId));
        Document update = new Document("$set", new Document("Status", "Suspend"));

        // Update the user's status to "Suspend"
        if (usersCollection.updateOne(query, update).getModifiedCount() > 0) {
            return true; // Successfully suspended the user
        }
        return false; // User not found or not modified
    } catch (Exception e) {
        e.printStackTrace();
        return false; // Return false if an error occurred
    }
}

public boolean unsuspendUser(String userId) {
    try (MongoClient mongoClient = MongoClients.create(CONNECTION_STRING)) {
        MongoDatabase database = mongoClient.getDatabase(DATABASE_NAME);
        MongoCollection<Document> usersCollection = database.getCollection(COLLECTION_NAME);

        // Use ObjectId for the MongoDB _id field
        Document query = new Document("_id", new ObjectId(userId));
        Document update = new Document("$set", new Document("Status", "Active"));

        // Update the user's status to "Active"
        if (usersCollection.updateOne(query, update).getModifiedCount() > 0) {
            return true; // Successfully unsuspended the user
        }
        return false; // User not found or not modified
    } catch (Exception e) {
        e.printStackTrace();
        return false; // Return false if an error occurred
    }
}

}
