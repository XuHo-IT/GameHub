/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.GamePostDAO;
import DAO.TopicDAO;
import DAO.UserDAO;
import Model.GamePostTemp;
import Model.Genre;
import Model.TopicTemp;
import Model.UserModel;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class SearchTopicServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            TopicDAO topicDAO = new TopicDAO();
            UserDAO userDAO = new UserDAO();

 
            // Retrieve search parameters
            String keyword = request.getParameter("keyword");
            String genre = request.getParameter("genre");
            
            // Search for posts
            List<TopicTemp> topicList = topicDAO.searchTopic(keyword);

            // Pagination logic
            int itemsPerPage = 9;
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
            request.setAttribute("keyword", keyword);
            request.setAttribute("genre", genre);
            request.setAttribute("topicList", topicList);
            
            HttpSession session = request.getSession();
             if (session.getAttribute("currentUser") != null) {
                String userID = (String) session.getAttribute("adminId");
                UserModel user = userDAO.getUserById(userID);
                String userRole = user.getRole();
                if(userRole.equals("1")){
                    request.getRequestDispatcher("search-result-topic-admin.jsp").forward(request, response);
                } else if(userRole.equals("0")){
                    request.getRequestDispatcher("search-result-topic-member.jsp").forward(request, response);
                }
            } else if(session.getAttribute("currentUser") == null){
                request.getRequestDispatcher("search-result-topic.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving search results.");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
    }
}
