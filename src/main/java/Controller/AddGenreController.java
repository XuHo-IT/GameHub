package Controller;

import DAO.GamePostDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Model.Genre;

public class AddGenreController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form parameters
        String genre = request.getParameter("genre1");
        System.out.println("Genre from form: " + genre);

        // Get the admin's ID from the session
        String userId = (String) request.getSession().getAttribute("userId");

        // Create a Genre object
        Genre genreMain = new Genre(null, genre, adminId);

        // Use GenreDAO to insert the genre
        GamePostDAO genreDAO = new GamePostDAO();
        genreDAO.addGenre(genreMain);

        // Redirect to the admin page after successful insertion
        response.sendRedirect("ReadGameHomeAdmin");
    }
}
