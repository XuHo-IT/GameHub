package Controller;

import DAO.GamePostDAO;
import Model.GamePost;
import Model.GamePostTemp;
import org.apache.commons.io.IOUtils;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

@MultipartConfig
public class AddGameController extends HttpServlet {

    private final GamePostDAO addGameDAO = new GamePostDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("Title");
        String gamePlay = request.getParameter("Gameplay");
        String description = request.getParameter("Description");
        String dateRelease = request.getParameter("DateRelease");
        String author = request.getParameter("Author");
        String genre = request.getParameter("Genre");
        String adminId = (String) request.getSession().getAttribute("adminId");
        String linkGame ="";
        String price = ""; 

        // Primary cover image
        Part filePart = request.getPart("file");
        String fileName = filePart.getSubmittedFileName();
        InputStream fileContent = filePart.getInputStream();
        byte[] fileDataBytes = IOUtils.toByteArray(fileContent);
        String fileDataBase64 = Base64.getEncoder().encodeToString(fileDataBytes);

        // Game action images
        List<String> actionImagesBase64 = new ArrayList<>();
        for (Part actionFilePart : request.getParts()) {
            if ("actionFiles".equals(actionFilePart.getName())) {
                byte[] actionFileDataBytes = IOUtils.toByteArray(actionFilePart.getInputStream());
                actionImagesBase64.add(Base64.getEncoder().encodeToString(actionFileDataBytes));
            }
        }

        // Create GamePost object
        GamePostTemp gamePost = new GamePostTemp(null, title, gamePlay, description, dateRelease, author, genre,
                adminId, fileName, fileDataBase64,linkGame,price);

        // Call DAO to insert the game post into MongoDB
        addGameDAO.addGamePost(gamePost, actionImagesBase64);

        response.sendRedirect("ReadGameHomeAdmin?adminid=" + adminId);
    }
}
