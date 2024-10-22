/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.bson.Document;

/**
 *
 * @author Admin
 */
public class EditUserServlet extends HttpServlet {
     private MongoClient mongoClient;

    @Override
    public void init() throws ServletException {
        mongoClient = MongoClients.create("mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get parameters from the request
        String userId = request.getParameter("id");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String dateOfBirth = request.getParameter("dateOfBirth");
        String address = request.getParameter("address");
        String name = request.getParameter("name");

       

      
            MongoDatabase database = mongoClient.getDatabase("GameHub");
            MongoCollection<Document> collection = database.getCollection("superadmin");

            // Create a document with the updated user information
            Document updatedUser = new Document("Email", email)
                    .append("PhoneNumber", phone)
                    .append("DateOfBirth", dateOfBirth)
                    .append("Address", address)
                    .append("Name", name);
            
            // Update the user in the database
            collection.updateOne(new Document("_id", new org.bson.types.ObjectId(userId)), new Document("$set", updatedUser));
       
        // Redirect to the user list page after editing
        response.sendRedirect("list-user.jsp");
    }
 @Override
    public void destroy() {
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}
