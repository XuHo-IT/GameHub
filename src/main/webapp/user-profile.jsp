<%@page import="DAO.UserDAO"%>
<%@ page import="java.util.List, Model.UserModel, mongodb.MongoConectUser" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="background-user.css">
        <link rel="stylesheet" href="css/bootstrap.min.css" />
        <link rel="stylesheet" href="css/font-awesome.min.css" />
        <link rel="stylesheet" href="css/slicknav.min.css" />
        <link rel="stylesheet" href="css/owl.carousel.min.css" />
        <link rel="stylesheet" href="css/magnific-popup.css" />
        <link rel="stylesheet" href="css/animate.css" />
        <link rel="stylesheet" href="css/searchbar.css" />
        <link rel="stylesheet" href="css/account-icon.css" />
        <link href="css/cssfpt1.css" rel="stylesheet" />
        <link href="img/favicon.ico" rel="shortcut icon" />
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
                background-color: #343a40;
                color: white;
            }
            body {
                background-image: url('img/Gif1.gif'); /* Update the path as needed */
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
            }
            .container {
                min-height: 78vh;
            }
            .form-control {
                background-color: #495057;
                color: white;
            }
            .btn-secondary {
                background-color: #6c757d;
            }
            .btn-secondary:hover {
                background-color: #5a6268;
            }
            /* Popup styles */
            .popup {
                display: none;
                position: fixed;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.7);
                z-index: 1000;
                justify-content: center;
                align-items: center;
            }
            .popup-content {
                background-color: #6f2b95;
                padding: 20px;
                border-radius: 8px;
                width: 400px;
                text-align: center;
            }
            .close-btn {
                cursor: pointer;
                color: white;
                font-weight: bold;
                position: absolute;
                top: 10px;
                right: 15px;
            }
        </style>
    </head>
    <body>
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
                        <a href="ReadGameHomeMember?userId=<%= request.getSession().getAttribute("adminId")%>" class="site-logo">
                            <img src="./img/logo1.png" alt="" class="logo1">
                            <img src="./img/logo2.png" alt="" class="logo2">
                        </a>
                    </div>
                    <nav class="top-nav-area w-100">
                        <div class="user-panel d-flex">

                            <div class="account-container">
                                <div class="user">                                   
                                    <img src="data:image/jpeg;base64,<%= request.getSession().getAttribute("photoUrl")%>" 
                                         alt="Profile Picture" 
                                         style="width: 50px; height: 50px; border-radius: 50%;" 
                                         onerror="this.onerror=null;this.src='img/t-rex.png';" />
                                </div>
                                <div class="account-dropdown">
                                    <ul>
                                        <li><a href="user-profile.jsp?userid=<%= request.getSession().getAttribute("adminId")%>">Account Info</a></li>
                                        <li>
                                            <a href="LogOut" class="dropdown-item">Logout</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- Menu -->

                        <%
                            String id = request.getParameter("userid");
                            UserDAO mgcn = new UserDAO();
                            UserModel user = mgcn.getUserById(id);
                            if (user == null) {
                                out.println("User not found.");
                                return;
                            }

                            String name = user.getName();
                            String profilePicture = user.getPhotoUrl();
                            String email = user.getEmail();
                            String phone = user.getPhone();
                            String photo = user.getPhotoUrl();
                            String address = user.getAddress();
                            String role = user.getRole().equals("1") ? "Administrator" : "Member";
                            String homePage = user.getRole().equals("1") ? "ReadGameHomeAdmin" : "ReadGameHomeMember";
                        %>
                        <ul class="main-menu primary-menu">
                            <% if ("Administrator".equals(role)) {%>
                            <!-- Menu for Administrator -->
                            <li><a href="ReadGameHomeAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>">Home</a></li>
                            <li><a href="ReadGameListAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>">Games</a></li>
                            <li><a href="ReadTopicAdmin?adminId=<%= request.getSession().getAttribute("adminId")%>">Forum</a></li>
                            <li><a href="ReadGameHomeAdmin?view=chart&adminId=<%= request.getSession().getAttribute("adminId")%>">Manage</a></li>
                                <% } else {%>
                            <!-- Menu for Member -->
                            <li><a href="ReadGameHomeMember?userId=<%= request.getSession().getAttribute("adminId")%>">Home</a></li>
                            <li><a href="ReadGameListMember?userId=<%= request.getSession().getAttribute("adminId")%>">Games</a></li>
                            <li><a href="ReadTopicMember?userId=<%= request.getSession().getAttribute("adminId")%>">Forum</a></li>
                            <li><a href="contact-after-login-member.jsp?userId=<%= request.getSession().getAttribute("adminId")%>">Contact</a></li>
                                <% } %>
                        </ul>

                    </nav>
                </div>
            </div>
        </header>
        <!-- Header section end -->

        <section class ="page-top-section">
            <div class="container">
                <div class="row flex-lg-nowrap">
                    <div class="col"> 
                        <div class="row">
                            <div class="col mb-3">
                                <div class="card" style="background-color: #6f2b95;">
                                    <div class="card-body">
                                        <div class="e-profile">
                                            <div class="row">
                                                <div class="col-12 col-sm-auto mb-3">
                                                    <div class="mx-auto" style="width: 140px;">
                                                        <div class="d-flex justify-content-center align-items-center rounded" style="height: 140px; background-color: rgb(233, 236, 239);">
                                                            <% if (photo != null && !photo.isEmpty()) {%>
                                                            <img src="data:image/jpeg;base64,<%= photo%>" style="width: 140px; height: 140px;" alt="Profile Picture" />
                                                            <% } else { %>
                                                            <span style='color: rgb(166, 168, 170); font: bold 8pt Arial;'>No Photo</span>
                                                            <% }%>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col d-flex flex-column flex-sm-row justify-content-between mb-3">
                                                    <div class="text-center text-sm-left mb-2 mb-sm-0">
                                                        <h4 class="pt-sm-2 pb-1 mb-0 text-nowrap"><%= name%></h4>
                                                        <div class="mt-2">

                                                            <form id="uploadForm" action="UploadPhoto" method="post" enctype="multipart/form-data">
                                                                <div class="input-field">
                                                                    <label class="mr-2">Change Photo</label>
                                                                    <input type="file" name="photoInput" required>
                                                                </div>
                                                                <input type="hidden" name="userId" value="<%= id%>">
                                                                <button type="submit" class="btn btn-primary mt-3">Upload Photo</button>
                                                            </form>

                                                        </div>
                                                    </div>
                                                    <div class="text-center text-sm-right">
                                                        <span class="badge badge-secondary"><%= role%></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="tab-content pt-3">
                                                <div class="tab-pane active">
                                                    <form class="form" novalidate="">
                                                        <div class="row">
                                                            <div class="col">
                                                                <div class="form-group">
                                                                    <label>Name</label>
                                                                    <div class="form-control"><%= name%></div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label>Email</label>
                                                                    <div class="form-control"><%= email%></div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label>Phone</label>
                                                                    <div class="form-control"><%= phone%></div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label>Address</label>
                                                                    <div class="form-control"><%= address%></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row mb-3">
                                                            <div class="col-12 col-sm-6">
                                                                <button class="btn btn-secondary" type="button" onclick="openEditPopup()">
                                                                    Edit Information
                                                                </button>
                                                            </div>
                                                            <div class="col-12 col-sm-6 text-sm-right">
                                                                <a href="change-password.jsp?id=<%= id%>" class="btn btn-secondary">
                                                                    Change Password
                                                                </a>
                                                            </div>
                                                        </div>
                                                        <div class="row mb-3">
                                                            <div class="col-12 text-center">
                                                                <a href="<%=homePage%>?id=<%= id%>" class="btn btn-secondary">
                                                                    Go Back to Home
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Popup for Editing Information -->
        <div id="editPopup" class="popup">
            <div class="popup-content">
                <span class="close-btn" onclick="closeEditPopup()">&times;</span>
                <h4>Edit Information</h4>
                <form id="editForm" action="EditUserServlet" method="post">
                    <input type="hidden" name="id" value="<%= id%>">
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text" class="form-control" name="name" value="<%= name%>" required>
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" class="form-control" name="email" value="<%= email%>" required>
                    </div>
                    <div class="form-group">
                        <label>Phone</label>
                        <input type="text" class="form-control" name="phone" value="<%= phone%>" required>
                    </div>
                    <div class="form-group">
                        <label>Address</label>
                        <input type="text" class="form-control" name="address" value="<%= address%>" required>
                    </div>
                    <button type="submit" class="btn btn-secondary">Save Changes</button>
                </form>
            </div>
        </div>
    </section>
    <script>

        document.addEventListener("DOMContentLoaded", function () {
            const bodyElement = document.querySelector('body');
            const bgImage = bodyElement.getAttribute('data-sbg');
            if (bgImage) {
                bodyElement.style.backgroundImage = `url(${bgImage})`;
                bodyElement.style.backgroundSize = 'cover';
                bodyElement.style.backgroundPosition = 'center';
                bodyElement.style.backgroundRepeat = 'no-repeat';
                bodyElement.style.backgroundAttachment = 'fixed';
            }
        });

        function openEditPopup() {
            document.getElementById("editPopup").style.display = "flex";
        }

        function closeEditPopup() {
            document.getElementById("editPopup").style.display = "none";
        }

        // Close popup when clicking outside of the popup content
        window.onclick = function (event) {
            var popup = document.getElementById("editPopup");
            if (event.target === popup) {
                closeEditPopup();
            }
        };


        document.getElementById('photoInput').addEventListener('change', function () {
            document.getElementById('uploadForm').submit();
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

</body>
</html>
