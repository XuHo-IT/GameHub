<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" href="css/forum.css" />
        <link rel="stylesheet" href="css/header.css" />

        <!-- Main Stylesheets -->
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet"
              href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@48,400,0,0">
        <link rel="stylesheet" href="Login/style.css">
        <script src="Login/script.js" defer></script>
        <link rel="stylesheet" href="Forum/style.css">


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

                    <button type="submit"><i class="fa fa-search"></i> Topic</button>
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

                                <ul class="sub-menu">
                                    <li><a href="top-rating-all.jsp">Top rating</a></li>
                                    <li><a href="top-wishlist.jsp">Top wishlist</a></li>
                                </ul>
                            </li>
                            <li><a href="contact.jsp">Contact</a></li>
                            <li><a href="forum.jsp">Community</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
            <div class="button-top-forum" >
                <div class="left-buttons">
                    <button class="forum-button" >All Topics</button>
                    <button class="forum-button">My Topics</button>
                </div>
                <div class="right-button">
                    <button class="forum-button">Create New Topic</button>
                </div>
            </div>
        </header>

        <section class="blog-section spad">
            <div class="container" style="
                 margin: 0 auto;
                 margin-top: 20px;
                 padding: 20px;">
                <div class="topic-container">
                    <!--Original thread-->
                    <div class="head">
                        <div class="authors">Author</div>
                        <div class="content">Title</div>
                    </div>

                    <div class="body">
                        <div class="authors">
                            <div class="username"><a href="">Username</a></div>

                            <img src="./img/Arc Raiders.jpg" alt="">

                        </div>
                        <div class="content">

                            <p style="color: lightblue">Who is hoà</p>

                            <div class="topic-img">
                                <img src="./img/Arc Raiders.jpg" alt="">
                            </div>
                            <div class="comment">
                                <button onclick="toggleArea('comment-area')">Comment</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!--Comment Area-->
                <div class="comment-area hide" id="comment-area">
                    <textarea name="comment" id="" placeholder="comment here ... "></textarea>
                    <input type="submit" value="submit">
                </div>

                <!--Another Comment With replies-->
                <div class="comments-container">
                    
                    <!<!-- Comment 1 -->
                    <div class="comments" id="1">
                        <div class="body">
                            <div class="authors">
                                <div class="username"><a href="">Username</a></div>
                                <img src="./img/Arc Raiders.jpg" alt="">
                            </div>
                            <div class="content">
                                <p style="color: lightblue">Hoà là t</p>
                                <div class="comment">
                                    <button onclick="showReply('reply-area-1')">Reply</button>
                                </div>
                            </div>
                        </div>

                        <!--Reply comment area-->
                        <div class="rely-container">
                            <div class="reply">
                                <!-- First reply always visible -->
                                <div class="body">
                                    <div class="authors">
                                        <div class="username"><a href="">Username</a></div>
                                        <img src="./img/Arc Raiders.jpg" alt="">
                                    </div>
                                    <div class="content">
                                        <p style="color: lightblue">Không, Hoà là t</p>
                                        <div class="comment">
                                            <button onclick="showReply('reply-area-1')">Reply</button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Hidden replies -->
                                <div class="hidden-replies" style="display: none;">
                                    <div class="body">
                                        <div class="authors">
                                            <div class="username"><a href="">Username</a></div>
                                            <img src="./img/Arc Raiders.jpg" alt="">
                                        </div>
                                        <div class="content">
                                            <p style="color: lightblue">Không, Hoà là t</p>
                                            <div class="comment">
                                                <button onclick="showReply('reply-area-1')">Reply</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="body">
                                        <div class="authors">
                                            <div class="username"><a href="">Username</a></div>
                                            <img src="./img/Arc Raiders.jpg" alt="">
                                        </div>
                                        <div class="content">
                                            <p style="color: lightblue">Không, Hoà là t</p>
                                            <div class="comment">
                                                <button onclick="showReply('reply-area-1')">Reply</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="body">
                                        <div class="authors">
                                            <div class="username"><a href="">Username</a></div>
                                            <img src="./img/Arc Raiders.jpg" alt="">
                                        </div>
                                        <div class="content">
                                            <p style="color: lightblue">Không, Hoà là t</p>
                                            <div class="comment">
                                                <button onclick="showReply('reply-area-1')">Reply</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Show/Hide Button -->
                                <button class="toggle-replies">Show more</button>

                                <!-- Reply text area -->
                                <div class="comment-area hide" id="reply-area-1">
                                    <textarea name="reply" placeholder="reply here ..."></textarea>
                                    <input type="submit" value="submit">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!<!-- Comment 2 -->
                    <div class="comments" id="2">
                        <div class="body">
                            <div class="authors">
                                <div class="username"><a href="">Username</a></div>
                                <img src="./img/Arc Raiders.jpg" alt="">
                            </div>
                            <div class="content">
                                <p style="color: lightblue">Hoà là t</p>
                                <div class="comment">
                                    <button onclick="showReply('reply-area-2')">Reply</button>
                                </div>
                            </div>
                        </div>

                        <!--Reply comment area-->
                        <div class="rely-container">
                            <div class="reply">
                                <!-- First reply always visible -->
                                <div class="body">
                                    <div class="authors">
                                        <div class="username"><a href="">Username</a></div>
                                        <img src="./img/Arc Raiders.jpg" alt="">
                                    </div>
                                    <div class="content">
                                        <p style="color: lightblue">Không, Hoà là t</p>
                                        <div class="comment">
                                            <button onclick="showReply('reply-area-2')">Reply</button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Hidden replies -->
                                <div class="hidden-replies" style="display: none;">
                                    <div class="body">
                                        <div class="authors">
                                            <div class="username"><a href="">Username</a></div>
                                            <img src="./img/Arc Raiders.jpg" alt="">
                                        </div>
                                        <div class="content">
                                            <p style="color: lightblue">Không, Hoà là t</p>
                                            <div class="comment">
                                                <button onclick="showReply('reply-area-2')">Reply</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Show/Hide Button -->
                                <button class="toggle-replies">Show more</button>

                                <!-- Reply text area -->                              
                                <div class="comment-area hide" id="reply-area-2">
                                    <textarea name="reply" placeholder="reply here ..."></textarea>
                                    <input type="submit" value="submit">
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!<!-- Comment 3 -->
                    <div class="comments" id="3">
                        <div class="body">
                            <div class="authors">
                                <div class="username"><a href="">Username</a></div>
                                <img src="./img/Arc Raiders.jpg" alt="">
                            </div>
                            <div class="content">
                                <p style="color: lightblue">Hoà là t</p>
                                <div class="comment">
                                    <button onclick="showReply('reply-area-3')">Reply</button>
                                </div>
                            </div>
                        </div>

                        <!--Reply comment area-->
                        <div class="rely-container">
                            <div class="reply">
                                <!-- First reply always visible -->
                                <div class="body">
                                    <div class="authors">
                                        <div class="username"><a href="">Username</a></div>
                                        <img src="./img/Arc Raiders.jpg" alt="">
                                    </div>
                                    <div class="content">
                                        <p style="color: lightblue">Không, Hoà là t</p>
                                        <div class="comment">
                                            <button onclick="showReply('reply-area-3')">Reply</button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Hidden replies -->
                                <div class="hidden-replies" style="display: none;">
                                    <div class="body">
                                        <div class="authors">
                                            <div class="username"><a href="">Username</a></div>
                                            <img src="./img/Arc Raiders.jpg" alt="">
                                        </div>
                                        <div class="content">
                                            <p style="color: lightblue">Không, Hoà là t</p>
                                            <div class="comment">
                                                <button onclick="showReply('reply-area-3')">Reply</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Show/Hide Button -->
                                <button class="toggle-replies">Show more</button>

                                <!-- Reply text area -->
                                <div class="comment-area hide" id="reply-area-3">
                                    <textarea name="reply" placeholder="reply here ..."></textarea>
                                    <input type="submit" value="submit">
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>

            </div>
        </section>




        <!-- Footer section -->
        <footer class="footer-section" style="margin-top: 0 ; padding: 10px 125px">
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
                    <li><a href="">Reviews</a></li>
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
            <span class="close-btn material-symbols-rounded">close</span>
            <div class="form-box login">
                <div class="form-details">
                    <h2>Welcome Back</h2>
                    <p>Please log in using your personal information to stay connected with us.</p>
                </div>
                <div class="form-content">
                    <h2>LOGIN</h2>
                    <form action="#">
                        <div class="input-field">
                            <input type="text" required>
                            <label>Email</label>
                        </div>
                        <div class="input-field">
                            <input type="password" required>
                            <label>Password</label>
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
                    <form action="#">
                        <div class="input-field">
                            <input type="text" required>
                            <label>Enter your email</label>
                        </div>
                        <div class="input-field">
                            <input type="password" required>
                            <label>Create password</label>
                        </div>
                        <div class="policy-text">
                            <input type="checkbox" id="policy">
                            <label for="policy">
                                I agree the
                                <a href="#" class="option">Terms & Conditions</a>
                            </label>
                        </div>
                        <button type="submit">Sign Up</button>
                    </form>
                    <div class="bottom-link">
                        Already have an account?
                        <a href="#" id="login-link">Login</a>
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
            function showComment() {
                var commentArea = document.getElementById("comment-area");
                commentArea.classList.toggle("hide");
            }

            function showReply(areaId) {
                var replyArea = document.getElementById(areaId);
                replyArea.classList.toggle("hide");
            }

            function toggleArea(areaId) {
                var area = document.getElementById(areaId);
                area.classList.toggle("hide");
            }

            document.addEventListener('DOMContentLoaded', function () {
                const toggleButtons = document.querySelectorAll('.toggle-replies');

                toggleButtons.forEach(button => {
                    button.addEventListener('click', function () {
                        const hiddenReplies = this.previousElementSibling;
                        if (hiddenReplies.style.display === 'none') {
                            hiddenReplies.style.display = 'block';
                            this.textContent = 'Hide';
                        } else {
                            hiddenReplies.style.display = 'none';
                            this.textContent = 'Show more';
                        }
                    });
                });
            });
        </script>
    </body>

</html>