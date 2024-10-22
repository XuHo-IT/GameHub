<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="org.bson.Document" %>
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
                        <a href="after-login.html" class="site-logo">
                            <img src="./img/logo1.png" alt="" class="logo1">
                            <img src="./img/logo2.png" alt="" class="logo2">
                        </a>
                    </div>
                    <nav class="top-nav-area w-100">
                        <div class="user-panel d-flex">
                            <!-- Bi?u t??ng gi? h�ng -->
                           
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


        <!-- Hero section -->
        <section class="hero-section overflow-hidden">
            <div class="hero-slider owl-carousel">
                <div class="hero-item set-bg d-flex align-items-center justify-content-center text-center"
                     data-setbg="img/slider-bg-1.jpg">
                    <div class="container">
                        <h2>Game on!</h2>
                        <p>Fusce erat dui, venenatis et erat in, vulputate dignissim lacus. Donec vitae tempus dolor,<br>sit
                            amet elementum lorem. Ut cursus tempor turpis.</p>
                        <a href="#" class="site-btn">Read More <img src="img/icons/double-arrow.png" alt="#" /></a>
                    </div>
                </div>
                <div class="hero-item set-bg d-flex align-items-center justify-content-center text-center"
                     data-setbg="img/slider-bg-2.jpg">
                    <div class="container">
                        <h2>Game on!</h2>
                        <p>Fusce erat dui, venenatis et erat in, vulputate dignissim lacus. Donec vitae tempus dolor,<br>sit
                            amet elementum lorem. Ut cursus tempor turpis.</p>
                        <a href="#" class="site-btn">Read More <img src="img/icons/double-arrow.png" alt="#" /></a>
                    </div>
                </div>
            </div>
        </section>
        <!-- Hero section end-->



        <!-- Service Start -->
        <div class="container-xxl py-5">
            <div class="container">
                <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                    <h6 class="section-title bg-white text-center text-primary px-3">Services</h6>
                    <h1 class="mb-5 text-primary">Our Services</h1>
                </div>
                <div class="row g-4">
                    <div class="col-lg-3 col-sm-6 wow fadeInUp icon-hover-service" data-wow-delay="0.1s">
                        <a href="room.jsp" class="nav-item nav-link">
                            <div class="service-item rounded pt-3">
                                <div class="p-4">
                                    <i class="fa fa-3x fa-globe text-primary mb-4"></i>
                                    <h5>Booking rooms</h5>
                                    <p>Available.</p>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="col-lg-3 col-sm-6 wow fadeInUp icon-hover-service" data-wow-delay="0.3s">
                        <a href="404.html" class="nav-item nav-link">
                            <div class="service-item rounded pt-3">
                                <div class="p-4">
                                    <i class="fa fa-3x fa-hotel text-primary mb-4"></i>
                                    <h5>Booking villa</h5>
                                    <p>Still update</p>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="col-lg-3 col-sm-6 wow fadeInUp icon-hover-service" data-wow-delay="0.5s">
                        <a href="404.html" class="nav-item nav-link">
                            <div class="service-item rounded pt-3">
                                <div class="p-4">
                                    <i class="fa fa-3x fa-user text-primary mb-4"></i>
                                    <h5>Travel Guides</h5>
                                    <p>Still update</p>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="col-lg-3 col-sm-6 wow fadeInUp icon-hover-service" data-wow-delay="0.7s">
                        <a href="404.html" class="nav-item nav-link">
                            <div class="service-item rounded pt-3">
                                <div class="p-4">
                                    <i class="fa fa-3x fa-cog text-primary mb-4"></i>
                                    <h5>Other booking</h5>
                                    <p>Still update</p>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>


        <!-- Service End -->


        <!-- Blog section -->
        <section class="blog-section spad">
            <div class="container">
                <div class="row">
                    <div class="col-xl-9 col-lg-8 col-md-7">
                        <div class="user-panel">
                            <button class="create-btn">Add Game Post</button>
                        </div>
                        <!-- Blog item -->
                        <%
                            String adminId = request.getParameter("id");  // Get AdminId from session
                        %>                        
                        <div class="blog-container">
                            <c:forEach var="post" items="${posts}">
                                <div class="blog-item">
                                    <!-- Display the post title -->

                                    <div class="blog-thumb">
                                        <!-- Display the image (if available), or a default image if missing -->
                                        <img src="data:image/png;base64,${post.fileData}" alt="Game Image" />
                                    </div>

                                    <div class="blog-text text-box text-white">
                                        <!-- Display the release date and genre -->
                                        <div class="top-meta">${post.dateRelease != null ? post.dateRelease : 'Unknown Date'} / <a href="#">${post.genre != null ? post.genre : 'Unknown Genre'}</a></div>
                                        <h3>${post.title != null ? post.title : 'Untitled'}</h3>

                                        <!-- Display the description -->
                                        <p>${post.description != null ? post.description : 'No description available'}</p>

                                        <!-- Read more link -->
                                        <a href="game-single-after-login-member.jsp?id=${post.postID}&adminId=<%= adminId%>" class="read-more">
                                            Read More <img src="img/icons/double-arrow.png" alt="#" />
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <a href="ReadGameListController" class=" more-game-btn"> More Game </a>
                    </div>

                    <style>
                        .more-game-btn{
                            margin-top: 50px;
                            padding-right: 90px;
                            font-size: 30px;
                            text-transform: uppercase;
                            font-weight: 700;
                            font-style: italic;
                            color: #fff;
                            display: inline-block;
                            -webkit-transition: all 0.2s;
                            -o-transition: all 0.2s;
                            transition: all 0.2s;
                            background-image: url("img/icons/more-arrow.png");
                            background-size: 250px;
                            background-repeat: no-repeat;
                            background-position: right -350% center;
                        }

                        .more-game-btn:hover{
                            color: #b01ba5;
                            background-position: right center;
                        }
                    </style>

                    <div class="col-xl-3 col-lg-4 col-md-5 sidebar">
                        <div id="stickySidebar">
                            <div class="widget-item">
                                <h4 class="widget-title">Trending</h4>
                            </div>
                        </div>
                        <div class="widget-item">
                            <div class="widget-item">
                                <div class="categories-widget">
                                    <h4 class="widget-title">Genre</h4>
                                    <form action="ReadGameHomeMemberController" method="get">   
                                        <ul>
                                            <c:forEach var="genre" items="${genres}">
                                                <li>
                                                    <a href="ReadGameHomeMemberController?genre=${genre.genreId}">
                                                        ${genre.genre != null ? genre.genre : 'No genre available'}
                                                    </a>
                                                </li>
                                            </c:forEach>     
                                        </ul>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="widget-item">
                            <a href="#" class="add">
                                <img src="./img/add.jpg" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Blog section end -->


    <!-- Intro section -->
    <section class="intro-video-section set-bg d-flex align-items-end " data-setbg="./img/promo-bg.jpg">
        <a href="https://www.youtube.com/watch?v=uFsGy5x_fyQ" class="video-play-btn video-popup"><img
                src="img/icons/solid-right-arrow.png" alt="#"></a>
        <div class="container">
            <div class="video-text">
                <h2>Promo video of the game</h2>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.</p>
            </div>
        </div>
    </section>
    <!-- Intro section end -->


    <!-- Featured section -->
    <section class="featured-section">
        <div class="featured-bg set-bg" data-setbg="img/featured-bg.jpg"></div>
        <div class="featured-box">
            <div class="text-box">
                <div class="top-meta">11.11.18 / in <a href="">Games</a></div>
                <h3>The game you?ve been waiting for is out now</h3>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore
                    et dolore magna aliqua. Quis ipsum suspendisse ultrices gravida. Ipsum dolor sit amet, consectetur
                    adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliquamet, consectetur
                    adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vestibulum
                    posuere porttitor justo id pellentesque. Proin id lacus feugiat, posuere erat sit amet, commodo
                    ipsum. Donec pellentesque vestibulum metus...</p>
                <a href="#" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#" /></a>
            </div>
        </div>
    </section>
    <!-- Featured section end-->



    <!-- Newsletter section -->
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
            <a href="after-login.jsp" class="footer-logo">
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

    <!-- Create Post Popup -->
    <div class="blur-bg-overlay"></div>
    <div class="form-popup create-post-popup">
        <span class="close-btn material-symbols-rounded" style="top:50px">close</span>

        <div class="form-box create-post">
            <div class="form-details">
                <h2>Create Post Game</h2>
                <p>To develop our community, upload news about games that you know</p>
            </div>
            <div class="form-content">
                <h2 style="margin-bottom: 6px">Create post</h2>
                <form action="AddGameByMemberController" method="post" enctype="multipart/form-data">
                    <!-- Form fields for creating post -->
                    <div class="input-field">
                        <label>Title</label>
                        <input type="text" required name="Title">
                    </div>
                    <div class="input-field">
                        <label>Game Play</label>
                        <input type="text" required name="Gameplay">
                    </div>
                    <div class="input-field">
                        <label>Description</label>
                        <input type="text" required name="Description">
                    </div>
                    <div class="input-field">
                        <label>Date Release</label>
                        <input type="date" required name="DateRelease">
                    </div>
                    <div class="input-field">
                        <label for="exampleFormControlSelect1">Status</label>
                        <select class="form-control" id="exampleFormControlSelect1" name="Status" required="required">
                            <option>Pre-Release</option>
                            <option>Released</option>
                        </select>
                    </div>
                    <div class="input-field">
                        <label>Author</label>
                        <input type="text" required name="Author">
                    </div>
                    <div class="input-field">
                        <label>Genre</label>
                        <select name="Genre" required>
                            <option value="">Select Genre</option>
                            <c:forEach var="genre" items="${genres}">
                                <option value="${genre.genre}">${genre.genre != null ? genre.genre : 'No genre available'}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="input-field">
                        <label class="mr-2">Picture Of Game:</label>
                        <input type="file" name="file">
                    </div>
                    <div class="policy-text">
                        <input type="checkbox" id="policy">
                        <label for="policy">I agree to the
                            <a href="#" class="option">Terms & Conditions</a>
                        </label>
                    </div>
                    <button type="submit">Send</button>
                </form>
                <div class="bottom-link">
                    Want to upload a genre?
                    <a href="#" id="upload-photo-link">Upload Genre</a>
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
    <script>

        const formPopup = document.querySelector(".form-popup");
        const showPopupBtn = document.querySelector(".create-btn"); // Button to open create post form
        const hidePopupBtn = formPopup.querySelectorAll(".close-btn"); // Close buttons for both forms

        // Show create post popup
        showPopupBtn?.addEventListener("click", () => {
            document.body.classList.add("show-popup");
        });

        // Hide both popups when close button is clicked
        hidePopupBtn.forEach(btn => {
            btn.addEventListener("click", () => {
                document.body.classList.remove("show-popup");
            });
        });
    </script>
    <script>
        document.getElementById('postForm').addEventListener('submit', function (event) {
            event.preventDefault();  // Prevent the form from submitting right away

            // Retrieve form data
            const formData = new FormData(this);

            // Log form data to the console for checking
            for (const [name, value] of formData.entries()) {
                console.log(name + ': ' + value);
            }

            // If needed, you can submit the form after logging the data
            // this.submit();
        });
    </script>

    <style>
        .form-popup .upload-photo,
        .form-popup .create-post {
            display: none;
        }

        /* Show upload-photo form and hide create-post form */
        .form-popup.show-upload-photo .upload-photo {
            display: flex;
        }

        .form-popup.show-upload-photo .create-post {
            display: none;
        }

        /* Show create-post form by default */
        .form-popup .create-post {
            display: flex;
        }
        form button {
            width: 100%;
            color: #fff;
            border: none;
            outline: none;
            padding: 10px 0;
            font-size: 1rem;
            font-weight: 500;
            border-radius: 3px;
            cursor: pointer;
            margin: 25px 0;
            background: #6f2b95;
            transition: 0.2s ease;
            margin-top: 0px;
            margin-bottom: 5px;
        }
        .right-position {
            padding-top: 81px;
            padding-right: 10px;
        }
        .upload-photo .form-details {
            padding: 0 20px;
            background: url("img/mortal-combat.jpg");
            background-position: center;
            background-size: cover;
        }
    </style>
</body>

</html>