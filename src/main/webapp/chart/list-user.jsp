<%@page import="DAO.UserDAO"%>
<%@page import="DAO.GamePostDAO"%>
<%@page import="mongodb.MongoConectUser"%>
<%@page import="Model.UserModel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="org.bson.Document" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Responsive Admin Dashboard | Redesign</title>
        <link rel="stylesheet" href="css/style.css" />
    </head>
    <body>
        <div class="container">
            <div class="navigation" style="background: #6f2b95; border-left: 10px solid #6f2b95">
                <ul>
                    <li>
                        <a href="">
                            <img src="../img/logo1.png" alt="" class="logo1" style="width: 25%; height: 25%;">
                            <span class="title">Manage Admin</span>
                        </a>
                    </li>
                    <li>
                        <a href="../ReadGameUploadByMember?adminId=<%= request.getSession().getAttribute("adminId")%>">
                            <span class="icon"><ion-icon name="people-outline"></ion-icon></span>
                            <span class="title">Censor Post</span>
                        </a>
                    </li>
                    <li>
                        <a href="../ReadGameHomeAdmin?view=chart&adminId=<%= request.getSession().getAttribute("adminId")%>">
                            <span class="icon"><ion-icon name="chatbubbles-outline"></ion-icon></span>
                            <span class="title">Statistic</span>
                        </a>
                    </li>
                    <li>
                        <a href="list-user.jsp?adminId=<%= request.getSession().getAttribute("adminId")%>">
                            <span class="icon"><ion-icon name="help-outline"></ion-icon></span>
                            <span class="title">Manage All User</span>
                        </a>
                    </li>
                </ul>
            </div>
            <!-- main -->
            <div class="main">
                <div class="topbar">
                    <div class="toggle">
                        <ion-icon name="menu-outline"></ion-icon>
                    </div>
                    <!-- UserImg -->
                    <%
                        UserDAO userDAO = new UserDAO();
                        UserModel user = userDAO.getUserById((String) request.getSession().getAttribute("adminId"));
                        request.setAttribute("user", user);
                    %>
                    <div style="font-family: "Ubuntu", sans-serif;">
                        <button type="button" class="btn back-btn" style="background: white; color: white; padding: 15px; font-size: 20px; color: #6f2b95; border: none; cursor: pointer" onclick="window.location.href = '../ReadGameHomeAdmin?&adminId=<%= request.getSession().getAttribute("adminId")%>'">Home</button>                    
                        <button type="button" class="btn back-btn" style="background: white; color: white; padding: 15px; font-size: 20px; color: #6f2b95; border: none; cursor: pointer" onclick="window.location.href = '../ReadGameListAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>'">Games</button>
                        <button type="button" class="btn back-btn" style="background: white; color: white; padding: 15px; font-size: 20px; color: #6f2b95; border: none; cursor: pointer" onclick="window.location.href = '../ReadTopicAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>'">Forum</button>   
                    </div>
                    <div class="user">                                   
                        <img src="data:image/jpeg;base64,<%= user != null ? user.getPhotoUrl() : ""%>" alt="Profile Picture" style="width: 50px; height: 50px; border-radius: 50%;" />
                    </div>
                </div>

                <div class="details">
                    <div class="recentOrders">
                        <div class="cardHeader">
                            <%
                                List<UserModel> userList = userDAO.getAllUsers();
                                request.setAttribute("userList", userList);  // Set the userList before displaying it in HTML
                            %>
                            <h2 style="color:#6f2b95">Post Uploaded By Member</h2>
                            <h2 style="color:#6f2b95">Total Members: ${fn:length(userList)}</h2>
                        </div>
                        <%
                            String adminId = (String) request.getSession().getAttribute("adminId");
                        %>
                        <div class="styled-table-wrapper">
                            <table class="styled-table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Email</th>
                                        <th>Name</th>
                                        <th>Status</th>
                                        <th>Role User</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if (userList != null && !userList.isEmpty()) {
                                            for (UserModel userItem : userList) {
                                                String statusLabel;
                                                String actionButton;

                                                // Determine the status label and action button based on user status
                                                if ("Active".equals(userItem.getStatus())) {
                                                    statusLabel = "<span class='text-success'>Active</span>";
                                                    actionButton = "<a href=\"../SuspendUser?id=" + userItem.getId() + "&adminId=" + adminId + "\" class=\"btn btn-warning btn-sm\" style=\"margin-left: 5px;\">Suspend</a>";
                                                } else {
                                                    statusLabel = "<span class='text-danger'>Suspended</span>";
                                                    actionButton = "<a href=\"../UnSuspendUser?id=" + userItem.getId() + "&adminId=" + adminId + "\" class=\"btn btn-primary btn-sm\" style=\"margin-left: 5px;\">Unsuspend</a>";
                                                }

                                                // New role management logic
                                                String roleDropdown = "<form action='../UpdateUserRole' method='post' style='display:inline;'>"
                                                        + "<input type='hidden' name='userId' value='" + user.getId() + "'/>"
                                                        + "<input type='hidden' name='adminId' value='" + adminId + "'/>" // Hidden input for adminId
                                                        + "<select name='role' onchange='this.form.submit()'>"
                                                        + "<option value='0'" + ("0".equals(userItem.getRole()) ? " selected" : "") + ">Member</option>"
                                                        + "<option value='1'" + ("1".equals(userItem.getRole()) ? " selected" : "") + ">Admin</option>"
                                                        + "</select></form>";

                                                out.print("<tr>"
                                                        + "<td>" + userItem.getId() + "</td>"
                                                        + "<td>" + userItem.getEmail() + "</td>"
                                                        + "<td>" + userItem.getName() + "</td>"
                                                        + "<td>" + statusLabel + "</td>"
                                                        + "<td>" + ("1".equals(userItem.getRole()) ? "Admin" : "Member") + "</td>"
                                                        + "<td>" + roleDropdown + "</td>"
                                                        + "<td><div class='d-flex style='text-align: center !important;'>"
                                                        + "<a href=\"../RemoveUser?id=" + userItem.getId() + "&adminId=" + adminId + "\" class=\"btn btn-danger btn-sm me-2\">Remove</a>"
                                                        + actionButton
                                                        + "</div></td>"
                                                        + "</tr>");
                                            }
                                        } else {
                                            out.print("<tr><td colspan='7' class='text-center'>No users found.</td></tr>");
                                        }
                                    %>
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
        <script src="js/main.js"></script>
    </body>
    <style>
        th {
            padding: 12px 15px;
            text-align: start;
        }
        td {
            text-align: start !important;
        }
    </style>
</html>
