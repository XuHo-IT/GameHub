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
        List<GamePost> adminPostList = mct.adminPostList;
        List<GamePost> memberPostList = mct.memberPostList;
        int adminPostCount = adminPostList.size();
        int memberPostCount = memberPostList.size();
        String jsonResponse = String.format("{\"adminPostList\": %d, \"memberPostList\": %d}", adminPostCount, memberPostCount);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(jsonResponse);
        out.flush();
   }    
}
