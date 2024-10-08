<%@page import="jdk.javadoc.internal.doclets.formats.html.markup.HtmlStyle.title"%>
<%@page import="jdk.javadoc.internal.doclets.formats.html.markup.HtmlStyle.title"%>
<%@page import="com.mongodb.client.model.Filters"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoClients"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="com.mongodb.client.MongoClient"%>
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
        <link rel="stylesheet" href="Login/style.css">
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
                        <a href="index.jsp" class="site-logo">
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
                            <li><a href="index.jsp">Home</a></li>
                            <li><a href="games.jsp">Games</a>

                                <ul class="sub-menu">
                                    <li><a href="top-rating-all.jsp">Top rating</a></li>
                                    <li><a href="top-wishlist.jsp">Top wishlist</a></li>
                                </ul>
                            </li>
                            <li><a href="contact.jsp">Contact</a></li>
                            <li><a href="forum.jsp">Community</a></li>
                        </ul>
                    </nav>
                </div>

            </div>
        </header>
        <!-- Header section end -->

        <!-- Page top section -->
        <section class="page-top-section set-bg" data-setbg="img/page-top-bg/1.jpg">
            <div class="page-info">
                <h2>Games</h2>
                <div class="site-breadcrumb">
                    <a href="">Home</a>  /
                    <span>Games</span>
                </div>
            </div>
        </section>
        <!-- Page top end-->


        <!-- Games section -->
        <section class="games-single-page">
            <div class="container">
                <div class="game-single-preview">
                    <img src="img/games/big.jpg" alt="">
                    <div class="wishlist-btns">
                        <button class="favourite-btn">
                            <i class="fa fa-star"></i> Add to favourite
                        </button>
                        <button class="wishlist-btn">Add to wishlist</button>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xl-9 col-lg-8 col-md-7 game-single-content">
                        <%@ page import="com.mongodb.client.MongoClients, com.mongodb.client.MongoClient, com.mongodb.client.MongoCollection, org.bson.Document, com.mongodb.client.model.Filters" %>
                        <%@ page import="org.bson.types.ObjectId" %>

                        <%
                            String title = null;
                            String description = null;
                            String dateRelease = null;
                            String fileData = null;

                            // Get the post ID from the URL query parameter
                            String postId = request.getParameter("id");

                            // Connect to MongoDB
                            MongoClient mongoClient = MongoClients.create("mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
                            MongoCollection<Document> postsCollection = mongoClient.getDatabase("GameHub").getCollection("postGame");

                            // Find the post by its ObjectId
                            Document post = postsCollection.find(Filters.eq("_id", new ObjectId(postId))).first();

                            // Check if the post exists
                            if (post != null) {
                                title = post.getString("title");
                                description = post.getString("description");
                                dateRelease = post.getString("dateRelease");
                                fileData = post.getString("fileData"); // Assuming image data is stored as base64
                            } else {
                                out.println("Post not found.");
                            }

                            // Close MongoDB connection
                            mongoClient.close();
                        %>

                        <div class="gs-meta">
                            <%= dateRelease != null ? dateRelease : "Unknown Date"%> / in <a href="#">Games</a>
                        </div>

                        <h2 class="gs-title">
                            <%= title != null ? title : "Untitled"%>
                        </h2>

                        <div class="gs-description">
                            <p><%= description != null ? description : "No description available"%></p>
                        </div>

                        <div class="gs-image">
                            <img src="data:image/png;base64,<%= fileData != null ? fileData : ""%>" alt="Game Image" />
                        </div>

                        <div class="card comment-section mt-5">
                            <div class="row no-gutters">
                                <div class="col-2 d-flex align-items-center justify-content-center">
                                    <img src="img/author.jpg" width="70" class="rounded-circle mt-2">
                                </div>
                                <div class="col-10">
                                    <div class="comment-box ml-3 p-3">
                                        <h4>Add a comment</h4>
                                        <div class="comment-area">
                                            <textarea class="form-control" placeholder="What is your view?" rows="4"></textarea>
                                        </div>
                                        <div class="comment-btns mt-3">
                                            <div class="row">
                                                <div class="col-6">
                                                    <button class="btn btn-secondary btn-sm w-100">Cancel</button>
                                                </div>
                                                <div class="col-6">
                                                    <button class="btn btn-primary btn-sm w-100">Send <i class="fa fa-long-arrow-right ml-1"></i></button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br>
                        <h3>4 Comments</h3>
                        <br>
                        <!-- COMMENT 1 - START -->
                        <div class="media">
                            <a class="pull-left" href="#"><img class="media-object" src="https://bootdey.com/img/Content/avatar/avatar1.png" alt=""></a>
                            <div class="media-body">
                                <h4 class="media-heading">John Doe</h4>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                <ul class="list-unstyled list-inline media-detail pull-left">
                                    <li><i class="fa fa-calendar"></i>27/02/2014</li>
                                    <li><i class="fa fa-thumbs-up"></i>13</li>
                                </ul>
                                <ul class="list-unstyled list-inline media-detail pull-right">
                                    <li class=""><a href="">Like</a></li>
                                    <li class=""><a href="">Reply</a></li>
                                </ul>
                            </div>
                        </div>
                        <!-- COMMENT 1 - END -->

                        <!-- COMMENT 2 - START -->
                        <div class="media">
                            <a class="pull-left" href="#"><img class="media-object" src="https://bootdey.com/img/Content/avatar/avatar2.png" alt=""></a>
                            <div class="media-body">
                                <h4 class="media-heading">John Doe</h4>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                <ul class="list-unstyled list-inline media-detail pull-left">
                                    <li><i class="fa fa-calendar"></i>27/02/2014</li>
                                    <li><i class="fa fa-thumbs-up"></i>13</li>
                                </ul>
                                <ul class="list-unstyled list-inline media-detail pull-right">
                                    <li class=""><a href="">Like</a></li>
                                    <li class=""><a href="">Reply</a></li>
                                </ul>
                            </div>
                        </div>
                        <!-- COMMENT 2 - END -->

                        <!-- COMMENT 3 - START -->
                        <div class="media">
                            <a class="pull-left" href="#"><img class="media-object" src="https://bootdey.com/img/Content/avatar/avatar3.png" alt=""></a>
                            <div class="media-body">
                                <h4 class="media-heading">John Doe</h4>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                <ul class="list-unstyled list-inline media-detail pull-left">
                                    <li><i class="fa fa-calendar"></i>27/02/2014</li>
                                    <li><i class="fa fa-thumbs-up"></i>13</li>
                                </ul>
                                <ul class="list-unstyled list-inline media-detail pull-right">
                                    <li class=""><a href="">Like</a></li>
                                    <li class=""><a href="">Reply</a></li>
                                </ul>
                            </div>
                        </div>
                        <!-- COMMENT 3 - END -->

                        <!-- COMMENT 4 - START -->
                        <div class="media">
                            <a class="pull-left" href="#"><img class="media-object" src="https://bootdey.com/img/Content/avatar/avatar4.png" alt=""></a>
                            <div class="media-body">
                                <h4 class="media-heading">John Doe</h4>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                <ul class="list-unstyled list-inline media-detail pull-left">
                                    <li><i class="fa fa-calendar"></i>27/02/2014</li>
                                    <li><i class="fa fa-thumbs-up"></i>13</li>
                                </ul>
                                <ul class="list-unstyled list-inline media-detail pull-right">
                                    <li class=""><a href="">Like</a></li>
                                    <li class=""><a href="">Reply</a></li>
                                </ul>
                            </div>
                        </div>
                        <!-- COMMENT 4 - END -->

                        <div class="geme-social-share pt-5 d-flex">
                            <p>Share:</p>
                            <a href="#"><i class="fa fa-pinterest"></i></a>
                            <a href="#"><i class="fa fa-facebook"></i></a>
                            <a href="#"><i class="fa fa-twitter"></i></a>
                            <a href="#"><i class="fa fa-dribbble"></i></a>
                            <a href="#"><i class="fa fa-behance"></i></a>
                        </div>
                    </div>
                    <div class="col-xl-3 col-lg-4 col-md-5 sidebar game-page-sideber">
                        <div id="stickySidebar">
                            <div class="widget-item">
                                <div class="rating-widget">
                                    <h4 class="widget-title">Ratings</h4>
                                    <ul>
                                        <li>Price<span>3.5/5</span></li>
                                        <li>Graphics<span>4.5/5</span></li>
                                        <li>Levels<span>3.5/5</span></li>
                                        <li>Levels<span>4.5/5</span></li>
                                        <li>Dificulty<span>4.5/5</span></li>
                                    </ul>
                                    <div class="rating">
                                        <h5><i>Rating</i><span>4.5</span> / 5</h5>
                                    </div>
                                </div>
                            </div>
                            <div class="widget-item">
                                <div class="testimonials-widget">
                                    <h4 class="widget-title">Testimonials</h4>
                                    <div class="testim-text">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolo re magna aliqua. Quis ipsum suspend isse ultrices.</p>
                                        <h6><span>James Smith,</span>Gamer</h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Games end-->

        <section class="game-author-section">
            <div class="container">
                <div class="game-author-pic set-bg" data-setbg="img/author.jpg"></div>
                <div class="game-author-info">
                    <h4>Written by: Michael Williams</h4>
                    <p>Vivamus volutpat nibh ac sollicitudin imperdiet. Donec scelerisque lorem sodales odio ultricies, nec rhoncus ex lobortis. Vivamus tincid-unt sit amet sem id varius. Donec elementum aliquet tortor. Curabitur justo mi, efficitur sed eros alique.</p>
                </div>
            </div>
        </section>


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
                    <img src="img/spider-removebg-preview.png" alt="">
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
