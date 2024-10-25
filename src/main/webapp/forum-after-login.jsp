<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="utils.MongoDBConnectionManager1"%>
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
                <div class="header-social d-flex justify-content-end">
                    <p>Follow us:</p>
                    <a href="https://www.facebook.com/fptcorp"><i class="fa fa-facebook"></i></a>
                    <a href="https://fpt.com/vi"><i class="fa fa-address-card-o"></i></a>
                    <a href="https://www.linkedin.com/company/fpt-corporation"><i class="fa fa-linkedin-square"></i></a>
                    <a href="https://www.youtube.com/c/FPTCorporation"><i class="fa fa-youtube-play"></i></a>
                </div>
                <div class="header-bar-warp d-flex">
                    <!-- site logo -->
                    <div class="logo-fix">
                        <a href="ReadGameHomeController" class="site-logo">
                            <img src="./img/logo1.png" alt="" class="logo1">
                            <img src="./img/logo2.png" alt="" class="logo2">
                        </a>
                    </div>
                    <nav class="top-nav-area w-100">
                        <div class="user-panel d-flex">
                            <div class="account-container">
                                 <div class="user">
                                    <%= request.getSession().getAttribute("adminId")%>
                                    <img src="<%= request.getSession().getAttribute("photoUrl")%>" alt="User Profile" />
                                </div>
                                <div class="account-dropdown">
                                    <ul>
                                        <li><a href="user-profile.jsp?id=<%= request.getSession().getAttribute("adminId")%>">Account Info</a></li>
                                        <li>
                                            <a href="LogOutController" class="dropdown-item">Logout</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- Menu -->
                        <ul class="main-menu primary-menu">
                            <li><a href="ReadGameHomeAdminController?adminId=<%= request.getSession().getAttribute("adminId")%>">Home</a></li>
                            <li><a href="ReadGameListAdminController?adminId=<%= request.getSession().getAttribute("adminId")%>">Games</a></li>
                            <li><a href="ReadGameHomeAdmin?view=chart&adminId=<%= request.getSession().getAttribute("adminId")%>">Manage</a></li>
                            <li><a href="ReadTopicAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>">Forum</a></li>                                       
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
                    <a href="ReadGameHomeAdminController?adminId=<%= request.getSession().getAttribute("adminId")%>">Home</a>  /
                    <span>Forum</span>
                </div>
            </div>
        </section>
        <!-- Page top end-->

        <section class="blog-section spad"> 
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
                        <button class="forum-button" >All Topics</button>
                        <button class="forum-button">My Topics</button>
                    </div>
                    <div class="right-button-forum">
                        <button class="create-btn">Create New Topic</button>
                    </div>
                </div>

                <div class="subforum">
                    <c:forEach var="topic" items="${topics}">
                        <div class="subforum-row">
                            <div class="subforum-icon subforum-column center">
                                <img src="${topic.photoUrl}" alt="User Photo">
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
                                    <fmt:formatDate value="${topic.date}" pattern="MM:hh a dd-MM-yyyy"/>
                                </a>
                                <div style="display: flex; align-items: center; gap: 10px;">
                                    <c:if test="${not empty sessionScope.adminId && not empty topic.userId && sessionScope.adminId == topic.userId}">
                                        <button class="btn-edit"
                                                onclick="openUpdatePopup('${topic.topicId}', '${fn:escapeXml(topic.title)}', '${fn:escapeXml(topic.description)}')">Edit</button>
                                    </c:if>
                                    <form action="TopicDeleteAdmin" method="post">
                                        <input type="hidden" name="topicId" value="${topic.topicId}">
                                        <button type="submit" name="action" value="delete" class="btn-danger">Delete</button>
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
        <section class="newsletter-section" style="">
            <div class="container">
                <h3 class="bottom-title">Thanks for using our website!</h3>
                <img src="img/Dawn.gif" alt="Game Image" style="width: 100%; height: auto;" />
            </div>
        </section>
        <!-- Newsletter section end -->

        <!-- Footer section -->
        <footer class="footer-section" style="margin-top: 0 ; padding: 10px 125px">
            <div class="container">
                <div class="footer-left-pic">
                    <img src="img/footer-left-pic.png" alt="">
                </div>
                <div class="footer-right-pic">
                    <img src="img/footer-right-pic.png" alt="">
                </div>
                <a href="ReadGameHomeController" class="footer-logo">
                    <img src="./img/logo1.png" alt="">
                    <img src="./img/logo2.png" alt="">
                </a>
                <ul class="main-menu footer-menu">
                    <li><a href="ReadGameHomeAdminController?adminId=<%= request.getSession().getAttribute("adminId")%>">Home</a></li>
                    <li><a href="ReadGameListAdminController?adminId=<%= request.getSession().getAttribute("adminId")%>">Games</a></li>
                    <li><a href="ReadTopicAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>">Forum</a></li>                                               
                    <li><a href="ReadGameHomeAdminController?view=chart&adminId=<%= request.getSession().getAttribute("adminId")%>">Manage</a></li>   

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
            h3.bottom-title {
                color: white;
                font-size: 35px;
                font-family: 'Sixtyfour Convergence';
                padding: 0 0px 30px 0;
            }
             .user {
                        position: relative;
                        width: 40px;
                        height: 40px;
                        border-radius: 50%;
                        overflow: hidden;
                        cursor: pointer;
                    }
                    .user img {
                        position: absolute;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
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