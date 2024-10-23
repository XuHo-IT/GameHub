<%@page import="utils.MongoDBConnectionManager1"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="Model.Topic"%>
<%@page import="com.mongodb.client.MongoDatabase"%>
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
        <link href="img/favicon.ico" rel="shortcut icon"/>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css?family=Roboto:400,400i,500,500i,700,700i,900,900i" rel="stylesheet">


        <!-- Stylesheets -->
        <link rel="stylesheet" href="css/bootstrap.min.css"/>
        <link rel="stylesheet" href="css/font-awesome.min.css"/>
        <link rel="stylesheet" href="css/slicknav.min.css"/>
        <link rel="stylesheet" href="css/owl.carousel.min.css"/>
        <link rel="stylesheet" href="css/magnific-popup.css"/>
        <link rel="stylesheet" href="css/animate.css"/>
        <link rel="stylesheet" href="css/searchbar.css"/>

        <!-- Main Stylesheets -->
        <link rel="stylesheet" href="css/style.css"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@48,400,0,0">
        <link rel="stylesheet" href="Login/style.css">
        <link rel="stylesheet" href="Forum/style.css">
        <script src="Login/script.js" defer></script>

        <!--[if lt IE 9]>
                  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>

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
                        <div class="user-panel">
                            <button class="login-btn">LOG IN</button>
                        </div>

                        <!-- Menu -->
                        <ul class="main-menu primary-menu">
                            <li><a href="ReadGameHomeController">Home</a></li>
                            <li><a href="ReadGameListController">Games</a></li>
                            <li><a href="ReadTopicController">Forum</a></li>
                            <li><a href="contact.jsp">Contact</a></li>

                        </ul>
                    </nav>
                </div>
            </div>
        </header>	
        <!-- Header section end -->

        <!-- Page top section -->
        <section class="page-top-section set-bg" data-setbg="img/page-top-bg/4.jpg">
            <div class="page-info">
                <h2>Forum</h2>
                <div class="site-breadcrumb">
                    <a href="ReadGameHomeController">Home</a>  /
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
                 max-width: 1500px">
                <div class="subforum">
                    <%MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();%>
                    <c:forEach var="topic" items="${topics}">
                        <div class="subforum-row">
                            <div class="subforum-icon subforum-column center">
                                <img src="${topic.photoUrl}" alt="User Photo">
                            </div>
                            <div class="subforum-description subforum-column">
                                <h4>
                                    <a href="forum-detail.jsp?id=${topic.topicId}">
                                        <c:choose>
                                            <c:when test="${fn:length(topic.title) >= 65}">
                                                ${fn:substring(topic.title, 0, 65)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${topic.title}
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </h4>
                                <c:choose>
                                    <c:when test="${fn:length(topic.description) >= 360}">
                                        <p style="word-wrap: break-word;">${fn:substring(topic.description, 0, 390)}...</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p style="word-wrap: break-word;">
                                            <c:out value="${topic.description}"/>
                                        </p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="subforum-stats subforum-column center">
                                <%
                                    // Get the topic object from the pageContext
                                    Topic topicObj = (Topic) pageContext.getAttribute("topic");

                                    // Kết nối đến cơ sở dữ liệu MongoDB
                                    // Lấy collection comment và reply
                                    MongoCollection<Document> commentCollection = mongoClient.getDatabase("GameHub").getCollection("comment");

                                    // Đếm số lượng bình luận cho mỗi chủ đề
                                    long commentCount = commentCollection.countDocuments(Filters.eq("TopicId", topicObj.getTopicId()));

                                    Date date = topicObj.getDate();
                                    SimpleDateFormat sdf = new SimpleDateFormat("mm:hh a dd-MM-yyyy");
                                    String formattedDate = sdf.format(date);
                                %>
                                <span style="font-size: 20px"><%= commentCount%> <img src="./img/icons/chat-icon.png" alt=""> </span>
                            </div>
                            <div class="subforum-info subforum-column">
                                <b>Post by</b> <a href="#" style="font-size: 15px">${topic.userName}</a></br>
                                <b>On</b><a style="font: "Courier ", "Courier New", monospace;"><%=formattedDate%></a>
                            </div>
                        </div>
                        <hr class="subforum-devider">
                    </c:forEach>
                    <%mongoClient.close();%>
                </div>      
            </div>
            <div class="site-pagination" style="margin-top: 10px; justify-content: center;">
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <a href="?page=${i}" class="${i == currentPage ? 'active' : ''}">${i < 10 ? '0' + i : i}</a>
                </c:forEach>
            </div>
        </section>

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
                    <li><a href="ReadGameHomeController">Home</a></li>
                    <li><a href="ReadGameListController">Games</a></li>
                    <li><a href="ReadTopicController">Forum</a></li>
                    <li><a href="contact.jsp">Contact</a></li>
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

        <!-- Login Popup -->
        <div class="blur-bg-overlay"></div>
        <div class="form-popup">
            <span class="close-btn material-symbols-rounded">close</span>
            <div class="form-box login">
                <div class="form-details">
                    <h2>Welcome Back</h2>
                    <p>Please log in using your personal information to stay connected with us.</p>
                </div>
                <div class="form-content">
                    <h2>LOGIN</h2>
                    <form action="LoginController" method="post">
                        <c:if test="${not empty errorMessage}">
                            <div class="error">${errorMessage}</div>
                        </c:if>

                        <div class="input-field">
                            <label>Email</label>

                            <input type="text" required name="email">
                        </div>
                        <div class="input-field">
                            <label>Password</label>

                            <input type="password" required name="password">
                        </div>
                        <a href="#" class="forgot-pass-link">Forgot password?</a>
                        <button type="submit">Log In</button>
                    </form>
                    <div class="bottom-link">
                        Don't have an account?
                        <a href="#" id="signup-link">Signup</a>
                    </div>
                </div>
            </div>
            <div class="form-box signup">
                <div class="form-details">
                    <h2>Create Account</h2>
                    <p>To become a part of our community, please sign up using your personal information.</p>
                </div>
                <div class="form-content">
                    <h2>SIGNUP</h2>
                    <form action="SignUpController" method="post">
                        <div class="input-field">
                            <label>Enter your name</label>

                            <input type="text" required name="Name">
                        </div>
                        <div class="input-field">
                            <label>Enter your email</label>

                            <input type="text" required name="Email">
                        </div>
                        <div class="input-field">
                            <label>Phone number</label>

                            <input type="number" required name="Phone">
                        </div>
                        <div class="input-field">
                            <label>Date of birth</label>

                            <input type="date" required name="Dob">
                        </div>
                        <div class="input-field">
                            <label>Address</label>

                            <input type="text" required name="Address">
                        </div>
                        <div class="input-field">
                            <label>Password</label>

                            <input type="password" required name="Password">
                        </div>
                        <div class="policy-text">
                            <input type="checkbox" id="policy">
                            <label for="policy">
                                I agree the
                                <a href="#" class="option">Terms & Conditions</a>
                            </label>
                        </div>
                        <button type="submit">Sign Up</button>
                    </form>
                    <div class="bottom-link">
                        Already have an account? 
                        <a href="#" id="login-link">Login</a>
                    </div>
                </div>
            </div>
        </div>


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