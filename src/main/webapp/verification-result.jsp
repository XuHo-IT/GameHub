<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Verification Result</title>
</head>
<body>
    <h1>Email Verification Status</h1>
    <%
        // Get the verification parameter from the query string
        String verificationParam = request.getParameter("verification");
        boolean isVerified = false; // Default to false

        // Check if the parameter exists and is either "true" or "false"
        if (verificationParam != null) {
            isVerified = Boolean.parseBoolean(verificationParam); // Convert the string to a boolean
        }

        if (isVerified) {
            out.println("<p>Your email has been successfully verified!</p>");
        } else {
            out.println("<p>Email verification failed or is still pending. Please check your email for verification instructions.</p>");
        }
    %>
    <a href="ReadGameHomeController">Go back to Home</a>
</body>
</html>
