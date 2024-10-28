package Controller;

import DAO.GamePostDAO;
import Model.GamePostTemp;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;


public class PostStatistic extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        GamePostDAO mct = new GamePostDAO();
        mct.getAllGamePosts();


        List<GamePostTemp> adminPostList = mct.adminPostList; // Fetch list of admin posts
        List<GamePostTemp> memberPostList = mct.memberPostList; // Fetch list of member posts

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


