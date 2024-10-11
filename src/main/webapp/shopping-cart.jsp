<%@page import="com.mongodb.client.model.Filters"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="com.mongodb.client.MongoClients"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="com.mongodb.client.MongoClient"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/background.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>

<section class="h-100 h-custom" style="background-color: #6f2b95 ;">
     <%
            String title = null;
            String gamePlay = null;
            String author = null;
            String genre = null;
            String description = null;
            String dateRelease = null;
            String fileData = null;
            double priceRating = 0.0;
            double graphicRating = 0.0;
            double difficultyRating = 0.0;
            double gameplayRating = 0.0;
            double averageRating = 0.0;

            // Get the post ID from the URL query parameter
            String postId = request.getParameter("id");
            System.out.println("Post ID: " + postId);

            // Connect to MongoDB
            MongoClient mongoClient = MongoClients.create("mongodb+srv://LoliHunter:Loli_slayer_123@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub"); // Your connection string
            MongoCollection<Document> postsCollection = mongoClient.getDatabase("GameHub").getCollection("postGame");

            // Find the post by its ObjectId
            Document post = postsCollection.find(Filters.eq("_id", new ObjectId(postId))).first();

            // Check if the post exists
            if (post != null) {
                gamePlay = post.getString("GamePlay");
                author = post.getString("Author");
                genre = post.getString("Genre");
                title = post.getString("Title"); // Ensure correct case
                description = post.getString("Description"); // Ensure correct case
                dateRelease = post.getString("DateRelease"); // Ensure correct case
                fileData = post.getString("FileData"); // Ensure correct case
                priceRating = post.getDouble("PriceRating");
                graphicRating = post.getDouble("GraphicRating");
                difficultyRating = post.getDouble("DifficultyRating");
                gameplayRating = post.getDouble("GameplayRating");
                averageRating = post.getDouble("AverageRating");

                // Log retrieved values
                System.out.println("Title: " + title);
                System.out.println("Description: " + description);
                System.out.println("Date Release: " + dateRelease);
                System.out.println("File Data: " + fileData);
            } else {
                out.println("Post not found.");
            }

            // Close MongoDB connection
            mongoClient.close();
        %>
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-12">
        <div class="card card-registration card-registration-2" style="border-radius: 15px; background-color: black;">
          <div class="card-body p-0">
            <div class="row g-0">
              <div class="col-lg-8">
                <div class="p-5">
                  <div class="d-flex justify-content-between align-items-center mb-5">
                    <h1 class="fw-bold mb-0" style="color:antiquewhite">Shopping Cart</h1>
                    --<h6 class="mb-0 text-muted" style="color:antiquewhite"></h6>
                  </div>
                  <hr class="my-4">

                 
                  <div class="row mb-4 d-flex justify-content-between align-items-center">
                    <div class="col-md-2 col-lg-2 col-xl-2">
                     <img src="data:image/png;base64,<%= fileData %>" class="same-size" alt="Game Image" />

                    </div>
                    <div class="col-md-3 col-lg-3 col-xl-3">
                      <h6 class="text-muted" style="color:antiquewhite"><%= genre%></h6>
                      <h6 class="mb-0" style="color:antiquewhite"><%= title %></h6>
                    </div>
                    <div class="col-md-3 col-lg-3 col-xl-2 d-flex">
                      <input id="form1" min="1" name="quantity" value="1" type="number" class="form-control form-control-sm" />
                    </div>
                    <div class="col-md-3 col-lg-2 col-xl-2 offset-lg-1">
                      <h6 class="mb-0" style="color:antiquewhite">$<%= description %></h6>
                    </div>
                    <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                      <a href="#!" class="text-muted"><i class="fas fa-times"></i></a>
                    </div>
                  </div>
                  <hr class="my-4">
                 

                  <div class="pt-5">
                    <h6 class="mb-0"><a href="index.html" class="text-body" style="color:antiquewhite"><i class="fas fa-long-arrow-alt-left me-2" style="color:antiquewhite"></i>Back to shop</a></h6>
                  </div>
                </div>
              </div>
              <div class="col-lg-4 bg-body-tertiary">
                <div class="p-5">
                  <h3 class="fw-bold mb-5 mt-2 pt-1" style="color:antiquewhite">Summary</h3>
                  <hr class="my-4">

                  <div class="d-flex justify-content-between mb-4">
                    <h5 class="text-uppercase" style="color:antiquewhite">items </h5>
                    <h5 style="color:antiquewhite"></h5>
                  </div>

                  <h5 class="text-uppercase mb-3" style="color:antiquewhite">Shipping</h5>

                  <div class="mb-4 pb-2">
                    <select data-mdb-select-init class="form-control">
                      <option value="1" style="color:black">Standard Delivery - $5.00</option>
                      <option value="2" style="color:black">Express Delivery - $15.00</option>
                    </select>
                  </div>

                  <h5 class="text-uppercase mb-3" style="color:antiquewhite">Give code</h5>

                  <div class="mb-5">
                    <div data-mdb-input-init class="form-outline">
                      <input type="text" id="form3Examplea2" class="form-control form-control-lg" />
                      <label class="form-label" for="form3Examplea2" style="color:antiquewhite">Enter your code</label>
                    </div>
                  </div>

                  <hr class="my-4">

                  <div class="d-flex justify-content-between mb-5">
                    <h5 class="text-uppercase" style="color:antiquewhite">Total price</h5>
                    <h5 style="color:antiquewhite"></h5>
                  </div>

                  <form action="PaymentServlet" method="post">
                    <a href="vnpay/web/vnpay_pay.jsp" class="btn btn-dark btn-block btn-lg" style="color:antiquewhite; text-decoration: none;">Buy Now</a>

                  </form>

                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
</html>
