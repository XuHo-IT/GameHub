/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


/**
 *
 * @author OS
 */
public class LoginController extends HttpServlet {

   
   

      private MongoClient mongoClient;

    @Override
    public void init() throws ServletException {
        mongoClient = MongoClients.create("mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
    }
  

    @Override 
 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    MongoDatabase database = mongoClient.getDatabase("GameHub");
    MongoCollection<Document> collection = database.getCollection("superadmin");

    Document query = new Document("Email", email);
    Document user = collection.find(query).first();

    if (user != null && user.getString("Password").equals(password)) {
        response.sendRedirect("admin-after-login.jsp");
    } else {
        request.setAttribute("errorMessage", "Invalid email or password");
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}


   @Override
public void destroy() {
    if (mongoClient != null) {
        mongoClient.close();
    }
}
}
