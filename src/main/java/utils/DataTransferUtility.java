package utils;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoClient;
import com.mongodb.client.FindIterable;
import org.bson.Document;

public class DataTransferUtility {

    // Array of collections to transfer
    private static final String[] COLLECTIONS_TO_TRANSFER = {
        "Genre",
        "Transaction",
        "comment",
        "postGame",
        "postGameMember",
        "superadmin",
        "topic"
    };

    public static void transferDataFromRemoteToLocal() {
        MongoClient remoteClient = MongoDBConnectionManager1.getRemoteMongoClient();
        MongoClient localClient = MongoDBConnectionManager1.getLocalMongoClient();

        MongoDatabase remoteDatabase = remoteClient.getDatabase("GameHub");
        MongoDatabase localDatabase = localClient.getDatabase("GameHub");

        for (String collectionName : COLLECTIONS_TO_TRANSFER) {
            try {
                MongoCollection<Document> remoteCollection = remoteDatabase.getCollection(collectionName);
                MongoCollection<Document> localCollection = localDatabase.getCollection(collectionName);

                FindIterable<Document> remoteDocuments = remoteCollection.find();

                for (Document doc : remoteDocuments) {
                    localCollection.insertOne(doc);
                }

                System.out.println("Successfully transferred data from " + collectionName);
            } catch (Exception e) {
                System.err.println("Error transferring data for collection " + collectionName + ": " + e.getMessage());
            }
        }

        MongoDBConnectionManager1.closeClients();
    }
    public static void transferDataFromLocalToRemote() {
        MongoClient remoteClient = MongoDBConnectionManager1.getRemoteMongoClient();
        MongoClient localClient = MongoDBConnectionManager1.getLocalMongoClient();

        MongoDatabase remoteDatabase = remoteClient.getDatabase("GameHub");
        MongoDatabase localDatabase = localClient.getDatabase("GameHub");

        for (String collectionName : COLLECTIONS_TO_TRANSFER) {
            try {
                MongoCollection<Document> remoteCollection = remoteDatabase.getCollection(collectionName);
                MongoCollection<Document> localCollection = localDatabase.getCollection(collectionName);

                FindIterable<Document> localDocuments = localCollection.find();

                for (Document doc : localDocuments) {
                    remoteCollection.insertOne(doc);
                }

                System.out.println("Successfully transferred data from " + collectionName);
            } catch (Exception e) {
                System.err.println("Error transferring data for collection " + collectionName + ": " + e.getMessage());
            }
        }

        MongoDBConnectionManager1.closeClients();
    }
}
