/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Statistics;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mongodb.MongoConnectStatistic;

/**
 *
 * @author Admin
 */
@WebServlet("/getMongoStatistics")
public class StatisticsServlet extends HttpServlet {
    MongoConnectStatistic mcs = new MongoConnectStatistic();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get statistics from MongoDB
        try {
            Statistics stats = mcs.getStatistics();

            System.out.println("Member Count: " + stats.getMemberCount());
            System.out.println("Admin Count: " + stats.getAdminCount());
            System.out.println("Post Count: " + stats.getPostCount());
            System.out.println("Topic Count: " + stats.getTopicCount());
            System.out.println("User Count: " + stats.getUserCount());

            // Set statistics as request attributes
            request.setAttribute("postCount", stats.getPostCount());
            request.setAttribute("topicCount", stats.getAdminCount());
            request.setAttribute("memberCount", stats.getMemberCount());
            request.setAttribute("adminCount", stats.getAdminCount());
            request.setAttribute("totalUserCount", stats.getUserCount());

            // Forward to JSP
            request.getRequestDispatcher("/index-chart.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error retrieving statistics: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
