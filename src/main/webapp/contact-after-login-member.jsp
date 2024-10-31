<%@page import="Model.UserModel"%>
<%@page import="DAO.UserDAO"%>
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
                                <%
                                    UserDAO userDAO = new UserDAO();
                                    UserModel user = userDAO.getUserById((String) request.getSession().getAttribute("adminId"));
                                    request.setAttribute("user", user);
                                %>
                                <div class="user">                                   
                                    <img src="data:image/jpeg;base64,<%= user != null ? user.getPhotoUrl() : ""%>" alt="Profile Picture" style="width: 50px; height: 50px; border-radius: 50%;" />
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
        <section class="page-top-section set-bg" data-setbg="img/page-top-bg/4.jpg">
            <div class="page-info">
                <h2>Contact</h2>
                <div class="site-breadcrumb">
                    <a href="ReadGameHome">Home</a>  /
                    <span>Contact</span>
                </div>
            </div>
        </section>
        <!-- Page top end-->


        <!-- Contact page -->
        <section class="contact-page">
            <div class="container">
                <div class="map"><iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3835.856069317691!2d108.25831101151101!3d15.968891042050895!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3142116949840599%3A0x365b35580f52e8d5!2zxJDhuqFpIGjhu41jIEZQVCDEkMOgIE7hurVuZw!5e0!3m2!1svi!2s!4v1729673804832!5m2!1svi!2s" style="border:0" allowfullscreen></iframe></div>
                <div class="row">
                    <div class="col-lg-7 order-2 order-lg-1">
                        <video class="contact-video" controls width="100%">
                            <source src="img/fpt.mp4" type="video/mp4">
                            Your browser does not support the video tag.
                        </video>
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
                            <div class="ci-icon">
                                <img src="img/icons/mail.png" alt="">
                            </div>
                            <div class="ci-text1" onclick="window.location.href = 'https://daihoc.fpt.edu.vn/'">https://daihoc.fpt.edu.vn/</div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Contact page end-->

        <!-- Newsletter section -->
        <section class="newsletter-section">
            <div class="container">
                <h2>Subscribe to our newsletter</h2>
                <form class="newsletter-form" onsubmit="return subscribeNewsletter(event)">
                    <input type="email" placeholder="ENTER YOUR E-MAIL" required>
                    <button type="submit" class="site-btn">subscribe <img src="img/icons/double-arrow.png" alt="#"/></button>
                </form>
                <p id="thank-you-message" style="display:none; color: green; font-weight: bold; margin-top: 10px;">
                    Thank you for subscribing! We will notify when our web have updates
                </p>
            </div>
        </section>
        <!-- Newsletter section end -->


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
        
        <!-- Newsletter section -->
        <section class="newsletter-section" style="background-image: url('img/Gif2.gif'); background-size: cover; background-position: center; height: 80vh; position: relative; color: white; display: flex; align-items: center; justify-content: center;">
            <div class="container" style="position: relative; z-index: 1; text-align: center;">
                <h3 class="bottom-title">Thanks for using our website!</h3>
            </div>
        </section>
        <style>
            .bottom-title {
                font-family: 'Sixtyfour Convergence', sans-serif;
                font-size: 45px;
            }

            .newsletter-section {
                /* Optional: Add any other styles you want */
            }
        </style>
        
        <!-- Footer section -->
        <footer class="footer-section">
            <div class="container">
                <div class="footer-left-pic">
                    <img class="img_bottom_1" src="./img/bottom_pic_1.png" alt="">
                </div>
                <div class="footer-right-pic">
                    <img class="img_bottom_2" src="./img//bottom_pic_2.png" alt="">
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
            img.img_bottom_1,img.img_bottom_2  {
                width: 50%;
            }
            .ci-text1 {
                color: White; /* Initial color */
                cursor: pointer;
                text-decoration: underline; /* Optional: makes it look more like a link */
            }

            .ci-text1:hover {
                color: darkorange; /* Change color on hover */
            }
            i.fab.fa-facebook-f,i.fab.fa-github {
                margin-left: -5px;
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
        </style>
        <script>
            function subscribeNewsletter(event) {
                event.preventDefault(); // Prevent form from submitting traditionally
                document.getElementById('thank-you-message').style.display = 'block'; // Show the thank-you message

                // Optionally, clear the input field
                document.querySelector('.newsletter-form input').value = '';
            }
        </script>
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
