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
import com.mongodb.client.model.Filters;
import org.bson.Document;
import org.bson.types.Binary;
import org.bson.conversions.Bson;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import javax.servlet.annotation.WebServlet;

public class SearchController extends HttpServlet {

    private MongoClient mongoClient;

    @Override
    public void init() throws ServletException {
        mongoClient = MongoClients.create("mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            MongoDatabase database = mongoClient.getDatabase("GameHub");
            MongoCollection<Document> genreCollection = database.getCollection("Genre");
            MongoCollection<Document> collection = database.getCollection("postGame");

            List<Genre> genres = new ArrayList<>();

            // Fetch genres from MongoDB only once
            List<Document> genreDocuments = genreCollection.find().into(new ArrayList<>());
            for (Document doc : genreDocuments) {
                Genre genre = new Genre();
                genre.setGenreId(doc.getObjectId("_id").toString());
                genre.setGenre(doc.getString("Genre"));
                genres.add(genre);
            }
            request.setAttribute("genres", genres);  // Store genres in request attributes

            // Retrieve search parameters
            String keyword = request.getParameter("keyword");
            String genre = request.getParameter("genre");

            // Build a dynamic query using MongoDB filters
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
                posts = collection.find(); // Retrieve all posts if no filters
            } else {
                posts = collection.find(Filters.and(filters)); // Apply all filters
            }

            // Map each document to GamePost object
            List<GamePost> postList = new ArrayList<>();
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
                        post.getString("Genre"),
                        post.getString("AdminId"),
                        post.getString("FileName"),
                        fileDataBase64
                );
                postList.add(gamePost);
            }

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

            // Sublist for current page
            List<GamePost> postsForCurrentPage = postList.subList(startIndex, endIndex);

            // Set attributes for JSP
            request.setAttribute("posts", postsForCurrentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("keyword", keyword);
            request.setAttribute("genre", genre);
            request.setAttribute("genres", genres);  // Pass genres to the JSP
            request.setAttribute("postList", postList);

            // Forward to search results JSP
            request.getRequestDispatcher("search-results.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving search results.");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
    }

    @Override
    public void destroy() {
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}