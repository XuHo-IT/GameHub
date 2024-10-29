package DAO;

import Model.GamePostTemp;
import Model.Genre;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Indexes;
import org.bson.Document;
import org.bson.types.Binary;
import org.bson.types.ObjectId;
import utils.MongoDBConnectionManager;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import org.bson.conversions.Bson;

public class GamePostDAO {

    private final MongoDatabase database;
    private final MongoCollection<Document> postCollection;
    private final MongoCollection<Document> genreCollection;
    private final MongoCollection<Document> transactionCollection;
    public List<GamePostTemp> memberPostList;
    public List<GamePostTemp> adminPostList;

    public GamePostDAO() {
        MongoClient mongoClient = MongoDBConnectionManager.getLocalMongoClient();
        this.database = mongoClient.getDatabase("GameHub");
        this.postCollection = database.getCollection("postGame");
        this.genreCollection = database.getCollection("Genre");
        this.transactionCollection = database.getCollection("Transaction");

    }

    public List<GamePostTemp> getAllGamePosts() {
        List<GamePostTemp> postList = new ArrayList<>();
        memberPostList = new ArrayList<>();
        adminPostList = new ArrayList<>();
        List<String> existingPostIDs = new ArrayList<>();

        MongoCollection<Document> memberCollection = database.getCollection("postGameMember");
        MongoCollection<Document> adminCollection = database.getCollection("postGame");

        try {
            // Fetch member posts
            for (Document doc : memberCollection.find()) {
                String postID = doc.getObjectId("_id").toString();
                if (!existingPostIDs.contains(postID)) {
                    GamePostTemp gamePost = mapDocumentToGamePost(doc);
                    postList.add(gamePost);
                    memberPostList.add(gamePost);
                    existingPostIDs.add(postID);
                }
            }

            // Fetch admin posts
            for (Document doc : adminCollection.find()) {
                String postID = doc.getObjectId("_id").toString();
                if (!existingPostIDs.contains(postID)) {
                    GamePostTemp gamePost = mapDocumentToGamePost(doc);
                    postList.add(gamePost);
                    adminPostList.add(gamePost);
                    existingPostIDs.add(postID);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return postList;
    }

    private GamePostTemp mapDocumentToGamePost(Document doc) {
        String fileDataBase64 = extractFileDataBase64(doc.get("FileData"));
        return new GamePostTemp(
                doc.getObjectId("_id").toString(),
                doc.getString("Title"),
                doc.getString("GamePlay"),
                doc.getString("Description"),
                doc.getString("DateRelease"),
                doc.getString("Author"),
                doc.getString("Genre"),
                doc.getString("AdminId"),
                doc.getString("FileName"),
                fileDataBase64,
                doc.getString("LinkGame"),
                doc.getString("Price")
        );
    }

    public List<GamePostTemp> getGamePostsByGenre(String genreId) {
        FindIterable<Document> posts = genreId != null && !genreId.isEmpty()
                ? postCollection.find(new Document("Genre", genreId))
                : postCollection.find();

        List<GamePostTemp> postList = new ArrayList<>();
        for (Document post : posts) {
            String fileDataBase64 = extractFileDataBase64(post.get("FileData"));

            GamePostTemp gamePost = new GamePostTemp(
                    post.getObjectId("_id").toString(),
                    post.getString("Title"),
                    post.getString("GamePlay"),
                    post.getString("Description"),
                    post.getString("DateRelease"),
                    post.getString("Author"),
                    post.getString("Genre"),
                    post.getString("AdminId"),
                    post.getString("FileName"),
                    fileDataBase64, // Correctly retrieve fileDataBase64
                    post.getString("LinkGame"),
                    post.getString("Price")
            );
            postList.add(gamePost);
        }
        Collections.reverse(postList);
        return postList;
    }

    public List<GamePostTemp> getTopGamePosts(int limit) {
        List<GamePostTemp> postList = getGamePostsByGenre(null);
        return postList.subList(0, Math.min(limit, postList.size()));
    }

    public List<Genre> getGenres() {
        List<Genre> genres = new ArrayList<>();

        for (Document doc : genreCollection.find()) {
            Genre genre = new Genre();
            genre.setGenreId(doc.getObjectId("_id").toString());
            genre.setGenre(doc.getString("Genre"));
            genres.add(genre);
        }
        return genres;
    }

    public List<Document> getTransactions() {
        List<Document> transactions = new ArrayList<>();
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        SimpleDateFormat outputFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");

        for (Document doc : transactionCollection.find()) {
            if (doc.containsKey("createDate")) {
                try {
                    Date date = inputFormat.parse(doc.getString("createDate"));
                    doc.append("formattedCreateDate", outputFormat.format(date));
                } catch (ParseException e) {
                    doc.append("formattedCreateDate", "N/A");
                }
            } else {
                doc.append("formattedCreateDate", "No date available");
            }
            transactions.add(doc);
        }
        return transactions;
    }

    private String extractFileDataBase64(Object fileData) {
        if (fileData instanceof Binary) {
            Binary fileDataBinary = (Binary) fileData;
            return Base64.getEncoder().encodeToString(fileDataBinary.getData());
        } else if (fileData instanceof String) {
            return (String) fileData;
        } else {
            return null;
        }
    }

    public void addGamePost(GamePostTemp gamePost, List<String> actionImagesBase64) {
        Document postGame = new Document("Title", gamePost.getTitle())
                .append("GamePlay", gamePost.getGamePlay())
                .append("Description", gamePost.getDescription())
                .append("DateRelease", gamePost.getDateRelease())
                .append("Author", gamePost.getAuthor())
                .append("Genre", gamePost.getGenre())
                .append("AdminId", gamePost.getAdminId())
                .append("FileName", gamePost.getFileName())
                .append("FileData", gamePost.getFileDataBase64()) // Store Base64 file data
                .append("LinkGame", gamePost.getLinkGame())
                .append("ActionImages", actionImagesBase64)
                .append("Price", gamePost.getPrice());

        postCollection.insertOne(postGame);
    }

    public void addGenre(Genre genre) {
        MongoCollection<Document> collection = database.getCollection("Genre");

        // Create a MongoDB Document from the Genre object
        Document genreDocument = new Document("Genre", genre.getGenre())
                .append("AdminId", genre.getAdminId());

        // Insert the document into the MongoDB collection
        collection.insertOne(genreDocument);
    }

    public List<GamePostTemp> getGamePostsMember(String selectedGenreId) {
        MongoCollection<Document> collection = database.getCollection("postGameMember");
        List<GamePostTemp> postList = new ArrayList<>();

        // Fetch posts, optionally filtering by genre
        FindIterable<Document> posts;
        if (selectedGenreId != null && !selectedGenreId.isEmpty()) {
            posts = collection.find(new Document("Genre", selectedGenreId));
        } else {
            posts = collection.find();
        }

        // Map each document to a GamePost object
        for (Document post : posts) {
            String fileDataBase64 = extractFileDataBase64(post.get("FileData")); // Correctly retrieve file data

            GamePostTemp gamePost = new GamePostTemp(
                    post.getObjectId("_id").toString(),
                    post.getString("Title"),
                    post.getString("GamePlay"),
                    post.getString("Description"),
                    post.getString("DateRelease"),
                    post.getString("Author"),
                    post.getString("Genre"),
                    post.getString("AdminId"),
                    post.getString("FileName"),
                    fileDataBase64, // Correctly retrieve fileDataBase64
                    post.getString("LinkGame"),
                    post.getString("Price")
            );
            postList.add(gamePost);
        }
        return postList;
    }

    public void editPost(String postId, GamePostTemp updatedPost) {
        MongoCollection<Document> collection = database.getCollection("postGame");

        // Create the update document
        Document update = new Document("$set", new Document("Title", updatedPost.getTitle())
                .append("Description", updatedPost.getDescription())
                .append("GamePlay", updatedPost.getGamePlay())
                .append("DateRelease", updatedPost.getDateRelease())
                .append("Author", updatedPost.getAuthor())
                .append("Genre", updatedPost.getGenre())
                .append("LinkGame", updatedPost.getLinkGame())
                .append("Price", updatedPost.getPrice())
                .append("FileData", updatedPost.getFileDataBase64())); // Update the file data

        // Update the post document in MongoDB
        collection.updateOne(new Document("_id", new ObjectId(postId)), update);
    }

    public void deletePost(String postId) {
        MongoCollection<Document> collection = database.getCollection("postGame");

        // Delete the post document from MongoDB
        collection.deleteOne(new Document("_id", new ObjectId(postId)));
    }

    public List<GamePostTemp> searchPosts(String keyword, String genre) {
        List<Bson> filters = new ArrayList<>();

        // Check if the keyword is provided and create the keyword filter
        if (keyword != null && !keyword.trim().isEmpty()) {
            filters.add(Filters.or(Filters.regex("Title", ".*" + keyword + ".*", "i")));
        }

        // Check if a genre is provided and create the genre filter
        if (genre != null && !genre.trim().isEmpty() && !genre.equals("All Genres")) {
            filters.add(Filters.eq("Genre", genre));
        }

        // Create the final filter query
        FindIterable<Document> posts;
        if (filters.isEmpty()) {
            posts = postCollection.find(); // Retrieve all posts if no filters
        } else {
            posts = postCollection.find(Filters.and(filters)); // Apply all filters
        }

        // Map each document to GamePost object
        List<GamePostTemp> postList = new ArrayList<>();
        for (Document post : posts) {
            Object fileData = post.get("FileData");
            String fileDataBase64 = null;

            if (fileData instanceof Binary) {
                Binary fileDataBinary = (Binary) fileData;
                fileDataBase64 = Base64.getEncoder().encodeToString(fileDataBinary.getData());
            } else if (fileData instanceof String) {
                fileDataBase64 = (String) fileData;
            }

            GamePostTemp gamePost = new GamePostTemp(
                    post.getObjectId("_id").toString(),
                    post.getString("Title"),
                    post.getString("GamePlay"),
                    post.getString("Description"),
                    post.getString("DateRelease"),
                    post.getString("Author"),
                    post.getString("Genre"),
                    post.getString("AdminId"),
                    post.getString("FileName"),
                    fileDataBase64,
                    post.getString("LinkGame"),
                    post.getString("Price")
            );
            postList.add(gamePost);
        }
        return postList;
    }
}
