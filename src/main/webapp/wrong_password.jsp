<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 50px;
            background-color: #f8d7da;
            color: #721c24;
        }
        h1 {
            color: #721c24;
        }
        p {
            font-size: 18px;
        }
        .btn {
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h1>
        <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            if ("Invalid email".equals(errorMessage)) {
        %>
            This email has not been registered, please sign up.
        <% 
            } else if ("Wrong password".equals(errorMessage)) {
        %>
            Your password is incorrect, use forgot password to recover your account.
        <% 
            } else {
        %>
            An error occurred. Please try again.
        <% 
            }
        %>
    </h1>
    <a class="btn" href="ReadGameHome">Return to Home</a>
</body>
</html>
