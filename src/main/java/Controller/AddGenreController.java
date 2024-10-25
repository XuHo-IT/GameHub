/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.Document;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import Model.Genre;
import utils.MongoDBConnectionManager1;

/**
 *
 * @author OS
 */
public class AddGenreController extends HttpServlet {

   

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form parameters
        String genre = request.getParameter("genre1");
        System.out.println("Genre from form: " + genre);
        // Get the admin's ID from the session
        String adminId = (String) request.getSession().getAttribute("adminId");

        // Create a GamePost object
        Genre genreMain = new Genre(
                null,
                genre,
                adminId);

        // Get MongoDB database and collection
        MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> collection = database.getCollection("Genre");

        // Create a MongoDB Document from the Genre object
        Document genre1 = new Document("Genre", genreMain.getGenre())
                .append("AdminId", genreMain.getAdminId());

        // Insert the document into the MongoDB collection
        collection.insertOne(genre1);
        // Redirect to the admin page after successful insertion
        response.sendRedirect("ReadGameHomeAdminController?adminid=" + adminId);
    }
}
