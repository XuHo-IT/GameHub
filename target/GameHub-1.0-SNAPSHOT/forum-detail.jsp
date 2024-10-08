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
				<a href="index.jsp" class="site-logo">
					<img src="./img/logo.png" alt="">
				</a>
				<nav class="top-nav-area w-100">
					<div class="user-panel">
						<button class="login-btn">LOG IN</button>
					</div>
					
					<!-- Menu -->
					<ul class="main-menu primary-menu">
						<li><a href="ReadGameHomeController">Home</a></li>
						<li><a href="games.jsp">Games</a></li>
						<li>
							<a class="li-fix" href="blog.jsp">News</a>
						
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
				<button class="forum-button" >All Posts</button>
				<button class="forum-button">My Posts</button>
			</div>
			<div class="right-button">
				<button class="forum-button">Create New Post</button>
			</div>
		</div>
	</header>
	
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
	<!-- Header section end -->


	  <section class="blog-section spad">
       
            
                      <div class="container">
             <div class="topic-container">
            <!--Original thread-->
            <div class="head">
                <div class="authors">Author</div>
                <div class="content">Topic: random topic (Read 1325 Times)</div>
            </div>

            <div class="body">
                <div class="authors">
                    <div class="username"><a href="">Username</a></div>
                    <div>Role</div>
                    <img src="https://cdn.pixabay.com/photo/2015/11/06/13/27/ninja-1027877_960_720.jpg" alt="">
                    <div>Posts: <u>45</u></div>
                    <div>Points: <u>4586</u></div>
                </div>
                <div class="content">
                    Just a random content of a random topic.
                    <br>To see how it looks like.
                    <br><br>
                    Nothing more and nothing less.
                    <br>
                    <hr>
                    Regards username
                    <br>
                   

                   <div class="comment">
                        <button onclick="showComment()">Comment</button>
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
            <div class="body">
                <div class="authors">
                    <div class="username"><a href="">AnotherUser</a></div>
                    <div>Role</div>
                    <img src="https://cdn.pixabay.com/photo/2015/11/06/13/27/ninja-1027877_960_720.jpg" alt="">
                    <div>Posts: <u>455</u></div>
                    <div>Points: <u>4586</u></div>
                </div>
                <div class="content">
                    Just a comment of the above random topic.
                    <br>To see how it looks like.
                    <br><br>
                    Nothing more and nothing less.
                    <br>
                    <br>
                    <div class="comment">
                        <button onclick="showReply()">Reply</button>
                    </div>
                </div>
            </div>
        </div>
         <!--Reply Area-->
      <div class="comment-area hide " id="reply-area">
            <textarea name="reply" id="" placeholder="reply here ... "></textarea>
            <input type="submit" value="submit">
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
function showComment(){
    var commentArea = document.getElementById("comment-area");
    commentArea.classList.remove("hide");
}

//Reply
function showReply(){
    var replyArea = document.getElementById("reply-area");
    replyArea.classList.remove("hide");
}
</script>
</body>

</html>