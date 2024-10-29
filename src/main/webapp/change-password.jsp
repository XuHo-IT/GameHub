<%@page import="DAO.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="org.bson.types.ObjectId" %>
<%
    // Get the user ID from the request parameter
    String userId = request.getParameter("id");
    // Create an instance of MongoConectUser to retrieve user information
    UserDAO mgcn = new UserDAO();
    // Get the user by ID
    UserModel user = mgcn.getUserById(userId);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>Change Password</title>
</head>
<body>
    <form action="ChangePasswordController" method="post">
        <input type="hidden" name="id" value="<%= userId %>"> <!-- Hidden field to send the user id -->
        <div class="row">
            <div class="col">
                <div class="form-group" style="color: antiquewhite;">
                    <label>Current Password</label>
                    <input class="form-control" type="password" name="currentPassword" placeholder="********" required>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <div class="form-group" style="color: antiquewhite;">
                    <label>New Password</label>
                    <input class="form-control" type="password" name="newPassword" placeholder="********" required>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <div class="form-group" style="color: antiquewhite;">
                    <label>Confirm New Password</label>
                    <input class="form-control" type="password" name="confirmPassword" placeholder="********" required>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col d-flex justify-content-end" style="color: antiquewhite;">
                <button type="submit" class="btn btn-primary">Save Changes</button>
            </div>
        </div>
    </form>
    
    <script>
        // JavaScript to apply the background image from the data-sbg attribute
        document.addEventListener("DOMContentLoaded", function() {
            const bodyElement = document.querySelector('body');
            const bgImage = bodyElement.getAttribute('data-sbg');
            if (bgImage) {
                bodyElement.style.backgroundImage = `url(${bgImage})`;
                bodyElement.style.backgroundSize = 'cover';
                bodyElement.style.backgroundPosition = 'center';
                bodyElement.style.backgroundRepeat = 'no-repeat';
                bodyElement.style.backgroundAttachment = 'fixed';
            }
        });
    </script>
</body>
</html>