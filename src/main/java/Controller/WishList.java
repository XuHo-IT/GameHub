package Controller;

import Model.GamePost;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet to handle adding games to wishlist and redirecting to cart.
 */
public class WishList extends HttpServlet {


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String gameId = request.getParameter("postId");
        String gameTitle = request.getParameter("title");
        String gameImage = request.getParameter("fileData");

        // Create a Game object (or whatever object you're using for the game)
        GamePost game = new GamePost();
        game.setPostID(gameId);
        game.setTitle(gameTitle);
        game.setFileData(gameImage);

        // Retrieve the cart from session (initialize if it's null)
        HttpSession session = request.getSession();
        List<GamePost> wishlist = (List<GamePost>) session.getAttribute("wishlist");
        if (wishlist == null) {
            wishlist = new ArrayList<>();
        }

        // Add the game to the wishlist
        wishlist.add(game);

        // Save the updated wishlist back to the session
        session.setAttribute("wishlist", wishlist);

        // Redirect to the cart page (the wishlist page)
        response.sendRedirect("shopping-cart.jsp");
    }
}
