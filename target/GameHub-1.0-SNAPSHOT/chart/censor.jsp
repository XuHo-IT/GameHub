<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
            <div class="navigation">
                <ul>
                    <li>
                        <a href="">
                            <span class="icon"><ion-icon name="logo-apple"></ion-icon></span>
                            <span class="title">Manage Amin</span>
                        </a>
                    </li>
                    <li>
                    </li>
                    <li>
                        <a href="censor.jsp">
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
                        <a href="">
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
                    <div class="search">
                        <label>
                            <input type="text" placeholder="Search here" />
                            <ion-icon name="search-outline"></ion-icon>
                        </label>
                    </div>
                    <!-- UserImg -->
                    <div class="user">
                        <img src="imgs/user.jpg" alt="" />
                    </div>
                </div>


                <div class="details" >
                    <!-- order details list -->
                    <div class="recentOrders">
                        <div class="cardHeader">
                            <h2>Post Uploaded by user</h2>
                            <a href="#" class="btn">View All</a>
                        </div>
                        <table>
                            <thead>
                                <tr>
                                    <td>Title</td>
                                    <td>Date Release</td>
                                    <td>Author</td>
                                    <td>Genre</td>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="post" items="${postsMember}">
                                    <tr>
                                        <td>${post.title != null ? post.title : 'No Title'}</td>
                                        <td>${post.dateRelease != null ? post.dateRelease : 'No Date'}</td>
                                        <td>${post.author != null ? post.author : 'Unknown Author'}</td>
                                        <td>${post.genre != null ? post.genre : 'Unknown Genre'}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>


                    </div>

                </div>
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
        <style>
            .details {
                position: relative;
                width: 100%;
                padding: 20px;
                /* margin-top: 10px; */
            }
        </style>
    </body>
</html>
