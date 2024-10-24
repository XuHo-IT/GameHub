
<%@page import="utils.MongoDBConnectionManager1"%>
<%@page import="com.mongodb.client.MongoDatabase"%>
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
                        <a href="https://www.facebook.com/fptcorp"><i class="fa fa-facebook"></i></a>
                        <a href="https://fpt.com/vi"><i class="fa fa-address-card-o"></i></a>
                        <a href="https://www.linkedin.com/company/fpt-corporation"><i class="fa fa-linkedin-square"></i></a>
                        <a href="https://www.youtube.com/c/FPTCorporation"><i class="fa fa-youtube-play"></i></a>
                    </div>
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
                            <div class="account-container">
                                <div class="account-icon">
                                    <i class="fa fa-user-circle" aria-hidden="true"></i>
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


                        <ul class="main-menu primary-menu">
<<<<<<< HEAD
                            <li><a href="ReadGameHomeAdminController">Home</a></li>
                            <li><a href="ReadGameListAdminController">Games</a>

                                <ul class="sub-menu">
                                    <li><a href="top-rating-all-after-login-admin.jsp">Top rating</a></li>
                                    <li><a href="top-wishlist-all-after-login-admin.jsp">Top wishlist</a></li>
                                </ul>
                            </li>
                            <li><a href="contact-after-login-admin.jsp">Contact</a></li>
                            <li><a href="chart/index-chart.jsp">Manage</a></li>
                            <li><a href="ReadTopicAdmin.jsp">Community</a></li>
=======
                            <li><a href="ReadGameHomeAdminController?adminId=<%= request.getSession().getAttribute("adminId")%>">Home</a></li>
                            <li><a href="ReadGameListAdminController?adminId=<%= request.getSession().getAttribute("adminId")%>">Games</a></li>
                            <li><a href="ReadGameHomeAdminController?view=chart&adminId=<%= request.getSession().getAttribute("adminId")%>">Manage</a></li>
<<<<<<< HEAD
                            <li><a href="ReadTopicAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>">Community</a></li>
>>>>>>> 8d095345313693ae86e02c1c50850ceafd6c7970
=======
                            <li><a href="ReadTopicAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>">Forum</a></li>
                            <li><a href="contact-after-login.jsp?adminId=<%= request.getSession().getAttribute("adminId")%>">Contact</a></li>
>>>>>>> 4a7e61d314ac293c061966d4e2a08a39b8b0551d
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
                    <a href="ReadGameHomeAdminController?adminId=<%= request.getSession().getAttribute("adminId")%>">Home</a>
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
            String linkGame = null;
            String price = null;
            double priceRating = 0.0;
            double graphicRating = 0.0;
            double difficultyRating = 0.0;
            double gameplayRating = 0.0;
            double averageRating = 0.0;

            // Get the post ID from the URL query parameter
            String postId = request.getParameter("id");
            System.out.println("Post ID: " + postId);

            // Connect to MongoDB
            MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();
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
                fileData = post.getString("FileData");
                linkGame = post.getString("LinkGame");
                price = post.getString("Price");
// Ensure correct case

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
                        <button id="wishlist-btn" class="wishlist-btn" style="background-color:#6f2b95" 
                                onclick="addToWishlist(this)">
                            Add to wishlist
                        </button>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xl-9 col-lg-8 col-md-7 game-single-content">
                        <!-- Button to submit the form -->
                        <form action="EditPostController" method="POST">
                            <div class="gs-meta">
                                <h3 style="color: white">Release Date</h3>
                                <input type="date" name="dateRelease" style="font-size: 20px; height: 50px" value="<%= dateRelease != null ? dateRelease : "Unknown Date"%>" class="form-control">
                            </div>

                            <h2 class="gs-title">
                                <h3 style="color: white">Title/h3>
                                    <input type="text" name="title" style="font-size: 20px; height: 50px" value="<%= title != null ? title : "Untitled"%>" class="form-control">
                                    </h2>

                                    <div class="gs-description">
                                        <h3 style="color: white">Description</h3>
                                        <textarea name="description" style="font-size: 20px; height: 400px" class="form-control"><%= description != null ? description : "No description available"%></textarea>
                                    </div>

                                    <div class="gs-gameplay">
                                        <h3 style="color: white">Game Play</h3>
                                        <textarea name="gamePlay" style="font-size: 20px; height: 50px" class="form-control"><%= gamePlay != null ? gamePlay : "No gamePlay available"%></textarea>
                                    </div>

                                    <div class="gs-auhtor-genre">
                                        <div class="left-author">
                                            <h3 style="color: white">Author</h3>
                                            <input type="text" name="author" style="font-size: 20px; height: 50px" value="<%= author != null ? author : "No Author available"%>" class="form-control">
                                        </div>
                                    </div>
<<<<<<< HEAD
                                        
=======

>>>>>>> 8d095345313693ae86e02c1c50850ceafd6c7970
                                    <div class="gs-gameplay">
                                        <h3 style="color: white">Link of the game</h3>
                                        <textarea name="Link" style="font-size: 20px; height: 50px" class="form-control"><%= linkGame != null ? linkGame : "No linkGame available"%></textarea>
                                    </div> <div class="gs-gameplay">
                                        <h3 style="color: white">Price</h3>
                                        <textarea name="Price" style="font-size: 20px; height: 50px" class="form-control"><%= price != null ? price : "No price available"%></textarea>
                                    </div>

                                    <input type="hidden" name="postId" value="<%= postId%>">
                                    <button class="edit-btn" type="submit" name="action" value="edit" style="background-color:#4CAF50;">Edit</button>
                                    </form>
                                    </div>


                                    <div class="col-xl-3 col-lg-4 col-md-5 sidebar game-page-sideber">
                                        <div id="stickySidebar">
                                            <div class="widget-item">
                                                <div class="rating-widget">
                                                    <h4 class="widget-title">Ratings</h4>
                                                    <ul>
                                                        <li>Price Rating: <strong><%= priceRating%></strong></li>
                                                        <li>Graphic Rating: <strong><%= graphicRating%></strong></li>
                                                        <li>Difficulty Rating: <strong><%= difficultyRating%></strong></li>
                                                        <li>Gameplay Rating: <strong><%= gameplayRating%></strong></li>
                                                    </ul>
                                                    <div class="rating">
                                                        <h5><i>Average Rating:</i><span><%= averageRating%></span> / 5</h5>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="widget-item">
                                                <div class="testimonials-widget">
                                                    <h4 class="widget-title">Testimonials</h4>
                                                    <div class="testim-text">
                                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
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
                                    <section class="newsletter-section" style="">
                                        <div class="container">
                                            <h3 class="bottom-title">Thanks for using our website!</h3>
                                            <img src="img/Dawn.gif" alt="Game Image" style="width: 100%; height: auto;" />
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
                                                <li><a href="ReadGameHomeAdminController?adminId=<%= request.getSession().getAttribute("adminId")%>">Home</a></li>
                                                <li><a href="ReadGameListAdminController?adminId=<%= request.getSession().getAttribute("adminId")%>">Games</a></li>
                                                <li><a href="ReadGameHomeAdminController?view=chart&adminId=<%= request.getSession().getAttribute("adminId")%>">Manage</a></li>
                                                <li><a href="ReadTopicAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>">Forum</a></li>
                                                <li><a href="contact-after-login.jsp?adminId=<%= request.getSession().getAttribute("adminId")%>">Contact</a></li>
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
                                 
                                    <script>
                                        function addToWishlist(button) {
                                            button.style.backgroundColor = '#D9D9D9';
                                            button.style.color = '#C20000';
                                            button.style.fontWeight = 'bold';
                                            button.innerHTML = 'Added to wishlist';
                                        }
                                    </script>
                                    <style>
                                        h3.bottom-title {
                                            color: white;
                                            font-size: 35px;
                                            font-family: 'Sixtyfour Convergence';
                                            padding: 0 0px 30px 0;
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
