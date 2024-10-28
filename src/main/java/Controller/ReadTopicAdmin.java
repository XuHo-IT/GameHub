package Controller;

import DAO.TopicDAO;
import Model.TopicTemp;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import utils.MongoDBConnectionManager1;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

public class ReadTopicAdmin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
          
            TopicDAO topicDAO = new TopicDAO();

            // Fetch topics from the database
            List<TopicTemp> topicList = topicDAO.fetchTopics();

            // Reverse the list for displaying the latest topics first
            Collections.reverse(topicList);

            // Pagination logic
            int itemsPerPage = 6;
            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                currentPage = Integer.parseInt(pageParam);
            }
            int totalItems = topicList.size();
            int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
            int startIndex = (currentPage - 1) * itemsPerPage;
            int endIndex = Math.min(startIndex + itemsPerPage, totalItems);

            // Sublist for current page
            List<TopicTemp> topicsForCurrentPage = topicList.subList(startIndex, endIndex);

            // Set attributes for JSP
            request.setAttribute("topics", topicsForCurrentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);

            String adminId = (String) request.getSession().getAttribute("adminid");
            // Forward to the forum page
            request.getRequestDispatcher("forum-after-login.jsp?adminid=" + adminId).forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving topics.");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
    }
}