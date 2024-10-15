<%@page import="mogodb.MongoConectUser"%>
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
                            <span class="title" >Manage Amin</span>
                        </a>
                    </li>
                    <li>
                    </li>
                    <li>
                        <a href="../ReadGameUploadByMemberController">
                            <span class="icon">
                                <ion-icon name="people-outline"></ion-icon>
                            </span>
                            <span class="title">Censor Post</span>
                        </a>
                    </li>
                    <li>
                        <a href="index-chart.jsp">
                            <span class="icon">
                                <ion-icon name="chatbubbles-outline"></ion-icon>
                            </span>
                            <span class="title">Statistic</span>
                        </a>
                    </li>
                    <li>
                        <a href="chart/list-user.jsp">
                            <span class="icon">
                                <ion-icon name="help-outline"></ion-icon>
                            </span>
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
                    <!-- Search -->
                    <!-- UserImg -->
                    <div class="user">
                        <img src="imgs/user.jpg" alt="" />
                    </div>
                </div>


                <div class="details">
                    <!-- order details list -->
                    <div class="recentOrders">
                        <div class="cardHeader">
                            <%
                                MongoConectUser mgcn = new MongoConectUser();
                                List<UserModel> userList = mgcn.getAllUsers();
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
                                                    statusLabel = "<span class='text-success'>Active</span>"; // Green for active
                                                    actionButton = "<a href=\"../SuspendUserController?id=" + user.getId() + "\" class=\"btn btn-warning btn-sm\">Suspend</a>";
                                                } else {
                                                    statusLabel = "<span class='text-danger'>Suspended</span>"; // Red for suspended
                                                    actionButton = "<a href=\"../UnSuspendUserController?id=" + user.getId() + "\" class=\"btn btn-primary btn-sm\">Unsuspend</a>";
                                                }

                                                out.print("<tr>"
                                                        + "<td>" + user.getId() + "</td>"
                                                        + "<td>" + user.getEmail() + "</td>"
                                                        + "<td>" + user.getName() + "</td>"
                                                        + "<td>" + statusLabel + "</td>"
                                                        + // New cell for status label
                                                        "<td>"
                                                        + "<div class='d-flex'>"
                                                        + // Use flexbox to align buttons horizontally
                                                        "<a href=\"../RemoveUserServlet?id=" + user.getId() + "\" class=\"btn btn-danger btn-sm me-2\">Remove</a>"
                                                        + actionButton
                                                        + // Add the action button here
                                                        "</div>"
                                                        + "</td>"
                                                        + "</tr>");
                                            }
                                        } else {
                                            out.print("<tr><td colspan='8' class='text-center'>No users found.</td></tr>");
                                        }
                                    %>
                                </tbody>
                            </table> 
                        </div>
                    </div>

                </div>
                <button type="button" class="btn back-btn" style="background: #6f2b95; color: white" onclick="window.location.href = '../ReadGameHomeAdminController'">Back To Home Page</button>
            </div>
        </div>
        <script
            type="module"
            src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"
        ></script>
        <script
            nomodule
            src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"
        ></script>
        <!-- <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script> -->
        <!-- <script src="js/chart.umd.js"></script> -->
        <script src="js/chart.min.js"></script>
        <script src="js/main.js"></script>
        <script>
                    // Function to handle deny button click
                    function denyPost(denyButton) {
                        // Hide the confirm and deny buttons
                        const row = denyButton.closest('tr');
                        const confirmBtn = row.querySelector('.confirm-btn');
                        const reDenyBtn = row.querySelector('.redeny-btn');

                        confirmBtn.style.display = 'none';
                        denyButton.style.display = 'none';

                        // Show the re-deny button
                        reDenyBtn.style.display = 'inline-block';

                        // Change text color of the entire row to gray
                        row.style.color = 'gray';
                    }


                    // Function to handle re-deny button click
                    function reDenyPost(reDenyButton) {
                        // Show the confirm and deny buttons again
                        const row = reDenyButton.closest('tr');
                        const confirmBtn = row.querySelector('.confirm-btn');
                        const denyBtn = row.querySelector('.deny-btn');

                        confirmBtn.style.display = 'inline-block';
                        denyBtn.style.display = 'inline-block';

                        // Hide the re-deny button
                        reDenyButton.style.display = 'none';
                        row.style.color = 'black';

                    }
        </script>
        <style>
            .styled-table {
                width: 100%;
                border-collapse: collapse;
                margin: 25px 0;
                font-size: 18px;
                text-align: left;
                table-layout: auto; /* Allow cells to expand based on content */
                overflow-x: auto; /* Enable horizontal scrolling if necessary */
            }

            .styled-table th, .styled-table td {
                padding: 12px 15px;
                white-space: nowrap; /* Prevent word wrapping to ensure long content stays in one line */
                min-width: 150px; /* Set a minimum width for better visibility */
            }

            /* Retain existing styling */
            .styled-table thead tr {
                background-color: #6f2b95;
                color: white;
                text-align: left;
            }

            .styled-table tbody tr {
                border-bottom: 1px solid #dddddd;
            }

            .styled-table tbody tr:nth-of-type(even) {
                background-color: #f3f3f3;
            }

            .styled-table tbody tr:last-of-type {
                border-bottom: 2px solid #009879;
            }

            .btn {
                padding: 8px 12px;
                margin: 5px;
                cursor: pointer;
                border: none;
                border-radius: 5px;
                font-size: 14px;
            }

            .confirm-btn {
                background-color: #4CAF50; /* Green */
                color: white;
            }

            .deny-btn {
                background-color: #f44336; /* Red */
                color: white;
            }

            .details {
                position: relative;
                width: 100%;
                padding: 20px;
            }

            button.btn.back-btn {
                padding: 3  0px;
                float: right;
            }
            th {
                color: white;
            }

        </style>
    </body>
</html>
