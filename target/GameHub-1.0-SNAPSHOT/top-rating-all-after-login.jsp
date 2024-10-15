<%@page import="com.mongodb.client.model.Sorts"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<!DOCTYPE html>
<%@ page import="com.mongodb.client.MongoClients, com.mongodb.client.MongoClient, com.mongodb.client.MongoCollection, org.bson.Document, org.bson.types.ObjectId, com.mongodb.client.model.Filters" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zxx">
    <head>
        <title>EndGame - Gaming Magazine Template</title>
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

        <script src="Login/script.js" defer></script>




    </head>
    <body>
        <!-- Page Preloder -->
        <div id="preloder">
            <div class="loader"></div>
        </div>

        <!-- Header section -->
        <header class="header-section">
            <div class="header-warp">
                <form class="search-form ">
                    <input type="text"  placeholder="Search..." aria-label="Search">
                    <button type="submit"><i class="fa fa-search"></i></button>
                </form>
                <div class="header-social d-flex justify-content-end">
                    <p>Follow us:</p>
                    <a href="#"><i class="fa fa-pinterest"></i></a>
                    <a href="#"><i class="fa fa-facebook"></i></a>
                    <a href="#"><i class="fa fa-twitter"></i></a>
                    <a href="#"><i class="fa fa-dribbble"></i></a>
                    <a href="#"><i class="fa fa-behance"></i></a>
                </div>
                <div class="header-bar-warp d-flex">
                    <!-- site logo -->
                    <div class="logo-fix">
                        <a href="home.html" class="site-logo">
                            <img src="./img/logo1.png" alt="" class="logo1">
                            <img src="./img/logo2.png" alt="" class="logo2">
                        </a>
                    </div>
                    <nav class="top-nav-area w-100">
                        <div class="user-panel d-flex">
                            <!-- Bi?u t??ng gi? hï¿½ng -->
                            <div class="cart-icon">
                                <a href="shopping-cart.jsp">
                                    <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                </a>
                            </div>
                            <!-- Bi?u t??ng tï¿½i kho?n -->
                            <div class="account-container">
                                <div class="account-icon">
                                    <i class="fa fa-user-circle" aria-hidden="true"></i>
                                </div>
                                <div class="account-dropdown">
                                    <ul>
                                        <li><a href="#">My Favourite</a></li>
                                        <li><a href="user-profile.jsp">Account Info</a></li>

                                        <li><a href="#">Log out</a></li>

                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- Menu -->
                        <!-- Menu -->
                        <ul class="main-menu primary-menu">
                            <li><a href="ReadGameHomeController">Home</a></li>
                            <li><a href="ReadGameListController">Games</a>

                                <ul class="sub-menu">
                                    <li><a href="top-rating-all-after-login.jsp">Top rating</a></li>
                                    <li><a href="top-wishlist-all-after-login.jsp">Top wishlist</a></li>
                                </ul>
                            </li>
                            <li><a href="contact-after-login.jsp">Contact</a></li>
                            <li><a href="chart/index-chart.jsp">Manage</a></li>
                            <li><a href="ReadTopicAdminController">Community</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </header>
        <!-- Header section end -->


        <!-- Page top section -->
        <section class="page-top-section set-bg" data-setbg="img/page-top-bg/2.jpg">
            <div class="page-info">
                <h2>Top rating</h2>
                <div class="site-breadcrumb">
                    <a href="index.js">Home</a>  /
                    <span>Top rating</span>
                </div>
            </div>
        </section>

        <!-- Review section -->
        <section class="review-section">
            <div class="container">
                <%
                    // Connect to MongoDB
                    MongoClient mongoClient = MongoClients.create("mongodb+srv://LoliHunter:Loli_slayer_123@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
                    MongoCollection<Document> postsCollection = mongoClient.getDatabase("GameHub").getCollection("postGame");

                    // Find all posts and sort by AverageRating in descending order
                    MongoCursor<Document> cursor = postsCollection.find().sort(Sorts.descending("AverageRating")).iterator();

                    // Loop through the results
                    while (cursor.hasNext()) {
                        Document post = cursor.next();

                        String title = post.getString("Title");
                        String description = post.getString("Description");
                        String dateRelease = post.getString("DateRelease");
                        double averageRating = post.getDouble("AverageRating");
                        String fileData = post.getString("FileData");
                        String postId = post.getObjectId("_id").toString();

                        // Display each post with the relevant information
%>
                <div class="review-item">
                    <div class="row">
                        <div class="col-lg-4">
                            <div class="review-pic">
                                <img src="data:image/jpeg;base64,<%= fileData != null ? fileData : ""%>" alt="Game Image">
                            </div>
                        </div>
                        <div class="col-lg-8">
                            <div class="review-content text-box text-white">
                                <div class="rating">
                                    <h5><i>Average Rating:</i><span><%= averageRating%></span> / 5</h5>
                                </div>
                                <div class="top-meta"><%= dateRelease != null ? dateRelease : "Unknown Release Date"%>  /  in <a href="#">Games</a></div>
                                <h3><%= title != null ? title : "Untitled"%></h3>
                                <p><%= description != null ? description : "No description available"%></p>
                                <a href="game-single.jsp?id=<%= postId%>" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#"></a>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                    // Close MongoDB connection
                    mongoClient.close();
                %>

                <div class="site-pagination">
                    <a href="#" class="active">01.</a>
                    <a href="#">02.</a>
                    <a href="#">03.</a>
                </div>
            </div>
        </section>
        <!-- Review section end-->


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
                <a href="index.jsp" class="footer-logo">
                    <img src="./img/logo.png" alt="">
                </a>
                <ul class="main-menu footer-menu">
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="games.jsp">Games</a></li>
                    <li><a href="forum.jsp">Forum</a></li>
                    <li><a href="blog.jsp">News</a></li>
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
                    <form action="#">
                        <div class="input-field">
                            <input type="text" required>
                            <label>Email</label>
                        </div>
                        <div class="input-field">
                            <input type="password" required>
                            <label>Password</label>
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
                    <form action="#">
                        <div class="input-field">
                            <input type="text" required>
                            <label>Enter your email</label>
                        </div>
                        <div class="input-field">
                            <input type="password" required>
                            <label>Create password</label>
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

    </body>
</html>