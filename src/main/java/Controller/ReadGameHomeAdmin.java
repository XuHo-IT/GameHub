package Controller;

import Model.GamePost;
import Model.Genre;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.bson.types.Binary;
import com.mongodb.client.FindIterable;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpSession;
import utils.MongoDBConnectionManager1;

public class ReadGameHomeAdmin extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
                MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();
            HttpSession session = request.getSession();
            GameReleaseNotificationAdminController.startScheduler(mongoClient, session);

            // Check if the logout action is triggered
            String userId = request.getParameter("id");
            String action = request.getParameter("action");
            if ("logout".equals(action)) {
                request.getSession().removeAttribute("currentUser");
                request.getSession().setAttribute("succMsg", "Logout Successfully");
                response.sendRedirect("ReadGameHomeController");
                return;
            }

            MongoDatabase database = mongoClient.getDatabase("GameHub");

            // Fetch genres from MongoDB
            MongoCollection<Document> genreCollection = database.getCollection("Genre");
            List<Document> genreDocuments = genreCollection.find().into(new ArrayList<>());
            List<Genre> genres = new ArrayList<>();

            for (Document doc : genreDocuments) {
                Genre genre = new Genre();
                genre.setGenreId(doc.getObjectId("_id").toString());
                genre.setGenre(doc.getString("Genre"));
                genres.add(genre);
            }
            request.setAttribute("genres", genres);

            // Fetch game posts from MongoDB
            MongoCollection<Document> postCollection = database.getCollection("postGame");
            List<GamePost> postList = new ArrayList<>();
            FindIterable<Document> posts = postCollection.find();

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
            
            Collections.reverse(postList);

            List<GamePost> postTop4 = new ArrayList<>();
            int maxPosts = Math.min(4, postList.size());
            for (int i = 0; i < maxPosts; i++) {
                postTop4.add(postList.get(i));
            }
            request.setAttribute("id", userId);
            request.setAttribute("posts", postTop4);

            // Fetch transactions from MongoDB
            MongoCollection<Document> transactionCollection = database.getCollection("Transaction");
            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyyMMddHHmmss");
            SimpleDateFormat outputFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
            List<Document> transactions = new ArrayList<>();

            FindIterable<Document> transactionsDocs = transactionCollection.find();
            for (Document doc : transactionsDocs) {
                if (doc.containsKey("createDate")) {
                    String createDateString = doc.getString("createDate");
                    String formattedDate = "N/A"; // Default value
                    try {
                        Date date = inputFormat.parse(createDateString);
                        formattedDate = outputFormat.format(date);
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                    doc.append("formattedCreateDate", formattedDate);
                } else {
                    doc.append("formattedCreateDate", "No date available");
                }
                transactions.add(doc);
            }

            // Set transactions and posts as request attributes
            request.setAttribute("transactionList", transactions);

            // Determine where to redirect based on a parameter
            String view = request.getParameter("view");

            if ("chart".equals(view)) {
                // If 'chart' view is requested, forward to the chart page
                request.getRequestDispatcher("chart/index-chart.jsp").forward(request, response);
            } else {
                // Default: forward to the admin home page
                request.getRequestDispatcher("admin-after-login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving data.");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
    }
}
