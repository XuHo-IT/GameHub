package utils;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MongoDBConnectionManager {
    private static MongoClient localMongoClient;
    private static MongoClient remoteMongoClient;
    private static final Logger logger = LoggerFactory.getLogger(MongoDBConnectionManager.class);

    // Local MongoDB connection URI
    private static final String LOCAL_URI = "mongodb://localhost:27017"; 

    // Remote MongoDB connection URI
    private static final String REMOTE_URI = "mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub";

    private MongoDBConnectionManager() {}

    // Method to get a local MongoDB client
    public static MongoClient getLocalMongoClient() {
        if (localMongoClient == null) {
            logger.info("Creating a new local MongoClient instance.");
            localMongoClient = MongoClients.create(LOCAL_URI);
        } else {
            logger.info("Reusing existing local MongoClient instance.");
        }
        return localMongoClient;
    }

    // Method to get a remote MongoDB client
    public static MongoClient getRemoteMongoClient() {
        if (remoteMongoClient == null) {
            logger.info("Creating a new remote MongoClient instance.");
            remoteMongoClient = MongoClients.create(REMOTE_URI);
        } else {
            logger.info("Reusing existing remote MongoClient instance.");
        }
        return remoteMongoClient;
    }

    // Method to close both local and remote MongoDB clients
    public static void closeClients() {
        if (localMongoClient != null) {
            logger.info("Closing local MongoClient instance.");
            localMongoClient.close();
            localMongoClient = null;
        }
        if (remoteMongoClient != null) {
            logger.info("Closing remote MongoClient instance.");
            remoteMongoClient.close();
            remoteMongoClient = null;
        }
    }
}
