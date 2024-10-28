package Controller;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Base64;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.bson.Document;
import mongodb.MongoConectUser;
import org.apache.commons.io.IOUtils;

@WebServlet("/upload-photo")
@MultipartConfig
public class UploadPhotoController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String userId = request.getParameter("userId");
            Part filePart = request.getPart("photofile");
            System.out.print(filePart);

            if (filePart == null || userId == null || userId.isEmpty()) {
                response.getWriter().println("Photo or userId missing.");
                return;
            }

            InputStream fileContent = filePart.getInputStream();
            byte[] fileDataBytes = IOUtils.toByteArray(fileContent);
            String fileDataBase64 = Base64.getEncoder().encodeToString(fileDataBytes);

            MongoConectUser mgcn = new MongoConectUser();
            boolean isUpdated = mgcn.updateUserProfilePicture(userId, fileDataBase64);

            if (isUpdated) {
                response.sendRedirect("user-profile.jsp?id=" + userId);
            } else {
                response.getWriter().println("User not found or not modified.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error uploading photo: " + e.getMessage());
        }
    }
}

