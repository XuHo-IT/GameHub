/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import java.io.IOException;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.bson.Document;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Admin
 */
@WebServlet("/getGamePostStatistics")
public class TopicStatisticController extends HttpServlet {

    private MongoClient mongoClient;

    public void init() throws ServletException {
        // Initialize the database connection
        mongoClient = MongoClients.create("mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> adminGamePostCollection = database.getCollection("postGame");
        MongoCollection<Document> memberGamePostCollection = database.getCollection("postGameMember");

        long adminPostsCount = adminGamePostCollection.countDocuments();
        long memberPostsCount = memberGamePostCollection.countDocuments();
        LocalDate now = LocalDate.now();
        JSONArray postStats = new JSONArray();

        // Loop through the last 7 days to get post counts
        for (int i = 0; i < 7; i++) {
            LocalDate targetDate = now.minusDays(i);

            // Count documents where the datePosted is the targetDate
            long adminCount = adminGamePostCollection.countDocuments(new Document("dateRelease", targetDate.toString()));
            long memberCount = memberGamePostCollection.countDocuments(new Document("dateRelease", targetDate.toString()));

            // Create a JSON object for each day's stats
            JSONObject dailyStats = new JSONObject();
            dailyStats.put("day", targetDate.toString());
            dailyStats.put("adminCount", adminCount);
            dailyStats.put("memberCount", memberCount);

            // Add the daily stats to the array
            postStats.put(dailyStats);
        }

        // Send the response back as JSON
        response.getWriter().write(postStats.toString());

    }

}
