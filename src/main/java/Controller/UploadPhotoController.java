package Controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import Model.UserModel;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import mogodb.MongoConectUser;

@WebServlet("/upload-photo")
@MultipartConfig
public class UploadPhotoController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String userId = request.getParameter("userId");
            Part part = request.getPart("photo");
            String realPath = request.getServletContext().getRealPath("/uploads");
            String fileName = Path.of(part.getSubmittedFileName()).getFileName().toString();

            if (!Files.exists(Path.of(realPath))) {
                Files.createDirectory(Path.of(realPath));
            }

            part.write(realPath + "/" + fileName);

            String imagePath = "uploads/" + fileName;
            MongoConectUser mgcn = new MongoConectUser();
            boolean isUpdated = mgcn.updateUserProfilePicture(userId, imagePath);

            if (isUpdated) {
                response.sendRedirect("user-profile.jsp?id=" + userId);
            } else {
                response.getWriter().println("User not found or not modified.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred while uploading the photo: " + e.getMessage());
        }
    }

    
}

