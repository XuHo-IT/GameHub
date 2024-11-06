package Controller;

import DAO.GamePostDAO;
import Model.GamePostTemp;
import Model.Genre;
import com.mongodb.client.MongoClient;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.MongoDBConnectionManager;
import org.bson.Document;

import java.io.IOException;
import java.util.List;

public class ReadGameHomeAdmin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Initialize MongoDB client and session
            MongoClient mongoClient = MongoDBConnectionManager.getLocalMongoClient();
            HttpSession session = request.getSession();

            GamePostDAO gamePostDAO = new GamePostDAO();
            GameReleaseNotificationAdminController.startScheduler(mongoClient, session);

            // Get parameters from the request
            String userId = request.getParameter("id");
            String selectedGenreId = request.getParameter("genre");
            String view = request.getParameter("view");

            // Set the user ID attribute (for session or tracking purposes)
            request.setAttribute("id", userId);

            // Fetch genres and top game posts
            List<Genre> genres = gamePostDAO.getGenres();
            request.setAttribute("genres", genres);

            List<GamePostTemp> postTop4 = gamePostDAO.getTopGamePosts(4);

            // Filter by genre if a valid genre is specified
            if (selectedGenreId != null && !selectedGenreId.isEmpty()) {
                List<GamePostTemp> genreFilteredPosts = gamePostDAO.getGamePostsByGenre(selectedGenreId);
                postTop4 = genreFilteredPosts.subList(0, Math.min(4, genreFilteredPosts.size()));
            }
            request.setAttribute("posts", postTop4);

            // Fetch transactions
            List<Document> transactions = gamePostDAO.getTransactions();
            request.setAttribute("transactionList", transactions);

            // Determine the view and forward to the appropriate JSP page
            if ("chart".equals(view)) {
                request.getRequestDispatcher("chart/index-chart.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("admin-after-login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving data.");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
    }
}
