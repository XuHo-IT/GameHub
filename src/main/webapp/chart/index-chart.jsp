<%@page import="Model.UserModel"%>
<%@page import="DAO.UserDAO"%>
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
                            <img src="./img/logo1.png" alt="" class="logo1" style="width: 25%; height: 25%;">
                            <span class="title">Manage Admin</span>
                        </a>
                    </li>
                    <li></li>
                    <li>
                        <a href="ReadGameUploadByMember?adminId=<%= request.getSession().getAttribute("adminId")%>">
                            <span class="icon">
                                <ion-icon name="people-outline"></ion-icon>
                            </span>
                            <span class="title">Censor Post</span>
                        </a>
                    </li>
                    <li>
                        <a href="ReadGameHomeAdmin?view=chart&adminId=<%= request.getSession().getAttribute("adminId")%>">
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
                            <span class="title">Manage All Users</span>
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Main Content -->
            <div class="main">
                <div class="topbar">
                    <div class="toggle">
                        <ion-icon name="menu-outline"></ion-icon>
                    </div>
                    <!-- Search -->
                    <div style="font-family: "Ubuntu", sans-serif;">
                        <button type="button" class="btn back-btn" style="background: white; color: white; padding: 15px; font-size: 20px; color: #6f2b95; border: none; cursor: pointer" onclick="window.location.href = 'ReadTopicAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>'">Forum</button>   
                        <button type="button" class="btn back-btn" style="background: white; color: white; padding: 15px; font-size: 20px; color: #6f2b95; border: none; cursor: pointer" onclick="window.location.href = 'ReadGameListAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>'">Games</button>
                        <button type="button" class="btn back-btn" style="background: white; color: white; padding: 15px; font-size: 20px; color: #6f2b95; border: none; cursor: pointer" onclick="window.location.href = 'ReadGameHomeAdmin?&adminId=<%= request.getSession().getAttribute("adminId")%>'">Home</button>                    
                    </div>
                    <!-- UserImg -->
                     <%
                                    UserDAO userDAO = new UserDAO();
                                    UserModel user = userDAO.getUserById((String) request.getSession().getAttribute("adminId"));
                                    request.setAttribute("user", user);
                                %>
                                <div class="user">                                   
                                    <img src="data:image/jpeg;base64,<%= user != null ? user.getPhotoUrl() : ""%>" alt="Profile Picture" style="width: 50px; height: 50px; border-radius: 50%;" />
                                </div>

                </div>

                <!-- Card Section -->
                <div class="cardBox">
                    <div class="card" id="totalPost">
                        <div>
                            <div class="numbers1"></div> 
                            <div class="cardName">Total Posts</div>
                        </div>
                        <div class="iconBx">
                            <ion-icon name="eye-outline"></ion-icon>
                        </div>
                    </div>


                    <div class="card" id="salesCard">
                        <div>
                            <div class="numbers">${fn:length(transactionList)}</div>
                            <div class="cardName">Sales</div>
                        </div>
                        <div class="iconBx">
                            <ion-icon name="cart-outline"></ion-icon>
                        </div>
                    </div>

                    <div class="card" id="earningsCard">
                        <div>
                            <div class="numbers" id="totalEarningsDisplay">$0</div>
                            <div class="cardName">Earning</div>
                        </div>
                        <div class="iconBx">
                            <ion-icon name="cash-outline"></ion-icon>
                        </div>
                    </div>
                </div>

                <div class="graphBox">
                    <div class="box">
                        <canvas id="myChart"></canvas>
                    </div>
                    <div class="box">
                        <canvas id="earning"></canvas>
                    </div>
                </div>

                <div class="details">
                    <!-- Order Details List -->
                    <div class="recentOrders">
                        <div class="cardHeader">
                            <h2>Recent Orders</h2>

                        </div>
                        <table>
                            <thead>
                                <tr>
                                    <td>Order Id</td>
                                    <td>Amount</td>
                                    <td>Order Type</td>
                                    <td>Date</td>
                                    <td>User Id</td>         
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="totalEarnings" value="0" />
                                <c:choose>
                                    <c:when test="${not empty transactionList}">
                                        <c:forEach var="transaction" items="${transactionList}">
                                            <tr>
                                                <td>${transaction.orderId}</td>
                                                <td><span class="status delivered">${fn:escapeXml(transaction.amount)}</span></td>
                                                <td>${transaction.orderType}</td>
                                                <td>${transaction.formattedCreateDate}</td>
                                                <td>${transaction.userId}</td>
                                            </tr>                                     
                                            <c:set var="totalEarnings" value="${totalEarnings + transaction.amount}" />
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
                        <!-- Finalize total earnings -->
                        <c:set var="totalEarnings" value="${totalEarnings}" />
                    </div>
                </div>
            </div>
        </div>

        <input type="hidden" id="totalEarningsValue" value="${totalEarnings}" />

        <!-- Format the total earnings with commas -->
        <c:set var="formattedTotalEarnings" value="${fn:replace(fn:substringBefore(fn:escapeXml(totalEarnings), '.'), ',', '')}" />
        <c:set var="formattedTotalEarnings" value="${fn:replace(formattedTotalEarnings, '0', '')}" /> <!-- Remove unnecessary zeros -->

        <!-- Display the formatted total earnings in the div -->
        <script>
            // Get the total earnings value from the hidden input field as a string
            const totalEarnings = document.getElementById("totalEarningsValue").value;
            const formattedEarnings = Number(totalEarnings).toLocaleString(); // Format with commas

            // Update the earnings display with the formatted value
            document.getElementById("totalEarningsDisplay").innerHTML = `VND ${formattedEarnings}`;
        </script>


        <script
            type="module"
            src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"
        ></script>
        <script
            nomodule
            src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"
        ></script>
        <script src="chart/js/chart.min.js"></script>
        <script src="chart/js/main.js"></script>

        <style>

            .numbers1 {
                position: relative;
                font-weight: 500;
                font-size: 2.5em;
                color: #6f2b95;
                transition: color 0.3s ease; /* Smooth color transition */
            }
            /* Hover effect */
            .cardBox .card:hover .numbers1 {
                color: var(--white); /* This will change color to white on hover */
            }
            .details {
                position: relative;
                width: 100%;
                padding: 20px;
                grid-template-columns: 2fr 1fr;
                grid-gap: 30px;
            }
            button.btn.back-btn {
                padding: 30px;
                float: right;
            }
            .details .recentOrders table tr td {
                padding: 12px 15px;
                text-align: start !important;
                /* padding: 10px; */
            }
        </style>
    </body>
</html>
