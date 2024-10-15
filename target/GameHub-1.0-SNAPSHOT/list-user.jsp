<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Model.UserModel, mogodb.MongoConectUser" %>
<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
   response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
   response.setDateHeader("Expires", 0); // Proxies.
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="css/background.css">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <title>View Users</title>
  <style>
    /* Apply styles for the table container */
    .user-list-container {
      overflow-y: auto; /* Enable vertical scrollbar */
      max-height: 400px; /* Set a maximum height for the container */
    }
  </style>
</head>
<body>
<section class="h-100 h-custom" style="background-color: #6f2b95;">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-12">
        <div class="card" style="border-radius: 15px; background-color: black;">
          <div class="card-body p-5">
            <h1 class="fw-bold mb-4" style="color:antiquewhite">User List</h1>
            <div class="user-list-container"> 
              <table class="table table-dark table-hover">
                <thead>
                  <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Email</th>
                    <th scope="col">Phone</th>
                    <th scope="col">Date of Birth</th>
                    <th scope="col">Address</th>
                    <th scope="col">Name</th>
                    <th scope="col">Status</th>
                    <th scope="col">Action</th>
                  </tr>
                </thead>
                <tbody>
                  <%
                    MongoConectUser mgcn = new MongoConectUser();
                    List<UserModel> userList = mgcn.getAllUsers();
                    if (userList != null && !userList.isEmpty()) {
                      for (UserModel user : userList) {                        
                        String statusLabel;
                        String actionButton;
                        

                        // Determine the status label and action button based on user status
                        if ("Active".equals(user.getStatus())) {
                          statusLabel = "<span class='text-success'>Active</span>"; // Green for active
                          actionButton = "<a href=\"SuspendUserController?id=" + user.getId() + "\" class=\"btn btn-warning btn-sm\">Suspend</a>";
                        } else {
                          statusLabel = "<span class='text-danger'>Suspended</span>"; // Red for suspended
                          actionButton = "<a href=\"UnSuspendUserController?id=" + user.getId() + "\" class=\"btn btn-primary btn-sm\">Unsuspend</a>";
                        }

                        out.print("<tr>" +
                          "<td>" + user.getId() + "</td>" +
                          "<td>" + user.getEmail() + "</td>" +
                          "<td>" + user.getPhone() + "</td>" +
                          "<td>" + user.getDateOfBirth() + "</td>" +
                          "<td>" + user.getAddress() + "</td>" +
                          "<td>" + user.getName() + "</td>" +
                          "<td>" + statusLabel + "</td>" + // New cell for status label
                          "<td>" +
                            "<div class='d-flex'>" + // Use flexbox to align buttons horizontally
                              "<a href=\"RemoveUserServlet?id=" + user.getId() + "\" class=\"btn btn-danger btn-sm me-2\">Remove</a>" +
                              actionButton + // Add the action button here
                            "</div>" +
                          "</td>" +
                        "</tr>");
                      }
                    } else {
                      out.print("<tr><td colspan='8' class='text-center'>No users found.</td></tr>");
                    }
                  %>
                </tbody>
              </table>
                
            </div>
                <div class="pt-4">
                            <h6><a href="admin-after-login.jsp" class="text-body" style="color:antiquewhite"><i class="fas fa-long-arrow-alt-left"></i> Back to home</a></h6>
                        </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

