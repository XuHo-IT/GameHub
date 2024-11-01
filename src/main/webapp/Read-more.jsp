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
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <header class="header-section">
        <div class="header-warp">

            <div class="header-social d-flex justify-content-end">
                <p><strong>Follow us:</strong></p>
                <a href="https://www.facebook.com/fptcorp"><i class="fa fa-facebook"></i></a>
                <a href="https://fpt.com/vi"><i class="fa fa-address-card-o"></i></a>
                <a href="https://www.linkedin.com/company/fpt-corporation"><i class="fa fa-linkedin-square"></i></a>
                <a href="https://www.youtube.com/c/FPTCorporation"><i class="fa fa-youtube-play"></i></a>
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


    <!-- Hero section -->
    <section class="hero-section overflow-hidden">
        <div class="hero-slider owl-carousel">
            <div class="hero-item set-bg d-flex align-items-center justify-content-center text-center" data-setbg="img/slider004.jpg">
                <div class="container">
                    <h2 >game on!</h2>
                    <p style="font-family: 'Silkscreen', cursive; font-size: 21px;">
                        Welcome to our gaming news platform, your go-to hub for the latest updates and insights in the gaming world. Whether you're a casual player or a dedicated enthusiast, our site offers features to keep you informed and engaged.<br><br>
                        Discover and share game news, upcoming titles, and industry events in a user-friendly space. Navigate through a mix of user-generated posts and admin-curated updates easily.<br><br>
                        Engage with fellow gamers by posting news, commenting on updates, and participating in discussions. Join our vibrant community and celebrate your passion for games.<br><br>
                        Stay updated and enjoy discovering what's new in the gaming world, Where all in one place!
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Hero section end-->


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
                } else {
                    nameError.textContent = '';
                    if (checkAllFieldsValid()) {
                        document.getElementById("formWarning").style.display = "none";
                    }
                }
            }

            function validateEmail() {
                const email = emailField.value.trim();
                const emailError = document.getElementById('emailError');
                const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailPattern.test(email)) {
                    emailError.textContent = 'Please enter a valid email address.';
                    document.getElementById("formWarning").style.display = "block";
                } else {
                    emailError.textContent = '';
                    if (checkAllFieldsValid()) {
                        document.getElementById("formWarning").style.display = "none";
                    }
                }
            }

            function validatePhone() {
                const phone = phoneField.value.trim();
                const phoneError = document.getElementById('phoneError');
                if (phone.length !== 10 || !/^\d+$/.test(phone)) {
                    phoneError.textContent = 'Phone number must be 10 digits long.';
                    document.getElementById("formWarning").style.display = "block";
                } else {
                    phoneError.textContent = '';
                    if (checkAllFieldsValid()) {
                        document.getElementById("formWarning").style.display = "none";
                    }
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
                } else {
                    dobError.textContent = '';
                    if (checkAllFieldsValid()) {
                        document.getElementById("formWarning").style.display = "none";
                    }
                }
            }

            function validateAddress() {
                const address = addressField.value.trim();
                const addressError = document.getElementById('addressError');
                if (address.length < 5) {
                    addressError.textContent = 'Address must be at least 5 characters long.';
                    document.getElementById("formWarning").style.display = "block";
                } else {
                    addressError.textContent = '';
                    if (checkAllFieldsValid()) {
                        document.getElementById("formWarning").style.display = "none";
                    }
                }
            }

            function validatePassword() {
                const password = passwordField.value.trim();
                const passwordError = document.getElementById('passwordError');
                if (password.length < 6) {
                    passwordError.textContent = 'Password must be at least 6 characters long.';
                    document.getElementById("formWarning").style.display = "block";
                } else {
                    passwordError.textContent = '';
                    if (checkAllFieldsValid()) {
                        document.getElementById("formWarning").style.display = "none";
                    }
                }
            }

            function validatePolicy() {
                const policyError = document.getElementById('policyError');
                if (!policyCheckbox.checked) {
                    policyError.textContent = 'You must agree to the terms and conditions.';
                    document.getElementById("formWarning").style.display = "block";
                } else {
                    policyError.textContent = '';
                    if (checkAllFieldsValid()) {
                        document.getElementById("formWarning").style.display = "none";
                    }
                }
            }

            function checkAllFieldsValid() {
                const errors = document.querySelectorAll('.error');
                return [...errors].every(error => error.textContent === '');
            }
        });
    </script>

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
            font-family: 'Sixtyfour Convergence';
            padding: 0 0px 30px 0;
        }
    </style>

</body>
</html>