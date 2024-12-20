package Controller;

import DAO.GamePostDAO;
import DAO.UserDAO;
import Model.GamePost;
import Model.GamePostTemp;
import Model.Genre;
import Model.SuperAdmin;
import Model.UserModel;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import utils.MongoDBConnectionManager;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;

public class Search extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
        
            GamePostDAO gamePostDAO = new GamePostDAO();
            UserDAO userDAO = new UserDAO();

            // Fetch genres from MongoDB
            List<Genre> genres = gamePostDAO.getGenres();
            
            request.setAttribute("genres", genres);  // Store genres in request attributes

            // Retrieve search parameters
            String keyword = request.getParameter("keyword");
            String genre = request.getParameter("genre");
            
            // Search for posts
            List<GamePostTemp> postList = gamePostDAO.searchPosts(keyword, genre);

            // Pagination logic
            int itemsPerPage = 9;
            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                currentPage = Integer.parseInt(pageParam);
            }
            int totalItems = postList.size();
            int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
            int startIndex = (currentPage - 1) * itemsPerPage;
            int endIndex = Math.min(startIndex + itemsPerPage, totalItems);
            // Sublist for current page
            List<GamePostTemp> postsForCurrentPage = postList.subList(startIndex, endIndex);

            // Set attributes for JSP
            request.setAttribute("posts", postsForCurrentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("keyword", keyword);
            request.setAttribute("genre", genre);
            request.setAttribute("postList", postList);
            
            HttpSession session = request.getSession();
             if (session.getAttribute("currentUser") != null) {
                String userID = (String) session.getAttribute("adminId");
                UserModel user = userDAO.getUserById(userID);
                String userRole = user.getRole();
                if(userRole.equals("1")){
                    request.getRequestDispatcher("search-result-admin.jsp").forward(request, response);
                } else if(userRole.equals("0")){
                    request.getRequestDispatcher("search-result-member.jsp").forward(request, response);
                }
            } else if(session.getAttribute("currentUser") == null){
                request.getRequestDispatcher("search-results.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving search results.");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
    }
}
