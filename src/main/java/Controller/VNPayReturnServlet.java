/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.Filters;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.bson.Document;
import org.bson.types.ObjectId;
import utils.MongoDBConnectionManager1;

/**
 *
 * @author OS
 */

public class VNPayReturnServlet extends HttpServlet {

   

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String postId = request.getParameter("postId"); // Make sure postId is being set

        String paymentStatus = request.getParameter("vnp_ResponseCode");
        
        if ("00".equals(paymentStatus)) {
                MongoClient mongoClient = MongoDBConnectionManager1.getLocalMongoClient();// Payment success code
            MongoCollection<Document> collection = mongoClient.getDatabase("GameHub").getCollection("postGame");

            if (postId != null) {
                Document post = collection.find(Filters.eq("_id", new ObjectId(postId))).first();

                // Log the retrieved post
                System.out.println("Retrieved post: " + post);

                if (post != null) {
                    String gameLink = post.getString("LinkGame");
                    System.out.println("Game link fetched: " + gameLink); // Log the game link

                    // Check if gameLink is null or not set
                    if (gameLink == null || gameLink.isEmpty()) {
                        gameLink = "default-game-link";  // Set a default game link if needed
                    }

                    // Pass the game link to the JSP page
                    request.setAttribute("postId", post);
                    request.setAttribute("linkGame", gameLink);
                    request.getRequestDispatcher("/payment-details.jsp").forward(request, response);
                } else {
                    response.getWriter().write("Game post not found.");
                }
            } else {
                response.getWriter().write("Invalid postId.");
            }
        } else {
            response.getWriter().write("Payment failed or canceled.");
        }
    }

}
