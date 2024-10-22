<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="org.bson.Document" %>
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
                    <div class="user-panel">
                        <button class="login-btn">LOG IN</button>
                    </div>

                    <!-- Menu -->
                    <ul class="main-menu primary-menu">
                        <li><a href="ReadGameHomeController">Home</a></li>
                        <li><a href="ReadGameListController">Games</a>
                        </li>
                        <li><a href="contact.jsp">Contact</a></li>
                        <li><a href="ReadTopicController">Community</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </header>
    <!-- Header section end -->


    <!-- Hero section -->
    <section class="hero-section overflow-hidden">
        <div class="hero-slider owl-carousel">
            <div class="hero-item set-bg d-flex align-items-center justify-content-center text-center" data-setbg="img/slider1.jpg">
                <div class="container">
                    <h2>Game on!</h2>
                    <p>The platform serves as a hub for sharing the latest game news, offering users a space to stay updated on upcoming releases and industry developments.<br> It allows users to view, comment, and engage in discussions about the latest news, fostering an active gaming community. With an intuitive interface, the platform enables easy access to user-generated posts and admin-curated updates.</p>
                    <a href="#" class="site-btn">Read More  <img src="img/icons/double-arrow.png" alt="#"/></a>
                </div>
            </div>
            <div class="hero-item set-bg d-flex align-items-center justify-content-center text-center" data-setbg="img/slider-bg-2.jpg">
                <div class="container">
                    <h2>Game on!</h2>
                    <p>The platform provides a centralized space for discovering and sharing game news, keeping users informed about upcoming titles and events.<br>Users can contribute by posting news, commenting on updates, and participating in forum discussions. The site promotes community interaction around gaming trends and developments.</p>
                    <a href="#" class="site-btn">Read More  <img src="img/icons/double-arrow.png" alt="#"/></a>
                </div>
            </div>
        </div>
    </section>
    <!-- Hero section end-->





    <!-- Blog section -->
    <section class="blog-section spad">
        <div class="container">
            <div class="row">
                <div class="col-xl-9 col-lg-8 col-md-7">
                    <div class="section-title text-white">
                        <h2>Latest News</h2>
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
                                    <div class="top-meta">${post.dateRelease != null ? post.dateRelease : 'Unknown Date'} / <a href="#">${post.genre != null ? post.genre : 'Unknown Genre'}</a></div>
                                    <h3>${post.title != null ? post.title : 'Untitled'}</h3>

                                    <!-- Display the description -->
                                    <p>${post.description != null ? post.description : 'No description available'}</p>

                                    <!-- Read more link -->
                                    <a href="game-single.jsp?id=${post.postID}" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#" /></a>
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
                            <a href="#" class="add">
                                <img src="./img/Game_Interactive.jpg" alt="">
                            </a>
                        </div>

                        <div class="widget-item">
                            <div class="categories-widget">
                                <h4 class="widget-title">Genre</h4>
                                <form action="ReadGameHomeController" method="get">   
                                    <ul>
                                        <c:forEach var="genre" items="${genres}">
                                            <li>
                                                <a href="ReadGameHomeController?genre=${genre.genre}">
                                                    ${genre.genre != null ? genre.genre : 'No genre available'}
                                                </a>
                                            </li>
                                        </c:forEach>     
                                    </ul>
                                </form>
                            </div>
                        </div>
                        <div class="site-pagination">
                            <c:if test="${currentPage > 1}">
                                <a href="?genre=${selectedGenre}&page=${currentPage - 1}" class="prev">Previous</a>
                            </c:if>

                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <a href="?genre=${selectedGenre}&page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <a href="?genre=${selectedGenre}&page=${currentPage + 1}" class="next">Next</a>
                            </c:if>
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
        <a href="https://www.youtube.com/watch?v=plUn_L8gAno" class="video-play-btn video-popup"><img src="img/icons/solid-right-arrow.png" alt="#"></a>
        <div class="container">
            <div class="video-text">
                <h2>Promo video of the game</h2>
                <p>Watch our exciting promotional video showcasing the latest features and gameplay of our highly anticipated game. 
                    Dive into a thrilling world filled with immersive graphics, intense action, and engaging storylines. </p>
            </div>
        </div>
    </section>
    <!-- Intro section end -->


    <!-- Featured section -->
    <section class="featured-section">
        <c:forEach var="post" items="${posts}" varStatus="status">
            <c:if test="${status.index == 0}">
                <!-- Featured background image -->
                <div class="featured-bg set-bg col-6 d-flex justify-content-center align-items-center" style="width: calc(50% - 40px); height: 100%;">
                    <img src="data:image/png;base64,${post.fileData}" alt="Game Image" style="max-width: 100%; max-height: 100%; object-fit: contain;" />
                </div>

                <!-- Featured content box -->
                <div class="featured-box col-6">
                    <div class="text-box">
                        <!-- Display post date and category dynamically -->
                        <div class="top-meta">${post.dateRelease} / in <a href="#">${post.genre}</a></div>

                        <h3>Newest game release is coming up!</h3>

                        <!-- Post title -->
                        <p style="font-size: 40px">${post.title}</p>

                        <!-- Post content (short summary) -->
                        <p>${post.description}</p>

                        <!-- Read more link -->
                        <a href="game-single.jsp?id=${post.postID}" class="read-more">Read More  
                            <img src="img/icons/double-arrow.png" alt="#"/>
                        </a>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </section>

    <!-- Featured section end-->



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
                <form action="LoginController" method="post">
                    <c:if test="${not empty errorMessage}">
                        <div class="error">${errorMessage}</div>
                    </c:if>

                    <div class="input-field">
                        <label>Email</label>

                        <input type="text" required name="email">
                    </div>
                    <div class="input-field">
                        <label>Password</label>

                        <input type="password" required name="password">
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
                <form id="signupForm" action="SignUpValidation" method="post">
                    <div class="input-field">
                        <label>Enter your name</label>
                        <input type="text" name="Name" id="name" required>
                        <div class="error-message" id="nameError"></div>
                    </div>
                    <div class="input-field">
                        <label>Enter your email</label>
                        <input type="email" name="Email" id="email" required>
                        <div class="error-message" id="emailError"></div>
                    </div>
                    <div class="input-field">
                        <label>Phone number</label>
                        <input type="number" name="Phone" id="phone" required>
                        <div class="error-message" id="phoneError"></div>
                    </div>
                    <div class="input-field">
                        <label>Date of birth</label>
                        <input type="date" name="Dob" id="dob" required>
                        <div class="error-message" id="dobError"></div>
                    </div>
                    <div class="input-field">
                        <label>Address</label>
                        <input type="text" name="Address" id="address" required>
                        <div class="error-message" id="addressError"></div>
                    </div>
                    <div class="input-field">
                        <label>Password</label>
                        <input type="password" name="Password" id="password" required>
                        <div class="error-message" id="passwordError"></div>
                    </div>
                    <div class="policy-text">
                        <input type="checkbox" id="policy" name="policy">
                        <label for="policy">I agree to the
                            <a href="#" class="option">Terms & Conditions</a>
                        </label>
                        <div class="error-message" id="policyError"></div>
                    </div>
                    <button type="submit">Sign Up</button>
                </form>
                <div class="bottom-link">
                    Already have an account? <a href="#" id="login-link">Login</a>
                </div>
            </div>
        </div>
        <script>
       document.addEventListener("DOMContentLoaded", function() {
           // Get all form fields
           const nameField = document.getElementById('name');
           const emailField = document.getElementById('email');
           const phoneField = document.getElementById('phone');
           const dobField = document.getElementById('dob');
           const addressField = document.getElementById('address');
           const passwordField = document.getElementById('password');
           const policyCheckbox = document.getElementById('policy');
            
           // Real-time validation for each field
           nameField.addEventListener('input', validateName);
           emailField.addEventListener('input', validateEmail);
           phoneField.addEventListener('input', validatePhone);
           dobField.addEventListener('input', validateDOB);
           addressField.addEventListener('input', validateAddress);
           passwordField.addEventListener('input', validatePassword);
           policyCheckbox.addEventListener('change', validatePolicy);

           // Validation functions
           function validateName() {
               const name = nameField.value.trim();
               const nameError = document.getElementById('nameError');
               if (name.length < 3) {
                   nameError.textContent = 'Name must be at least 3 characters long.';
               } else {
                   nameError.textContent = '';
               }
           }

           function validateEmail() {
               const email = emailField.value.trim();
               const emailError = document.getElementById('emailError');
               const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
               if (!emailPattern.test(email)) {
                   emailError.textContent = 'Please enter a valid email address.';
               } else {
                   emailError.textContent = '';
               }
           }

           function validatePhone() {
               const phone = phoneField.value.trim();
               const phoneError = document.getElementById('phoneError');
               if (phone.length !== 10 || !/^\d+$/.test(phone)) {
                   phoneError.textContent = 'Phone number must be 10 digits long.';
               } else {
                   phoneError.textContent = '';
               }
           }

           function validateDOB() {
               const dob = dobField.value.trim();
               const dobError = document.getElementById('dobError');
               const date = new Date(dob);
               const today = new Date();
               const age = today.getFullYear() - date.getFullYear();
               if (age < 18) {
                   dobError.textContent = 'You must be at least 18 years old.';
               } else {
                   dobError.textContent = '';
               }
           }

           function validateAddress() {
               const address = addressField.value.trim();
               const addressError = document.getElementById('addressError');
               if (address.length < 5) {
                   addressError.textContent = 'Address must be at least 5 characters long.';
               } else {
                   addressError.textContent = '';
               }
           }

           function validatePassword() {
               const password = passwordField.value.trim();
               const passwordError = document.getElementById('passwordError');
               if (password.length < 6) {
                   passwordError.textContent = 'Password must be at least 6 characters long.';
               } else {
                   passwordError.textContent = '';
               }
           }

           function validatePolicy() {
               const policyError = document.getElementById('policyError');
               if (!policyCheckbox.checked) {
                   policyError.textContent = 'You must agree to the terms and conditions.';
               } else {
                   policyError.textContent = '';
               }
           }

           // Final validation before form submission (if necessary)
           const signupForm = document.getElementById('signupForm');
           signupForm.addEventListener('submit', function(event) {
               validateName();
               validateEmail();
               validatePhone();
               validateDOB();
               validateAddress();
               validatePassword();
               validatePolicy();

               // Prevent form submission if there are errors
               if (document.querySelectorAll('.error-message:empty').length !== 7) {
                   event.preventDefault();
               }
           });
       });
        </script>
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
        $(document).ready(function () {
            $(".carousel").owlCarousel({
                items: 5, // Number of items to show
                loop: true, // Infinite looping
                margin: 10, // Margin between items
                nav: true, // Show next/prev navigation buttons
                dots: true, // Show pagination dots
                autoplay: true, // Auto sliding
                autoplayTimeout: 3000, // Slide every 3 seconds
                responsive: {// Responsive settings
                    0: {
                        items: 1
                    },
                    600: {
                        items: 3
                    },
                    1000: {
                        items: 5
                    }
                }
            });
        });
    </script>
    <style>
        h3.bottom-title {
            color: white;
            font-size: 35px;
            font-family: 'Material Symbols Rounded';
            padding: 0 0px 30px 0;
        }
    </style>

</body>
</html>
