package Controller;

import Model.GamePost;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.annotation.WebServlet;
import mongodb.MongoConnectStatistic;

@WebServlet("/getPostCounts")
public class GamePostStatisticController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MongoConnectStatistic mct = new MongoConnectStatistic();
        mct.getAllGamePost();


        List<GamePost> adminPostList = mct.adminPostList; // Fetch list of admin posts
        List<GamePost> memberPostList = mct.memberPostList; // Fetch list of member posts

        int adminPostCount = adminPostList.size(); // Count admin posts
        int memberPostCount = memberPostList.size(); // Count member posts
        int totalPostCount = adminPostCount + memberPostCount; // Calculate total posts

        // Construct JSON response to include admin, member, and total posts
        String jsonResponse = String.format(
            "{\"adminPostList\": %d, \"memberPostList\": %d, \"totalPostCount\": %d}",
            adminPostCount, memberPostCount, totalPostCount
        );


        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(jsonResponse);
        out.flush();

    }
}


