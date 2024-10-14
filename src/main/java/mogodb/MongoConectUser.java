package mogodb;

import Model.UserModel;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import static com.mongodb.client.model.Filters.eq;
import com.mongodb.client.model.Updates;
import org.bson.Document;
import org.bson.types.ObjectId;

import java.util.ArrayList;
import java.util.List;
import static jdk.jfr.internal.consumer.EventLog.update;



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
    public boolean updateUser(String userId, String name, String email, String phone, String address) {
    try (MongoClient mongoClient = MongoClients.create(CONNECTION_STRING)) {
        MongoDatabase database = mongoClient.getDatabase(DATABASE_NAME);
        MongoCollection<Document> collection = database.getCollection(COLLECTION_NAME);

        Document query = new Document("_id", new ObjectId(userId));
        Document updateFields = new Document();

        if (name != null && !name.isEmpty()) {
            updateFields.append("Name", name);
        }
        if (email != null && !email.isEmpty()) {
            updateFields.append("Email", email);
        }
        if (phone != null && !phone.isEmpty()) {
            updateFields.append("Phone", phone);
        }
        if (address != null && !address.isEmpty()) {
            updateFields.append("Address", address);
        }

        if (updateFields.isEmpty()) {
            return false; // No updates provided
        }

        Document update = new Document("$set", updateFields);
        if (collection.updateOne(query, update).getModifiedCount() > 0) {
            return true; // Successfully updated the user
        }
        return false; // User not found or not modified
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
                user.setStatus(doc.getString("Status"));
                user.setRole(doc.getString("Role"));
                return user;
            }
            else return null;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
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
public boolean updateUserProfilePicture(String userId, String imagePath) {
        try (MongoClient mongoClient = MongoClients.create(CONNECTION_STRING)) {
            MongoDatabase database = mongoClient.getDatabase(DATABASE_NAME);
            MongoCollection<Document> collection = database.getCollection(COLLECTION_NAME);

            Document query = new Document("_id", new ObjectId(userId));
            Document update = new Document("$set", new Document("PhotoUrl", imagePath));

            if (collection.updateOne(query, update).getModifiedCount() > 0) {
                return true; // Successfully updated the profile picture
            }
            return false; // User not found or not modified
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Return false if an error occurred
        }
    }
    public boolean changePassword(String userId, String oldPassword, String newPassword) {
        try (MongoClient mongoClient = MongoClients.create(CONNECTION_STRING)) {
            MongoDatabase database = mongoClient.getDatabase(DATABASE_NAME);
            MongoCollection<Document> collection = database.getCollection(COLLECTION_NAME);

            Document query = new Document("_id", new ObjectId(userId));
            Document user = collection.find(query).first();

            if (user != null && user.getString("password").equals(oldPassword)) {
                Document update = new Document("$set", new Document("password", newPassword));
                if (collection.updateOne(query, update).getModifiedCount() > 0) {
                    return true; // Successfully changed password
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // Old password is incorrect or user not found
    }

}
