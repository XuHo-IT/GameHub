<%@page import="Model.UserModel"%>
<%@page import="DAO.UserDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="Model.Topic"%>
<%@page import="com.mongodb.client.model.Filters"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="com.mongodb.client.MongoClients"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="com.mongodb.client.MongoClient"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="org.bson.Document" %>
<!DOCTYPE html>
<html lang="zxx">
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <head>
        <title>EndGam - Gaming Magazine Template</title>
        <meta charset="UTF-8">
        <meta name="description" content="EndGam Gaming Magazine Template">
        <meta name="keywords" content="endGam,gGaming, magazine, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Favicon -->
        <link href="img/favicon.ico" rel="shortcut icon" />

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css?family=Roboto:400,400i,500,500i,700,700i,900,900i" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Sixtyfour+Convergence&display=swap" rel="stylesheet">

        <!-- Stylesheets -->
        <link rel="stylesheet" href="css/bootstrap.min.css" />
        <link rel="stylesheet" href="css/font-awesome.min.css" />
        <link rel="stylesheet" href="css/slicknav.min.css" />
        <link rel="stylesheet" href="css/owl.carousel.min.css" />
        <link rel="stylesheet" href="css/magnific-popup.css" />
        <link rel="stylesheet" href="css/animate.css" />
        <link rel="stylesheet" href="css/searchbar.css" />
        <link rel="stylesheet" href="css/account-icon.css" />

        <!-- Main Stylesheets -->
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet"
              href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@48,400,0,0">
        <link rel="stylesheet" href="Login/style.css">
        <link rel="stylesheet" href="Forum/style.css">
        <script src="Login/script.js" defer></script>

        <!--[if lt IE 9]>
                      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
              <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
            <![endif]-->

    </head>
    <body>
        <!-- Page Preloder -->
        <div id="preloder">
            <div class="loader"></div>
        </div>

        <header class="header-section">
            <div class="header-warp">
                 <div class="row align-items-center">
                    <div class="col-8">
                        <form action="SearchTopicServlet" method="GET">
                            <!-- Search Bar Row -->
                            <div class="row" style="align-items: center;">
                                <!-- Search button on the left side -->
                                <div class="col-2 d-flex align-items-end">
                                    <button type="submit" class="w-100" style="height: 52px;">Search</button>
                                </div>

                                <!-- Keyword input for the search bar -->
                                <div class="col-6" style="padding-top: 15px;">
                                    <input type="text" name="keyword" class="form-control" placeholder="Search by keyword..." aria-label="Search" style="height: 52px;">
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="header-social d-flex justify-content-end">
                        <p>Follow us:</p>
                        <a href="https://www.facebook.com/fptcorp"><i class="fa fa-facebook"></i></a>
                        <a href="https://fpt.com/vi"><i class="fa fa-address-card-o"></i></a>
                        <a href="https://www.linkedin.com/company/fpt-corporation"><i class="fa fa-linkedin-square"></i></a>
                        <a href="https://www.youtube.com/c/FPTCorporation"><i class="fa fa-youtube-play"></i></a>
                    </div>
                </div>
                <div class="header-bar-warp d-flex">
                    <!-- site logo -->
                    <div class="logo-fix">
                        <a href="ReadGameHomeAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>" class="site-logo">
                            <img src="./img/logo1.png" alt="" class="logo1">
                            <img src="./img/logo2.png" alt="" class="logo2">
                        </a>
                    </div>
                    <nav class="top-nav-area w-100">
                        <div class="user-panel d-flex">
                            <div class="account-container">
                               <%
                                    UserDAO userDAO = new UserDAO();
                                    UserModel user = userDAO.getUserById((String) request.getSession().getAttribute("adminId"));
                                    request.setAttribute("user", user);
                                %>
                                <div class="user">                                   
                                    <img src="data:image/jpeg;base64,<%= user != null ? user.getPhotoUrl() : ""%>" alt="Profile Picture" style="width: 50px; height: 50px; border-radius: 50%;" onerror="this.onerror=null;this.src='img/t-rex.png';"  />
                                </div>
                                <div class="account-dropdown">
                                    <ul>
                                        <li><a href="user-profile.jsp?userid=<%= request.getSession().getAttribute("adminId")%>">Account Info</a></li>
                                        <li>
                                            <a href="LogOut" class="dropdown-item">Logout</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- Menu -->
                        <ul class="main-menu primary-menu">
                            <li><a href="ReadGameHomeAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>">Home</a></li>
                            <li><a href="ReadGameListAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>">Games</a></li>
                            <li><a href="ReadTopicAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>">Forum</a></li>
                            <li><a href="ReadGameHomeAdmin?view=chart&adminId=<%= request.getSession().getAttribute("adminId")%>">Manage</a></li>
                        </ul>
                    </nav>
                </div>
            </div>     
        </header>	

        <!-- Header section end -->

        <section class="page-top-section set-bg" data-setbg="img/page-top-bg/4.jpg">
            <div class="page-info">
                <h2>Forum</h2>
                <div class="site-breadcrumb">
                    <a href="ReadGameHomeAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>">Home</a>  /
                    <span>Forum</span>
                </div>
            </div>
        </section>
        <!-- Page top end-->

        <section class="blog-section spad" style="padding-bottom: 0;"> 
            <div class="container" style="
                 margin: 20px;
                 margin-top: -100px;
                 margin-left: auto;
                 margin-right: auto;
                 padding: 20px;
                 max-width: 1500px;
                 background: linear-gradient(to right, #2d1854 0%, #101D3D 100%);">
                <!-- button -->
                <div class="button-top-forum" >
                    <div class="left-button-forum">

                    </div>
                    <div class="right-button-forum">
                        <button class="create-btn">Create New Topic</button>
                    </div>
                </div>

                <div class="subforum">
                    <c:forEach var="topic" items="${topics}">
                        <div class="subforum-row">
                            <div class="subforum-icon subforum-column center">
                                <img src="data:image/jpeg;base64,${topic.photoUrl}" alt="User Photo" style="width: 140px; height: 140px; border-radius: 50%;" />

                            </div>
                            <div class="subforum-description subforum-column">
                                <h4>
                                    <a href="forum-detail-after-login.jsp?topicId=${topic.topicId}&adminId=${sessionScope.adminId}">
                                        <c:choose>
                                            <c:when test="${fn:length(topic.title) >= 64}">
                                                ${fn:substring(topic.title, 0, 64)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${topic.title}
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </h4>
                                <c:choose>
                                    <c:when test="${fn:length(topic.description) >= 360}">
                                        <p style="word-wrap: break-word;">${fn:substring(topic.description, 0, 385)}...</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p style="word-wrap: break-word;">
                                            <c:out value="${topic.description}"/>
                                        </p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="subforum-stats subforum-column center">
                                <span style="font-size: 20px">${topic.commentCount} <img src="./img/icons/chat-icon.png" alt=""></span>
                            </div>

                            <div class="subforum-info subforum-column">
                                <b>Post by</b> <a href="#" style="font-size: 15px">${topic.userName}</a><br>
                                <b>On</b> <a style="font-family: 'Courier', 'Courier New', monospace;">
                                    <fmt:formatDate value="${topic.date}" pattern="hh:mm a dd-MM-yyyy"/>
                                </a>
                                <div style="display: flex; align-items: center; gap: 10px;">
                                    <c:if test="${not empty sessionScope.adminId && not empty topic.userId && sessionScope.adminId == topic.userId}">
                                        <button class="btn-edit"
                                                onclick="openUpdatePopup('${topic.topicId}', '${fn:escapeXml(topic.title)}', '${fn:escapeXml(topic.description)}')">Edit</button>
                                    </c:if>
                                    <form action="TopicDeleteAdmin" method="post">
                                        <input type="hidden" name="topicId" value="${topic.topicId}">
                                        <button type="submit" name="action" value="delete" class="btn-danger" onclick="return confirm('Are you sure you want to delete this topic?');">Delete</button>
                                    </form>
                                </div>   
                            </div>
                        </div>
                        <hr class="subforum-devider">
                    </c:forEach>
                </div>
            </div>
            <div class="site-pagination" style="margin-top: 10px; justify-content: center;">
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <a href="?page=${i}" class="${i == currentPage ? 'active' : ''}">${i < 10 ? '0' + i : i}</a>
                </c:forEach>
            </div>
        </section>

        <!-- Newsletter section -->

        <!-- Newsletter section end -->

        <!-- Footer section -->
        <footer class="footer-section" style="margin-top: 0 ; padding: 10px 125px">
            <div class="container">
                <div class="footer-left-pic">
                    <img class="img_bottom_1" src="./img/bottom_pic_1.png" alt="">
                </div>
                <div class="footer-right-pic">
                    <img class="img_bottom_2" src="./img//bottom_pic_2.png" alt="">
                </div>
                <a href="ReadGameHomeAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>" class="footer-logo">
                    <img src="./img/logo1.png" alt="">
                    <img src="./img/logo2.png" alt="">
                </a>
                <ul class="main-menu footer-menu">
                    <li><a href="ReadGameHomeAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>">Home</a></li>
                    <li><a href="ReadGameListAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>">Games</a></li>
                    <li><a href="ReadTopicAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>">Forum</a></li>                                               
                    <li><a href="ReadGameHomeAdmin?view=chart&adminId=<%= request.getSession().getAttribute("adminId")%>">Manage</a></li>   

                </ul>
                <div class="footer-social d-flex justify-content-center">
                    <a href="https://www.facebook.com/fptcorp"><i class="fa fa-facebook"></i></a>
                    <a href="https://fpt.com/vi"><i class="fa fa-address-card-o"></i></a>
                    <a href="https://www.linkedin.com/company/fpt-corporation"><i class="fa fa-linkedin-square"></i></a>
                    <a href="https://www.youtube.com/c/FPTCorporation"><i class="fa fa-youtube-play"></i></a>
                </div>
                <div class="copyright"><a href="">Colorlib</a> 2018 @ All rights reserved</div>
            </div>
        </footer>
        <!-- Footer section end -->

        <!-- Create Post Popup -->
        <div class="blur-bg-overlay create-overlay"></div>
        <div class="form-popup create-topic-popup">
            <span class="close-btn material-symbols-rounded">close</span>
            <div class="form-box create-topic">
                <div class="form-details">
                    <h2>Create Topic</h2>
                    <p>Please enter topic details below to share with the forum</p>
                </div>
                <div class="form-content">
                    <form action="TopicCreateAdmin" method="post" enctype="multipart/form-data">
                        <div class="input-field">
                            <label>Topic Title</label>
                            <input type="text" name="topicTitle" required>
                        </div>
                        <div class="input-field">
                            <label>Topic Content</label>
                            <textarea name="topicContent" rows="4" required></textarea>
                        </div>
                        <div class="input-field">
                            <label>Upload Image (Optional)</label>
                            <input type="file" name="topicImage" accept="image/*">
                        </div>
                        <button type="submit">Create Topic</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Update Post Popup -->
        <div class="blur-bg-overlay update-overlay"></div>
        <div class="form-popup update-topic-popup" id="updateTopicPopup" style="display:none;">
            <span class="close-btn material-symbols-rounded" onclick="closeUpdatePopup()">close</span>
            <div class="form-box update-topic">
                <div class="form-details">
                    <h2>Update Topic</h2>
                </div>
                <div class="form-content">
                    <form action="TopicUpdateAdmin" method="post" enctype="multipart/form-data">
                        <input type="hidden" id="updateTopicId" name="topicId">
                        <div class="input-field">
                            <label for="updateTopicTitle">Topic Title</label>
                            <input type="text" id="updateTopicTitle" name="topicTitle" required>
                        </div>
                        <div class="input-field">
                            <label for="updateTopicContent">Topic Content</label>
                            <textarea id="updateTopicContent" name="topicContent" rows="4" required></textarea>
                        </div>
                        <div class="input-field">
                            <label for="updateTopicImage">Upload Image</label>
                            <input type="file" id="updateTopicImage" name="topicImage">
                        </div>
                        <button type="submit" name="action" value="update" type="submit">Update Topic</button>
                        <button type="button" onclick="closeUpdatePopup()">Cancel</button>
                    </form>
                </div>
            </div>
        </div>


        <script>

            // Show Create Post Popup
            const showCreatePopupBtn = document.querySelector(".create-btn"); // Button to open create post form
            if (showCreatePopupBtn) {
                showCreatePopupBtn.addEventListener("click", () => {
                    document.querySelector(".create-topic-popup").style.display = "block"; // Show the create popup
                    document.querySelector('.create-overlay').style.display = 'block'; // Show the overlay
                    document.body.classList.add("show-popup"); // Disable scrolling
                });
            }


            function openUpdatePopup(topicId, title, description) {
                const updatePopup = document.getElementById("updateTopicPopup");
                const titleInput = document.getElementById("updateTopicTitle");
                const contentTextarea = document.getElementById("updateTopicContent");
                const topicIdInput = document.getElementById("updateTopicId"); // Get the hidden field

                // Pre-fill the form with topic data
                titleInput.value = title;
                contentTextarea.value = description;
                topicIdInput.value = topicId; // Set the topicId in the hidden field

                // Display the update popup and overlay
                updatePopup.style.display = "block";
                document.querySelector('.update-overlay').style.display = 'block'; // Show the overlay

                // Disable scrolling
                document.body.classList.add("show-popup");
            }


            function closeUpdatePopup() {
                // Hide both popups
                document.getElementById("updateTopicPopup").style.display = "none";
                document.querySelector(".create-topic-popup").style.display = "none";
                document.querySelector('.create-overlay').style.display = 'none'; // Hide the create overlay
                document.querySelector('.update-overlay').style.display = 'none'; // Hide the update overlay

                // Allow scrolling again
                document.body.classList.remove("show-popup");
            }

            // Hide Create Popup when clicking outside
            document.querySelector('.create-overlay').addEventListener('click', function () {
                closeUpdatePopup();
            });

            // Hide Update Popup when clicking outside
            document.querySelector('.update-overlay').addEventListener('click', function () {
                closeUpdatePopup();
            });

            // Close button handler for both forms
            document.querySelectorAll('.close-btn').forEach(btn => {
                btn.addEventListener('click', function () {
                    closeUpdatePopup();
                });
            });
        </script>
        <style>
            img.img_bottom_1,img.img_bottom_2  {
                width: 50%;
            }
            .show-popup {
                overflow: hidden; /* Disable scrolling when popups are visible */
            }
            .blur-bg-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                display: none;
                z-index: 999;
            }
            .create-topic-popup, .update-topic-popup {
                display: none; /* Hidden by default */
                z-index: 1000;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: white;
                padding: 20px;
                box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
                border: 10px solid #501755;
                border-radius: 15px;
            }
            .create-overlay, .update-overlay {
                display: none;
                opacity:1;
            }
            .btn-danger{
                margin: 0;
                margin-top: 5px;
                width: 90px;
                height: 50px;
                font-size: 16px;
                font-weight: bold;
                border-radius: 5px;
            }
            .btn-danger:hover{
                background-color: #4a4646;
            }
            .btn-edit {
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 5px;
                padding: 10px 20px;
                margin-top: 5px;
                width: 90px;
                height: 50px;
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.2s;
            }
            .btn-edit:hover{
                background-color: #4a4646;
            }
        </style>
        <!--====== Javascripts & Jquery ======-->
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.slicknav.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/jquery.sticky-sidebar.min.js"></script>
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/main.js"></script>
        <script src="Forum/main.js"></script>
    </body>   
</html>