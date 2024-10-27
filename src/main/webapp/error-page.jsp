<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Error - System Issue</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 50px;
            background-color: #f8d7da;
            color: #721c24;
        }
        h1 {
            color: #721c24;
        }
        p {
            font-size: 18px;
        }
        .btn {
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1 class="error-title">Oops! Something Went Wrong</h1>

        <!-- Conditional error messages based on error type -->
        <c:choose>
            <!-- LoginController error -->
            <c:when test="${param.errorType == 'LoginController'}">
                <p class="error-message">There was an issue with your login. Please check your credentials and try again.</p>
                <p><a href="index.jsp">Back to Login</a></p>
            </c:when>

            <!-- ReadGameHomeAdmin error -->
            <c:when test="${param.errorType == 'ReadGameHomeAdmin'}">
                <p class="error-message">Unable to load the Admin Game Home. Please try refreshing the page or come back later.</p>
                <p><a href="gameHomeAdmin.jsp">Return to Home </a></p>
            </c:when>

            <!-- ReadGameHomeController error -->
            <c:when test="${param.errorType == 'ReadGameHomeController'}">
                <p class="error-message">Unable to load the Game Home. Please try refreshing the page or come back later.</p>
                <p><a href="admin-after-login.jsp">Return to Home</a></p>
            </c:when>

            <!-- ReadGameHomeMemberController error -->
            <c:when test="${param.errorType == 'ReadGameHomeMemberController'}">
                <p class="error-message">Unable to load the Game Home for members. Please try again later.</p>
                <p><a href="after-login.jsp">Return to Home</a></p>
            </c:when>

            <!-- ReadGameListAdminController error -->
            <c:when test="${param.errorType == 'ReadGameListAdminController'}">
                <p class="error-message">Could not load the Admin Game List. Please try again later.</p>
                <p><a href="games-after-login.jsp">Return to Game List</a></p>
            </c:when>

            <!-- ReadGameListController error -->
            <c:when test="${param.errorType == 'ReadGameListController'}">
                <p class="error-message">Could not load the Game List. Please try again later.</p>
                <p><a href="games.jsp">Return to Game List</a></p>
            </c:when>

            <!-- ReadGameListMemberController error -->
            <c:when test="${param.errorType == 'ReadGameListMemberController'}">
                <p class="error-message">Could not load the Game List for members. Please try again later.</p>
                <p><a href="games-after-login-member.jsp">Return to Game List</a></p>
            </c:when>

            <!-- ReadGameUploadByMemberController error -->
            <c:when test="${param.errorType == 'ReadGameUploadByMemberController'}">
                <p class="error-message">There was an issue uploading the game. Please try again.</p>
                <p><a href="admin-after-login.jsp">Retry Game Upload</a></p>
            </c:when>

            <!-- ReadTopic error -->
            <c:when test="${param.errorType == 'ReadTopic'}">
                <p class="error-message">The topic you're looking for could not be loaded. It may not exist or there was an error retrieving it.</p>
                <p><a href="forum-after-login.jsp">Return to Forum</a></p>
            </c:when>

            <!-- ReadTopicMember error -->
            <c:when test="${param.errorType == 'ReadTopicMember'}">
                <p class="error-message">Unable to load the topic for members. Please try again later.</p>
                <p><a href="forum-after-login-member.jsp">Return to Forum (Member)</a></p>
            </c:when>

            <!-- SignUpController error -->
            <c:when test="${param.errorType == 'SignUpController'}">
                <p class="error-message">There was an issue with your sign-up request. Please ensure all fields are filled out correctly and try again.</p>
                <p><a href="index.jsp">Back to Sign-Up</a></p>
            </c:when>

            <!-- Default error -->
            <c:otherwise>
                <p class="error-message">An unexpected error occurred. Please try again or contact support if the issue persists.</p>
                <p><a href="index.jsp">Back to Home</a></p>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
