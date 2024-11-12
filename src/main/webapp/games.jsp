<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="org.bson.Document" %>
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
                        <form action="Search" method="GET">
                            <!-- Search Bar Row -->
                            <div class="row" style="align-items: center;">
                                <!-- Search button on the left side -->
                                <div class="col-2 d-flex align-items-end">
                                    <button type="submit" class="w-100" style="height: 52px;">Search</button>
                                </div>

                                <!-- Keyword input for the search bar -->
                                <div class="col-6" style="padding-top: 15px; margin-bottom: 14px;">
                                    <input type="text" name="keyword" class="form-control" placeholder="Search by keyword..." aria-label="Search" style="height: 52px;">
                                </div>

                                <!-- Genre dropdown next to search input -->
                                <div class="col-4" style="padding-top: 15px; margin-bottom: 14px;">
                                    <select id="genre" name="genre" class="form-select" style="height: 52px; border: 2px solid #ccc; font-style: italic; padding: 5px; border-radius: 5px; font-family: 'Arial', sans-serif;">
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
                        <a href="ReadGameHome" class="site-logo">
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
                            <li><a href="ReadGameHome">Home</a></li>
                            <li><a href="ReadGameList">Games</a></li>
                            <li><a href="ReadTopic">Forum</a></li>
                            <li><a href="contact.jsp">Contact</a></li>

                        </ul>
                    </nav>
                </div>
            </div>
        </header>
        <!-- Header section end -->

        <!-- Page top section -->
        <section class="page-top-section set-bg" data-setbg="img/page-top-bg/1.jpg">
            <div class="page-info" style="padding-top: 30px">
                <h2>Games</h2>
                <div class="site-breadcrumb">
                    <a href="">Home</a>  /
                    <span>Games</span>
                </div>
            </div>
        </section>
        <!-- Page top end-->

        <!-- Games section -->
        <section class="games-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-xl-9 col-lg-8 col-md-7">
                        <div class="row">
                            <c:forEach var="post" items="${posts}">
                                <div class="col-lg-4 col-md-6">
                                    <div class="game-item" style="margin-bottom: 15px; height: 80%;">
                                        <img src="data:image/png;base64,${post.fileData}" class="same-size" alt="Game Image" />
                                        <h5>${post.title != null ? post.title : 'Untitled'}</h5>
                                        <a href="game-single.jsp?id=${post.postID}" class="read-more">Read More  <img src="img/icons/double-arrow.png" alt="#"/></a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                    </div>
                    <div class="col-xl-3 col-lg-4 col-md-5 sidebar game-page-sideber">                       
                        <div class="widget-item">
                            <img src="img/zed.gif" alt="#">
                        </div>
                        <div class="widget-item">
                            <div class="categories-widget">
                                <h4 class="widget-title">Genre</h4>
                                <form action="ReadGameList" method="get">   
                                    <ul>
                                        <c:forEach var="genre" items="${genres}">
                                            <li>
                                                <a href="ReadGameList?genre=${genre.genre}">
                                                    ${genre.genre != null ? genre.genre : 'No genre available'}
                                                </a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </form>
                            </div>
                        </div>
                        <div class="widget-item">
                            <img src="img/ironMan.gif" alt="#">
                        </div>                       
                    </div>
                    <div class="site-pagination">
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <a href="?genre=${selectedGenre}&page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                        </c:forEach>
                    </div>

                </div>
            </div>
        </section>
        <!-- Games end-->

        <!-- Featured section -->
        <section class="featured-section">
            <c:forEach var="post" items="${posts}" varStatus="status">
                <c:if test="${status.index == 0}">
                    <!-- Featured background image -->
                    <div class="featured-bg set-bg col-6 d-flex justify-content-center align-items-center" style="width: calc(50% - 40px); height: 100%; ">
                        <img class="img_newest" src="data:image/png;base64,${post.fileData}" alt="Game Image" style="max-width: 100%; max-height: 100%; object-fit: contain;" />
                    </div>

                    <!-- Featured content box -->
                    <div class="featured-box col-6" >
                        <div class="text-box" >
                            <!-- Display post date and category dynamically -->
                            <div class="top-meta">${post.dateRelease} / in <a href="ReadGameList?genre=${post.genre}">${post.genre != null ? post.genre : 'Unknown Genre'}</a></div>

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
                <a href="ReadGameHome" class="footer-logo">
                    <img src="./img/logo1.png" alt="">
                    <img src="./img/logo2.png" alt="">
                </a>
                <ul class="main-menu footer-menu">
                    <li><a href="ReadGameHome">Home</a></li>
                    <li><a href="ReadGameList">Games</a></li>
                    <li><a href="ReadTopic">Forum</a></li>
                    <li><a href="contact.jsp">Contact</a></li>
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


        <!-- Popup Container -->
        <div class="blur-bg-overlay"></div>
        <div class="form-popup">
            <span class="close-btn material-symbols-rounded">close</span>

            <!-- Login Form -->
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
                    <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:8080/Web_Trading_Game/GoogleLogin&response_type=code&client_id=1057176700449-vfic30arnmput3sb11tug6d2m28o0m29.apps.googleusercontent.com&approval_prompt=force" class="btn btn-lg btn-danger">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-google" viewBox="0 0 16 16">
                        <path d="M15.545 6.558a9.42 9.42 0 0 1 .139 1.626c0 2.434-.87 4.492-2.384 5.885h.002C11.978 15.292 10.158 16 8 16A8 8 0 1 1 8 0a7.689 7.689 0 0 1 5.352 2.082l-2.284 2.284A4.347 4.347 0 0 0 8 3.166c-2.087 0-3.86 1.408-4.492 3.304a4.792 4.792 0 0 0 0 3.063h.003c.635 1.893 2.405 3.301 4.492 3.301 1.078 0 2.004-.276 2.722-.764h-.003a3.702 3.702 0 0 0 1.599-2.431H8v-3.08h7.545z" />
                        </svg>
                        <span class="ms-2 fs-6">Sign in with Google</span>
                    </a>
                    <div class="bottom-link">
                        Don't have an account?
                        <a href="#" id="signup-link">Signup</a>
                    </div>
                </div>
            </div>

            <!-- Signup Form -->
            <div class="form-box signup" style="display: none;">
                <div class="form-details">
                    <h2>Create Account</h2>
                    <p>To become a part of our community, please sign up using your personal information.</p>
                    <p id="formWarning" style="display: none;">This form will be larger if you do not enter the required value correctly.</p>
                </div>
                <div class="form-content">
                    <h2>SIGNUP</h2>
                    <form id="signupForm" action="SignUp" method="post">
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
                            <div>
                                <input type="checkbox" id="policy" name="policy">
                                <label for="policy">I agree to the
                                    <a href="#" class="option">Terms & Conditions</a>
                                </label>
                            </div>
                            <div class="error-message" id="policyError"></div>
                        </div>
                        <button type="submit">Sign Up</button>
                    </form>
                    <div class="bottom-link">
                        Already have an account? <a href="#" id="login-link">Login</a>
                    </div>
                </div>
            </div>

            <!-- Forgot Password Form -->
            <div class="form-box forgot-password" style="display: none;">
                <div class="form-details">
                    <h2>Forgot Password</h2>
                    <p>Please enter your registered email address to reset your password.</p>
                </div>
                <div class="form-content">
                    <form id="forgotPasswordForm" action="ForgotPasswordController" method="post">
                        <div class="input-field">
                            <label>Enter your email</label>
                            <input type="email" name="emailForgot" id="forgotEmail" required>
                            <div class="error-message" id="forgotEmailError"></div>
                        </div>
                        <button type="submit">Submit</button>
                    </form>
                    <div class="bottom-link">
                        <a href="#" class="back-to-login">Back to Login</a>
                    </div>
                </div>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Check if session attribute for emailRegistered is set
                const emailRegistered = '<%= session.getAttribute("emailRegistered")%>';
                if (emailRegistered === "true") {
                    alert("This email is already registered. Please use another email to register");
                    session.removeAttribute("emailRegistered"); // Clear session attribute after displaying the message
                }
            });
            document.addEventListener("DOMContentLoaded", function () {
                // Form boxes
                const loginForm = document.querySelector(".form-box.login");
                const signupForm = document.querySelector(".form-box.signup");
                const forgotPasswordForm = document.querySelector(".form-box.forgot-password");

                // Links
                const signupLink = document.getElementById("signup-link");
                const loginLink = document.getElementById("login-link");
                const forgotPasswordLink = document.querySelector(".forgot-pass-link");
                const backToLoginLink = document.querySelector(".back-to-login");
                const hidePopupBtn = document.querySelector(".close-btn");

                // Show signup form
                signupLink.addEventListener("click", (e) => {
                    e.preventDefault();
                    loginForm.style.display = "none";
                    signupForm.style.display = "flex";
                    forgotPasswordForm.style.display = "none";
                });

                // Show login form
                loginLink.addEventListener("click", (e) => {
                    e.preventDefault();
                    signupForm.style.display = "none";
                    loginForm.style.display = "flex";
                    forgotPasswordForm.style.display = "none";
                });

                // Show forgot password form
                forgotPasswordLink.addEventListener("click", (e) => {
                    e.preventDefault();
                    loginForm.style.display = "none";
                    forgotPasswordForm.style.display = "flex";
                    signupForm.style.display = "none";
                });

                // Back to login from forgot password
                backToLoginLink.addEventListener("click", (e) => {
                    e.preventDefault();
                    forgotPasswordForm.style.display = "none";
                    loginForm.style.display = "flex";
                    signupForm.style.display = "none";
                });

                // Hide the popup
                hidePopupBtn.addEventListener("click", () => {
                    document.body.classList.remove("show-popup");
                });
            });
            document.addEventListener("DOMContentLoaded", function () {
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
                        document.getElementById("formWarning").style.display = "block";
                        return false;
                    } else {
                        nameError.textContent = '';
                        return true;
                    }
                }

                function validateEmail() {
                    const email = emailField.value.trim();
                    const emailError = document.getElementById('emailError');
                    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (!emailPattern.test(email)) {
                        emailError.textContent = 'Please enter a valid email address.';
                        document.getElementById("formWarning").style.display = "block";
                        return false;
                    } else {
                        emailError.textContent = '';
                        return true;
                    }
                }

                function validatePhone() {
                    const phone = phoneField.value.trim();
                    const phoneError = document.getElementById('phoneError');
                    if (phone.length !== 10 || !/^\d+$/.test(phone)) {
                        phoneError.textContent = 'Phone number must be 10 digits long.';
                        document.getElementById("formWarning").style.display = "block";
                        return false;
                    } else {
                        phoneError.textContent = '';
                        return true;
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
                        document.getElementById("formWarning").style.display = "block";
                        return false;
                    } else {
                        dobError.textContent = '';
                        return true;
                    }
                }

                function validateAddress() {
                    const address = addressField.value.trim();
                    const addressError = document.getElementById('addressError');
                    if (address.length < 5) {
                        addressError.textContent = 'Address must be at least 5 characters long.';
                        document.getElementById("formWarning").style.display = "block";
                        return false;
                    } else {
                        addressError.textContent = '';
                        return true;
                    }
                }

                function validatePassword() {
                    const password = passwordField.value.trim();
                    const passwordError = document.getElementById('passwordError');
                    if (password.length < 6) {
                        passwordError.textContent = 'Password must be at least 6 characters long.';
                        document.getElementById("formWarning").style.display = "block";
                        return false;
                    } else {
                        passwordError.textContent = '';
                        return true;
                    }
                }

                function validatePolicy() {
                    const policyError = document.getElementById('policyError');
                    if (!policyCheckbox.checked) {
                        policyError.textContent = 'You must agree to the terms & conditions.';
                        document.getElementById("formWarning").style.display = "block";
                        return false;
                    } else {
                        policyError.textContent = '';
                        return true;
                    }
                }
                function ValidateAll() {
                    const isNameValid = validateName();
                    const isEmailValid = validateEmail();
                    const isPhoneValid = validatePhone();
                    const isDOBValid = validateDOB();
                    const isAddressValid = validateAddress();
                    const isPasswordValid = validatePassword();
                    const isPolicyValid = validatePolicy();

                    const allValid = isNameValid && isEmailValid && isPhoneValid && isDOBValid && isAddressValid && isPasswordValid && isPolicyValid;

                    document.getElementById("formWarning").style.display = allValid ? "none" : "block";

                    return allValid;
                }
            }

            );
        </script>
        <style>
            img.img_bottom_1,img.img_bottom_2  {
                width: 50%;
            }
            img.img_newest {
                height: 100%;
            }
            img.gif_bot {
                width: 50%;
            }
            .same-size {
                width: 300px; /* set the width to 200px */
                height: 200px; /* set the height to 200px */
                object-fit: cover; /* make sure the image is scaled to cover the entire area */
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