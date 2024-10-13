<!DOCTYPE html>
<%@page import="com.mongodb.client.model.Sorts"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<!DOCTYPE html>
<%@ page import="com.mongodb.client.MongoClients, com.mongodb.client.MongoClient, com.mongodb.client.MongoCollection, org.bson.Document, org.bson.types.ObjectId, com.mongodb.client.model.Filters" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
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
        <link rel="stylesheet" href="css/account-icon.css" />

        <!-- Main Stylesheets -->
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet"
              href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@48,400,0,0">
        <link rel="stylesheet" href="Login/style.css">
        <script src="Login/script.js" defer></script>
    </head>
    <body>
        <section class=" h-custom" style="background-color: #6f2b95 ;">
          <div class="container py-5 h-100">
            <div class="row d-flex justify-content-center align-items-center h-100">
              <div class="col-12">
                <div class="card card-registration card-registration-2" style="border-radius: 15px; background-color: black;">
                  <div class="card-body p-0">
                    <div class="row g-0">
                      <div class="col-lg-8">
                        <div class="p-5">
                          <div class="d-flex justify-content-between align-items-center mb-5">
                            <h1 class="fw-bold mb-0" style="color:antiquewhite">Wishlist Item</h1>
                          </div>
                          <hr class="my-4">

                          <div class="row mb-4 d-flex justify-content-between align-items-center">
                            
                              <% 
                                    String postId = request.getParameter("postId");
                                    String title = request.getParameter("title");
                                    String fileData = request.getParameter("fileData");
                                    String dateRelease = request.getParameter("dateRelease");
                                    String author = request.getParameter("author");
                     
                            // Check if the data exists
                            if (postId != null && title != null && author != null && fileData != null) {
                        %>
                                <div class="wishlist-item">
                                    <img src="data:image/jpeg;base64,<%= fileData %>" alt="Game Image" />
                                    <p>Title: <%= title %></p>
                                    <p>Author: <%= author %></p>
                                </div>
                        <%
                            } else {
                                out.println("No game data found.");
                            }
                        %>

                        <!-- Email form and send button -->
                        <form id="wishlistForm" action="GameReleaseNotificationMemberController" method="post">
                            <input type="hidden" name="postId" value="<%= postId %>" />
                            <input type="hidden" name="title" value="<%= title %>" />
                            <input type="hidden" name="fileData" value="<%= fileData %>" />
                            <input type="hidden" name="dateRelease" value="<%= dateRelease %>" />
                            <input type="hidden" name="author" value="<%= author %>" />

                            <label for="userEmail">Enter your email:</label>
                            <input type="email" name="userEmail" required />

                            <button type="submit">Send</button>
                        </form>
                        <form action="game-single.jsp?id=<%= postId %>" method="GET">
                            <button type="submit">Cancel</button>
                        </form>

                        <script>
                            function validateEmail() {
                                var email = document.getElementById('emailField').value;
                                if (email === '') {
                                    alert("Please enter your email before submitting.");
                                    return false;
                                }
                                return true;
                            }
                        </script>
                            </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.slicknav.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/jquery.sticky-sidebar.min.js"></script>
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>