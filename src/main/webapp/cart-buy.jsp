<%@ page import="com.mongodb.client.model.Sorts" %>
<%@ page import="com.mongodb.client.MongoCursor" %>
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
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@48,400,0,0">
        <link rel="stylesheet" href="Login/style.css">
        <script src="Login/script.js" defer></script>
    </head>
    <body>
        <section class="h-custom" style="background-color: #6f2b95;">
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
                                                    MongoClient mongoClient = null;
                                                    String title = null;
                                                    String fileData = null;
                                                    String dateRelease = null;
                                                    String author = null;

                                                    try {
                                                        mongoClient = MongoClients.create("mongodb+srv://LoliHunter:Loli_slayer_123@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");

                                                        MongoCollection<Document> collection = mongoClient.getDatabase("GameHub").getCollection("postGame");

                                                        String postId = request.getParameter("postId");
                                                     

                                                        if (postId == null || postId.isEmpty()) {
                                                            out.println("No post ID provided.");
                                                            return; // Exit early
                                                        }

                                                        if (postId.length() != 24) {
                                                            out.println("Invalid post ID format.");
                                                            return; // Exit early
                                                        }

                                                        Document post = collection.find(Filters.eq("_id", new ObjectId(postId))).first(); // Fetching the post by postId

                                                        // Check if the post data exists
                                                        if (post != null) {
                                                            title = post.getString("Title");
                                                            fileData = post.getString("FileData");
                                                            dateRelease = post.getString("DateRelease");
                                                            author = post.getString("Author");
                                                %>
                                                <div class="wishlist-item">
                                                    <img src="data:image/jpeg;base64,<%= fileData%>" alt="Game Image" />
                                                    <p>Title: <%= title%></p>
                                                    <p>Author: <%= author%></p>
                                                </div>
                                                <%
                                                        } else {
                                                            out.println("No game data found.");
                                                        }
                                                    } catch (Exception e) {
                                                        out.println("Error fetching post: " + e.getMessage());
                                                        e.printStackTrace(); // Log the exception
                                                    } finally {
                                                        if (mongoClient != null) {
                                                            mongoClient.close(); // Ensure the connection is closed
                                                        }
                                                    }
                                                %>

                                                <!-- Email form and send button -->

                                                <button type="submit">Buy</button>
                                                </form>
                                                <form action="game-single.jsp?id=<%= request.getParameter("postId")%>" method="GET">
                                                    <button type="submit">Cancel</button>
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
