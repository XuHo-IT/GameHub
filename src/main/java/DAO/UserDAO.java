package DAO;

import Model.UserModel;
import Model.SuperAdmin;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Indexes;
import org.bson.Document;
import org.bson.types.ObjectId;
import utils.MongoDBConnectionManager1;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UserDAO {

    private final MongoCollection<Document> collection;
    private final MongoDatabase database;

    public UserDAO() {
        MongoClient mongoClient = MongoDBConnectionManager1.getLocalMongoClient();
        this.database = mongoClient.getDatabase("GameHub"); // Initialize the database
        this.collection = database.getCollection("superadmin");
        createUserIndexes();
    }

    private void createUserIndexes() {
        collection.createIndex(Indexes.ascending("Email"));
        collection.createIndex(Indexes.ascending("PhoneNumber"));
        collection.createIndex(Indexes.ascending("Address"));
        collection.createIndex(Indexes.ascending("Password"));
        collection.createIndex(Indexes.ascending("Status"));
        collection.createIndex(Indexes.ascending("Role"));
        collection.createIndex(Indexes.ascending("DateOfBirth"));
    }

    public SuperAdmin findByEmail(String email) {
        Document query = new Document("Email", email);
        Document userDoc = collection.find(query).first();

        if (userDoc == null) {
            return null;
        }

        try {
            return new SuperAdmin(
                    userDoc.getObjectId("_id").toString(),
                    userDoc.getString("Name"),
                    new SimpleDateFormat("yyyy-MM-dd").parse(userDoc.getString("DateOfBirth")),
                    userDoc.getString("Email"),
                    userDoc.getString("PhoneNumber"),
                    userDoc.getString("Address"),
                    userDoc.getString("Password"),
                    userDoc.getString("PhotoUrl"),
                    userDoc.getString("Role"),
                    userDoc.getString("Status")
            );
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean isEmailRegistered(String email) {
        Document existingUser = collection.find(Filters.eq("Email", email)).first();
        return existingUser != null;
    }

    public ObjectId registerSuperAdmin(SuperAdmin superAdmin) {
        Document user = new Document("Name", superAdmin.getName())
                .append("Email", superAdmin.getEmail())
                .append("PhoneNumber", superAdmin.getPhone())
                .append("DateOfBirth", new SimpleDateFormat("yyyy-MM-dd").format(superAdmin.getDob()))
                .append("Address", superAdmin.getAddress())
                .append("Password", superAdmin.getPassWord())
                .append("PhotoUrl", superAdmin.getPhotoUrl())
                .append("Role", superAdmin.getRole())
                .append("Status", superAdmin.getStatus());

        collection.insertOne(user);
        return user.getObjectId("_id");
    }

    public void insertVerificationKey(String email, String verificationKey) {
        MongoCollection<Document> verifiedEmailCollection = database.getCollection("VerifiedEmail");
        Document verificationDoc = new Document("email", email)
                .append("verificationKey", verificationKey)
                .append("createdAt", new Date())
                .append("verified", false);
        verifiedEmailCollection.insertOne(verificationDoc);
    }

    public boolean updateUserRole(String userId, String newRole) {
        Document query = new Document("_id", new ObjectId(userId));
        Document update = new Document("$set", new Document("Role", newRole));

        // Perform the update and return whether it was successful
        return collection.updateOne(query, update).getModifiedCount() > 0;
    }

    // Method to get all users from the database
    public List<UserModel> getAllUsers() {
        List<UserModel> userList = new ArrayList<>();
        try {
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
                user.setRole(doc.getString("Role"));
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
        try {
            Document result = collection.findOneAndDelete(Filters.eq("_id", new ObjectId(userId)));
            return result != null; // Return true if a user was deleted
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Return false if an error occurred
        }
    }

    // Method to update a user in the database
    public boolean updateUser(String userId, String name, String email, String phone, String address) {
        try {
            // Create the document to update
            Document updatedUser = new Document("Name", name)
                    .append("Email", email)
                    .append("PhoneNumber", phone)
                    .append("Address", address);

            // Use ObjectId for _id field in MongoDB
            long modifiedCount = collection.updateOne(Filters.eq("_id", new ObjectId(userId)),
                    new Document("$set", updatedUser))
                    .getModifiedCount();
            return modifiedCount > 0; // Return true if user was updated
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Return false if an error occurred
        }
    }

    // Method to get a user by ID
    public UserModel getUserById(String userId) {
        try {
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // Return null if user is not found
    }

    public boolean suspendUser(String userId) {
        try {
            Document query = new Document("_id", new ObjectId(userId));
            Document update = new Document("$set", new Document("Status", "Suspend"));

            return collection.updateOne(query, update).getModifiedCount() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Return false if an error occurred
        }
    }

    public boolean unsuspendUser(String userId) {
        try {
            Document query = new Document("_id", new ObjectId(userId));
            Document update = new Document("$set", new Document("Status", "Active"));

            return collection.updateOne(query, update).getModifiedCount() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Return false if an error occurred
        }
    }

    public boolean assignAdmin(String userId) {
        try {
            Document query = new Document("_id", new ObjectId(userId));
            Document update = new Document("$set", new Document("Role", "1"));

            return collection.updateOne(query, update).getModifiedCount() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Return false if an error occurred
        }
    }

    public boolean updateUserProfilePicture(String userId, String photoUrl) {
        try {
            Document update = new Document("$set", new Document("PhotoUrl", photoUrl));
            return collection.updateOne(new Document("_id", new ObjectId(userId)), update).getModifiedCount() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean changePassword(String userId, String oldPassword, String newPassword) {
        try {
            Document query = new Document("_id", new ObjectId(userId));
            Document user = collection.find(query).first();

            if (user != null && user.getString("Password").equals(oldPassword)) {
                Document update = new Document("$set", new Document("Password", newPassword));
                return collection.updateOne(query, update).getModifiedCount() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // Return false if an error occurred or password is incorrect
    }
}
