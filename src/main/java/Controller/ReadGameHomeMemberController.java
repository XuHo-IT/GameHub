package Controller;

import DAO.GamePostDAO;
import Model.GamePost;
import Model.GamePostTemp;
import Model.Genre;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Controller for handling game post retrieval for members, as well as logout functionality.
 */
public class ReadGameHomeMemberController extends HttpServlet {

    private final GamePostDAO gamePostDAO = new GamePostDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Fetch the genres and top 4 game posts for display
            List<Genre> genres = gamePostDAO.getGenres();
            List<GamePostTemp> postTop4 = gamePostDAO.getTopGamePosts(4);

            // Set retrieved data as request attributes
            request.setAttribute("genres", genres);
            request.setAttribute("posts", postTop4);

            // Forward the request to the member home JSP page
            request.getRequestDispatcher("after-login.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving game posts.");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
    }
}
