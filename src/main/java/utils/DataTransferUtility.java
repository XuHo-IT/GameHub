package utils;

import org.bson.Document;

import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

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
        MongoClient remoteClient = MongoDBConnectionManager.getRemoteMongoClient();
        MongoClient localClient = MongoDBConnectionManager.getLocalMongoClient();

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

        MongoDBConnectionManager.closeClients();
    }
     public static void transferDataFromLocalToRemote() {
        MongoClient remoteClient = MongoDBConnectionManager.getRemoteMongoClient();
        MongoClient localClient = MongoDBConnectionManager.getLocalMongoClient();

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

        MongoDBConnectionManager.closeClients();
    }
     
     public static void dropDataFromRemoteAndInsertLocal() {
    MongoClient remoteClient = MongoDBConnectionManager.getRemoteMongoClient();
    MongoClient localClient = MongoDBConnectionManager.getLocalMongoClient();

    MongoDatabase remoteDatabase = remoteClient.getDatabase("GameHub");
    MongoDatabase localDatabase = localClient.getDatabase("GameHub");

    for (String collectionName : COLLECTIONS_TO_TRANSFER) {
        try {
            MongoCollection<Document> remoteCollection = remoteDatabase.getCollection(collectionName);
            MongoCollection<Document> localCollection = localDatabase.getCollection(collectionName);

            // Clear the remote collection before transferring data
            remoteCollection.drop();

            // Transfer data from local to remote
            FindIterable<Document> localDocuments = localCollection.find();
            for (Document doc : localDocuments) {
                remoteCollection.insertOne(doc);
            }

            System.out.println("Successfully transferred and replaced data for " + collectionName);
        } catch (Exception e) {
            System.err.println("Error transferring data for collection " + collectionName + ": " + e.getMessage());
        }
    }

    MongoDBConnectionManager.closeClients();
}

}
