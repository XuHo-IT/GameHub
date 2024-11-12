<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <link href="img/favicon.ico" rel="shortcut icon"/>
    <title>Password Changed Successfully</title>
    <style>
         <%
                String id = request.getParameter("userid");
            %>
        .message {
            font-size: 20px;
            color: #28a745;
            text-align: center;
            margin-top: 50px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #28a745;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="message">
        Password changed successfully!
    </div>
    <div style="text-align: center; margin-top: 20px;">
       <button onclick="window.location.href='ReadGameHomeMember?userId=<%= id %>'" style="padding: 10px 20px; font-size: 16px; color: white; background-color: #28a745; border: none; border-radius: 5px; cursor: pointer;">Back to Homepage</button>
    </div>
</body>
</html>
