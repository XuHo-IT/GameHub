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
                            <span class="icon"><ion-icon name="logo-apple"></ion-icon></span>
                            <span class="title">Manage Admin</span>
                        </a>
                    </li>
                    <li>
                        <a href="../ReadGameUploadByMemberController?adminId=<%= request.getSession().getAttribute("adminId")%>">
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
                        <a href="chart/list-user.jsp?adminId=<%= request.getSession().getAttribute("adminId")%>">
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
                    <div class="user">
                        <%= request.getSession().getAttribute("adminId")%>
                        <img src="../<%= request.getSession().getAttribute("photoUrl")%>" alt="User Profile" />
                    </div>
                </div>

                <div class="details">
                    <div class="recentOrders">
                        <div class="cardHeader">
                            <%
                                UserDAO userDAO = new UserDAO();
                                List<UserModel> userList = userDAO.getAllUsers();
                                request.setAttribute("userList", userList);  // Set the userList before displaying it in HTML
                            %>
                            <h2 style="color:#6f2b95">Post Uploaded By Member</h2>
                            <h2 style="color:#6f2b95">Total Members: ${fn:length(userList)}</h2>
                        </div>
                        <div class="styled-table-wrapper">
                            <table class="styled-table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Email</th>
                                        <th>Name</th>
                                        <th>Status</th>
                                        <th>Role User</th>
                                        <th> Edit Role</th> <!-- New Role Column -->
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if (userList != null && !userList.isEmpty()) {
                                            for (UserModel user : userList) {
                                                String statusLabel;
                                                String actionButton;

                                                // Determine the status label and action button based on user status
                                                if ("Active".equals(user.getStatus())) {
                                                    statusLabel = "<span class='text-success'>Active</span>";
                                                    actionButton = "<a href=\"../SuspendUser?id=" + user.getId() + "\" class=\"btn btn-warning btn-sm\">Suspend</a>";
                                                } else {
                                                    statusLabel = "<span class='text-danger'>Suspended</span>";
                                                    actionButton = "<a href=\"../UnSuspendUser?id=" + user.getId() + "\" class=\"btn btn-primary btn-sm\">Unsuspend</a>";
                                                }

                                                // New role management logic
                                                String roleDropdown = "<form action='../UpdateUserRole' method='post' style='display:inline;'>"
                                                        + "<input type='hidden' name='userId' value='" + user.getId() + "'/>"
                                                        + "<select name='role' onchange='this.form.submit()'>"
                                                        + "<option value='0'" + ("0".equals(user.getRole()) ? " selected" : "") + ">Member</option>"
                                                        + "<option value='1'" + ("1".equals(user.getRole()) ? " selected" : "") + ">Admin</option>"
                                                        + "</select></form>";

                                                out.print("<tr>"
                                                        + "<td>" + user.getId() + "</td>"
                                                        + "<td>" + user.getEmail() + "</td>"
                                                        + "<td>" + user.getName() + "</td>"
                                                        + "<td>" + statusLabel + "</td>"
                                                        + "<td>" + user.getRole() + "</td>"
                                                        + "<td>" + roleDropdown + "</td>" // Display dropdown instead of user.getRole()
                                                        + "<td><div class='d-flex'>"
                                                        + "<a href=\"../RemoveUser?id=" + user.getId() + "\" class=\"btn btn-danger btn-sm me-2\">Remove</a>"
                                                        + actionButton
                                                        + "</div></td>"
                                                        + "</tr>");
                                            }
                                        } else {
                                            out.print("<tr><td colspan='6' class='text-center'>No users found.</td></tr>");
                                        }
                                    %>
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>
                <button type="button" class="btn back-btn" style="background: #6f2b95; color: white" onclick="window.location.href = '../ReadGameHomeAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>'">Back To Home Page</button>
            </div>
        </div>
        <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>
