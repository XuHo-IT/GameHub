package Controller;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.bson.conversions.Bson;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import utils.MongoDBConnectionManager1;

@WebServlet("/getGamePostStatistics")
public class TopicStatisticController extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> adminGamePostCollection = database.getCollection("postGame");         // Admin post collection
        MongoCollection<Document> memberGamePostCollection = database.getCollection("postGameMember");  // Member post collection

        LocalDate now = LocalDate.now();
        JSONArray postStats = new JSONArray();
        DateTimeFormatter formatter = DateTimeFormatter.ISO_DATE;

        // Loop through the last 7 days to get post counts
        for (int i = 0; i < 7; i++) {
            LocalDate targetDate = now.minusDays(i);

            // Create BSON filters for the target date
            Bson adminFilter = new Document("dateRelease", targetDate.toString());
            Bson memberFilter = new Document("dateRelease", targetDate.toString());

            // Count documents where dateRelease matches the targetDate
            long adminCount = adminGamePostCollection.countDocuments(adminFilter);
            long memberCount = memberGamePostCollection.countDocuments(memberFilter);

            // Create a JSON object for each day's stats
            JSONObject dailyStats = new JSONObject();
            dailyStats.put("day", targetDate.format(formatter));
            dailyStats.put("adminCount", adminCount);
            dailyStats.put("memberCount", memberCount);

            // Add the daily stats to the array
            postStats.put(dailyStats);
        }

        // Send the response back as JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(postStats.toString());
    }
}
