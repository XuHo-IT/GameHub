/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.GamePost;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import java.io.IOException;
import java.io.PrintWriter;
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

/**
 *
 * @author OS
 */
public class ReadGameHomeController extends HttpServlet {

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
        MongoCollection<Document> collection = database.getCollection("postGame");
        List<GamePost> postList = new ArrayList<>();

        // Retrieve all posts from the database
        FindIterable<Document> posts = collection.find();

        // Map each document to a GamePost object
        for (Document post : posts) {
            // Check if FileData is stored as Binary or String
            Object fileData = post.get("FileData");
            String fileDataBase64;

            if (fileData instanceof Binary) {
                // If it's Binary, convert to Base64
                Binary fileDataBinary = (Binary) fileData;
                fileDataBase64 = Base64.getEncoder().encodeToString(fileDataBinary.getData());
            } else if (fileData instanceof String) {
                // If it's a String (possibly already Base64), just use it directly
                fileDataBase64 = (String) fileData;
            } else {
                fileDataBase64 = null; 
            }

            GamePost gamePost = new GamePost(
                    post.getObjectId("_id").toString(), // postID
                    post.getString("Title"),
                    post.getString("GamePlay"),
                    post.getString("Description"),
                    post.getString("DateRelease"),
                    post.getString("Author"),
                    post.getString("Genre"),
                    post.getString("AdminId"),
                    post.getString("FileName"),
                    fileDataBase64 // Convert Binary to Base64 String or use as is
            );
            postList.add(gamePost);
            System.out.println(post.toJson()); 
        }

        if (postList.isEmpty()) {
            System.out.println("No posts found in the database.");
        }

        Collections.reverse(postList);
        
        // Pagination logic
        int itemsPerPage = 4;
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

        request.setAttribute("posts", postsForCurrentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
       
        request.getRequestDispatcher("index.jsp").forward(request, response);
    } catch (Exception e) {
        e.printStackTrace(); // Log the exception
        request.setAttribute("errorMessage", "Error retrieving game posts.");
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
