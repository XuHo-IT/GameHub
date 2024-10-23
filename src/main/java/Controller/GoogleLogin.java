/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.GoogleAccount;
import Model.GoogleLoginHandler;
import Model.Iconstant;
import Model.UserModel;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mongodb.MongoConectUser;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import org.bson.types.ObjectId;
/**
 *
 * @author Admin
 */
public class GoogleLogin extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        String accessToken = getToken(code);
        GoogleAccount acc = getUserInfo(accessToken);  
        MongoConectUser mgcn = new MongoConectUser();
        String id = "HanHacAm";
        List<UserModel> userList = mgcn.getAllUsers();
        boolean emailExist = false;
        String sign = "no";
        
        for (UserModel u : userList) {
            if (acc.getEmail().equals(u.getEmail())){
                emailExist = true;
                sign = "yes";
                id = u.getId();
                
            }
        }

        if (emailExist == true) {
            UserModel user = mgcn.getUserById(id);
            String location = user.getRole().equals("0") ? "after-login.jsp" : "admin-after-login.jsp";
            response.sendRedirect(location + "?id=" + id);
        }else {
            String name = acc.getName();
            String email = acc.getEmail();
            String phoneNumber = "";
            String dateOfBirth = "";
            String address = "";
            String password = "Abc123";
            String photoUrl = "img/logo1.png";
            ObjectId userId = mgcn.createAccount(name, email, phoneNumber, dateOfBirth, address, password, photoUrl);

        // Check if the account was created successfully
            if (userId != null) {
                UserModel user = mgcn.getUserById(userId.toString());
                String location = user.getRole().equals("0") ? "after-login.jsp" : "admin-after-login.jsp";
                response.sendRedirect(location + "?id=" + id);
            } else {
                response.sendRedirect("index.jsp");
            }

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    public static String getToken(String code) throws ClientProtocolException, IOException {

        String response = Request.Post(Iconstant.GOOGLE_LINK_GET_TOKEN)

                .bodyForm(

                        Form.form()

       .add("client_id", Iconstant.GOOGLE_CLIENT_ID)

                        .add("client_secret", Iconstant.GOOGLE_CLIENT_SECRET)

                        .add("redirect_uri", Iconstant.GOOGLE_REDIRECT_URI)

                        .add("code", code)

                        .add("grant_type", Iconstant.GOOGLE_GRANT_TYPE)

                        .build()

                )

                .execute().returnContent().asString();



        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);

        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");

        return accessToken;

    }

    // Method to retrieve user info using the access token
    public static GoogleAccount getUserInfo(final String accessToken) throws ClientProtocolException, IOException {

        String link = Iconstant.GOOGLE_LINK_GET_USER_INFO + accessToken;

        String response = Request.Get(link).execute().returnContent().asString();

        GoogleAccount googlePojo = new Gson().fromJson(response, GoogleAccount.class);

        return googlePojo;

    }
}
