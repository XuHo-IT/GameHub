<!DOCTYPE html>
<html lang="zxx">
    <head>
        <title>EndGame - Gaming Magazine Template</title>
        <meta charset="UTF-8">
        <meta name="description" content="EndGam Gaming Magazine Template">
        <meta name="keywords" content="endGam,gGaming, magazine, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Favicon -->
        <link href="./img/favicon.png" rel="icon" />

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&display=swap"
            rel="stylesheet"
            />

        <!-- Bootstrap CSS -->
        <link
            href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
            rel="stylesheet"
            />
        <!-- Icon Font Stylesheet -->
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
            rel="stylesheet"
            />
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
            rel="stylesheet"
            />

        <!-- Libraries Stylesheet -->
        <link href="lib/animate/animate.min.css" rel="stylesheet" />
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet" />
        <link
            href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css"
            rel="stylesheet"
            />
        <link href="css/cssfpt2.css" rel="stylesheet" />

        <!-- Template Stylesheet -->
        <link href="css/cssfpt1.css" rel="stylesheet" />
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

        <!-- Header section -->
        <header class="header-section">
            <div class="header-warp">

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
                        <a href="ReadGameHomeController" class="site-logo">
                            <img src="./img/logo1.png" alt="" class="logo1">
                            <img src="./img/logo2.png" alt="" class="logo2">
                        </a>
                    </div>
                    <nav class="top-nav-area w-100">
                        <div class="user-panel d-flex">
                            <!-- Bi?u t??ng gi? h�ng -->
                            <div class="cart-icon">

                            </div>
                            <!-- Bi?u t??ng t�i kho?n -->
                            <div class="account-container">
                                <div class="account-icon">
                                    <i class="fa fa-user-circle" aria-hidden="true"></i>
                                </div>
                                <div class="account-dropdown">
                                    <ul>
                                        <li><a href="user-profile.jsp">Account Info</a></li>
                                        <li>
                                            <a href="LogOutController" class="dropdown-item">Logout</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- Menu -->
                        <ul class="main-menu primary-menu">
                            <li><a href="ReadGameHomeMemberController?userId=<%= request.getSession().getAttribute("adminId")%>">Home</a></li>
                            <li><a href="ReadGameListMemberController?userId=<%= request.getSession().getAttribute("adminId")%>">Games</a>
                            <li><a href="contact-after-login-member.jsp?userId=<%= request.getSession().getAttribute("adminId")%>">Contact</a></li>
                            <li><a href="ReadTopicMemberController?userId=<%= request.getSession().getAttribute("adminId")%>">Community</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </header>
        <!-- Header section end -->


        <!-- Page top section -->
        <section class="page-top-section set-bg" data-setbg="img/page-top-bg/4.jpg">
            <div class="page-info">
                <h2>Contact</h2>
                <div class="site-breadcrumb">
                    <a href="ReadGameHomeController">Home</a>  /
                    <span>Contact</span>
                </div>
            </div>
        </section>
        <!-- Page top end-->


        <!-- Contact page -->
        <section class="contact-page">
            <div class="container">
                <div class="map">
                    <iframe 
                        src="https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d14376.077865872314!2d108.2583164!3d15.9688859!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sen!2sbd!4v1546528920522" 
                        style="border:0" 
                        allowfullscreen>
                    </iframe>
                </div>                <div class="row">
                    <div class="col-lg-7 order-2 order-lg-1">
                        <form class="contact-form">
                            <input type="text" placeholder="Your name">
                            <input type="text" placeholder="Your e-mail">
                            <input type="text" placeholder="Subject">
                            <textarea placeholder="Message"></textarea>
                            <button class="site-btn">Send message<img src="img/icons/double-arrow.png" alt="#"/></button>
                        </form>
                    </div>
                    <div class="col-lg-5 order-1 order-lg-2 contact-text text-white">
                        <h3>FPT! Say hello</h3>
                        <p>FPT University Da Nang is located in the scenic coastal city of Da Nang, Vietnam. Established in August 2018, the campus blends modern technical architecture with the natural beauty of the region1
                            . It offers a vibrant, green environment conducive to learning, working, and living2
                            . The campus features state-of-the-art facilities, including the Beta Lecture Hall and canteen complexes, designed to support both academic and social activities1
                            .</p>
                        <div class="cont-info">
                            <div class="ci-icon"><img src="img/icons/location.png" alt=""></div>
                            <div class="ci-text"> FPT City, Ngu Hanh Son,Da Nang, Viet Nam</div>
                        </div>
                        <div class="cont-info">
                            <div class="ci-icon"><img src="img/icons/phone.png" alt=""></div>
                            <div class="ci-text">02367300999</div>
                        </div>
                        <div class="cont-info">
                            <div class="ci-icon"><a href="https://daihoc.fpt.edu.vn/"><img src="img/icons/mail.png" alt=""></div>
                                    <div class="ci-text">https://daihoc.fpt.edu.vn/</div>
                            </div>
                        </div>
                    </div>
                </div>
        </section>
        <!-- Contact page end-->


        <div class="container-xxl py-5">
            <div class="container">
                <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                    <h6 class="section-title bg-white text-center text-primary px-3">Founder & Co-Founder</h6>
                    <h1 class="mb-5">Meet Our Founders</h1>
                </div>
                <div class="row g-4">
                    <!-- Team Member 1 -->
                    <div class="col-lg-2 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                        <div class="team-item">
                            <div class="overflow-hidden">
                                <img class="img-fluid" src="img/team-1.jpg" alt="" />
                            </div>
                            <div class="position-relative d-flex justify-content-center" style="margin-top: -19px">
                                <a class="btn btn-square mx-1" href=""><i class="fab fa-facebook-f"></i></a>
                                <a class="btn btn-square mx-1" href="https://github.com/huylongdev" target="_blank" rel="noopener">
                                    <i class="fab fa-github"></i></a>
                            </div>
                            <div class="text-center p-4">
                                <h5 class="mb-0">Nguyen Thanh Tung</h5>
                                <small>FE DEVELOPER</small>
                            </div>
                        </div>
                    </div>
                    <!-- Team Member 2 -->
                    <div class="col-lg-2 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
                        <div class="team-item">
                            <div class="overflow-hidden">
                                <img class="img-fluid" src="img/team-2.jpg" alt="" />
                            </div>
                            <div class="position-relative d-flex justify-content-center" style="margin-top: -19px">
                                <a class="btn btn-square mx-1" href=""><i class="fab fa-facebook-f"></i></a>
                                <a class="btn btn-square mx-1" href="https://github.com/huylongdev" target="_blank" rel="noopener">
                                    <i class="fab fa-github"></i></a>
                            </div>
                            <div class="text-center p-4">
                                <h5 class="mb-0">Ngo Tran Xuan Hoa</h5>
                                <small>BE DEVELOPER</small>
                            </div>
                        </div>
                    </div>
                    <!-- Team Member 3 -->
                    <div class="col-lg-2 col-md-6 wow fadeInUp" data-wow-delay="0.5s">
                        <div class="team-item">
                            <div class="overflow-hidden">
                                <img class="img-fluid" src="img/Card.jpg" alt="" />
                            </div>
                            <div class="position-relative d-flex justify-content-center" style="margin-top: -19px">
                                <a class="btn btn-square mx-1" href=""><i class="fab fa-facebook-f"></i></a>
                                <a class="btn btn-square mx-1" href="https://github.com/huylongdev" target="_blank" rel="noopener">
                                    <i class="fab fa-github"></i></a>
                            </div>
                            <div class="text-center p-4">
                                <h5 class="mb-0">Nguyen Le Dang Thanh</h5>
                                <small>Game Developer</small>
                            </div>
                        </div>
                    </div>
                    <!-- Team Member 4 -->
                    <div class="col-lg-2 col-md-6 wow fadeInUp" data-wow-delay="0.7s">
                        <div class="team-item">
                            <div class="overflow-hidden">
                                <img class="img-fluid" src="img/team-4.jpg" alt="" />
                            </div>
                            <div class="position-relative d-flex justify-content-center" style="margin-top: -19px">
                                <a class="btn btn-square mx-1" href=""><i class="fab fa-facebook-f"></i></a>
                                <a class="btn btn-square mx-1" href="https://github.com/huylongdev" target="_blank" rel="noopener">
                                    <i class="fab fa-github"></i></a>
                            </div>
                            <div class="text-center p-4">
                                <h5 class="mb-0">Tran Nguyen Han</h5>
                                <small>Designation</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-6 wow fadeInUp" data-wow-delay="0.7s">
                        <div class="team-item">
                            <div class="overflow-hidden">
                                <img class="img-fluid" src="img/team-4.jpg" alt="" />
                            </div>
                            <div class="position-relative d-flex justify-content-center" style="margin-top: -19px">
                                <a class="btn btn-square mx-1" href=""><i class="fab fa-facebook-f"></i></a>
                                <a class="btn btn-square mx-1" href="https://github.com/huylongdev" target="_blank" rel="noopener">
                                    <i class="fab fa-github"></i></a>
                            </div>
                            <div class="text-center p-4">
                                <h5 class="mb-0">Nguyen Thanh Tuan</h5>
                                <small>Designation</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-6 wow fadeInUp" data-wow-delay="0.7s">
                        <div class="team-item">
                            <div class="overflow-hidden">
                                <img class="img-fluid" src="img/team-4.jpg" alt="" />
                            </div>
                            <div class="position-relative d-flex justify-content-center" style="margin-top: -19px">
                                <a class="btn btn-square mx-1" href=""><i class="fab fa-facebook-f"></i></a>
                                <a class="btn btn-square mx-1" href="https://github.com/huylongdev" target="_blank" rel="noopener">
                                    <i class="fab fa-github"></i></a>
                            </div>
                            <div class="text-center p-4">
                                <h5 class="mb-0">Nguyen Hoang Duong</h5>
                                <small>Designation</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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
                    <li><a href="forum.jsp">Forum</a></li>
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
        <style>
            a.btn.btn-square.mx-1 {
                padding-right: 35px;
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
