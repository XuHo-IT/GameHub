<%@page import="Model.CommentTemp"%>
<%@page import="utils.MongoDBConnectionManager1"%>
<%@page import="java.time.Period"%>
<%@page import="java.time.Duration"%>
<%@page import="java.time.ZoneId"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.Date"%>
<%@page import="com.mongodb.client.MongoClients"%>
<%@page import="com.mongodb.client.MongoClient"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mongodb.client.model.Filters"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="org.bson.Document"%>
<%@page import="Model.Comment"%>
<%@page import="java.util.Collections"%>
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
        <link rel="stylesheet" href="css/account-icon.css" />

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
                <<div class="header-social d-flex justify-content-end">
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
                            <div class="account-container">
                                <div class="user">
                                    <%= request.getSession().getAttribute("adminId")%>
                                    <img src="<%= request.getSession().getAttribute("photoUrl")%>" alt="User Profile" />
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
                            <li><a href="ReadGameHomeMemberController?userId=<%= request.getSession().getAttribute("adminId")%>">Home</a></li>
                            <li><a href="ReadGameListMemberController?userId=<%= request.getSession().getAttribute("adminId")%>">Games</a></li>
                            <li><a href="ReadTopicMember?userId=<%= request.getSession().getAttribute("adminId")%>">Forum</a></li>
                            <li><a href="contact-after-login-member.jsp?userId=<%= request.getSession().getAttribute("adminId")%>">Contact</a></li>
                        </ul>
                    </nav>
                </div>
            </div>

        </header>
        <section class="page-top-section set-bg" data-setbg="img/page-top-bg/4.jpg">
            <div class="page-info">
                <h2>Forum</h2>
                <div class="site-breadcrumb">
                    <a href="ReadGameHomeMemberController?userId=<%= request.getSession().getAttribute("adminId")%>">Home</a>  /
                    <span>Forum</span>
                </div>
            </div>
        </section>

        <!--Forum section-->
        <%
            String userIdTopic = null;
            String userNameTopic = null;
            String title = null;
            String description = null;
            String imageData = null;
            String photoUrlUser = null;

            List<CommentTemp> comments = new ArrayList<>();

            // Get the post ID from the URL query parameter
            String topicId = request.getParameter("topicId");
            String userId = request.getParameter("userId");
            System.out.println(userId + "1");

            // Connect to MongoDB
            MongoClient mongoClient = MongoDBConnectionManager1.getMongoClient();
            MongoCollection<Document> topicsCollection = mongoClient.getDatabase("GameHub").getCollection("topic");

            // Find the topic by its ObjectId
            Document topic = topicsCollection.find(Filters.eq("_id", new ObjectId(topicId))).first();

            // Check if the post exists
            if (topic != null) {
                title = topic.getString("Title");
                description = topic.getString("Description");
                imageData = topic.getString("ImageData");
                userIdTopic = topic.getString("UserId");

                MongoCollection<Document> usersCollection = mongoClient.getDatabase("GameHub").getCollection("superadmin");

                // Find the user by its ObjectId
                Document userTopic = usersCollection.find(Filters.eq("_id", new ObjectId(userIdTopic))).first();

                userNameTopic = userTopic.getString("Name");
                photoUrlUser = userTopic.getString("PhotoUrl");

                MongoCollection<Document> commentsCollection = mongoClient.getDatabase("GameHub").getCollection("comment");

                // Find the comment by its ObjectId
                List<Document> commentDocuments = commentsCollection
                        .find(Filters.eq("TopicId", topicId))
                        .into(new ArrayList<>());

                for (Document doc : commentDocuments) {
                    String userIdComment = doc.getString("UserId");
                    String photoUrl;
                    String userName;

                    if (userIdComment != null && ObjectId.isValid(userIdComment)) {
                        Document user = usersCollection.find(Filters.eq("_id", new ObjectId(userIdComment))).first();
                        photoUrl = (user != null) ? user.getString("PhotoUrl") : "./img/t-rex.png";
                        userName = (user != null) ? user.getString("Name") : "Unknown";
                    } else {
                        // Xử lý trường hợp UserId không hợp lệ
                        photoUrl = "./img/t-rex.png";
                        userName = "Unknown";
                    }

                    CommentTemp comment = new CommentTemp();
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

                    comments.add(comment);
                }
                Collections.reverse(comments);
            } else {
                out.println("Post not found.");
            }
        %>

        <section class="blog-section spad">
            <div class="container" style="
                 margin: 0 auto;
                 margin-top: -160px;
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
                            <div class="comment">
                                <button onclick="toggleArea('comment-area')">Comment</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!--Comment Area-->
                <form action="AddComment" method="POST">
                    <div class="comment-area hide" id="comment-area">
                        <textarea name="comment" placeholder="comment here ..." required></textarea>
                        <input type="hidden" name="memberid" value="<%= request.getSession().getAttribute("adminId")%>">
                        <input type="hidden" name="topicid" value="<%=request.getParameter("topicId")%>">
                        <input type="submit" value="submit">
                    </div>
                </form>
                <!--Another Comment With replies-->
                <div class="comments-container">
                    <% if (comments != null && !comments.isEmpty()) {
                            int commentIndex = 0;
                            for (CommentTemp comment : comments) {%>
                    <!<!-- Comment-->
                    <div class="comments" id="<%= comment.getCommentId()%>">
                        <div class="comments" id="comment-<%= comment.getCommentId()%>" data-comment-index="<%= commentIndex++%>">
                            <div class="body">
                                <div class="authors">
                                    <img src="<%= (comment.getPhotoUrl() == null || comment.getPhotoUrl().isEmpty()) ? "./img/t-rex.png" : comment.getPhotoUrl()%>" alt="Photo User">
                                    <div class="username"><a href=""><%= comment.getUserName()%></a></div>
                                    <div class="date-comment">
                                        <%
                                            Date pastDate = comment.getDate();
                                            LocalDateTime pastDateTime = pastDate.toInstant().atZone(ZoneId.of("UTC")).toLocalDateTime();
                                            LocalDateTime now = LocalDateTime.now();

                                            Duration duration = Duration.between(pastDateTime, now);
                                            Period period = Period.between(pastDateTime.toLocalDate(), now.toLocalDate());

                                            if (duration.toMinutes() < 60) {
                                        %>
                                        <b><%= duration.toMinutes()%>m ago<%=comment.getStatus()%></b>
                                        <%
                                        } 
                                        else if (duration.toHours() < 24) {
                                        %>
                                        <b><%= duration.toHours()%>H ago<%=comment.getStatus()%></b>
                                        <%
                                        } 
                                        else if (duration.toDays() < 7) {
                                        %>
                                        <b><%= duration.toDays()%>D ago<%=comment.getStatus()%></b>
                                        <%
                                        } 
                                        else if (duration.toDays() < 28) {
                                        %>
                                        <b><%= duration.toDays() / 7%>W ago<%=comment.getStatus()%></b>
                                        <%
                                        } 
                                        else if (period.toTotalMonths() < 12) {
                                        %>
                                        <b><%= period.toTotalMonths()%>M ago<%=comment.getStatus()%></b>
                                        <%
                                        } 
                                        else {
                                        %>
                                        <b><%= period.getYears()%>Y ago<%=comment.getStatus()%></b>
                                        <%
                                            }
                                        %>
                                    </div>
                                </div>
                                <div class="content" style="display: grid; align-content: space-between;">
                                    <p style="color: lightblue; word-break: break-word; overflow-wrap: anywhere;">
                                        <%= comment.getContent()%>
                                    </p>                                     
                                    <div style="display: flex; align-items: center; flex-direction: row-reverse; gap: 10px;">  
                                        <% if (comment.getUserId().equals(request.getSession().getAttribute("adminId"))) {%> 
                                        <div class="comment update-button">
                                            <button onclick="showUpdate('<%= comment.getCommentId()%>', '<%= comment.getContent()%>', '<%= topicId%>', '<%= comment.getContent()%>')" aria-label="Update comment">Edit</button>
                                        </div>
                                        <div class="comment delete-button">
                                            <form action="DeleteComment" method="POST">
                                                <input type="hidden" name="commentid" value="<%= comment.getCommentId()%>">
                                                <input type="hidden" name="topicid" value="<%=request.getParameter("topicId")%>">
                                                <input type="hidden" name="memberid" value="<%= request.getSession().getAttribute("adminId")%>">
                                                <button type="submit">Delete</button>
                                            </form>
                                        </div>
                                        <% } else {%>
                                        <div style="display: flex; align-items: center; flex-direction: row-reverse;">
                                            <div class="comment reply-button">
                                                <button onclick="showReply('reply-area-<%= comment.getCommentId()%>', '<%= comment.getUserName()%>')">Reply</button>
                                            </div>
                                        </div>
                                        <% }%>
                                    </div>                                 
                                </div>
                            </div>
                        </div>
                        <form action="UpdateComment" method="POST" onsubmit="return validateComment(this)">
                            <div class="comment-area hide" id="update-area-<%= comment.getCommentId()%>">
                                <textarea name="newContent" id="newContent-<%= comment.getCommentId()%>" placeholder="reply here ..." required></textarea>
                                <input type="hidden" name="commentid" value="<%= comment.getCommentId()%>">
                                <input type="hidden" name="memberid" value="<%= request.getSession().getAttribute("adminId")%>">
                                <input type="hidden" name="topicid" value="<%= request.getParameter("topicId")%>">
                                <input type="hidden" id="originalContent-<%= comment.getCommentId()%>" value="<%= comment.getContent()%>">
                                <input type="submit" value="submit">
                            </div>
                        </form>
                        <!-- Reply text area -->
                        <form action="AddComment" method="POST">
                            <div class="comment-area hide" id="reply-area-<%= comment.getCommentId()%>">
                                <textarea name="comment" placeholder="reply here ..." required></textarea>
                                <input type="hidden" name="memberid" value="<%= request.getSession().getAttribute("adminId")%>">
                                <input type="hidden" name="topicid" value="<%=request.getParameter("topicId")%>">            
                                <input type="submit" value="submit">
                            </div>
                        </form>   
                    </div>
                    <hr class="subforum-devider">
                    <% }
                    } else { %>
                    <p>No comments yet. <a href="#" id="show-comment-area">Be the first to comment!</a></p>
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
                <a href="ReadGameHomeController" class="footer-logo">
                    <img src="./img/logo1.png" alt="">
                    <img src="./img/logo2.png" alt="">
                </a>
                <ul class="main-menu footer-menu">
                    <li><a href="ReadGameHomeMemberController?userId=<%= request.getSession().getAttribute("adminId")%>">Home</a></li>
                    <li><a href="ReadGameListMemberController?userId=<%= request.getSession().getAttribute("adminId")%>">Games</a></li>
                    <li><a href="ReadTopicMember?userId=<%= request.getSession().getAttribute("adminId")%>">Forum</a></li>
                    <li><a href="contact-after-login-member.jsp?userId=<%= request.getSession().getAttribute("adminId")%>">Contact</a></li>
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

        <!--====== Javascripts & Jquery ======-->
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.slicknav.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/jquery.sticky-sidebar.min.js"></script>
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/main.js"></script>
        <script>
                            const showCommentLink = document.getElementById("show-comment-area");

                            showCommentLink.addEventListener("click", (e) => {
                                e.preventDefault();
                                toggleArea('comment-area');
                            });

                            function showReply(areaId, username) {
                                const allCommentAreas = document.querySelectorAll('.comment-area');
                                allCommentAreas.forEach(area => area.classList.add('hide'));

                                var replyArea = document.getElementById(areaId);
                                replyArea.classList.toggle("hide");

                                var textArea = replyArea.querySelector('textarea');
                                if (textArea) {
                                    textArea.value = '@' + username + ' ';
                                }
                            }

                            function showUpdate(commentId, username, topicId, oldContent) {
                                const allCommentAreas = document.querySelectorAll('.comment-area');
                                allCommentAreas.forEach(area => {
                                    area.classList.add('hide');
                                });

                                var updateArea = document.getElementById('update-area-' + commentId);
                                updateArea.classList.remove('hide');

                                var textArea = updateArea.querySelector('textarea');
                                textArea.value = oldContent;
                            }

                            function toggleArea(areaId) {
                                var area = document.getElementById(areaId);
                                area.classList.toggle("hide");
                            }

                            function validateComment(form) {
                                var originalContent = document.getElementById('originalContent-' + form.commentid.value).value;
                                var newContent = document.getElementById('newContent-' + form.commentid.value).value;

                                if (newContent.trim() !== originalContent.trim()) {
                                    return true;
                                } else {
                                    // Nếu giống, hiển thị thông báo lỗi bằng tooltip và không gửi form
                                    var tooltip = document.createElement('div');
                                    tooltip.classList.add('tooltip');
                                    tooltip.textContent = 'Same content. Can not update.';

                                    // Thêm tooltip vào bên cạnh input
                                    document.getElementById('newContent-' + form.commentid.value).parentNode.appendChild(tooltip);

                                    setTimeout(() => {
                                        tooltip.remove();
                                    }, 5000); //5s

                                    return false;
                                }
                            }
        </script>
        <style>
            .hide{
                display: none;
            }
            .modal {
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
            .user {
                position: relative;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                overflow: hidden;
                cursor: pointer;
            }
            .user img {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            .tooltip {
                position: absolute;
                background-color: red;
                color: white;
                padding: 5px;
                border-radius: 10px;
                font-size: 16px;
                z-index: 1000;
                white-space: nowrap;
                opacity: 1;
            }
        </style>
    </body>

</html>