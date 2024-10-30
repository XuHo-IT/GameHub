<%@page import="Model.UserModel"%>
<%@page import="DAO.UserDAO"%>
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
                            <img src="./img/logo1.png" alt="" class="logo1" style="width: 25%; height: 25%;">
                            <span class="title" >Manage Admin</span>
                        </a>
                    </li>
                    <li>
                    </li>
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
                    <%
                        UserDAO userDAO = new UserDAO();
                        UserModel user = userDAO.getUserById((String) request.getSession().getAttribute("adminId"));
                        request.setAttribute("user", user);
                    %>
                    <div style="font-family: "Ubuntu", sans-serif;">
                        <button type="button" class="btn back-btn" style="background: white; color: white; padding: 15px; font-size: 20px; color: #6f2b95;" onclick="window.location.href = 'ReadTopicAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>'">Forum</button>   
                        <button type="button" class="btn back-btn" style="background: white; color: white; padding: 15px; font-size: 20px; color: #6f2b95;" onclick="window.location.href = 'ReadGameListAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>'">Games</button>
                        <button type="button" class="btn back-btn" style="background: white; color: white; padding: 15px; font-size: 20px; color: #6f2b95;" onclick="window.location.href = 'ReadGameHomeAdmin?&adminId=<%= request.getSession().getAttribute("adminId")%>'">Home</button>                    
                    </div>
                    <div class="user">                                   
                        <img src="data:image/jpeg;base64,<%= user != null ? user.getPhotoUrl() : ""%>" alt="Profile Picture" style="width: 50px; height: 50px; border-radius: 50%;" />
                    </div>
                </div>


                <div class="details">
                    <!-- order details list -->
                    <div class="recentOrders">
                        <div class="cardHeader">
                            <h2 style="color:#6f2b95">Post Uploaded By Member</h2>
                            <h2 style="color:#6f2b95">Total Post: ${fn:length(postsMember)}</h2>
                        </div>
                        <form action="ConfirmPost" method="post">
                            <table class="styled-table">
                                <thead>
                                    <tr style="color:white;">
                                        <th>Title</th>
                                        <th>Date Release</th>
                                        <th>Author</th>
                                        <th>Genre</th>
                                        <th>View</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="post" items="${postsMember}">
                                        <tr>
                                            <td style="padding: 12px 15px;text-align: start;">${post.title != null ? post.title : 'No Title'}</td>
                                            <td style="padding: 12px 15px;text-align: start;">${post.dateRelease != null ? post.dateRelease : 'No Date'}</td>
                                            <td style="padding: 12px 15px;text-align: start;">${post.author != null ? post.author : 'Unknown Author'}</td>
                                            <td style="padding: 12px 15px;text-align: start;">${post.genre != null ? post.genre : 'Unknown Genre'}</td>
                                            <td style="padding: 12px 15px;text-align: start;">${post.genre != null ? post.genre : 'Unknown Genre'}</td>

                                            <td>
                                                <!-- Button to view details -->
                                                <button type="button" class="btn details-btn" onclick="openDetailsModal('${post.title}', '${post.dateRelease}', '${post.author}', '${post.genre}', '${post.description}', '${post.postID}')">Details</button>
                                            </td>
                                            <td>
                                                <!-- Confirm and Deny buttons -->
                                                <input type="hidden" name="postId" value="${post.postID}">
                                                <button type="submit" class="btn confirm-btn">Confirm</button>
                                                <button type="button" class="btn deny-btn" onclick="setActionType('deny')">Deny</button>
                                                <button type="button" class="btn redeny-btn" style="display:none;background: yellow;color: black" onclick="setActionType('re-deny')">Re-Deny</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                        </form>

                    </div>

                </div>
            </div>
        </div>
        <!-- Modal for showing post details -->
        <div id="postDetailsModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <h2>Post Details</h2>
                <p><strong>Title:</strong> <span id="modalTitle"></span></p>
                <p><strong>Date Release:</strong> <span id="modalDateRelease"></span></p>
                <p><strong>Author:</strong> <span id="modalAuthor"></span></p>
                <p><strong>Genre:</strong> <span id="modalGenre"></span></p>
                <p><strong>Description:</strong> <span id="modalDescription"></span></p>

                <!-- Hidden form to confirm or deny within modal -->
                <form action="ConfirmPostController" method="post">
                    <input type="hidden" name="postId" id="modalPostId">
                    <button type="submit" class="btn confirm-btn">Confirm</button>
                    <button type="button" class="btn deny-btn" onclick="denyPostInModal()">Deny</button>
                </form>
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
                        // Function to open the modal and display post details
                        function openDetailsModal(title, dateRelease, author, genre, description, postId) {
                            document.getElementById('modalTitle').innerText = title;
                            document.getElementById('modalDateRelease').innerText = dateRelease;
                            document.getElementById('modalAuthor').innerText = author;
                            document.getElementById('modalGenre').innerText = genre;
                            document.getElementById('modalDescription').innerText = description;
                            document.getElementById('modalPostId').value = postId;

                            // Show the modal
                            document.getElementById('postDetailsModal').style.display = 'block';
                        }

// Function to close the modal
                        function closeModal() {
                            document.getElementById('postDetailsModal').style.display = 'none';
                        }

// Handle deny button in the modal
                        function denyPostInModal() {
                            // Change button states or add additional functionality here if needed
                            alert('Post denied!');
                            closeModal();  // Close the modal after denying
                        }

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
                            row.style.color = '#6f2b95';

                        }
                        function setActionType(type) {
                            document.getElementById("actionType").value = type;
                            document.querySelector("form").submit(); // Submit form with selected action
                        }
        </script>
        <style>
            /* Modal styling */
            .modal {
                display: none; /* Hidden by default */
                position: fixed; /* Stay in place */
                z-index: 1; /* Sit on top */
                padding-top: 100px; /* Location of the box */
                left: 0;
                top: 0;
                width: 100%; /* Full width */
                height: 100%; /* Full height */
                background-color: rgba(0,0,0,0.4); /* Black background with opacity */
            }

            .modal-content {
                background-color: #fefefe;
                margin: auto;
                padding: 20px;
                border: 1px solid #888;
                width: 50%; /* Modal width */
                text-align: left;
            }

            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }

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
