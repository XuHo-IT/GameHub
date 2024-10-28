// ReadGameHomeController.java
package Controller;

import DAO.GamePostDAO;
import Model.GamePost;
import Model.GamePostTemp;
import Model.Genre;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ReadGameHome extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            GamePostDAO gamePostDAO = new GamePostDAO();
          
            // Retrieve genres
            List<Genre> genres = gamePostDAO.getGenres();
            request.setAttribute("genres", genres);

            // Retrieve the genre parameter from the request, if it exists
            String selectedGenreId = request.getParameter("genre");

            // Fetch the top 4 game posts, filtered by genre if specified
            List<GamePostTemp> postTop4 = gamePostDAO.getTopGamePosts(4);
            if (selectedGenreId != null && !selectedGenreId.isEmpty()) {
                postTop4 = gamePostDAO.getGamePostsByGenre(selectedGenreId).subList(0, Math.min(4, postTop4.size()));
            }

            request.setAttribute("posts", postTop4);
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving game posts.");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
    }
}
