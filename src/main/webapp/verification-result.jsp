<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <title>Verification Result</title>
</head>
<body>
    <h1>Email Verification Status</h1>
    <%
        Boolean isVerified = (Boolean) session.getAttribute("isVerified");

        if (isVerified != null) {
            if (isVerified) {
                out.println("<p>Your email has been successfully verified!</p>");
            } else {
                out.println("<p>Email verification failed or is still pending. Please check your email for verification instructions.</p>");
            }
            session.removeAttribute("isVerified"); // Clear the message after displaying
        } else {
            out.println("<p>No verification status available.</p>");
        }
    %>
    <a href="index.jsp">Go back to Home</a>
</body>
</html>
