
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
                        <a href="after-login.jsp" class="site-logo">
                            <img src="./img/logo1.png" alt="" class="logo1">
                            <img src="./img/logo2.png" alt="" class="logo2">
                        </a>
                    </div>
                    <nav class="top-nav-area w-100">
                        <div class="user-panel d-flex">
                            <!-- Bi?u t??ng gi? h�ng -->
                            <div class="cart-icon">
                                <a href="shopping-cart.jsp">
                                    <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                </a>
                            </div>
                            <!-- Bi?u t??ng t�i kho?n -->
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
                        <ul class="main-menu primary-menu">
                            <li><a href="ReadGameHomeController">Home</a></li>
                            <li><a href="games.jsp">Games</a></li>
                            <li>
                                <a class="li-fix" href="blog.jsp">News</a>

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
        <%
            String title = null;
            String gamePlay = null;
            String author = null;
            String genre = null;
            String description = null;
            String dateRelease = null;
            String fileData = null;
            double priceRating = 0.0;
            double graphicRating = 0.0;
            double difficultyRating = 0.0;
            double gameplayRating = 0.0;
            double averageRating = 0.0;

            // Get the post ID from the URL query parameter
            String postId = request.getParameter("id");
            System.out.println("Post ID: " + postId);

            // Connect to MongoDB
            MongoClient mongoClient = MongoClients.create("mongodb+srv://LoliHunter:Loli_slayer_123@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub"); // Your connection string
            MongoCollection<Document> postsCollection = mongoClient.getDatabase("GameHub").getCollection("postGame");

            // Find the post by its ObjectId
            Document post = postsCollection.find(Filters.eq("_id", new ObjectId(postId))).first();

            // Check if the post exists
            if (post != null) {
                gamePlay = post.getString("GamePlay");
                author = post.getString("Author");
                genre = post.getString("Genre");
                title = post.getString("Title"); // Ensure correct case
                description = post.getString("Description"); // Ensure correct case
                dateRelease = post.getString("DateRelease"); // Ensure correct case
                fileData = post.getString("FileData"); // Ensure correct case
                priceRating = post.getDouble("PriceRating");
                graphicRating = post.getDouble("GraphicRating");
                difficultyRating = post.getDouble("DifficultyRating");
                gameplayRating = post.getDouble("GameplayRating");
                averageRating = post.getDouble("AverageRating");

                // Log retrieved values
                System.out.println("Title: " + title);
                System.out.println("Description: " + description);
                System.out.println("Date Release: " + dateRelease);
                System.out.println("File Data: " + fileData);
            } else {
                out.println("Post not found.");
            }

            // Close MongoDB connection
            mongoClient.close();
        %>

        <section class="games-single-page">
            <div class="container">
                <div class="game-single-preview">
                    <img src="data:image/jpeg;base64,<%= fileData != null ? fileData : ""%>" alt="Game Image" />
                    <div class="wishlist-btns">
                        
                        <button class="wishlist-btn" style="background-color:#6f2b95">Add to wishlist</button>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xl-9 col-lg-8 col-md-7 game-single-content">
                        <div class="gs-meta">
                            Release : <%= dateRelease != null ? dateRelease : "Unknown Date"%>
                        </div>
                        <h2 class="gs-title">
                            <%= title != null ? title : "Untitled"%>
                        </h2>
                        <div class="gs-description">
                            <h3 style="color: white">Description</h3>

                            <p style="font-size: 20px"><%= description != null ? description : "No description available"%></p>
                        </div>
                        <div class="gs-gameplay">
                            <h3 style="color: white">Game Play</h3>
                            <p style="font-size: 20px"><%= gamePlay != null ? gamePlay : "No gamePlay available"%></p>
                        </div>
                        <div class="gs-auhtor-genre" ">
                            <div class="left-author">
                                <h3 style="color: white">Author</h3>
                            <p style="font-size: 20px"><%= author != null ? author : "No Author available"%></p>
                            </div>
                            <div class="right-genre">
                                 <h3 style="color: white">Genre</h3>
                            <p style="font-size: 20px"><%= genre != null ? genre : "No genre available"%></p>
                            </div>
                        </div>
                    </div>
                <div class="col-xl-3 col-lg-4 col-md-5 sidebar game-page-sideber">
                    <div id="stickySidebar">
                        <div class="widget-item">
                            <div class="rating-widget">
                                <h4 class="widget-title">Ratings</h4>
                                <ul>
                                    <li>Price Rating: <strong><%= priceRating %></strong></li>
                                    <li>Graphic Rating: <strong><%= graphicRating %></strong></li>
                                    <li>Difficulty Rating: <strong><%= difficultyRating %></strong></li>
                                    <li>Gameplay Rating: <strong><%= gameplayRating %></strong></li>
                                </ul>
                                <div class="rating">
                                    <h5><i>Average Rating:</i><span><%= averageRating %></span> / 5</h5>
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
            <a href="#" class="footer-logo">
                <img src="./img/logo.png" alt="">
            </a>
            <ul class="main-menu footer-menu">
                <li><a href="">Home</a></li>
                <li><a href="">Games</a></li>
                <li><a href="">Reviews</a></li>
                <li><a href="">News</a></li>
                <li><a href="">Contact</a></li>
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
