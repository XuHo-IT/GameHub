package Controller;

import DAO.GamePostDAO;
import Model.GamePost;
import Model.GamePostEdit;
import Model.GamePostTemp;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;

@MultipartConfig
public class EditPostController extends HttpServlet {

    private final GamePostDAO gamePostDAO = new GamePostDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String postId = request.getParameter("postId");

        if ("edit".equals(action)) {
            editPost(request, response, postId);
        } else if ("delete".equals(action)) {
            deletePost(request, response, postId);
        }
    }

    private void editPost(HttpServletRequest request, HttpServletResponse response, String postId)
            throws ServletException, IOException {
        // Fetch new post data from the request
        postId=request.getParameter("postId");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String gamePlay = request.getParameter("gamePlay");
        String dateRelease = request.getParameter("dateRelease");
        String author = request.getParameter("author");
        String genre = request.getParameter("genre");
        String linkGame = request.getParameter("Link");
        String adminId = request.getParameter("adminId");
        
        String price = request.getParameter("Price");

       
        GamePostEdit updatedPost = new GamePostEdit(postId, title, gamePlay, description, dateRelease, author, genre, adminId, linkGame, price);
        // Update the post in the database
        gamePostDAO.editPost(postId, updatedPost);
        response.sendRedirect("edit_post_success.jsp?adminId="+adminId);
    }

    private void deletePost(HttpServletRequest request, HttpServletResponse response, String postId)
            throws ServletException, IOException {
          String adminId = request.getParameter("adminId");
        // Delete the post in the database
        gamePostDAO.deletePost(postId);
        response.sendRedirect("ReadGameHomeAdmin?adminId="+adminId);
    }
}
