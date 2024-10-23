package Controller;

import Model.EmailVerification;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import org.bson.Document;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.annotation.WebServlet;

public class VerifyEmailHandler extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Retrieve the verification key from the request
        String verificationKey = request.getParameter("key");
        String email = request.getParameter("email");

        // Create or retrieve the user session
        HttpSession session = request.getSession();

        // Connect to MongoDB
        MongoClient mongoClient = MongoClients.create("mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
        MongoDatabase database = mongoClient.getDatabase("GameHub");
        MongoCollection<Document> verifiedEmailCollection = database.getCollection("VerifiedEmail");

        Document existingVerification = verifiedEmailCollection.find(Filters.eq("email", email)).first();

        if (existingVerification != null) {
            // Email already exists in the VerifiedEmail collection, handle accordingly
            if ("true".equalsIgnoreCase(existingVerification.getString("isVerified"))) {
                session.setAttribute("isVerified", true); // Email is already verified
            } else {
                session.setAttribute("isVerified", false); // Verification pending
            }
        } else {
            // Email doesn't exist, create a new verification entry
            Document newVerification = new Document("email", email)
                    .append("key", verificationKey)
                    .append("isVerified", "false");

            verifiedEmailCollection.insertOne(newVerification);

            // Find the document with the matching verification key
            Document verificationDoc = verifiedEmailCollection.find(Filters.eq("key", verificationKey)).first();

            try (PrintWriter out = response.getWriter()) {
                if (verificationDoc != null) {
                    // Check if the email has already been verified
                    String isVerified = verificationDoc.getString("isVerified");

                    if ("true".equalsIgnoreCase(isVerified)) {
                        session.setAttribute("isVerified", true); // Already verified
                    } else {
                        // Mark the email as verified
                        verificationDoc.put("isVerified", "true");

                        // Update the document in MongoDB
                        verifiedEmailCollection.replaceOne(Filters.eq("key", verificationKey), verificationDoc);

                        // Set the session attribute for verification
                        session.setAttribute("isVerified", true);
                    }
                } else {
                    if (email == null || email.isEmpty()) {
                        session.setAttribute("isVerified", false); // Error case
                        return;
                    }

                    EmailVerification emailVerification = new EmailVerification(email, verificationKey, "true");

                    // Create a new document based on the EmailVerification model
                    Document newVerificationDoc = new Document("email", emailVerification.getEmail())
                            .append("key", emailVerification.getKey())
                            .append("isVerified", emailVerification.getIsVerified());

                    // Insert the new verification document into MongoDB
                    verifiedEmailCollection.insertOne(newVerificationDoc);

                    // Respond to the user
                    session.setAttribute("isVerified", true); // Verification record created and verified
                }
            } finally {
                // Close the MongoDB connection
                mongoClient.close();
            }
        }
        // Get the verification status from the session
        boolean isVerified = (boolean) session.getAttribute("isVerified");

        // Redirect to verification-result.jsp with the status as a query parameter
        response.sendRedirect("verification-result.jsp?verification=" + isVerified);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
