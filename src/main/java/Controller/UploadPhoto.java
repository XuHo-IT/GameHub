package Controller;

import DAO.UserDAO;
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
import org.apache.commons.io.IOUtils;

@MultipartConfig
public class UploadPhoto extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     
            String userId = request.getParameter("userId");
            Part filePart = request.getPart("photoInput");
            if (filePart == null || filePart.getSize() == 0) {
                response.getWriter().println("Photo part is missing or empty.");
                return;
            }
            InputStream fileContent = filePart.getInputStream();
            byte[] fileDataBytes = IOUtils.toByteArray(fileContent);
            String fileDataBase64 = Base64.getEncoder().encodeToString(fileDataBytes);

            UserDAO mgcn = new UserDAO();
            mgcn.updateUserProfilePicture(userId, fileDataBase64);

            response.sendRedirect("user-profile.jsp?id=" + userId);

        }
    }

