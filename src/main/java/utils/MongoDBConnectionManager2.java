/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;

/**
 *
 * @author OS
 */
public class MongoDBConnectionManager2 {
     private static final String CONNECTION_STRING = "mongodb+srv://LoliHunter:Loli_slayer_123@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub";
    private static MongoClient mongoClient;

    static {
        mongoClient = MongoClients.create(CONNECTION_STRING);
    }

    public static MongoClient getMongoClient() {
        return mongoClient;
    }
    
    public static void closeMongoClient() {
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}