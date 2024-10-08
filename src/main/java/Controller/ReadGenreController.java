/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Genre;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.bson.Document;

/**
 *
 * @author OS
 */
public class ReadGenreController extends HttpServlet {

     private MongoClient mongoClient;

    @Override
    public void init() throws ServletException {
        mongoClient = MongoClients.create("mongodb+srv://LoliHunter:Loli_slayer_123@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
    }
 @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    // Fetch genres from MongoDB
    MongoDatabase database = mongoClient.getDatabase("GameHub");
    MongoCollection<Document> genreCollection = database.getCollection("Genre");

    // Fetch genres as Document and then map them to Genre model
    List<Document> genreDocuments = genreCollection.find().into(new ArrayList<>());
    List<Genre> genres = new ArrayList<>();

    for (Document doc : genreDocuments) {
        Genre genre = new Genre();
        genre.setGenreId(doc.getObjectId("_id").toString());
        genre.setGenre(doc.getString("Genre"));
        genre.setAdminId(doc.getString("AdminId"));
        genres.add(genre);
    }

    // Debug log to ensure genres are not empty
    System.out.println("Genres found: " + genres.size());

    // Pass genres to the JSP page
    request.setAttribute("genres", genres);
    request.getRequestDispatcher("admin-after-login.jsp").forward(request, response);
}
@Override
    public void destroy() {
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}
