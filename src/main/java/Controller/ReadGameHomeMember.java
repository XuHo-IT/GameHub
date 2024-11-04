package Controller;

import DAO.GamePostDAO;
import Model.GamePostTemp;
import Model.Genre;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Controller for handling game post retrieval for members, as well as logout functionality.
 */
public class ReadGameHomeMember extends HttpServlet {

    private final GamePostDAO gamePostDAO = new GamePostDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Fetch genres and set as request attribute
            List<Genre> genres = gamePostDAO.getGenres();
            request.setAttribute("genres", genres);

            // Retrieve selected genre from request parameters
            String selectedGenreId = request.getParameter("genre");

            // Fetch the top 4 game posts, filtered by genre if specified
            List<GamePostTemp> postTop4;
            if (selectedGenreId != null && !selectedGenreId.isEmpty()) {
                List<GamePostTemp> genreFilteredPosts = gamePostDAO.getGamePostsByGenre(selectedGenreId);
                postTop4 = genreFilteredPosts.subList(0, Math.min(4, genreFilteredPosts.size()));
            } else {
                postTop4 = gamePostDAO.getTopGamePosts(4);
            }
            request.setAttribute("posts", postTop4);

            // Forward to the member's home page JSP
            request.getRequestDispatcher("after-login.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving game posts.");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
    }
}
