<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="Model.UserModel"%>
<%@page import="DAO.UserDAO"%>
<%@page import="utils.MongoDBConnectionManager"%>
<%@page import="java.util.List"%>
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
        <link href="https://fonts.googleapis.com/css2?family=Sixtyfour+Convergence&display=swap" rel="stylesheet">

        <!-- Stylesheets -->
        <link rel="stylesheet" href="css/bootstrap.min.css"/>
        <link rel="stylesheet" href="css/font-awesome.min.css"/>
        <link rel="stylesheet" href="css/slicknav.min.css"/>
        <link rel="stylesheet" href="css/owl.carousel.min.css"/>
        <link rel="stylesheet" href="css/magnific-popup.css"/>
        <link rel="stylesheet" href="css/animate.css"/>
        <link rel="stylesheet" href="css/searchbar.css"/>
        <link rel="stylesheet" href="css/account-icon.css" />

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
            String fileName = null;
            String adminId = request.getParameter("adminId");
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
                fileName = post.getString("FileName");
                price = post.getString("Price");
                adminId = post.getString("AdminId");// Ensure correct case

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
                                        <li><a href="user-profile.jsp?id=<%= request.getSession().getAttribute("adminId")%>">Account Info</a></li>
                                        <li>
                                            <a href="LogOut" class="dropdown-item">Logout</a>
                                        </li>
                                    </ul>
                                </div>

                            </div>
                        </div>


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

        <!-- Page top section -->
        <section class="page-top-section set-bg" data-setbg="img/page-top-bg/1.jpg">
            <div class="page-info">
                <h2>Games</h2>
                <div class="site-breadcrumb">
                    <a href="ReadGameHomeAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>">Home</a>
                    <span>Games</span>
                </div>
            </div>
        </section>
        <!-- Page top end-->



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
                <% if (releaseDate != null && releaseDate.before(today)) {%>
                <div class="gs-price">
                    <h3 style="color: white">Price</h3>
                    <p style="font-size: 20px"><%= price != null ? price : "No price available"%> VND</p>
                </div>
                <div class="gs-link">
                    <h3 style="color: white">Link Game</h3>
                    <p style="font-size: 20px"><%= linkGame != null ? linkGame : "No linkGame available"%></p>
                </div>
                <% }%>

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
        </section>
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
                <a href="ReadGameHomeAdminController?adminId=<%= request.getSession().getAttribute("adminId")%>" class="footer-logo">
                    <img src="./img/logo1.png" alt="">
                    <img src="./img/logo2.png" alt="">
                </a>
                <ul class="main-menu footer-menu">
                    <li><a href="ReadGameHomeAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>">Home</a></li>
                    <li><a href="ReadGameListAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>">Games</a></li>
                    <li><a href="ReadGameHomeAdmin?view=chart&adminId=<%= request.getSession().getAttribute("adminId")%>">Manage</a></li>
                    <li><a href="ReadTopicAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>">Forum</a></li>
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
            .games-single-page, .review-section, .blog-page, .contact-page {
                padding-bottom: 0;
            }
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
            .gs-price {
                padding: 30px 0;
            }
            .gs-link {
                padding: 30px 0;
            }
            .gs-author-genre{
                padding: 50px 0;
            }
            .gs-meta {
                font-size: 20px;
                color: lightblue;
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

            h3.bottom-title {
                color: white;
                font-size: 35px;
                font-family: 'Sixtyfour Convergence';
                padding: 0 0px 30px 0;
            }
            img.game_single_img {
                width: 1000px;
                height: 700px;
            }
            .buy-button{
                color: #fff;
                border: none;
                outline: none;
                padding: 14px 0;
                font-size: 1rem;
                font-weight: 500;
                border-radius: 3px;
                cursor: pointer;
                margin: 25px 0;
                background: #6f2b95;
                transition: 0.2s ease;
                float: end;
                width: 140%;
                font-weight: bold;
            }
            .buy-button:hover{
                background: #4a4646;
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
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>

    </body>
</html>
