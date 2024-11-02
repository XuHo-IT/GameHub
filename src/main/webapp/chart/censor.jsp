<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="utils.MongoDBConnectionManager"%>
<%@page import="com.mongodb.client.MongoClient"%>
<%@page import="Model.GamePostMember"%>
<%@page import="Model.UserModel"%>
<%@page import="DAO.UserDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="org.bson.Document" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                        <button type="button" class="btn back-btn" style="background: white; color: white; padding: 15px; font-size: 20px; color: #6f2b95;" onclick="window.location.href = 'ReadGameHomeAdmin?&adminId=<%= request.getSession().getAttribute("adminId")%>'">Home</button>                    
                        <button type="button" class="btn back-btn" style="background: white; color: white; padding: 15px; font-size: 20px; color: #6f2b95;" onclick="window.location.href = 'ReadGameListAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>'">Games</button>
                        <button type="button" class="btn back-btn" style="background: white; color: white; padding: 15px; font-size: 20px; color: #6f2b95;" onclick="window.location.href = 'ReadTopicAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>'">Forum</button>   
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
                                        <th>Game Play</th>
                                        <th>Description</th>
                                        <th>Game Image</th>
                                        <th>Action Images</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="post" items="${postsMember}">
                                        <tr>
                                            <td style="padding: 12px 15px;text-align: start;">${post.title != null ? post.title : 'No Title'}</td>
                                            <td style="padding: 12px 15px;text-align: start;">${post.dateRelease != null ? post.dateRelease : 'No Date'}</td>
                                            <td style="padding: 12px 15px;text-align: start;">${post.author != null ? post.author : 'Unknown Author'}</td>
                                            <td style="padding: 12px 15px;text-align: start;">${post.genre != null ? post.genre : 'Unknown Genre'}</td>
                                            <td style="padding: 12px 15px;text-align: start;">${post.gamePlay != null ? post.gamePlay : 'Unknown Genre'}</td> 
                                            <td style="padding: 12px 15px;text-align: start;">${post.description!= null ? post.description : 'Unknown Genre'}</td> 
                                            <td style="padding: 12px 15px;text-align: start;cursor: pointer;text-decoration: underline;" 
                                                onclick="openImageModal('data:image/png;base64,${post.fileData}')" class="view-link">View Image</td>
                                            <td style="padding: 12px 15px;text-align: start;cursor: pointer;text-decoration: underline;" 
                                                onclick="openActionImagesModal('data:image/png;base64,${post.actionImages}')" class="view-link">View Action Images</td>
                                            <td style="padding: 12px 15px;text-align: start;">
                                                <!-- Confirm and Deny buttons -->
                                                <input type="hidden" name="actionType" id="actionType" value="">
                                                <input type="hidden" name="adminId" value="<%= request.getSession().getAttribute("adminId")%>">
                                                <input type="hidden" name="postId" value="${post.postID}">
                                                <button type="submit" class="btn confirm-btn" onclick="setActionType('confirm')">Confirm</button>
                                                <button type="button" class="btn deny-btn" onclick="denyPost(this)">Deny</button>
                                                <button type="button" class="btn redeny-btn" style="display:none;background: yellow;color: black;" onclick="reDenyPost(this)">Re-Deny</button>
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

        <!-- Main Image Modal -->
        <div class="modal_1 fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header" style="display: flex; justify-content: space-between;">
                        <h5 class="modal-title" id="imageModalLabel" style="font-size: 25px">Game Image</h5>
                        <button type="button" class="btn-close"  onclick=" closeImageModal()" aria-label="Close">X</button>
                    </div>
                    <div class="modal-body" id="gameImagesContainer">
                        <img id="modalImage" src="" alt="Game Image" class="img-fluid">
                    </div>
                </div>
            </div>
        </div>

        <!-- Action Images Modal -->
        <div class="modal fade" id="actionImagesModal" tabindex="-1" aria-labelledby="actionImagesModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header" style="display: flex; justify-content: space-between;">
                        <h5 class="modal-title" id="actionImagesModalLabel" style="font-size: 25px">Game Image Actions</h5>
                        <button type="button" class="btn-close" onclick="closeActionModal()" aria-label="Close">X</button>
                    </div>
                    <div class="modal-body" id="actionImagesContainer">
                        <!-- Action images will be loaded here -->
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
        <script>
                            function openImageModal(imageData) {
                                document.getElementById('modalImage').src = imageData;
                                const imageModalElement = document.querySelector('.modal_1');
                                imageModalElement.style.display = 'block';
                            }
                            function closeImageModal() {
                                const imageModalElement = document.querySelector('.modal_1');
                                imageModalElement.style.display = 'none';
                            }

                            function openActionImagesModal(actionImagesBase64) {

                                const actionImagesContainer = document.getElementById('actionImagesContainer');
                                actionImagesContainer.innerHTML = '';

                                // Remove any brackets and split by commas
                                const cleanedActionImagesBase64 = actionImagesBase64.replace(/\[|\]/g, ''); // Remove brackets
                                const actionImagesArray = cleanedActionImagesBase64.split(',')
                                        .map(image => image.trim()) // Trim spaces around each entry
                                        .filter(image => image); // Filter out empty strings

                                actionImagesArray.forEach(imageData => {
                                    const img = document.createElement('img');

                                    // Only prepend the prefix if it doesn't already exist
                                    img.src = imageData.startsWith('data:image/png;base64,') ? imageData : `data:image/png;base64,` + imageData;
                                    if (img.src === 'data:image/png;base64,data:image/png;base64') {
                                        img.style.display = 'none'; // Hide the image
                                    }
                                    img.alt = 'Action Image';
                                    img.className = 'img-fluid';
                                    img.style.marginBottom = '10px';
                                    actionImagesContainer.appendChild(img);
                                    console.log(actionImagesArray);

                                });

                                const actionImagesModal = document.querySelector('.modal');
                                actionImagesModal.style.display = 'block';
                            }

                            function closeActionModal() {
                                const imageModalElement = document.querySelector('.modal');
                                imageModalElement.style.display = 'none';
                            }



                            function setActionType(type) {
                                document.getElementById("actionType").value = type;
                            }

                            function denyPost(denyButton) {
                                const row = denyButton.closest('tr');
                                const confirmBtn = row.querySelector('.confirm-btn');
                                const reDenyBtn = row.querySelector('.redeny-btn');

                                confirmBtn.style.display = 'none';
                                denyButton.style.display = 'none';
                                reDenyBtn.style.display = 'inline-block';
                                row.style.color = 'gray';

                            }

                            function reDenyPost(reDenyButton) {
                                const row = reDenyButton.closest('tr');
                                const confirmBtn = row.querySelector('.confirm-btn');
                                const denyBtn = row.querySelector('.deny-btn');

                                confirmBtn.style.display = 'inline-block';
                                denyBtn.style.display = 'inline-block';
                                reDenyButton.style.display = 'none';
                                row.style.color = '#6f2b95';

                            }
        </script>
        <style>
            .modal_1 {
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
                border: 5px solid #501755;
                width: 50%; /* Modal width */
                text-align: center;
                height: 50%;
                border-radius: 15px;
            }

            #gameImagesContainer{
                max-height: 700px;
                overflow-y: auto;
                margin-top: 5px;
            }

            #actionImagesContainer {
                max-height: 700px;
                overflow-y: auto;
                margin-top: 5px;
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
                width: 80px;
            }
            .deny-btn {
                background-color: #f44336; /* Red */
                color: white;
                width: 80px;
            }
            button.btn-close {
                width: 25px;
                height: 25px;
                justify-content: space-evenly;
                align-items: center;
                cursor: pointer;
                border-radius: 50%;
                font-weight: bold;
            }
            button.btn-close:hover{
                background: red;
                color: white;
            }
            .details {
                position: relative;
                width: 100%;
                padding: 20px;
                /* margin-top: 10px; 
            }
            button.btn.back-btn {
                /* margin-left: 500px; */
                /* text-align: right; */
                padding: 30px;
                float: right;
            }
            img.img-fluid {
                width: 100%;
                height: 100%;
                margin-top: 10px;
            }
        </style>
    </body>
</html>
