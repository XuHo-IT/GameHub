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
                <a href="home.html" class="site-logo">
                    <img src="./img/logo.png" alt="">
                </a>
                <nav class="top-nav-area w-100">
                    <div class="user-panel d-flex">
                        <!-- Bi?u t??ng gi? hàng -->
                        
                        <!-- Bi?u t??ng tài kho?n -->
                        <div class="account-container">
                            <div class="account-icon">
                                <i class="fa fa-user-circle" aria-hidden="true"></i>
                            </div>
                            <div class="account-dropdown">
                                <ul>
                                    
                                    <li><a href="user-profile.jsp">Account Info</a></li>
                                    

                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- Menu -->
                    <ul class="main-menu primary-menu">
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="games.jsp">Games</a></li>
                        <li>
                            <a class="li-fix" href="blog.jsp">News</a>
                            <ul class="sub-menu">
                                <li><a href="game-single.jsp">Top rating</a></li>
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
                    <div class="section-title text-white">
                        <h2>Latest News</h2>
                    </div>
                    <ul class="blog-filter">
                        <li><a href="#">Racing</a></li>
                        <li><a href="#">Shooters</a></li>
                        <li><a href="#">Strategy</a></li>
                        <li><a href="#">Online</a></li>
                      <div class="user-panel">
						<button class="create-btn">Add Game Post</button>
					</div>


                    </ul>
                    <!-- Blog item -->
                    <div class="blog-item">
                        <div class="blog-thumb">
                            <img src="./img/blog/1.jpg" alt="">
                        </div>
                        <div class="blog-text text-box text-white">
                            <div class="top-meta">11.11.18 / in <a href="">Games</a></div>
                            <h3>The best online game is out now!</h3>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eius-mod tempor
                                incididunt ut labore et dolore magna aliqua. Quis ipsum suspendisse ultrices gravida.
                                Lorem ipsum dolor sit amet, consecte-tur adipiscing elit, sed do eiusmod tempor
                                incididunt ut labore et dolore magna aliqua.....</p>
                            <a href="#" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#" /></a>
                        </div>
                    </div>
                    <!-- Blog item -->
                    <div class="blog-item">
                        <div class="blog-thumb">
                            <img src="./img/blog/2.jpg" alt="">
                        </div>
                        <div class="blog-text text-box text-white">
                            <div class="top-meta">11.11.18 / in <a href="">Games</a></div>
                            <h3>The best online game is out now!</h3>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eius-mod tempor
                                incididunt ut labore et dolore magna aliqua. Quis ipsum suspendisse ultrices gravida.
                                Lorem ipsum dolor sit amet, consecte-tur adipiscing elit, sed do eiusmod tempor
                                incididunt ut labore et dolore magna aliqua.....</p>
                            <a href="#" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#" /></a>
                        </div>
                    </div>
                    <!-- Blog item -->
                    <div class="blog-item">
                        <div class="blog-thumb">
                            <img src="./img/blog/3.jpg" alt="">
                        </div>
                        <div class="blog-text text-box text-white">
                            <div class="top-meta">11.11.18 / in <a href="">Games</a></div>
                            <h3>The best online game is out now!</h3>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eius-mod tempor
                                incididunt ut labore et dolore magna aliqua. Quis ipsum suspendisse ultrices gravida.
                                Lorem ipsum dolor sit amet, consecte-tur adipiscing elit, sed do eiusmod tempor
                                incididunt ut labore et dolore magna aliqua.....</p>
                            <a href="#" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#" /></a>
                        </div>
                    </div>
                </div>
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
                                <h4 class="widget-title">categories</h4>
                                <ul>
                                    <li><a href="">Games</a></li>
                                    <li><a href="">Gaming Tips & Tricks</a></li>
                                    <li><a href="">Online Games</a></li>
                                    <li><a href="">Team Games</a></li>
                                    <li><a href="">Community</a></li>
                                    <li><a href="">Uncategorized</a></li>
                                </ul>
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
    <span class="close-btn material-symbols-rounded" style="top:50px">close</span>
     <div class="form-box create-post">
            <div class="form-details">
                <h2>Create Post Game</h2>
                <p>To develop our community, upload news about game that you know</p>
            </div>
            <div class="form-content">
                <h2 style="margin-bottom: 6px">Create post</h2>
                <form action="AddGameController" method="post" enctype="multipart/form-data">
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

                        <input type="text" required name="Genre">
                    </div>
                    <div class="input-field">
            <label class="mr-2">Picture Of Game:</label>
            <input type="file" name="file">
          </div>
                    <div class="policy-text">
                        <input type="checkbox" id="policy">
                        <label for="policy">
                            I agree the
                            <a href="#" class="option">Terms & Conditions</a>
                        </label>
                    </div>
                    <button type="submit">Send</button>
                </form>
            
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
const hidePopupBtn = formPopup.querySelector(".close-btn");
const showAddPostBtn = document.querySelector(".create-btn"); // Select the "Create Post" button

// Show "Create Post" form
showAddPostBtn.addEventListener("click", () => {
    document.body.classList.toggle("show-popup");
    // Optionally, show the 'create_post' form section
    formPopup.classList.add("show-create-post"); // Add a specific class to show the create post form
});
// Hide login popup
hidePopupBtn.addEventListener("click", () => {
    document.body.classList.remove("show-popup");
});





    </script>

</body>

</html>