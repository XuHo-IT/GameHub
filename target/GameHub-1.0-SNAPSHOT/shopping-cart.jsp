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
        <section class="h-100 h-custom" style="background-color: #6f2b95 ;">
          <div class="container py-5 h-100">
            <div class="row d-flex justify-content-center align-items-center h-100">
              <div class="col-12">
                <div class="card card-registration card-registration-2" style="border-radius: 15px; background-color: black;">
                  <div class="card-body p-0">
                    <div class="row g-0">
                      <div class="col-lg-8">
                        <div class="p-5">
                          <div class="d-flex justify-content-between align-items-center mb-5">
                            <h1 class="fw-bold mb-0" style="color:antiquewhite">Wishlist</h1>
                            <h6 class="mb-0 text-muted" style="color:antiquewhite">3 items</h6>
                          </div>
                          <hr class="my-4">

                          <div class="row mb-4 d-flex justify-content-between align-items-center">
                            <div class="col-md-2 col-lg-2 col-xl-2">
                              <img
                                src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-shopping-carts/img5.webp"
                                class="img-fluid rounded-3" alt="Cotton T-shirt">
                            </div>
                            <div class="col-md-3 col-lg-3 col-xl-3">
                              <h6 class="text-muted" style="color:antiquewhite">Shirt</h6>
                              <h6 class="mb-0" style="color:antiquewhite">Cotton T-shirt</h6>
                            </div>
                            <div class="col-md-3 col-lg-3 col-xl-2 d-flex">
                                <button data-mdb-button-init data-mdb-ripple-init class="btn btn-link px-2"
                                    onclick="this.parentNode.querySelector('input[type=number]').stepDown()">
                                    <img src="./img/pngegg_1.png" alt="Icon" style="width: 20px; height: 20px;">
                                </button>
                            </div>
                          </div>
                          <div class="row mb-4 d-flex justify-content-between align-items-center">
                            <div class="col-md-2 col-lg-2 col-xl-2">
                              <img
                                src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-shopping-carts/img6.webp"
                                class="img-fluid rounded-3" alt="Cotton T-shirt">
                            </div>
                            <div class="col-md-3 col-lg-3 col-xl-3">
                              <h6 class="text-muted" style="color:antiquewhite">Shirt</h6>
                              <h6 class="mb-0" style="color:antiquewhite">Cotton T-shirt</h6>
                            </div>
                            <div class="col-md-3 col-lg-3 col-xl-2 d-flex">
                                <button data-mdb-button-init data-mdb-ripple-init class="btn btn-link px-2"
                                    onclick="this.parentNode.querySelector('input[type=number]').stepDown()">
                                    <img src="./img/pngegg_1.png" alt="Icon" style="width: 20px; height: 20px;">
                                </button>
                            </div>
                          </div>
                          <div class="row mb-4 d-flex justify-content-between align-items-center">
                            <div class="col-md-2 col-lg-2 col-xl-2">
                              <img
                                src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-shopping-carts/img7.webp"
                                class="img-fluid rounded-3" alt="Cotton T-shirt">
                            </div>
                            <div class="col-md-3 col-lg-3 col-xl-3">
                              <h6 class="text-muted" style="color:antiquewhite">Shirt</h6>
                              <h6 class="mb-0" style="color:antiquewhite">Cotton T-shirt</h6>
                            </div>
                            <div class="col-md-3 col-lg-3 col-xl-2 d-flex">
                                <button data-mdb-button-init data-mdb-ripple-init class="btn btn-link px-2"
                                    onclick="this.parentNode.querySelector('input[type=number]').stepDown()">
                                    <img src="./img/pngegg_1.png" alt="Icon" style="width: 20px; height: 20px;">
                                </button>
                              </button>
                            </div>
                          </div>
                          <div class="pt-5">
                            <h6 class="mb-0"><a href="index.html" class="text-body" style="color:antiquewhite"><i
                                  class="fas fa-long-arrow-alt-left me-2" style="color:antiquewhite"></i>Back to shop</a></h6>
                          </div>
                        </div>
                      </div>
                      <div class="col-lg-4 bg-body-tertiary">
                        <div class="p-5">
                          <h3 class="fw-bold mb-5 mt-2 pt-1" style="color:antiquewhite">Summary</h3>
                          <hr class="my-4">
                          <div class="d-flex justify-content-between mb-4"> 
                          </div>
                          <h5 class="text-uppercase mb-3" style="color:antiquewhite">Get notification</h5>
                          <div class="mb-5">
                            <div data-mdb-input-init class="form-outline">
                              <input type="text" id="form3Examplea2" class="form-control form-control-lg" />
                              <label class="form-label" for="form3Examplea2" style="color:antiquewhite">Enter your email</label>
                            </div>
                          </div>
                        <hr class="my-4">
                            <div class="d-flex justify-content-between mb-5">
                              <h5 class="text-uppercase" style="color:antiquewhite">Total price</h5>
                              <h5 style="color:antiquewhite"></h5>
                            </div>
                          <div class="button-group">
                        <button type="button" onclick="location.href='game-single-after-login.jsp?id=<%= request.getParameter("gameId") %>';" 
                                class="btn btn-block btn-lg" style="background-color:#C20000; color:antiquewhite;">
                            Cancel
                        </button>
                        <button type="button" data-mdb-button-init data-mdb-ripple-init 
                                class="btn btn-dark btn-block btn-lg" data-mdb-ripple-color="dark" 
                                style="color:antiquewhite;">
                            Send
                        </button>
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