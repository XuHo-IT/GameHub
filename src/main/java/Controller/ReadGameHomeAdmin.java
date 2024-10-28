package Controller;

import DAO.GamePostDAO;
import Model.GamePost;
import Model.GamePostTemp;
import Model.Genre;
import com.mongodb.client.MongoClient;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import utils.MongoDBConnectionManager;

import java.io.IOException;
import java.util.List;
import org.bson.Document;

public class ReadGameHomeAdmin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            MongoClient mongoClient = MongoDBConnectionManager.getLocalMongoClient();
            HttpSession session = request.getSession();

            GamePostDAO gamePostDAO = new GamePostDAO();
            GameReleaseNotificationAdminController.startScheduler(mongoClient, session);

            // Handle logout action
            String userId = request.getParameter("id");
           
            // Fetch genres and set as request attribute
            List<Genre> genres = gamePostDAO.getGenres();
            request.setAttribute("genres", genres);

            // Fetch game posts and set as request attribute
            List<GamePostTemp> postTop4 = gamePostDAO.getTopGamePosts(4);
            request.setAttribute("id", userId);
            request.setAttribute("posts", postTop4);

            // Fetch transactions and set as request attribute
            List<Document> transactions = gamePostDAO.getTransactions();
            request.setAttribute("transactionList", transactions);

            // Determine the view to redirect to
            String view = request.getParameter("view");
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
