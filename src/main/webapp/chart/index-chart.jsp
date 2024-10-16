<%@page import="Model.Transaction"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                        <a href="list-user.jsp">
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
                <!-- Card -->
                <div class="cardBox">
                    <div class="card">
                        <div>
                            <div class="numbers">1,504</div>
                            <div class="cardName">Daily Views</div>
                        </div>
                        <div class="iconBx">
                            <ion-icon name="eye-outline"></ion-icon>
                        </div>
                    </div>
                    <div class="card">
                        <div>
                            <div class="numbers">80</div>
                            <div class="cardName">Sales</div>
                        </div>
                        <div class="iconBx">
                            <ion-icon name="cart-outline"></ion-icon>
                        </div>
                    </div>
                    <div class="card">
                        <div>
                            <div class="numbers">284</div>
                            <div class="cardName">Comments</div>
                        </div>
                        <div class="iconBx">
                            <ion-icon name="chatbubbles-outline"></ion-icon>
                        </div>
                    </div>
                    <div class="card">
                        <div>
                            <div class="numbers">$7,842</div>
                            <div class="cardName">Earning</div>
                        </div>
                        <div class="iconBx">
                            <ion-icon name="cash-outline"></ion-icon>
                        </div>
                    </div>
                </div>
                <!-- Add Charts -->
                <div class="graphBox">
                    <div class="box">
                        <canvas id="myChart"></canvas>
                    </div>
                    <div class="box">
                        <canvas id="earning"></canvas>
                    </div>
                </div>
                <div class="details">
                    <!-- order details list -->
                    <div class="recentOrders">
                        <div class="cardHeader">
                            <h2>Recent Orders</h2>
                            <a href="#" class="btn">View All</a>
                        </div>
                        <table>
                            <thead>
                                <tr>
                                    <td>Order Id</td>
                                    <td>Amount</td>
                                    <td>Order Type</td>
                                    <td>Date</td>
                                </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${not empty transactionList}">
                                    <c:forEach var="transaction" items="${transactionList}">
                                        <tr>
                                            <td>${transaction.orderId}</td>
                                            <td><span class="status delivered">${fn:escapeXml(transaction.amount)}</span></td>
                                            <td>${transaction.orderType}</td>
                                            <td>${transaction.formattedCreateDate}</td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="4">No transactions found.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>
                    <!-- New Customers -->
                    <div class="recentCustomers">
                        <div class="cardHeader">
                            <h2>Recent Customers</h2>
                        </div>
                        <table>
                            <tr>
                                <td width="60px">
                                    <div class="imgBx"><img src="imgs/img1.jpg" alt="" /></div>
                                </td>
                                <td>
                                    <h4>David<br /><span>Italy</span></h4>
                                </td>
                            </tr>
                            <tr>
                                <td width="60px">
                                    <div class="imgBx"><img src="imgs/img2.jpg" alt="" /></div>
                                </td>
                                <td>
                                    <h4>Muhammad<br /><span>India</span></h4>
                                </td>
                            </tr>
                            <tr>
                                <td width="60px">
                                    <div class="imgBx"><img src="imgs/img3.jpg" alt="" /></div>
                                </td>
                                <td>
                                    <h4>Amelia<br /><span>France</span></h4>
                                </td>
                            </tr>
                            <tr>
                                <td width="60px">
                                    <div class="imgBx"><img src="imgs/img4.jpg" alt="" /></div>
                                </td>
                                <td>
                                    <h4>Olivia<br /><span>USA</span></h4>
                                </td>
                            </tr>
                            <tr>
                                <td width="60px">
                                    <div class="imgBx"><img src="imgs/img5.jpg" alt="" /></div>
                                </td>
                                <td>
                                    <h4>Amit<br /><span>Japan</span></h4>
                                </td>
                            </tr>
                            <tr>
                                <td width="60px">
                                    <div class="imgBx"><img src="imgs/img6.jpg" alt="" /></div>
                                </td>
                                <td>
                                    <h4>Ashraf<br /><span>India</span></h4>
                                </td>
                            </tr>
                            <tr>
                                <td width="60px">
                                    <div class="imgBx"><img src="imgs/img7.jpg" alt="" /></div>
                                </td>
                                <td>
                                    <h4>Diana<br /><span>Malaysia</span></h4>
                                </td>
                            </tr>
                            <tr>
                                <td width="60px">
                                    <div class="imgBx"><img src="imgs/img8.jpg" alt="" /></div>
                                </td>
                                <td>
                                    <h4>Amit<br /><span>India</span></h4>
                                </td>
                            </tr>
                            <tr>
                                <td width="60px">
                                    <div class="imgBx"><img src="imgs/img9.jpg" alt="" /></div>
                                </td>
                                <td>
                                    <h4>Amelia<br /><span>China</span></h4>
                                </td>
                            </tr>
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
        <script src="chart/js/chart.min.js"></script>
        <script src="chart/js/main.js"></script>
        <style>
            .details {
                position: relative;
                width: 100%;
                padding: 20px;
                display: grid;
                grid-template-columns: 2fr 1fr;
                grid-gap: 30px;
                /* margin-top: 10px; */
            }
        </style>
    </body>
</html>
