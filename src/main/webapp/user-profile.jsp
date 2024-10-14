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
            background-color: #343a40;
            color: white;
        }
        .container {
            min-height: 100vh;
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
    <%
        String id = request.getParameter("id");
        MongoConectUser mgcn = new MongoConectUser();
        UserModel user = mgcn.getUserById(id);
        if (user == null) {
            out.println("User not found.");
            return; // Ng?ng x? lý n?u không tìm th?y ng??i dùng
        }
        String name = user.getName();
        String profilePicture = user.getPhotoUrl(); // Gi? s? ph??ng th?c này t?n t?i
        String email = user.getEmail();
        String phone = user.getPhone();
        String address = user.getAddress();
        String role = user.getRole().equals("1") ? "Administrator" : "Member";
        String homePage = user.getRole().equals("1") ? "admin-after-login.jsp" : "after-login.jsp";
    %>

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
                                                    <% if (profilePicture != null && !profilePicture.isEmpty()) { %>
                                                        <img src='<%= profilePicture %>' style='width: 140px; height: 140px; border-radius: 50%;'/>
                                                    <% } else { %>
                                                        <span style='color: rgb(166, 168, 170); font: bold 8pt Arial;'>No Photo</span>
                                                    <% } %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col d-flex flex-column flex-sm-row justify-content-between mb-3">
                                            <div class="text-center text-sm-left mb-2 mb-sm-0">
                                                <h4 class="pt-sm-2 pb-1 mb-0 text-nowrap"><%= name %></h4>
                                                <div class="text-muted"><small>Last seen 2 hours ago</small></div>
                                            </div>
                                            <div class="text-center text-sm-right">
                                                <span class="badge badge-secondary"><%= role %></span>
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
                                                            <div class="form-control"><%= name %></div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label>Email</label>
                                                            <div class="form-control"><%= email %></div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label>Phone</label>
                                                            <div class="form-control"><%= phone %></div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label>Address</label>
                                                            <div class="form-control"><%= address %></div>
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
                                                        <a href="change-password.jsp?id=<%= id %>" class="btn btn-secondary">
                                                            Change Password
                                                        </a>
                                                    </div>
                                                </div>
                                                <div class="row mb-3">
                                                    <div class="col-12 text-center">
                                                        <a href="<%=homePage%>?id=<%= id %>" class="btn btn-secondary">
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

                    <div class="col-12 col-md-3 mb-3">
                        <div class="card mb-3">
                            <div class="card-body">
                                <div class="px-xl-3">
                                    <button class="btn btn-block btn-secondary" onclick="location.href='logout.jsp'">
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
    </div>

    <!-- Popup for Editing Information -->
    <div id="editPopup" class="popup">
        <div class="popup-content">
            <span class="close-btn" onclick="closeEditPopup()">&times;</span>
            <h4>Edit Information</h4>
            <form id="editForm" action="updateUser.jsp" method="post">
                <input type="hidden" name="id" value="<%= id %>">
                <div class="form-group">
                    <label>Name</label>
                    <input type="text" class="form-control" name="name" value="<%= name %>" required>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" class="form-control" name="email" value="<%= email %>" required>
                </div>
                <div class="form-group">
                    <label>Phone</label>
                    <input type="text" class="form-control" name="phone" value="<%= phone %>" required>
                </div>
                <div class="form-group">
                    <label>Address</label>
                    <input type="text" class="form-control" name="address" value="<%= address %>" required>
                </div>
                <button type="submit" class="btn btn-secondary">Save Changes</button>
            </form>
        </div>
    </div>

    <script>
        function openEditPopup() {
            document.getElementById("editPopup").style.display = "flex";
        }

        function closeEditPopup() {
            document.getElementById("editPopup").style.display = "none";
        }

        // Close popup when clicking outside of the popup content
        window.onclick = function(event) {
            var popup = document.getElementById("editPopup");
            if (event.target === popup) {
                closeEditPopup();
            }
        }
    </script>
</body>
</html>
