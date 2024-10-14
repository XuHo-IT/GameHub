<%@ page import="java.util.List, Model.UserModel, mogodb.MongoConectUser" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="background-user.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        .container {
            min-height: 100vh;
        }
        .popup {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }
        .popup-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body data-sbg="img/tnk229NQH3hSUPXLDBKNUA.jpg">
    <% 
    String id = request.getParameter("id");
    MongoConectUser mgcn = new MongoConectUser();
    UserModel user = mgcn.getUserById(id);
    if (user == null) {
        out.println("User not found.");
        return; // Ng?ng x? lý n?u không tìm th?y ng??i dùng
    }
    String name = user.getName();
    String profilePicture = user.getPhotoUrl();  // Assuming this method exists
    String email = user.getEmail();
    String dob = user.getDateOfBirth();
    String phone = user.getPhone();
    String address = user.getAddress();
    String status = user.getStatus();
    String role;
    if (user.getRole().equals("1")) {
        role = "Administrator";
    } else {
        role = "Member";
    }
    %>
    
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
    <div class="container">
        <div class="row flex-lg-nowrap">
            <div class="col-12 col-lg-auto mb-3" style="width: 200px;">
                <div class="card p-3">
                    <div class="e-navlist e-navlist--active-bg">
                        <ul class="nav">
                            <li class="nav-item"><a class="nav-link px-2 active" href="#" style="color: #ebaa3bb0"><i class="fa fa-fw fa-bar-chart mr-1"></i><span>Overview</span></a></li>
                            <li class="nav-item"><a class="nav-link px-2" href="https://www.bootdey.com/snippets/view/bs4-crud-users" target="__blank" style="color: #ebaa3bb0"><i class="fa fa-fw fa-th mr-1"></i><span>CRUD</span></a></li>
                            <li class="nav-item"><a class="nav-link px-2" href="https://www.bootdey.com/snippets/view/bs4-edit-profile-page" target="__blank" style="color: #ebaa3bb0"><i class="fa fa-fw fa-cog mr-1"></i><span>Settings</span></a></li>
                        </ul>
                    </div>
                </div>
            </div>

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
                                                    <% if (profilePicture != null && !profilePicture.isEmpty()) { %>
                                                        <img src='<%= profilePicture %>' style='width: 140px; height: 140px; border-radius: 50%;'/>
                                                    <% } else { %>
                                                        <span style='color: rgb(166, 168, 170); font: bold 8pt Arial;'>140x140</span>
                                                    <% } %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col d-flex flex-column flex-sm-row justify-content-between mb-3">
                                            <div class="text-center text-sm-left mb-2 mb-sm-0" style="color: antiquewhite;">
                                                <h4 class="pt-sm-2 pb-1 mb-0 text-nowrap"><%= name %></h4>
                                                <div class="text-muted"><small style="color: antiquewhite;">Last seen 2 hours ago</small></div>
                                                <div class="mt-2">
                                                    <button class="btn btn-primary" type="button" onclick="document.getElementById('photoInput').click();">
                                                        <i class="fa fa-fw fa-camera"></i>
                                                        <span>Change Photo</span>
                                                    </button>
                                                    <form id="uploadForm" action="upload-photo" method="post" enctype="multipart/form-data">
                                                        <input type="file" name="photo" id="photoInput" style="display:none;">
                                                        <input type="hidden" name="userId" value="<%= id %>">
                                                    </form>
                                                </div>
                                            </div>
                                            <div class="text-center text-sm-right">
                                                <span class="badge badge-secondary"><%= role %></span>
                                                <div class="text-muted"><small style="color: antiquewhite;">Joined 09 Dec 2017</small></div>
                                            </div>
                                        </div>
                                    </div>
                                    <ul class="nav nav-tabs">
                                        <li class="nav-item"><a href="" class="active nav-link">Settings</a></li>
                                    </ul>
                                    <div class="tab-content pt-3">
                                        <div class="tab-pane active">
                                            <form class="form" novalidate="">
                                                <div class="row">
                                                    <div class="col">
                                                        <div class="row">
                                                            <div class="col">
                                                                <div class="form-group" style="color: antiquewhite;">
                                                                    <label>Name</label>
                                                                    <div class="form-control" style="background-color: #343a40; color: white;"> <!-- Black background -->
                                                                        <%= name %>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col">
                                                                <div class="form-group" style="color: antiquewhite;">
                                                                    <label>Email</label>
                                                                    <div class="form-control" style="background-color: #343a40; color: white;"> <!-- Black background -->
                                                                        <%= email %>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col mb-3">
                                                                <div class="form-group" style="color: antiquewhite;">
                                                                    <label>Phone</label>
                                                                    <div class="form-control" style="background-color: #343a40; color: white;"> <!-- Black background -->
                                                                        <%= phone %>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col mb-3">
                                                                <div class="form-group" style="color: antiquewhite;">
                                                                    <label>Address</label>
                                                                    <div class="form-control" style="background-color: #343a40; color: white;"> <!-- Black background -->
                                                                        <%= address %>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-12 col-sm-6 mb-3">
                                                        <button class="btn btn-secondary" type="button" onclick="openEditPopup()">
                                                            Edit Information
                                                        </button>
                                                    </div>
                                                    <div class="row">
                                                    <a href="change-password.jsp?id=<%=id%>" class="btn btn-secondary">
                                                        Change Password
                                                    </a>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <a href="change-password.jsp?id=<%=id%>" class="btn btn-secondary">
                                                        Change Password
                                                    </a>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 col-md-3 mb-3">
                        <div class="card mb-3">
                            <div class="card-body">
                                <div class="px-xl-3">
                                    <button class="btn btn-block btn-secondary" onclick="location.href='index.jsp'">
                                        <i class="fa fa-sign-out"></i>
                                        <span>Logout</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <h6 class="card-title font-weight-bold">Support</h6>
                                <p class="card-text">Get fast, free help from our friendly assistants.</p>
                                <button type="button" class="btn btn-primary">Contact Us</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Popup for editing user information -->
        <div id="editPopup" class="popup">
            <div class="popup-content">
                <span class="close" onclick="closeEditPopup()">&times;</span>
                <h2>Edit User Information</h2>
                <form action="update-user" method="post">
                    <input type="hidden" name="userId" value="<%= id %>">
                    <div class="form-group">
                        <label for="editName">Name</label>
                        <input type="text" class="form-control" id="editName" name="name" value="<%= name %>" required>
                    </div>
                    <div class="form-group">
                        <label for="editEmail">Email</label>
                        <input type="email" class="form-control" id="editEmail" name="email" value="<%= email %>" required>
                    </div>
                    <div class="form-group">
                        <label for="editPhone">Phone</label>
                        <input type="text" class="form-control" id="editPhone" name="phone" value="<%= phone %>" required>
                    </div>
                    <div class="form-group">
                        <label for="editAddress">Address</label>
                        <input type="text" class="form-control" id="editAddress" name="address" value="<%= address %>" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Update</button>
                </form>
            </div>
        </div>

    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
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

        document.getElementById('photoInput').addEventListener('change', function() {
            document.getElementById('uploadForm').submit();
        });

        function openEditPopup() {
            document.getElementById("editPopup").style.display = "block";
        }

        function closeEditPopup() {
            document.getElementById("editPopup").style.display = "none";
        }

        // Close the popup when clicking outside of it
        window.onclick = function(event) {
            const popup = document.getElementById("editPopup");
            if (event.target == popup) {
                popup.style.display = "none";
            }
        }
    </script>
</body>
</html>
