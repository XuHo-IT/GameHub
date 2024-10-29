package Controller;

import Model.SuperAdmin;
import DAO.UserDAO;
import utils.EmailUtility;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

public class SignUpController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get user registration details
        String name = request.getParameter("Name");
        String email = request.getParameter("Email");
        String phoneNumber = request.getParameter("Phone");
        String dateOfBirth = request.getParameter("Dob");
        String address = request.getParameter("Address");
        String password = request.getParameter("Password");
        String photoUrl = request.getParameter("PhotoUrl");

        // Parse the Date of Birth
        Date dob;
        try {
            dob = new SimpleDateFormat("yyyy-MM-dd").parse(dateOfBirth);
        } catch (ParseException e) {
            request.setAttribute("errorMessage", "Invalid date format.");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
            return;
        }


        // Create a SuperAdmin object
        SuperAdmin superAdmin = new SuperAdmin(
                null, // MongoDB auto-generates the Admin ID
                name,
                dob,
                email,
                phoneNumber,
                address,
                password,
                photoUrl,
                "0", // Default role for regular user
                "Active"
        );

        UserDAO superAdminDAO = new UserDAO();

        if (superAdminDAO.isEmailRegistered(email)) {
            request.setAttribute("errorMessage", "This email is already registered.");
                   response.sendRedirect("email_register.jsp");
        } else {
            // Register user
            ObjectId adminId = superAdminDAO.registerSuperAdmin(superAdmin);

            // Generate verification key and insert it
            String verificationKey = UUID.randomUUID().toString();
            superAdminDAO.insertVerificationKey(superAdmin.getEmail(), verificationKey);

            // Send verification email
            boolean emailSent = EmailUtility.sendEmailVerification(superAdmin.getEmail(), verificationKey);
            if (emailSent) {
                HttpSession session = request.getSession();
                session.setAttribute("currentUser", superAdmin);
                session.setAttribute("adminId", adminId.toString());
                session.setAttribute("adminName", superAdmin.getName());
                session.setAttribute("adminEmail", superAdmin.getEmail());
                session.setAttribute("photoUrl", superAdmin.getPhotoUrl());
                response.sendRedirect("ReadGameHomeMember?id=" + adminId.toString());
            } else {
                request.setAttribute("errorMessage", "Failed to send verification email.");
                request.getRequestDispatcher("error-page.jsp").forward(request, response);
            }
        }
    }

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
}
