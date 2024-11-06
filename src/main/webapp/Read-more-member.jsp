<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="org.bson.Document" %>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Sixtyfour+Convergence&display=swap" rel="stylesheet">
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
    <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">

    <!-- Stylesheets -->
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/font-awesome.min.css"/>
    <link rel="stylesheet" href="css/slicknav.min.css"/>
    <link rel="stylesheet" href="css/owl.carousel.min.css"/>
    <link rel="stylesheet" href="css/magnific-popup.css"/>
    <link rel="stylesheet" href="css/animate.css"/>
    <link rel="stylesheet" href="css/searchbar.css"/>
    <link rel="stylesheet" href="css/account-icon.css" />

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Silkscreen:wght@400;700&display=swap" rel="stylesheet">

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
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Header section -->
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
                    <a href="ReadGameHomeMember?userId=<%= request.getSession().getAttribute("adminId")%>" class="site-logo">
                        <img src="./img/logo1.png" alt="" class="logo1">
                        <img src="./img/logo2.png" alt="" class="logo2">
                    </a>
                </div>
                <nav class="top-nav-area w-100">
                    <div class="user-panel d-flex">
                        <div class="account-container">
                            <div class="user">                                   
                                <img src="data:image/jpeg;base64,<%= request.getSession().getAttribute("photoUrl")%>" alt="Profile Picture" style="width: 50px; height: 50px; border-radius: 50%;" />
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


    <!-- Hero section -->
    <section class="hero-section overflow-hidden">
        <div class="hero-slider owl-carousel">
            <div class="hero-item set-bg d-flex align-items-center justify-content-center text-center" data-setbg="img/slider004.jpg">
                <div class="container">
                    <h2 >game on!</h2>
                    <strong style="font-family: 'Silkscreen', cursive; font-size: 20px; color: rgba(255, 255, 255, 0.7);">
                        Welcome to our gaming news platform, your go-to hub for the latest updates and insights in the gaming world. Whether you're a casual player or a dedicated enthusiast, our site offers features to keep you informed and engaged.<br><br>
                        Discover and share game news, upcoming titles, and industry events in a user-friendly space. Navigate through a mix of user-generated posts and admin-curated updates easily.<br><br>
                        Engage with fellow gamers by posting news, commenting on updates, and participating in discussions. Join our vibrant community and celebrate your passion for games.<br><br>
                        Stay updated and enjoy discovering what's new in the gaming world, Where all in one place!
                    </strong>
                </div>
            </div>
        </div>
    </section>
    <!-- Hero section end-->

    <!-- Newsletter section -->

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
            <a href="ReadGameHome" class="footer-logo">
                <img src="./img/logo1.png" alt="">
                <img src="./img/logo2.png" alt="">
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
    <style>
        a.btn.btn-square.mx-1 {
            padding-right: 35px;
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