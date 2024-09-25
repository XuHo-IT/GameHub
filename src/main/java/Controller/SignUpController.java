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
 * @author OS
 */
public class SignUpController extends HttpServlet {

  

       private MongoClient mongoClient;

    @Override
    public void init() throws ServletException {
        mongoClient = MongoClients.create("mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phone");
        String dateOfBirth = request.getParameter("dob"); 
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        
         MongoDatabase database = mongoClient.getDatabase("GameHub");
         MongoCollection<Document> collection = database.getCollection("superadmin");
         
          Document user = new Document("email", email)
                .append("phoneNumber", phoneNumber)
                .append("dateOfBirth", dateOfBirth)
                .append("address", address)
                .append("password", password)
                .append("name",name);


            
            collection.insertOne(user);
             response.sendRedirect("admin-after-login.jsp");
    }

    @Override
public void destroy() {
    if (mongoClient != null) {
        mongoClient.close();
    }
}
}

