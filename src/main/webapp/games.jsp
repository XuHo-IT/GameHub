<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="org.bson.Document" %>
<!DOCTYPE html>
<html lang="zxx">
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

        <!-- Header section -->
        <header class="header-section">
            <div class="header-warp">
                <div class="row align-items-center">
                    <!-- Left side: Search Form (col-7) -->
                    <div class="col-8">
                        <form action="SearchController" method="GET">
                            <!-- Search Bar Row -->
                            <div class="row" style="align-items: center;">
                                <!-- Keyword input for the search bar -->
                                <div class="col-2 d-flex align-items-end">
                                    <button type="submit" class=" w-100" style="height: 52px;">Search</button>
                                </div>

                                <div class="col-10" style="text-align: center;padding-top: 33px ">
                                    <input type="text" name="keyword" class="form-control" placeholder="Search by keyword..." aria-label="Search" style="height: 52px;">
                                    <label for="genre" class="form-label" style="font-style: italic; font-weight: bold;">Genre:</label>
                                    <select id="genre" name="genre" class="form-select" style="height: 34px; float: left; border: 2px solid #ccc; font-style: italic; padding: 5px; border-radius: 5px; font-family: 'Arial', sans-serif;">
                                        <option value="">All Genres</option>
                                        <!-- Dynamically populate genres from MongoDB -->
                                        <c:forEach var="genre" items="${genres}">
                                            <option value="${genre.genre}">${genre.genre}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!-- Right side: Social Media Icons (col-4) -->
                    <div class="col-4 header-social d-flex align-items-center justify-content-end">
                        <p class="mb-0">Follow us:</p>
                        <a href="#"><i class="fa fa-pinterest"></i></a>
                        <a href="#"><i class="fa fa-facebook"></i></a>
                        <a href="#"><i class="fa fa-twitter"></i></a>
                        <a href="#"><i class="fa fa-dribbble"></i></a>
                        <a href="#"><i class="fa fa-behance"></i></a>
                    </div>
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
                            <li><a href="ReadGameListController">Games</a>						
                                <ul class="sub-menu">
                                    <li><a href="top-rating-all.jsp">Top rating</a></li>
                                </ul>
                            </li>
                            <li><a href="ReadTopicController">Forum</a></li>
                            <li><a href="contact.jsp">Contact</a></li>
                            
                        </ul>
                    </nav>
                </div>
            </div>
        </header>
        <!-- Header section end -->

        <!-- Page top section -->
        <section class="page-top-section set-bg" data-setbg="img/page-top-bg/1.jpg">
            <div class="page-info"style="padding-top: 30px">
                <h2>Games</h2>
                <div class="site-breadcrumb">
                    <a href="">Home</a>  /
                    <span>Games</span>
                </div>
            </div>
        </section>
        <!-- Page top end-->

        <!-- Games section -->
        <section class="games-section">
            <div class="container">
                <div class="row justify-content-center align-items-center">
                    <div class="col-xl-9 col-lg-8 col-md-7">
                        <div class="row">
                            <c:forEach var="post" items="${posts}">
                                <div class="col-lg-4 col-md-6">
                                    <div class="game-item">
                                        <img src="data:image/png;base64,${post.fileData}" class="same-size" alt="Game Image" />
                                        <h5>${post.title != null ? post.title : 'Untitled'}</h5>
                                        <a href="game-single.jsp?id=${post.postID}" class="read-more">Read More  <img src="img/icons/double-arrow.png" alt="#"/></a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                    </div>
                    <div class="col-xl-3 col-lg-4 col-md-5 sidebar game-page-sideber">
                        <div id="stickySidebar">
                            <div class="widget-item">
                                <div class="categories-widget">
                                    <h4 class="widget-title">Genre</h4>
                                    <form action="ReadGameListController" method="get">   
                                        <ul>
                                            <c:forEach var="genre" items="${genres}">
                                                <li>
                                                    <a href="ReadGameListController?genre=${genre.genre}">
                                                        ${genre.genre != null ? genre.genre : 'No genre available'}
                                                    </a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </form>
                                </div>
                            </div>
                            <div class="widget-item">
                                <img src="img/game-console.jpg" alt="#">
                            </div>
                        </div>
                    </div>
                    <div class="site-pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="?genre=${selectedGenre}&page=${currentPage - 1}" class="prev">Previous</a>
                        </c:if>

                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <a href="?genre=${selectedGenre}&page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <a href="?genre=${selectedGenre}&page=${currentPage + 1}" class="next">Next</a>
                        </c:if>
                    </div>

                </div>
            </div>
        </section>
        <!-- Games end-->

        <!-- Featured section -->
        <section class="featured-section">
            <div class="featured-bg set-bg" data-setbg="img/featured-bg.jpg"></div>
            <div class="featured-box">
                <div class="text-box">
                    <div class="top-meta">11.11.18  /  in <a href="">Games</a></div>
                    <h3>The game you?ve been waiting  for is out now</h3>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum suspendisse ultrices gravida. Ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliquamet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vestibulum posuere porttitor justo id pellentesque. Proin id lacus feugiat, posuere erat sit amet, commodo ipsum. Donec pellentesque vestibulum metus...</p>
                    <a href="#" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#"/></a>
                </div>
            </div>
        </section>
        <!-- Featured section end-->


        <!-- Newsletter section -->
        <section class="newsletter-section">
            <div class="container">
                <h2>Subscribe to our newsletter</h2>
                <form class="newsletter-form">
                    <input type="text" placeholder="ENTER YOUR E-MAIL">
                    <button class="site-btn">subscribe  <img src="img/icons/double-arrow.png" alt="#"/></button>
                </form>
            </div>
        </section>
        <!-- Newsletter section end -->

        <!-- Footer section -->
        <footer class="footer-section">
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
                    <a href="#"><i class="fa fa-pinterest"></i></a>
                    <a href="#"><i class="fa fa-facebook"></i></a>
                    <a href="#"><i class="fa fa-twitter"></i></a>
                    <a href="#"><i class="fa fa-dribbble"></i></a>
                    <a href="#"><i class="fa fa-behance"></i></a>
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
        <style>
            .same-size {
                width: 300px; /* set the width to 200px */
                height: 200px; /* set the height to 200px */
                object-fit: cover; /* make sure the image is scaled to cover the entire area */
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
    </body>
</html>
