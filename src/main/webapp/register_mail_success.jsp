<%@page import="Model.UserModel"%>
<%@page import="DAO.UserDAO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html style="background: url(img/R&M.gif);
      background-size: 100%;
      background-repeat: no-repeat;
      background-position: top;">
    <head>
        <link rel="stylesheet" href="css/style.css" />
        <title>Mail Register Successfully</title>
        <style>
            <%
                String id = request.getParameter("userId");
            %>
            .message {
                font-size: 50px;
                text-align: center;
                margin-top: 23px;
                text-shadow: 2px 2px 2px black, -2px -2px 2px black, -2px 2px 2px black, 2px -2px 2px black;
                color: gray;
                mix-blend-mode: multiply;
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
    <body style="display: flex;
          flex-direction: column;
          align-items: center;">
        <div class="message" style="font-family: FungkybrowdemoRegular; width: 80%">
            Thanks for your register, we will notify you by your email when game release
        </div>
        <div style="text-align: center; margin-top: 20px;">
            <button onclick="window.location.href = 'ReadGameHomeMember?userId=<%= id%>'" style="
                    font-family: FungkybrowdemoRegular;
                    padding: 10px 20px;
                    font-size: 30px;
                    color: white;
                    background-color: #6f2b95;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                    text-shadow: 1px 1px 1px black,
                    -1px -1px 1px black,
                    -1px 1px 1px black,
                    1px -1px 1px black;
                    ">Back to Homepage</button>
        </div>
    </body>
</html>
