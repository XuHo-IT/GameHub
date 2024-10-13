package Controller;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;
import org.json.JSONObject;

public class StatisticController extends HttpServlet {

    private MongoClient mongoClient;

    @Override
    public void init() throws ServletException {
        // Initialize the database connection
        mongoClient = MongoClients.create("mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("application/json");
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        try {
            MongoCollection<Document> adminGamePostCollection = database.getCollection("postGame");
            MongoCollection<Document> memberGamePostCollection = database.getCollection("postGameMember");

            long adminPostsCount = adminGamePostCollection.countDocuments();
            long memberPostsCount = memberGamePostCollection.countDocuments();

            // Create a JSON object to hold the counts
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("adminPostsCount", adminPostsCount);
            jsonResponse.put("memberPostsCount", memberPostsCount);

            // Send the JSON response
            response.getWriter().write(jsonResponse.toString());
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

    }
}

