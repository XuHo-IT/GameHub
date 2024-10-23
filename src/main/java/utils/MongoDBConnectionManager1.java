package utils;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MongoDBConnectionManager1 {
    private static MongoClient mongoClient;
    private static final Logger logger = LoggerFactory.getLogger(MongoDBConnectionManager1.class);

    private MongoDBConnectionManager1() {}

    public static MongoClient getMongoClient() {
        if (mongoClient == null) {
            logger.info("Creating a new MongoClient instance.");
            mongoClient = MongoClients.create("mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
        } else {
            logger.info("Reusing existing MongoClient instance.");
        }
        return mongoClient;
    }

    public static void closeMongoClient() {
        if (mongoClient != null) {
            logger.info("Closing MongoClient instance.");
            mongoClient.close();
            mongoClient = null;
        }
    }
}
