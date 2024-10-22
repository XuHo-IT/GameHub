
package mongodb;


import Model.GamePost;
import Model.Statistics;
import Model.UserModel;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import static com.mongodb.client.model.Filters.eq;
import java.util.ArrayList;
import java.util.List;
import org.bson.Document;



public class MongoConnectStatistic {
    private static final String CONNECTION_STRING = "mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub";
    private static final String DATABASE_NAME = "GameHub";
    private static final String MEMBER_POST_COLLECTION_NAME = "postGameMember";
    private static final String ADMIN_POST_COLLECTION_NAME = "postGame";
    private static final String GAME_POST_COLLECTION = "postGame";
    private static final String TOPIC_COLLECTION = "topic";
    private static final String USER_COLLECTION ="superadmin";
    
    public List<GamePost> adminPostList;
    public List<GamePost> memberPostList;

    // Method to get all users from the database
    public List<UserModel> getAllUsers() {
        List<UserModel> userList = new ArrayList<>();
        try (MongoClient mongoClient = MongoClients.create(CONNECTION_STRING)) {
            MongoDatabase database = mongoClient.getDatabase(DATABASE_NAME);
            MongoCollection<Document> collection = database.getCollection(USER_COLLECTION);
            
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
    public List<GamePost> getAllGamePost(){
        List<GamePost> postList = new ArrayList<>();
        memberPostList = new ArrayList<>();
        adminPostList = new ArrayList<>();
         List<String> existingPostIDs = new ArrayList<>();
        try (MongoClient mongoClient = MongoClients.create(CONNECTION_STRING)) {
            MongoDatabase database = mongoClient.getDatabase(DATABASE_NAME);
            MongoCollection<Document> memberCollection = database.getCollection(MEMBER_POST_COLLECTION_NAME);
            MongoCollection<Document> adminCollection = database.getCollection(ADMIN_POST_COLLECTION_NAME);
            for (Document doc : memberCollection.find()) {
                String postID = doc.getObjectId("_id").toString();
                 if (!existingPostIDs.contains(postID)) {
                    GamePost gamepost = new GamePost();
                    gamepost.setPostID(postID);
                    gamepost.setTitle(doc.getString("Title"));
                    gamepost.setGamePlay(doc.getString("GamePlay"));
                    gamepost.setDescription(doc.getString("Description"));
                    gamepost.setDateRelease(doc.getString("DateRelease"));
                    gamepost.setAuthor(doc.getString("Author"));
                    gamepost.setGenre(doc.getString("Genre"));
                    gamepost.setAdminId(doc.getString("AdminId"));
                    gamepost.setFileName(doc.getString("FileName"));
                    gamepost.setFileData(doc.getString("FileData"));
                    postList.add(gamepost);
                    memberPostList.add(gamepost);
                    existingPostIDs.add(postID); 
                }
            }
            for (Document doc : adminCollection.find()) {
                String postID = doc.getObjectId("_id").toString();
                 if (!existingPostIDs.contains(postID)) {
                     GamePost gamepost = new GamePost();
                     gamepost.setPostID(postID);
                     gamepost.setTitle(doc.getString("Title"));
                     gamepost.setGamePlay(doc.getString("GamePlay"));
                     gamepost.setDescription(doc.getString("Description"));
                     gamepost.setDateRelease(doc.getString("DateRelease"));
                     gamepost.setAuthor(doc.getString("Author"));
                     gamepost.setGenre(doc.getString("Genre"));
                     gamepost.setAdminId(doc.getString("AdminId"));
                     gamepost.setFileName(doc.getString("FileName"));
                     gamepost.setFileData(doc.getString("FileData"));
                     postList.add(gamepost);
                     adminPostList.add(gamepost);
                     existingPostIDs.add(postID); 
                 }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return postList;
    }
    
    public Statistics getStatistics() {
        MongoClient mongoClient = MongoClients.create(CONNECTION_STRING);
        MongoDatabase database = mongoClient.getDatabase(DATABASE_NAME);
        MongoCollection<Document> userCollection = database.getCollection(USER_COLLECTION);
 
        long gamePostCount = database.getCollection(GAME_POST_COLLECTION).countDocuments();
        long topicCount = database.getCollection(TOPIC_COLLECTION).countDocuments();
        long adminCount = userCollection.countDocuments(eq("Role", "1"));
        long memberCount = userCollection.countDocuments(eq("Role", "0"));
        long userCount = database.getCollection(USER_COLLECTION).countDocuments();

        mongoClient.close();

        return new Statistics(gamePostCount, topicCount, memberCount, adminCount, userCount);
    }
    
//    public List<Integer> getPostCountsForPast7Days() {
//    List<Integer> dailyCounts = new ArrayList<>();
//
//    try (MongoClient mongoClient = MongoClients.create(CONNECTION_STRING)) {
//        MongoDatabase database = mongoClient.getDatabase(DATABASE_NAME);
//        MongoCollection<Document> gamePostCollection = database.getCollection(MEMBER_POST_COLLECTION_NAME);
//
//        // Get current date and iterate back 7 days
//        LocalDate today = LocalDate.now();
//
//        for (int i = 0; i < 7; i++) {
//            LocalDate targetDate = today.minusDays(i);
//            String dateStr = targetDate.toString();  // Convert date to string for matching, adjust format if needed
//
//            long count = gamePostCollection.countDocuments(Filters.eq("DateRelease", dateStr)); // Match date
//            dailyCounts.add((int) count);
//        }
//    } catch (Exception e) {
//        e.printStackTrace();
//    }
//
//    return dailyCounts;}

}
