<%@page import="java.time.Period"%>
<%@page import="java.time.Duration"%>
<%@page import="java.time.ZoneId"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Collections"%>
<%@page import="com.mongodb.client.MongoClients"%>
<%@page import="Model.Comment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.mongodb.client.model.Filters"%>
<%@page import="com.mongodb.client.MongoClient"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCollection"%>
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
                        <a href="ReadGameHomeController" class="site-logo">
                            <img src="./img/logo1.png" alt="" class="logo1">
                            <img src="./img/logo2.png" alt="" class="logo2">
                        </a>
                    </div>
                    <nav class="top-nav-area w-100">
                        <div class="user-panel d-flex">
                            <!-- Bi?u t??ng gi? hï¿½ng -->

                            <!-- Bi?u t??ng tï¿½i kho?n -->
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
                            <li><a href="contact-after-login.jsp?adminId=<%= request.getSession().getAttribute("adminId")%>">Contact</a></li>
                            <li><a href="ReadGameHomeAdminController?view=chart&adminId=<%= request.getSession().getAttribute("adminId")%>">Manage</a></li>
                            <li><a href="ReadTopicAdminController?adminId=<%= request.getSession().getAttribute("adminId")%>">Forum</a></li>
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


        <!--Forum section -->
        <%
            String userId = null;
            String userNameTopic = null;
            String title = null;
            String description = null;
            String imageData = null;
            String photoUrlUser = null;

            List<Comment> comments = new ArrayList<>();

            // Get the post ID from the URL query parameter
            String topicId = request.getParameter("id");
            System.out.println("Topic ID: " + topicId);

            // Connect to MongoDB
            MongoClient mongoClient = MongoClients.create("mongodb+srv://LoliHunter:Loli_slayer_123@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub"); // Your connection string
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
                List<Document> commentDocuments = commentsCollection
                        .find(Filters.eq("TopicId", topicId))
                        .into(new ArrayList<>());

                for (Document doc : commentDocuments) {
                    Document user = usersCollection.find(Filters.eq("_id", new ObjectId(doc.getString("UserId")))).first();
                    String photoUrl = (user != null) ? user.getString("PhotoUrl") : "./img/t-rex.png";
                    String userName = (user != null) ? user.getString("Name") : "Unknown";

                    Comment comment = new Comment();
                    comment.setCommentId(doc.getObjectId("_id").toString());
                    comment.setTopicId(doc.getString("TopicId").toString());
                    comment.setUserId(doc.getString("UserId").toString());
                    comment.setUserName(userName);
                    comment.setPhotoUrl(photoUrl);
                    comment.setContent(doc.getString("Content"));

                    if (doc.getString("Status").equals("unedited")) {
                        comment.setStatus("");
                    } else {
                        comment.setStatus("(edited)");
                    };
                    comment.setDate(doc.getDate("Date"));

                    // Log retrieved values
                    System.out.println("Topic id: " + comment.getTopicId());
                    System.out.println("User id: " + comment.getUserId());
                    System.out.println("Comment id: " + comment.getCommentId());
                    System.out.println("User name: " + userName);
                    System.out.println("Content: " + comment.getContent());
                    System.out.println("Photo ulr: " + photoUrl);

                    comments.add(comment);
                }

                Collections.reverse(comments);

                // Log retrieved values
                System.out.println("Title: " + title);
                System.out.println("Description: " + description);
                System.out.println("Image ulr: " + imageData);
                System.out.println("User name: " + userNameTopic);
                System.out.println("Photo ulr: " + photoUrlUser);
            } else {
                out.println("Post not found.");
            }

            // Close MongoDB connection
            mongoClient.close();
        %>
        <section class="blog-section spad">
            <div class="container" style="
                 margin: 0 auto;
                 margin-top: 20px;
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
                            <div class="username"><a href=""><%=userNameTopic%></a></div>
                        </div>
                        <div class="content">
                            <p style="color: lightblue; white-space: normal; word-wrap: break-word; overflow-wrap: break-word;">
                                <%= description%>
                            </p>

                            <div class="topic-img">
                                <img src="data:image/jpeg;base64,<%= imageData != null ? imageData : ""%>"  alt="">
                            </div>  
                            <div class="comment">
                                <button onclick="toggleArea('comment-area')">Comment</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!--Comment Area-->
                <form action="AddCommentAdminController" method="POST">
                    <div class="comment-area hide" id="comment-area">
                        <!-- Textarea để nhập comment -->
                        <textarea name="comment" placeholder="comment here ..." required></textarea>
                        <!-- Các trường ẩn để truyền các giá trị cần thiết -->
                        <input type="hidden" name="userid" value="<%= request.getSession().getAttribute("adminId")%>">
                        <input type="hidden" name="topicid" value="<%=topicId%>">

                        <!-- Nút submit để gửi form -->
                        <input type="submit" value="submit">
                    </div>
                </form>
                <!--Another Comment With replies-->
                <div class="comments-container">
                    <% if (comments != null && !comments.isEmpty()) {
                            int commentIndex = 0;
                            for (Comment comment : comments) {%>
                    <!<!-- Comment-->
                    <div class="comments" id="<%= comment.getCommentId()%>">
                        <div class="comments" id="comment-<%= comment.getCommentId()%>" data-comment-index="<%= commentIndex++%>">
                            <div class="body">

                                <div class="authors">
                                    <img src="<%= (comment.getPhotoUrl() == null || comment.getPhotoUrl().isEmpty()) ? "./img/t-rex.png" : comment.getPhotoUrl()%>" alt="Photo User">
                                    <div class="username"><a href=""><%= comment.getUserName()%></a></div>
                                    <div class="date-comment">
                                        <%// Chuyển Date thành LocalDateTime
                                            Date pastDate = comment.getDate();
                                            LocalDateTime pastDateTime = pastDate.toInstant().atZone(ZoneId.of("UTC")).toLocalDateTime();

                                            // Lấy thời gian hiện tại (LocalDateTime)
                                            LocalDateTime now = LocalDateTime.now();

                                            // Tính khoảng cách thời gian giữa hai thời điểm
                                            Duration duration = Duration.between(pastDateTime, now);
                                            Period period = Period.between(pastDateTime.toLocalDate(), now.toLocalDate());

                                            // Điều kiện 1: Nếu nhỏ hơn 1 giờ -> Hiện n phút trước
                                            if (duration.toMinutes() < 60) {
                                        %>
                                        <b><%= duration.toMinutes()%>m ago<%=comment.getStatus()%></b>
                                        <%
                                        } // Điều kiện 2: Nếu nhỏ hơn 1 ngày -> Hiện n giờ trước
                                        else if (duration.toHours() < 24) {
                                        %>
                                        <b><%= duration.toHours()%>H ago<%=comment.getStatus()%></b>
                                        <%
                                        } // Điều kiện 3: Nếu nhỏ hơn 1 tuần -> Hiện n ngày trước
                                        else if (duration.toDays() < 7) {
                                        %>
                                        <b><%= duration.toDays()%>D ago<%=comment.getStatus()%></b>
                                        <%
                                        } // Điều kiện 4: Nếu nhỏ hơn 4 tuần -> Hiện n tuần trước
                                        else if (duration.toDays() < 28) {
                                        %>
                                        <b><%= duration.toDays() / 7%>W ago<%=comment.getStatus()%></b>
                                        <%
                                        } // Điều kiện 5: Nếu lớn hơn 4 tuần nhưng nhỏ hơn 1 năm -> Hiện n tháng trước
                                        else if (period.toTotalMonths() < 12) {
                                        %>
                                        <b><%= period.toTotalMonths()%>M ago<%=comment.getStatus()%></b>
                                        <%
                                        } // Điều kiện 6: Nếu lớn hơn 1 năm -> Hiện n năm trước
                                        else {
                                        %>
                                        <b><%= period.getYears()%>Y ago<%=comment.getStatus()%></b>
                                        <%
                                            }
                                        %>
                                    </div>
                                </div>
                                <div class="content">
                                    <p style="color: lightblue; white-space: normal; word-wrap: break-word; overflow-wrap: break-word;">
                                        <%= comment.getContent()%>
                                    </p>
                                    <%if (!comment.getUserId().equalsIgnoreCase(request.getSession().getAttribute("adminId").toString())) {%>
                                    <div class="comment">
                                        <button onclick="showReply('reply-area-<%= comment.getCommentId()%>', '<%=comment.getUserName()%>')">Reply</button>
                                    </div>
                                    <%} else {%>
                                    <div class="comment">
                                        <button class="update-button" onclick="showUpdate('<%= comment.getCommentId()%>', '<%= comment.getContent()%>', '<%= topicId%>', '<%= comment.getContent()%>')" aria-label="Update comment">Update</button>
                                    </div>
                                    <form action="UpdateCommentAdminController" method="POST">
                                        <div class="comment-area hide" id="update-area-<%= comment.getCommentId()%>">
                                            <textarea name="newContent" placeholder="reply here ..." required></textarea>
                                            <input type="hidden" name="commentid" value="<%= comment.getCommentId()%>">
                                            <input type="hidden" name="topicid" value="<%= topicId%>">
                                            <input type="submit" value="Submit">
                                        </div>
                                    </form>
                                    <%}%>
                                    <div class="comment">
                                        <button style="margin-left: 840px; margin-top: 15px;" onclick="deleteComment('<%= comment.getCommentId()%>', '<%=topicId%>')">Delete</button>
                                    </div>   
                                </div>
                            </div>
                        </div>
                        <!-- Reply text area -->
                        <form action="AddCommentAdminController" method="POST">
                            <div class="comment-area hide" id="reply-area-<%= comment.getCommentId()%>">
                                <!-- Textarea để nhập reply -->
                                <textarea name="comment" placeholder="reply here ..." required></textarea>

                                <!-- Các trường ẩn để truyền các giá trị cần thiết -->
                                <input type="hidden" name="userid" value="<%= request.getSession().getAttribute("adminId")%>">
                                <input type="hidden" name="topicid" value="<%=topicId%>">            

                                <!-- Nút submit để gửi form -->
                                <input type="submit" value="submit">
                            </div>
                        </form>
                        <% }
                        } else { %>
                        <p>No comments yet. <a href="#" id="show-comment-area">Be the first to comment!</a></p>
                        <% }%>        
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
                    <li><a href="ReadGameHomeAdminController?adminId=<%= request.getSession().getAttribute("adminId")%>">Home</a></li>
                    <li><a href="ReadGameListAdminController?adminId=<%= request.getSession().getAttribute("adminId")%>">Games</a>
                    <li><a href="contact-after-login.jsp?adminId=<%= request.getSession().getAttribute("adminId")%>">Contact</a></li>
                    <li><a href="ReadGameHomeAdminController?view=chart&adminId=<%= request.getSession().getAttribute("adminId")%>">Manage</a></li>
                    <li><a href="ReadTopicAdminController?adminId=<%= request.getSession().getAttribute("adminId")%>">Forum</a></li>
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
                                            function showComment() {
                                                var commentArea = document.getElementById("comment-area");
                                                commentArea.classList.toggle("hide");
                                            }
                                            
                                            // Bắt sự kiện khi bấm vào dòng chữ "Be the first to comment!"
                                            const showCommentLink = document.getElementById("show-comment-area");

                                            showCommentLink.addEventListener("click", (e) => {
                                                e.preventDefault();  // Ngăn chặn hành động mặc định của thẻ <a>
                                                toggleArea('comment-area');  // Gọi hàm toggleArea giống như khi bấm nút "Comment"
                                            });

                                            function showReply(areaId, username) {
                                                // Tìm tất cả các phần comment-area và ẩn chúng
                                                const allCommentAreas = document.querySelectorAll('.comment-area');
                                                allCommentAreas.forEach(area => {
                                                    area.classList.add('hide'); // Ẩn tất cả các comment-area
                                                });

                                                // Hiển thị phần comment-area tương ứng với reply được bấm
                                                var replyArea = document.getElementById(areaId);
                                                replyArea.classList.toggle("hide"); // Toggle hiển thị phần comment-area được bấm

                                                // Lấy thẻ textarea trong phần reply hiện tại
                                                var textArea = replyArea.querySelector('textarea');

                                                // Đặt giá trị ban đầu cho textarea là username
                                                textArea.value = '@' + username + ' ';
                                            }

                                            function showUpdate(commentId, username, topicId, oldContent) {
                                                // Hide all comment areas
                                                const allCommentAreas = document.querySelectorAll('.comment-area');
                                                allCommentAreas.forEach(area => {
                                                    area.classList.add('hide');
                                                });

                                                // Show the corresponding comment area
                                                var updateArea = document.getElementById('update-area-' + commentId);
                                                updateArea.classList.remove('hide');

                                                // Set the initial value for the textarea
                                                var textArea = updateArea.querySelector('textarea');
                                                textArea.value = oldContent;
                                            }

                                            function toggleArea(areaId) {
                                                var area = document.getElementById(areaId);
                                                area.classList.toggle("hide");
                                            }
                                            function deleteComment(value1, value2) {
                                                const form = document.createElement('form');
                                                form.method = 'POST';
                                                form.action = 'DeleteCommentAdminController';  // Đường dẫn tới servlet

                                                // Tạo các input ẩn để truyền giá trị
                                                const input1 = document.createElement('input');
                                                input1.type = 'hidden';
                                                input1.name = 'commentId';  // Tên của tham số truyền vào servlet
                                                input1.value = value1;

                                                const input2 = document.createElement('input');
                                                input2.type = 'hidden';
                                                input2.name = 'topicId';
                                                input2.value = value2;

                                                // Thêm input vào form
                                                form.appendChild(input1);
                                                form.appendChild(input2);

                                                // Thêm form vào body và submit
                                                document.body.appendChild(form);
                                                form.submit();
                                            }
        </script>
        <style>.modal {
                display: none;
                position: fixed;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 1;
            }

            .modal-content {
                background-color: white;
                margin: 15% auto;
                padding: 20px;
                width: 80%;
                border-radius: 10px;
                text-align: center;
            }

            .close {
                float: right;
                font-size: 24px;
                cursor: pointer;
            }
        </style>
    </body>

</html>