package Controller;

import Model.Genre;
import DAO.GamePostDAO;
import Model.GamePostMember;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

public class ReadGameUploadByMember extends HttpServlet {

    private final GamePostDAO gamePostDAO = new GamePostDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("id");
        String selectedGenreId = request.getParameter("genre");

        try {
            // Fetch genres from the DAO
            List<Genre> genres = gamePostDAO.getGenres();
            request.setAttribute("genres", genres);

            // Fetch game posts from the DAO
            List<GamePostMember> postList = gamePostDAO.getGamePostsMember(selectedGenreId);
            Collections.reverse(postList); // Reverse the list if needed

            request.setAttribute("postsMember", postList);
            request.setAttribute("posts", postList); // Combine this attribute
            request.setAttribute("id", userId);

            // Forward the request to the appropriate JSP page based on role
            String role = request.getParameter("role");
            if ("1".equals(role)) {
                request.getRequestDispatcher("admin-after-login.jsp?id=" + userId).forward(request, response);
            } else {
                request.getRequestDispatcher("chart/censor.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving game posts.");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
    }
}
