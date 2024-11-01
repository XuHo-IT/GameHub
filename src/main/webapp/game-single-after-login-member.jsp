<%@page import="Model.UserModel"%>
<%@page import="DAO.UserDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="utils.MongoDBConnectionManager"%>
<%@page import="Model.Genre"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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

        <%
            String title = null;
            String gamePlay = null;
            String author = null;
            String genre = null; // For storing genre name from post data
            String description = null;
            String dateRelease = null;
            String fileData = null;
            String linkGame = null;
            String price = null;
            String adminId = request.getSession().getAttribute("adminId").toString();
            List<String> actionImages = null;

            // Connect to MongoDB
            MongoClient mongoClient = MongoDBConnectionManager.getLocalMongoClient();
            MongoCollection<Document> postsCollection = mongoClient.getDatabase("GameHub").getCollection("postGame");

            // Get the post ID from the URL query parameter
            String postId = request.getParameter("id");
            System.out.println("Post ID: " + postId);

            // Find the post by its ObjectId
            Document post = postsCollection.find(Filters.eq("_id", new ObjectId(postId))).first();

            // Check if the post exists
            if (post != null) {
                actionImages = (List<String>) post.get("ActionImages");
                gamePlay = post.getString("GamePlay");
                author = post.getString("Author");
                genre = post.getString("Genre"); // Ensure correct case
                title = post.getString("Title"); // Ensure correct case
                description = post.getString("Description"); // Ensure correct case
                dateRelease = post.getString("DateRelease"); // Ensure correct case
                fileData = post.getString("FileData");
                linkGame = post.getString("LinkGame");
                price = post.getString("Price"); // Ensure correct case

            } else {
                out.println("Post not found.");
            }
        %>
        <!-- Header section -->
        <header class="header-section">
            <div class="header-warp">
                <div class="row align-items-center">
                    <!-- Left side: Search Form (col-7) -->
                    <div class="col-8">
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
                        <a href="ReadGameHomeMember?userId=<%= request.getSession().getAttribute("adminId")%>" class="site-logo">
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
                                    <img src="data:image/jpeg;base64,<%= request.getSession().getAttribute("photoUrl")%>" 
                                         alt="Profile Picture" 
                                         style="width: 50px; height: 50px; border-radius: 50%;" 
                                         onerror="this.onerror=null;this.src='img/t-rex.png';" />
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
                            <li><a href="ReadGameHomeMember?userId=<%= request.getSession().getAttribute("adminId")%>">Home</a></li>
                            <li><a href="ReadGameListMember?userId=<%= request.getSession().getAttribute("adminId")%>">Games</a></li>
                            <li><a href="ReadTopicMember?userId=<%= request.getSession().getAttribute("adminId")%>">Forum</a></li>
                            <li><a href="contact-after-login-member.jsp?userId=<%= request.getSession().getAttribute("adminId")%>">Contact</a></li>
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



        <!-- Games section -->
        <section class="games-single-page">
            <div class="container">
                <div class="game-single-preview">
                    <img class="game_single_img" src="data:image/jpeg;base64,<%= fileData != null ? fileData : ""%>" alt="Game Image" />
                    <%
                        // Parse the release date if it's not null
                        Date today = new Date();
                        Date releaseDate = null;

                        if (dateRelease != null) {
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // Ensure format matches dateRelease
                            releaseDate = sdf.parse(dateRelease);
                        }
                    %>

                    <!-- Add to Wishlist button -->
                    <% if (releaseDate != null && releaseDate.after(today)) {%>
                    <div class="wishlist-btns">
                        <form id="wishlistForm" action="shopping-cart.jsp?id=<%= postId%>&adminId=<%= adminId%>" method="POST">
                            <input type="hidden" name="postId" value="<%= postId%>" />
                            <input type="hidden" name="adminId" value="<%= adminId%>" />
                            <input type="hidden" name="title" value="<%= title%>" />
                            <input type="hidden" name="fileData" value="<%= fileData%>" />
                            <input type="hidden" name="dateRelease" value="<%= dateRelease%>" />
                            <input type="hidden" name="author" value="<%= author%>" />
                            <input type="hidden" name="price" value="<%= price%>" />
                            <input type="hidden" name="linkGame" value="<%= linkGame%>" />
                            <button type="submit">Add to Wishlist</button>
                            <script>
                                function addToWishlist(button) {
                                    button.style.backgroundColor = '#D9D9D9';
                                    button.style.color = '#C20000';
                                    button.style.fontWeight = 'bold';
                                    button.innerHTML = 'Added to wishlist';
                                }
                            </script>
                        </form>
                    </div>
                    <% }%>

                    <% if (releaseDate != null && releaseDate.before(today)) {%>
                    <div class="buy-btn">
                        <button class="buy-button" type="submit" 
                                onclick="window.location.href = 'http://localhost:8080/Web_Trading_Game/cart-buy.jsp?id=<%= postId%>&adminId=<%= adminId%>'">
                            Buy Game
                        </button>
                    </div>
                    <% }%>

                </div>
                <h2 class="gs-title">
                    <%= title != null ? title : "Untitled"%>
                </h2>
                <br>
                <div class="gs-meta">
                    Release : <%= dateRelease != null ? dateRelease : "Unknown Date"%>
                </div>                   
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
                        <h3 style="color: white">Publisher</h3>
                        <p style="font-size: 20px"><%= author != null ? author : "No Author available"%></p>
                    </div>
                    <div class="right-genre">
                        <h3 style="color: white">Genre</h3>
                        <p style="font-size: 20px"><%= genre != null ? genre : "No genre available"%></p>
                    </div>
                </div>

                <div id="actionImagesCarousel" class="carousel slide" data-ride="carousel">
                    <div class="carousel-inner">
                        <%
                            if (actionImages != null && !actionImages.isEmpty()) {
                                for (int i = 0; i < actionImages.size(); i++) {
                                    String imageBase64 = actionImages.get(i);
                        %>
                        <div class="carousel-item <%= (i == 0) ? "active" : ""%>">
                            <img src="data:image/jpeg;base64,<%= imageBase64%>" class="d-block w-100" alt="Game Action Image <%= i + 1%>">
                        </div>
                        <%
                            }
                        } else {
                        %>
                        <div class="carousel-item active">
                            <p>No action images available.</p>
                        </div>
                        <% }%>
                    </div>
                    <a class="carousel-control-prev" href="#actionImagesCarousel" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#actionImagesCarousel" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
            </div>
        </section>
        <!-- Games end-->    
        <!-- Games end-->




        <!-- Newsletter section -->

        <!-- Newsletter section end -->


        <!-- Footer section -->
        <footer class="footer-section">
            <div class="container">
                <div class="footer-left-pic">
                    <img class="img_bottom_1" src="./img/bottom_pic_1.png" alt="">
                </div>
                <div class="footer-right-pic">
                    <img class="img_bottom_2" src="./img//bottom_pic_2.png" alt="">
                </div>
                <a href="#" class="footer-logo">
                    <img src="./img/logo.png" alt="">
                </a>
                <ul class="main-menu footer-menu">
                    <li><a href="ReadGameHomeMember?userId=<%= request.getSession().getAttribute("adminId")%>">Home</a></li>
                    <li><a href="ReadGameListMember?userId=<%= request.getSession().getAttribute("adminId")%>">Games</a>
                    <li><a href="ReadTopicMember?userId=<%= request.getSession().getAttribute("adminId")%>">Forum</a></li>
                    <li><a href="contact-after-login-member.jsp?userId=<%= request.getSession().getAttribute("adminId")%>">Contact</a></li>
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




        <!--====== Javascripts & Jquery ======-->
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.slicknav.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/jquery.sticky-sidebar.min.js"></script>
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/main.js"></script>


        <style>
            .gs-auhtor-genre {
                width: 100%;
                display: flex;
                align-content: stretch;
                flex-wrap: wrap;
                justify-content: space-around;
            }
            .left-author {
                padding: 20px 0;
            }
            .right-genre {
                padding: 20px 0;
            }

            .gs-description {
                padding: 50px 0;
            }
            .gs-gameplay {
                padding: 50px 0;
            }
            .gs-author-genre{
                padding: 50px 0;
            }
            .gs-meta {
                font-size: 20px;
                color: #585858;
            }
            h2.gs-title {
                font-size: 60px;
                color: white;
            }
            .game-single-preview {
                text-align: center;
            }
            img.game_single_img {
                width: 1000px;
                height: 700px;
            }
            img.img_bottom_1,img.img_bottom_2  {
                width: 50%;
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
            .buy-button{
                width: 20%;
                color: #fff;
                border: none;
                outline: none;
                padding: 14px 0;
                font-size: 1rem;
                font-weight: 500;
                border-radius: 3px;
                cursor: pointer;
                margin: 25px 0;
                background: #952b2b;
                transition: 0.2s ease;

            }
        </style>

    </body>
</html>
