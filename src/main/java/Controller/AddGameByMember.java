package Controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Base64;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.commons.io.IOUtils;
import DAO.GamePostDAO;
import Model.GamePostMember;
import Model.GamePostTemp;
import java.util.List;

@MultipartConfig
public class AddGameByMember extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form parameters
        String title = request.getParameter("Title");
        String gamePlay = request.getParameter("Gameplay");
        String description = request.getParameter("Description");
        String dateRelease = request.getParameter("DateRelease");
        String author = request.getParameter("Author");
        String genre = request.getParameter("Genre");
        String linkGame = "";
        String price = "";
        String status = "";

        // Get member ID
         String memberId = (String) request.getSession().getAttribute("adminId");

        // Handle file upload
        Part filePart = request.getPart("file");
        String fileName = filePart.getSubmittedFileName();
        byte[] fileDataBytes;

        // Convert file data to Base64
        try (InputStream fileContent = filePart.getInputStream()) {
            fileDataBytes = IOUtils.toByteArray(fileContent);
        }
        String fileDataBase64 = Base64.getEncoder().encodeToString(fileDataBytes);

        // Game action images
        List<String> actionImagesBase64 = new ArrayList<>();
        for (Part actionFilePart : request.getParts()) {
            if (actionFilePart.getName().equals("actionFiles")) {
                try (InputStream actionFileContent = actionFilePart.getInputStream()) {
                    byte[] actionFileDataBytes = IOUtils.toByteArray(actionFileContent);
                    String actionFileDataBase64 = Base64.getEncoder().encodeToString(actionFileDataBytes);
                    actionImagesBase64.add(actionFileDataBase64);
                }
            }
        }

        // Create a GamePost object
        GamePostMember gamePost = new GamePostMember(
                null, title, gamePlay, description, dateRelease, author, genre,
                memberId, fileName, fileDataBase64,linkGame,price,status, actionImagesBase64);

        // Use GamePostDAO to insert the game
        GamePostDAO gamePostDAO = new GamePostDAO();
        gamePostDAO.addGamePostMember(gamePost, actionImagesBase64);

        // Redirect after adding
        response.sendRedirect("ReadGameHomeMember?memberid=" + memberId);
    }
}
