<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="forgot-password-container">
        <div class="form-box">
            <h2>Forgot Password</h2>
            <p>Please enter your email address below and we will send you a link to reset your password.</p>

            <form action="ForgotPasswordController" method="post">
                <c:if test="${not empty errorMessage}">
                    <div class="error-message">${errorMessage}</div>
                </c:if>

                <c:if test="${not empty message}">
                    <div class="success-message">${message}</div>
                </c:if>

                <div class="input-field">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" required>
                </div>

                <button type="submit">Send Reset Link</button>
            </form>

            <div class="back-to-login">
                <a href="login.jsp">Back to Login</a>
            </div>
        </div>
    </div>
</body>
</html>
