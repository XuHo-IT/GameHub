package Controller;

import java.io.*;
import java.util.zip.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/uploadLink")
@MultipartConfig
public class UploadLinkServlet extends HttpServlet {
    private static final String UPLOAD_DIRECTORY = "/uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = request.getPart("linkFile");
        String linkGame = "";
        String savedFilePath = "";

        if (filePart != null && filePart.getSize() > 0) {
            String uploadDir = getServletContext().getRealPath(UPLOAD_DIRECTORY);
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs(); // Create the directory if it doesn't exist
            }

            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            File savedFile = new File(dir, fileName);
            savedFilePath = UPLOAD_DIRECTORY + "/" + fileName;

            try (InputStream fileContent = filePart.getInputStream();
                 FileOutputStream fos = new FileOutputStream(savedFile)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = fileContent.read(buffer)) != -1) {
                    fos.write(buffer, 0, bytesRead);
                }
            }

            // If the uploaded file is a ZIP, extract and process the contents
            if (fileName.endsWith(".zip")) {
                linkGame = processZipFile(savedFile);
            } else {
                linkGame = savedFilePath; // If not a ZIP, just save the file path
            }
        }

        request.setAttribute("linkGame", linkGame);
        RequestDispatcher dispatcher = request.getRequestDispatcher("nextPage.jsp");
        dispatcher.forward(request, response);
    }

    private String processZipFile(File zipFile) {
        StringBuilder fileLinks = new StringBuilder();

        try (ZipInputStream zis = new ZipInputStream(new FileInputStream(zipFile))) {
            ZipEntry entry;
            while ((entry = zis.getNextEntry()) != null) {
                if (!entry.isDirectory()) {
                    // Save or process file entries here (e.g., storing paths in fileLinks)
                    fileLinks.append(entry.getName()).append("; ");
                }
                zis.closeEntry();
            }
        } catch (IOException e) {
            e.printStackTrace();
            // Handle errors and return empty string if an error occurs
        }
        return fileLinks.toString();
    }
}
