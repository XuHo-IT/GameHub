<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="utils.MongoDBConnectionManager1"%>
<%@page import="Model.CommentTemp"%>
<%@page import="java.time.Period"%>
<%@page import="java.time.Duration"%>
<%@page import="java.time.ZoneId"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Collection"%>
<%@page import="Model.Comment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mongodb.client.model.Filters"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoClients"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="com.mongodb.client.MongoClient"%>
<!DOCTYPE html>
<html lang="zxx">

    <head>
        <title>EndGame - Gaming Magazine Template</title>
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

        <!-- Forum section -->
        <%
            String userId = null;
            String userNameTopic = null;
            String title = null;
            String description = null;
            String imageData = null;
            String photoUrlUser = null;
            List<CommentTemp> comments = new ArrayList<>();

            // Get the post ID from the URL query parameter
            String topicId = request.getParameter("topicId");

            // Connect to MongoDB
            MongoClient mongoClient = MongoDBConnectionManager1.getLocalMongoClient();
            MongoCollection<Document> topicsCollection = mongoClient.getDatabase("GameHub").getCollection("topic");

            // Find the topic by its ObjectId
            Document topic = topicsCollection.find(Filters.eq("_id", new ObjectId(topicId))).first();

            // Check if the post exists
            if (topic != null) {
                title = topic.getString("Title");
                description = topic.getString("Description");
                imageData = topic.getString("ImageData");
                userId = topic.getString("UserId");

                MongoCollection<Document> usersCollection = mongoClient.getDatabase("GameHub").getCollection("superadmin");
                // Find the user by its ObjectId
                Document userTopic = usersCollection.find(Filters.eq("_id", new ObjectId(userId))).first();

                userNameTopic = userTopic.getString("Name");
                photoUrlUser = userTopic.getString("PhotoUrl");

                MongoCollection<Document> commentsCollection = mongoClient.getDatabase("GameHub").getCollection("comment");
                // Find the comment by its ObjectId
                List<Document> commentDocuments = commentsCollection.find(Filters.eq("TopicId", topicId)).into(new ArrayList<>());

                for (Document doc : commentDocuments) {
                    Document user = usersCollection.find(Filters.eq("_id", new ObjectId(doc.getString("UserId")))).first();
                    String photoUrl = (user != null) ? user.getString("PhotoUrl") : "./img/t-rex.png";
                    String userName = (user != null) ? user.getString("Name") : "Unknown";

                    CommentTemp comment = new CommentTemp();
                    comment.setCommentId(doc.getObjectId("_id").toString());
                    comment.setTopicId(doc.getString("TopicId").toString());
                    comment.setUserId(doc.getString("UserId").toString());
                    comment.setUserName(userName);
                    comment.setPhotoUrl(photoUrl);
                    comment.setContent(doc.getString("Content"));

                    if ("unedited".equals(doc.getString("Status"))) {
                        comment.setStatus("");
                    } else {
                        comment.setStatus("(edited)");
                    }
                    comment.setDate(doc.getDate("Date"));

                    comments.add(comment);
                }
                Collections.reverse(comments);
            }
        %>

        <section class="blog-section spad">
            <div class="container" style="
                 margin: 0 auto;
                 margin-top: -30px;
                 padding: 20px;">
                <div class="topic-container">
                    <!--Original thread-->
                    <div class="head">
                        <div class="authors">Author</div>
                        <div class="content"><%=title%></div>
                    </div>

                    <div class="body">
                        <div class="authors">                          
                            <img src="<%= (photoUrlUser == null || photoUrlUser.isEmpty()) ? "./img/t-rex.png" : photoUrlUser%>" alt="Photo User">
                            <div class="username"><a href="#"><%=userNameTopic%></a></div>
                        </div>
                        <div class="content">
                            <p style="color: lightblue; word-break: break-word; overflow-wrap: anywhere;">
                                <%= description%>
                            </p>

                            <div class="topic-img">
                                <img src="data:image/jpeg;base64,<%= imageData != null ? imageData : ""%>"  alt="">
                            </div>                    
                        </div>
                    </div>
                </div>

                <!-- Another Comment With replies -->
                <div class="comments-container">
                    <% if (comments != null && !comments.isEmpty()) {
                            int commentIndex = 0;
                            for (CommentTemp comment : comments) {%>
                    <div class="comments" id="comment-<%= comment.getCommentId()%>" data-comment-index="<%= commentIndex++%>">
                        <div class="body">
                            <div class="authors">
                                <img src="<%= (comment.getPhotoUrl() == null || comment.getPhotoUrl().isEmpty()) ? "./img/t-rex.png" : comment.getPhotoUrl()%>" alt="Photo User">
                                <div class="username"><a href=""><%= comment.getUserName()%></a></div>
                                <div class="date-comment">
                                    <%
                                        Date pastDate = comment.getDate();
                                        LocalDateTime pastDateTime = pastDate.toInstant().atZone(ZoneId.of("UTC")).toLocalDateTime();
                                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
                                        String originalTime = pastDateTime.format(formatter);

                                        LocalDateTime now = LocalDateTime.now();

                                        Duration duration = Duration.between(pastDateTime, now);
                                        Period period = Period.between(pastDateTime.toLocalDate(), now.toLocalDate());

                                        if (duration.toMinutes() < 60) {
                                    %>
                                    <b>
                                        <i class="fas fa-clock" title="<%= originalTime%>"></i> <%= duration.toMinutes()%>m ago <%= comment.getStatus()%>
                                    </b>
                                    <%
                                    } else if (duration.toHours() < 24) {
                                    %>
                                    <b>
                                        <i class="fas fa-clock" title="<%= originalTime%>"></i> <%= duration.toHours()%>H ago <%= comment.getStatus()%>
                                    </b>
                                    <%
                                    } else if (duration.toDays() < 7) {
                                    %>
                                    <b>
                                        <i class="fas fa-clock" title="<%= originalTime%>"></i> <%= duration.toDays()%>D ago <%= comment.getStatus()%>
                                    </b>
                                    <%
                                    } else if (duration.toDays() < 28) {
                                    %>
                                    <b>
                                        <i class="fas fa-clock" title="<%= originalTime%>"></i> <%= duration.toDays() / 7%>W ago <%= comment.getStatus()%>
                                    </b>
                                    <%
                                    } else if (period.toTotalMonths() < 12) {
                                    %>
                                    <b>
                                        <i class="fas fa-clock" title="<%= originalTime%>"></i> <%= period.toTotalMonths()%>M ago <%= comment.getStatus()%>
                                    </b>
                                    <%
                                    } else {
                                    %>
                                    <b>
                                        <i class="fas fa-clock" title="<%= originalTime%>"></i> <%= period.getYears()%>Y ago <%= comment.getStatus()%>
                                    </b>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                            <div class="content">
                                <p style="color: lightblue;  word-break: break-word; overflow-wrap: anywhere;">
                                    <%= comment.getContent()%>
                                </p>
                            </div>
                        </div>
                    </div>
                    <% }
                    } else { %>
                    <p>No comments yet. <a href="#" id="show-login-from-comment">Be the first to comment!</a></p>
                    <% }%>
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
                    <form action="SignUpController" method="post">
                        <div class="input-field">
                            <label>Enter your name</label>

                            <input type="text" required name="Name">
                        </div>
                        <div class="input-field">
                            <label>Enter your email</label>

                            <input type="text" required name="Email">
                        </div>
                        <div class="input-field">
                            <label>Phone number</label>

                            <input type="number" required name="Phone">
                        </div>
                        <div class="input-field">
                            <label>Date of birth</label>

                            <input type="date" required name="Dob">
                        </div>
                        <div class="input-field">
                            <label>Address</label>

                            <input type="text" required name="Address">
                        </div>
                        <div class="input-field">
                            <label>Password</label>

                            <input type="password" required name="Password">
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
            const showLoginFromComment = document.getElementById("show-login-from-comment");
            // Show login popup when click letter "Be the first to comment!"
            showLoginFromComment.addEventListener("click", (e) => {
                document.body.classList.toggle("show-popup");
            });
        </script>
    </body>

</html>