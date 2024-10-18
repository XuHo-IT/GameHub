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
        <link rel="stylesheet" href="chart/css/style.css" />
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
                        <a href="ReadGameUploadByMemberController?adminId=<%= request.getSession().getAttribute("adminId")%>">
                            <span class="icon">
                                <ion-icon name="people-outline"></ion-icon>
                            </span>
                            <span class="title">Censor Post</span>
                        </a>
                    </li>
                    <li>
                        <a href="ReadGameHomeAdminController?view=chart&adminId=<%= request.getSession().getAttribute("adminId")%>">
                            <span class="icon">
                                <ion-icon name="chatbubbles-outline"></ion-icon>
                            </span>
                            <span class="title">Statistic</span>
                        </a>
                    </li>
                    <li>
                        <a href="chart/list-user.jsp?adminId=<%= request.getSession().getAttribute("adminId")%>">
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
                            <h2 style="color:#6f2b95">Post Uploaded By Member</h2>
                            <h2 style="color:#6f2b95">Total Post: ${fn:length(postsMember)}</h2>
                        </div>
                        <form action="ConfirmPostController" method="post">
                            <table class="styled-table">
                                <thead>
                                    <tr style="color:white">
                                        <th>Title</th>
                                        <th>Date Release</th>
                                        <th>Author</th>
                                        <th>Genre</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="post" items="${postsMember}">
                                        <tr>
                                            <td>${post.title != null ? post.title : 'No Title'}</td>
                                            <td>${post.dateRelease != null ? post.dateRelease : 'No Date'}</td>
                                            <td>${post.author != null ? post.author : 'Unknown Author'}</td>
                                            <td>${post.genre != null ? post.genre : 'Unknown Genre'}</td>
                                            <td>
                                                <!-- Pass the post ID as a hidden field -->
                                                <input type="hidden" name="postId" value="${post.postID}">

                                                <!-- Confirm and Deny buttons -->
                                                <button type="submit" class="btn confirm-btn">Confirm</button>
                                                <button type="button" class="btn deny-btn" onclick="denyPost(this)">Deny</button>

                                                <!-- Re-Deny button (hidden initially) -->
                                                <button type="button" class="btn redeny-btn" style="display:none;background: yellow;color: black" onclick="reDenyPost(this)">Re-Deny</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </form>

                    </div>

                </div>
                <button type="button" class="btn back-btn" style="background: #6f2b95; color: white" onclick="window.location.href = 'ReadGameHomeAdminController?&adminId=<%= request.getSession().getAttribute("adminId")%>'">Back To Home Page</button>
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
        <script src="chart/js/chart.min.js"></script>
        <script src="chart/js/main.js"></script>
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

            }
            .styled-table th, .styled-table td {
                padding: 12px 15px;
            }
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
                /* margin-top: 10px; */
            }
            button.btn.back-btn {
                /* margin-left: 500px; */
                /* text-align: right; */
                padding: 30px;
                float: right;
            }
        </style>
    </body>
</html>
