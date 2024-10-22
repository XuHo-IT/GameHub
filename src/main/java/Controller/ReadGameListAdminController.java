/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.GamePost;
import Model.Genre;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.bson.Document;
import org.bson.types.Binary;
import utils.MongoDBConnectionManager1;

/**
 *
 * @author Admin
 */
public class ReadGameListAdminController extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
                MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();
            MongoDatabase database = mongoClient.getDatabase("GameHub");
            MongoCollection<Document> collection = database.getCollection("postGame");

            List<GamePost> postList = new ArrayList<>();

            // Fetch genres from MongoDB
            MongoCollection<Document> genreCollection = database.getCollection("Genre");
            List<Document> genreDocuments = genreCollection.find().into(new ArrayList<>());
            List<Genre> genres = new ArrayList<>();

            for (Document doc : genreDocuments) {
                Genre genre = new Genre();
                genre.setGenre(doc.getString("Genre"));  // Use the actual genre name, e.g., 'PvsP'
                genres.add(genre);
            }
            request.setAttribute("genres", genres);

            // Get the selected genre name from the request
            String selectedGenre = request.getParameter("genre");
            FindIterable<Document> posts;

            if (selectedGenre != null && !selectedGenre.isEmpty()) {
                // Filter posts by the selected genre name (not ID)
                Document genreFilter = new Document("Genre", selectedGenre);
                posts = collection.find(genreFilter);
            } else {
                // Retrieve all posts if no genre is selected
                posts = collection.find();
            }

            // Map each document to a GamePost object
            for (Document post : posts) {
                Object fileData = post.get("FileData");
                String fileDataBase64;

                if (fileData instanceof Binary) {
                    Binary fileDataBinary = (Binary) fileData;
                    fileDataBase64 = Base64.getEncoder().encodeToString(fileDataBinary.getData());
                } else if (fileData instanceof String) {
                    fileDataBase64 = (String) fileData;
                } else {
                    fileDataBase64 = null;
                }

                GamePost gamePost = new GamePost(
                        post.getObjectId("_id").toString(),
                        post.getString("Title"),
                        post.getString("GamePlay"),
                        post.getString("Description"),
                        post.getString("DateRelease"),
                        post.getString("Author"),
                        post.getString("Genre"),  // Store genre name, not ID
                        post.getString("AdminId"),
                        post.getString("FileName"),
                        fileDataBase64
                );
                postList.add(gamePost);
            }

            Collections.reverse(postList);

            // Pagination logic
            int itemsPerPage = 9;
            int currentPage = 1;
            String pageParam = request.getParameter("page");

            if (pageParam != null) {
                currentPage = Integer.parseInt(pageParam);
            }

            int totalItems = postList.size();
            int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);

            int startIndex = (currentPage - 1) * itemsPerPage;
            int endIndex = Math.min(startIndex + itemsPerPage, totalItems);

            List<GamePost> postsForCurrentPage = postList.subList(startIndex, endIndex);

            request.setAttribute("posts", postsForCurrentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("selectedGenre", selectedGenre);  // Pass selected genre to JSP

            // Forward the request to the JSP page
            request.getRequestDispatcher("games-after-login.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
            request.setAttribute("errorMessage", "Error retrieving game posts.");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
    }
}
