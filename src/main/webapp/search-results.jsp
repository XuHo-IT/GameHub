<%@page import="com.mongodb.client.MongoDatabase"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.GamePost"%>
<%@page import="com.mongodb.client.model.Filters"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoClients"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="com.mongodb.client.MongoClient"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Results</title>
    <style>
        /* Basic styling for search results */
        .post-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: space-around;
        }
        .post {
            width: 30%;
            border: 1px solid #ccc;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .post:hover {
            transform: scale(1.05);
        }
        .post img {
            max-width: 100%;
            border-radius: 5px;
        }
        .pagination {
            text-align: center;
            margin-top: 20px;
        }
        .pagination a {
            margin: 0 5px;
            padding: 8px 16px;
            text-decoration: none;
            color: #007bff;
            border: 1px solid #007bff;
            border-radius: 5px;
        }
        .pagination a.active {
            background-color: #007bff;
            color: white;
        }
        .pagination a:hover {
            background-color: #0056b3;
            color: white;
        }
    </style>
</head>
<body>

<header>
    <h1>Search Results for "${param.keyword}"</h1>
    <a href="ReadGameListController.java">Back to Game List</a>
</header>
    
    <c:if test="${not empty postList}">
    <div class="post-container">
        <c:forEach var="post" items="${postList}">
            <div class="post">
                <h2>${post.title}</h2>
                <p><strong>Genre:</strong> ${post.genre}</p>
                <p><strong>Description:</strong> ${post.description}</p>
                <p><strong>Release Date:</strong> ${post.dateRelease}</p>
                <p><strong>Author:</strong> ${post.author}</p>
  
               <%
                        // Connect to MongoDB to retrieve ratings
                        MongoClient mongoClient = MongoClients.create("mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
                        MongoDatabase database = mongoClient.getDatabase("GameHub");
                        MongoCollection<Document> postsCollection = database.getCollection("postGame");
                        
                        // Fetch detailed post data by ObjectId
                        Document detailedPost = postsCollection.find(Filters.eq("_id", new ObjectId())).first();

                        double priceRating = 0.0;
                        double graphicRating = 0.0;
                        double difficultyRating = 0.0;
                        double gameplayRating = 0.0;
                        double averageRating = 0.0;

                        if (detailedPost != null) {
                            priceRating = detailedPost.getDouble("PriceRating");
                            graphicRating = detailedPost.getDouble("GraphicRating");
                            difficultyRating = detailedPost.getDouble("DifficultyRating");
                            gameplayRating = detailedPost.getDouble("GameplayRating");
                            averageRating = detailedPost.getDouble("AverageRating");
                        }
                        mongoClient.close();
                    %>
<!--
                    <p><strong>Price Rating:</strong> <%= priceRating %></p>
                    <p><strong>Graphic Rating:</strong> <%= graphicRating %></p>
                    <p><strong>Difficulty Rating:</strong> <%= difficultyRating %></p>
                    <p><strong>Gameplay Rating:</strong> <%= gameplayRating %></p>
                    <p><strong>Average Rating:</strong> <%= averageRating %></p>
-->
                <c:set var="ratings" value="${ratingsMap[post.postID]}" />
                <p><strong>Price Rating:</strong> ${ratings[0]}</p>
                <p><strong>Graphic Rating:</strong> ${ratings[1]}</p>
                <p><strong>Difficulty Rating:</strong> ${ratings[2]}</p>
                <p><strong>Gameplay Rating:</strong> ${ratings[3]}</p>
                <p><strong>Average Rating:</strong> ${ratings[4]}</p>

            <c:if test="${not empty post.fileData}">
                    <img src="data:image/png;base64,${post.fileData}" alt="${post.title}">
            </c:if>
            <c:if test="${empty post.fileData}">
                    <img src="placeholder-image.png" alt="No Image Available">
            </c:if>
                    <a href="game-single-after-login.jsp?id=${post.postID}" class="read-more">Read More  <img src="img/icons/double-arrow.png" alt="#"/></a>
            </div>
        </c:forEach>
         
    </div>

    <div class="pagination">
        <c:forEach var="i" begin="1" end="${totalPages}">
            <a href="?page=${i}&keyword=${param.keyword}" class="${i == currentPage ? 'active' : ''}">
                ${i}
            </a>
        </c:forEach>
    </div>
</c:if>

<c:if test="${empty postList}">
    <p>No results found for the keyword "<strong>${param.keyword}</strong>". Please try again with different keywords.</p>
</c:if>

</body>
</html>
