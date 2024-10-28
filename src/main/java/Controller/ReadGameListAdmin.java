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

public class ReadGameListAdmin extends HttpServlet {

    private final GamePostDAO gamePostDAO = new GamePostDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Fetch genres from the DAO
            List<Genre> genres = gamePostDAO.getGenres();
            request.setAttribute("genres", genres);

            // Get the search parameters from the request
            String keyword = request.getParameter("keyword");
            String selectedGenre = request.getParameter("genre");

            // Check if a search keyword is provided
            if (keyword != null && !keyword.trim().isEmpty()) {
                // Perform a search and redirect to a different JSP
                List<GamePostTemp> postList = gamePostDAO.searchPosts(keyword, selectedGenre);
                request.setAttribute("posts", postList);
                request.setAttribute("selectedGenre", selectedGenre);
                request.setAttribute("keyword", keyword);
                request.getRequestDispatcher("search-results.jsp").forward(request, response);
            } else {
                // Fetch game posts by selected genre if no keyword
                List<GamePostTemp> postList = gamePostDAO.getGamePostsByGenre(selectedGenre);
                
                // Reverse the list if needed
                Collections.reverse(postList);

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

                // Get the sublist for the current page
                List<GamePostTemp> postsForCurrentPage = postList.subList(startIndex, endIndex);

                // Set attributes for JSP
                request.setAttribute("posts", postsForCurrentPage);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("currentPage", currentPage);
                request.setAttribute("selectedGenre", selectedGenre);  // Pass selected genre to JSP
                request.setAttribute("keyword", keyword);  // Pass keyword to JSP

                // Forward the request to the original JSP page
                request.getRequestDispatcher("games-after-login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
            request.setAttribute("errorMessage", "Error retrieving game posts.");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
    }
}
