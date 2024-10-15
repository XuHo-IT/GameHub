package Controller;

import java.io.*;
import java.util.zip.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/uploadLink")
@MultipartConfig
public class UploadLinkServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = request.getPart("linkFile"); // Retrieves <input type="file" name="linkFile">
        String linkGame = "";
        String savedFilePath = "";

        if (filePart != null && filePart.getSize() > 0) {
            // Define the directory to save uploaded files
            String uploadDir = getServletContext().getRealPath("/uploads"); // Adjust path as needed
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs(); // Create the directory if it doesn't exist
            }

            // Create a unique file name to avoid overwriting
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            File savedFile = new File(dir, fileName);
            savedFilePath = "uploads/" + fileName; // Relative path to access later

            // Save the uploaded file to the specified directory
            try (InputStream fileContent = filePart.getInputStream();
                 FileOutputStream fos = new FileOutputStream(savedFile)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = fileContent.read(buffer)) != -1) {
                    fos.write(buffer, 0, bytesRead);
                }
            }

            // Read the contents of the ZIP file if needed (as before)
            // ...
        }

        // Process the linkGame as needed
        request.setAttribute("linkGame", savedFilePath); // Store the path for download
        RequestDispatcher dispatcher = request.getRequestDispatcher("nextPage.jsp"); // Adjust page as needed
        dispatcher.forward(request, response);
    }
}
