package Controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.mongodb.client.MongoClient;
import java.io.IOException;

public class AddToWishlistController extends HttpServlet {

    private MongoClient mongoClient;

    public AddToWishlistController(MongoClient mongoClient) {
        this.mongoClient = mongoClient;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String postId = request.getParameter("postId");
        String userEmail = request.getParameter("userEmail"); // Lưu ý: bạn cần thêm cách nhận email từ form

        // Retrieve game title from MongoDB
        String gameTitle = getGameTitleFromMongo(postId);

        // Use the GameReleaseNotificationAdminController to send the confirmation email
//        GameReleaseNotificationAdminController notificationController = 
//                new GameReleaseNotificationAdminController(mongoClient);
//        notificationController.sendWishlistConfirmationEmail(userEmail, gameTitle, postId);

        // Redirect to game-single.jsp with the updated wishlist status
        response.sendRedirect("game-single.jsp?id=" + postId + "&wishlistAdded=true");
    }

    private String getGameTitleFromMongo(String postId) {
        // Code to retrieve the game title from MongoDB based on the postId
        return "Sample Game Title"; // Placeholder
    }
}
