<%@page import="utils.MongoDBConnectionManager"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.SortedMap"%>
<%@page import="Controller.Config"%>
<%@page import="com.mongodb.client.MongoClient"%>
<%@page import="com.mongodb.client.MongoClients"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="org.bson.Document"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="com.mongodb.client.model.Filters"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="description" content="EndGam Gaming Magazine Template">
        <meta name="keywords" content="endGam,gGaming, magazine, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>EndGam - Gaming Magazine Template</title>
        <!-- Favicon -->
        <link href="img/favicon.ico" rel="shortcut icon"/>
        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css?family=Roboto:400,400i,500,500i,700,700i,900,900i" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Sixtyfour+Convergence&display=swap" rel="stylesheet">
        <!-- Stylesheets -->
        <link rel="stylesheet" href="css/bootstrap.min.css" />
        <link rel="stylesheet" href="css/font-awesome.min.css" />
        <link rel="stylesheet" href="css/slicknav.min.css" />
        <link rel="stylesheet" href="css/owl.carousel.min.css" />
        <link rel="stylesheet" href="css/magnific-popup.css" />
        <link rel="stylesheet" href="css/animate.css" />
        <link rel="stylesheet" href="css/searchbar.css" />
        <link rel="stylesheet" href="css/account-icon.css" />
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="Login/style.css">
        <script src="Login/script.js" defer></script>
    </head>
    <body>
        <section class="h-custom" style="background: url('img/bg-order.jpg');
                 background-size: 100%;
                 background-repeat: no-repeat;
                 background-position: top;">
            <div class="container py-5 h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-14">
                        <div class="card card-registration card-registration-2" style="border-radius: 15px; background-color: black; width: 80%; height: auto; margin: 0 auto;">
                            <div class="card-body p-0">
                                <div class="row g-0" style="text-align: center;">
                                    <div class="col-lg-8" style="padding-right: 0px;">
                                        <div class="p-5" style="display: flex;
                                             flex-wrap: wrap;
                                             justify-content: center;
                                             padding: 1rem !important;">
                                            <div class="d-flex justify-content-between align-items-center mb-5">
                                                <h1 class="fw-bold mb-0" style="color:antiquewhite">Your Order</h1>
                                            </div>
                                            <%
                                                MongoClient mongoClient = MongoDBConnectionManager.getLocalMongoClient();
                                                try {

                                                    MongoCollection<Document> collection = mongoClient.getDatabase("GameHub").getCollection("postGame");
                                                    MongoCollection<Document> userCollection = mongoClient.getDatabase("GameHub").getCollection("superadmin");

                                                    String postId = request.getParameter("id");
                                                    String userId = request.getParameter("userId");

                                                    Document user = userCollection.find(Filters.eq("_id", new ObjectId(userId))).first();
                                                    String photoUrl = user.getString("PhotoUrl");

                                                    if (postId == null || postId.isEmpty() || postId.length() != 24) {
                                                        out.println("<p style='color:red;'>Invalid post ID provided.</p>");
                                                        return;
                                                    }

                                                    Document post = collection.find(Filters.eq("_id", new ObjectId(postId))).first();
                                                    if (post != null) {
                                                        String title = post.getString("Title");
                                                        String fileData = post.getString("FileData");
                                                        String dateRelease = post.getString("DateRelease");
                                                        String author = post.getString("Author");
                                                        String link = post.getString("LinkGame");
                                                        String price = post.getString("Price");
                                            %>

                                            <div class="wishlist-item row" style="display:flex">
                                                <div class="col-6">
                                                    <img src="data:image/jpeg;base64,<%= fileData%>" alt="Game Image" style="width: 100%; height: auto;" />
                                                    <form>
                                                        <!-- Updated Cancel Button to Include postId and adminId -->
                                                        <button 
                                                            onclick="window.location.href = 'game-single-after-login-member.jsp?id=<%= postId%>&adminId=<%= userId%>'" 
                                                            type="button">
                                                            Cancel
                                                        </button>
                                                    </form>
                                                </div>        
                                                <div class="col-6">
                                                    <div style="background-color: #1e1e1e; padding: 20px; border-radius: 10px;">
                                                        <h2 style="color: #ffcc00; font-size: 32px; font-weight: bold; margin-bottom: 15px;">Game Details</h2>
                                                        <p style="color: #ffffff; font-size: 22px; margin-bottom: 10px;">
                                                            <strong>Title:</strong> <%= title%>
                                                        </p>
                                                        <p style="color: #ffffff; font-size: 22px; margin-bottom: 10px;">
                                                            <strong>Author:</strong> <%= author%>
                                                        </p>
                                                        <p style="color: #ffffff; font-size: 22px;">
                                                            <strong>Date Release:</strong> <%= dateRelease != null ? dateRelease : "Unknown"%>
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>  
                                        </div>
                                    </div>
                                    <div class="col-lg-4" style="padding-left: 0;">
                                        <img src="data:image/jpeg;base64,<%= photoUrl%>" alt="Game Image" style="width: 100%; height: auto; padding:10px 7px; border-radius: 50%;" />
                                        <form id="wishlistForm" action="GameReleaseNotificationMemberController" method="post">
                                            <input type="hidden" name="postId" value="<%= postId%>" />
                                            <input type="hidden" name="title" value="<%= title%>" />
                                            <input type="hidden" name="fileData" value="<%= fileData%>" />
                                            <input type="hidden" name="dateRelease" value="<%= dateRelease%>" />
                                            <input type="hidden" name="link" value="<%= link%>" />
                                            <input type="hidden" name="author" value="<%= author%>" />
                                            <div style="margin-top: 50px; margin-bottom: 5px">
                                                <p style="color:white;font-size:28px">Price: <%= price%>VND</p>
                                            </div>
                                        </form>
                                        <%
                                            SortedMap<String, String> params = new TreeMap<>();
                                            params.put("vnp_Version", "2.1.0");
                                            params.put("vnp_Command", "pay");
                                            params.put("vnp_TmnCode", "792CIWPF"); // Merchant Code
                                            params.put("vnp_Amount", String.valueOf(price != null ? Integer.parseInt(price) * 100 : 0)); // Amount
                                            params.put("vnp_CurrCode", "VND");
                                            params.put("vnp_CreateDate", new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
                                            params.put("vnp_IpAddr", request.getRemoteAddr());
                                            params.put("vnp_Locale", "vn");
                                            params.put("vnp_OrderInfo", "Payment for game: " + title);
                                            params.put("vnp_OrderType", "game");
                                            params.put("vnp_ReturnUrl", "https://yourdomain.com/VnPayReturn");
                                            params.put("vnp_ExpireDate", new SimpleDateFormat("yyyyMMddHHmmss").format(new Date(System.currentTimeMillis() + 300000)));
                                            // Generate secure hash
                                            String secretKey = "9T97RKKUE11F70PAIYAVYU1M5MPAKXRH"; 
                                            String secureHash = Config.getSecureHash(params, secretKey);
                                        %>

                                        <form id="paymentForm" action="vnpay-payment" method="post" onsubmit="setLinkValue()">
                                            <input type="hidden" name="vnp_Version" value="2.1.0">
                                            <input type="hidden" name="vnp_Command" value="pay">
                                            <input type="hidden" name="vnp_TmnCode" value="792CIWPF">
                                            <input type="hidden" name="vnp_Amount" value="<%= String.valueOf(price != null ? Integer.parseInt(price) * 100 : 0)%>">
                                            <input type="hidden" name="vnp_CurrCode" value="VND">
                                            <input type="hidden" name="vnp_CreateDate" value="<%= new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())%>">
                                            <input type="hidden" name="vnp_IpAddr" value="<%= request.getRemoteAddr()%>">
                                            <input type="hidden" name="vnp_Locale" value="vn">
                                            <input type="hidden" name="vnp_OrderInfo" value="Payment for game: <%= title%>">
                                            <input type="hidden" name="vnp_OrderType" value="game">
                                            <input type="hidden" name="vnp_ReturnUrl" value="https://yourdomain.com/VnPayReturn">
                                            <input type="hidden" name="vnp_ExpireDate" value="<%= new SimpleDateFormat("yyyyMMddHHmmss").format(new Date(System.currentTimeMillis() + 300000))%>">

                                            <!-- Hidden input for the original link value -->
                                            <input type="hidden" id="vnp_Link" name="vnp_Link" value="<%= link%>"> <!-- Original link value -->

                                            <!-- Hidden input for the user ID -->
                                            <input type="hidden" id="user_Id" name="user_Id" value="">

                                            <button type="submit" class="btn btn-success" style="margin-top: 10px;">Proceed to Payment</button>
                                        </form>

                                        <script>
                                            function setLinkValue() {
                                                var originalLinkValue = document.getElementById("vnp_Link").value;
                                                var userId = "<%= userId%>";

                                                var updatedLinkValue = originalLinkValue + "&UserID=" + userId;

                                                document.getElementById("vnp_Link").value = updatedLinkValue;
                                                document.getElementById("user_Id").value = userId;
                                            }
                                        </script>

                                        <%
                                                } else {
                                                    out.println("<p style='color:red;'>Post not found.</p>");
                                                }
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                                out.println("<p style='color:red;'>An error occurred while processing your request.</p>");
                                            }

                                        %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>
