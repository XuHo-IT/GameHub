<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="org.bson.Document" %>
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
                        <a href="admin-after-login.jsp" class="site-logo">
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

                        <!-- Menu -->
                        <ul class="main-menu primary-menu">
                            <li><a href="ReadGameHomeAdminController?adminId=<%= request.getSession().getAttribute("adminId")%>">Home</a></li>
                            <li><a href="ReadGameListAdminController?adminId=<%= request.getSession().getAttribute("adminId")%>">Games</a>
                            <li><a href="ReadGameHomeAdminController?view=chart&adminId=<%= request.getSession().getAttribute("adminId")%>">Manage</a></li>
                            <li><a href="ReadTopicAdminController?adminId=<%= request.getSession().getAttribute("adminId")%>">Community</a></li>
                        </ul>


                    </nav>
                </div>

            </div>
        </header>

        <!-- Hero section -->
      <!-- Hero Section Start -->
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
<!-- Hero Section End -->

<!-- Team Section Start -->

<!-- Team Section End -->



        <!-- Intro section -->
        <section class="intro-section">
            <div class="container">
                <div class="row">
                    <div class="col-md-4">
                        <div class="intro-text-box text-box text-white">
                            <div class="top-meta">11.11.18 / in <a href="">Games</a></div>
                            <h3>The best online game is out now!</h3>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
                                labore et dolore magna aliqua. Quis ipsum suspendisse ultrices gravida....</p>
                            <a href="#" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#" /></a>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="intro-text-box text-box text-white">
                            <div class="top-meta">11.11.18 / in <a href="">Playstation</a></div>
                            <h3>Top 5 best games in november</h3>
                            <p>Ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore
                                et dolore magna aliqua. Quis ipsum labore suspendisse ultrices gravida....</p>
                            <a href="#" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#" /></a>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="intro-text-box text-box text-white">
                            <div class="top-meta">11.11.18 / in <a href="">Reviews</a></div>
                            <h3>Get this game at a promo price</h3>
                            <p>Sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore
                                magna aliqua. Quis ipsum suspendisse ultrices gravida ncididunt ut labore ....</p>
                            <a href="#" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#" /></a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Intro section end -->


        <!-- Blog section -->
        <section class="blog-section spad">
            <div class="container">
                <div class="row">
                    <div class="col-xl-9 col-lg-8 col-md-7">
                        <div class="user-panel">
                            <button class="create-btn">Add Game Post/ Genre</button>
                        </div>
                        <!-- Blog item -->
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
                                        <div class="top-meta">${post.dateRelease != null ? post.dateRelease : 'Unknown Date'} / 
                                            <a href="#">${post.genre != null ? post.genre : 'Unknown Genre'}</a></div>
                                        <h3>${post.title != null ? post.title : 'Untitled'}</h3>

                                        <!-- Display the description -->
                                        <p>${post.description != null ? post.description : 'No description available'}</p>

                                        <!-- Read more link -->
                                        <a href="game-single-after-login-member.jsp?id=${post.postID}" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#" /></a>

                                        <!-- Edit and Delete Buttons -->
                                        <div class="action-buttons">
                                            <a href="game-single-after-login.jsp?id=${post.postID}&postId=${post.postID}" class="btn btn-warning">Edit</a>


                                            <form action="EditPostController" method="post">
                                                <input type="hidden" name="postId" value="${post.postID}">
                                                <button type="submit" name="action" value="delete" class="btn-danger " style="margin-top: 5px;
                                                        width: 69px;">Delete</button>
                                            </form>
                                        </div>

                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <a href="ReadGameListController" class="more-game-btn">More Game</a>
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
                                <div class="trending-widget">
                                    <div class="tw-item">
                                        <div class="tw-thumb">
                                            <img src="./img/blog-widget/1.jpg" alt="#">
                                        </div>
                                        <div class="tw-text">
                                            <div class="tw-meta">11.11.18 / in <a href="">Games</a></div>
                                            <h5>The best online game is out now!</h5>
                                        </div>
                                    </div>
                                    <div class="tw-item">
                                        <div class="tw-thumb">
                                            <img src="./img/blog-widget/2.jpg" alt="#">
                                        </div>
                                        <div class="tw-text">
                                            <div class="tw-meta">11.11.18 / in <a href="">Games</a></div>
                                            <h5>The best online game is out now!</h5>
                                        </div>
                                    </div>
                                    <div class="tw-item">
                                        <div class="tw-thumb">
                                            <img src="./img/blog-widget/3.jpg" alt="#">
                                        </div>
                                        <div class="tw-text">
                                            <div class="tw-meta">11.11.18 / in <a href="">Games</a></div>
                                            <h5>The best online game is out now!</h5>
                                        </div>
                                    </div>
                                    <div class="tw-item">
                                        <div class="tw-thumb">
                                            <img src="./img/blog-widget/4.jpg" alt="#">
                                        </div>
                                        <div class="tw-text">
                                            <div class="tw-meta">11.11.18 / in <a href="">Games</a></div>
                                            <h5>The best online game is out now!</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="widget-item">
                                <div class="categories-widget">
                                    <h4 class="widget-title">Genre</h4>
                                    <form action="AddGameController" method="post" enctype="multipart/form-data">   
                                        <ul>
                                            <c:forEach var="genre" items="${genres}">
                                                <li><a href="#">${genre.genre != null ? genre.genre : 'No genre available'}</a></li>
                                                </c:forEach>     
                                        </ul>
                                    </form>
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
        <section class="newsletter-section">
            <div class="container">
                <h2>Subscribe to our newsletter</h2>
                <form class="newsletter-form">
                    <input type="text" placeholder="ENTER YOUR E-MAIL">
                    <button class="site-btn">subscribe <img src="img/icons/double-arrow.png" alt="#" /></button>
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
                <a href="ReadGameHomeController" class="footer-logo">
                    <img src="./img/logo1.png" alt="">
                    <img src="./img/logo2.png" alt="">
                </a>
                <ul class="main-menu footer-menu">
                    <li><a href="ReadGameHomeAdminController?adminId=<%= request.getSession().getAttribute("adminId")%>">Home</a></li>
                    <li><a href="ReadGameListAdminController?adminId=<%= request.getSession().getAttribute("adminId")%>">Games</a>
                    <li><a href="ReadGameHomeAdminController?view=chart&adminId=<%= request.getSession().getAttribute("adminId")%>">Manage</a></li>
                    <li><a href="ReadTopicAdminController?adminId=<%= request.getSession().getAttribute("adminId")%>">Community</a></li>
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


        <!-- Create Post Popup -->
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
                    <form action="AddGameController" method="post" enctype="multipart/form-data">
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

            <div class="form-box upload-photo">
                <div class="form-details">
                </div>
                <div class="form-content">
                    <h2 style="margin-bottom: 6px">Upload Genre</h2>
                    <form action="AddGenreController" method="post">
                        <div class="input-field">
                            <label class="mr-2">Genre Of Game:</label>
                            <input type="text" required name="genre1">
                        </div>
                        <button type="submit">Send</button>
                    </form>
                    <div class="bottom-link">
                        <a href="#" id="create-post-link">Add Post Game</a>
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
            const photoOrPost = document.querySelectorAll(".bottom-link a"); // Links to toggle forms

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

// Switch between create post and upload photo forms
            photoOrPost.forEach(link => {
                link.addEventListener("click", (e) => {
                    e.preventDefault();
                    if (link.id === 'upload-photo-link') {
                        formPopup.classList.add("show-upload-photo");
                    } else {
                        formPopup.classList.remove("show-upload-photo");
                    }
                });
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
