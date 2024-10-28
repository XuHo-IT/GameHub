package Controller;

import Model.GamePost;
import Model.Genre;
import DAO.GamePostDAO;
import Model.GamePostTemp;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

public class ReadGameList extends HttpServlet {

    private final GamePostDAO gamePostDAO = new GamePostDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Fetch genres from the DAO
            List<Genre> genres = gamePostDAO.getGenres();
            request.setAttribute("genres", genres);

            // Get search parameters
            String keyword = request.getParameter("keyword");
            String selectedGenre = request.getParameter("genre");

            List<GamePostTemp> postList;

            // If a keyword is provided, perform a search
            if (keyword != null && !keyword.trim().isEmpty()) {
                postList = gamePostDAO.searchPosts(keyword, selectedGenre);
            } else {
                // Fetch game posts by genre if no keyword is provided
                postList = gamePostDAO.getGamePostsByGenre(selectedGenre);
            }

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

            // Ensure the sublist is valid
            List<GamePostTemp> postsForCurrentPage = postList.subList(startIndex, endIndex);

            // Set request attributes
            request.setAttribute("posts", postsForCurrentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("selectedGenre", selectedGenre);  // Pass selected genre to JSP
            request.setAttribute("keyword", keyword);  // Pass the keyword for search

            // Forward the request to the JSP page
            request.getRequestDispatcher("games.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
            request.setAttribute("errorMessage", "Error retrieving game posts.");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
    }
}